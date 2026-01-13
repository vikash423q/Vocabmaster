import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/word_detail_bloc.dart';
import '../../../core/models/word.dart';
import '../../../core/models/progress.dart';
import '../../../core/models/quiz.dart';
import '../../../core/di/injection.dart';
import '../../../core/network/api_service.dart';

class ComprehensiveReviewScreen extends StatefulWidget {
  final int wordId;
  final bool fromReview;

  const ComprehensiveReviewScreen({
    super.key,
    required this.wordId,
    this.fromReview = false,
  });

  @override
  State<ComprehensiveReviewScreen> createState() => _ComprehensiveReviewScreenState();
}

class _ComprehensiveReviewScreenState extends State<ComprehensiveReviewScreen> {
  final ApiService _apiService = getIt<ApiService>();
  WordProgressDetail? _wordProgress;
  bool _loadingProgress = true;
  final GlobalKey<_AIContextSectionState> _aiContextKey = GlobalKey<_AIContextSectionState>();

  @override
  void initState() {
    super.initState();
    _loadWordProgress();
  }

  Future<void> _loadWordProgress() async {
    try {
      final progress = await _apiService.getWordProgress(widget.wordId);
      if (mounted) {
        setState(() {
          _wordProgress = progress;
          _loadingProgress = false;
        });
        // If from review and first time (level 0), trigger AI content load
        if (widget.fromReview && progress.fibonacciLevel == 0) {
          _aiContextKey.currentState?.autoLoadIfFirstTime();
        }
      }
    } catch (e) {
      // Word might not be in progress yet, that's okay - treat as first time
      if (mounted) {
        setState(() {
          _loadingProgress = false;
        });
        // If from review and no progress (first time), trigger AI content load
        if (widget.fromReview) {
          _aiContextKey.currentState?.autoLoadIfFirstTime();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => WordDetailBloc()..add(LoadReviewPage(widget.wordId)),
        child: BlocBuilder<WordDetailBloc, WordDetailState>(
          builder: (context, state) {
            if (state is WordDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WordDetailLoaded) {
              final data = state.data;

              return NotificationListener<ScrollNotification>(
                onNotification: (notification) {
                  if (notification is ScrollUpdateNotification) {
                    final metrics = notification.metrics;
                    final scrollDelta = notification.scrollDelta;
                    if (scrollDelta != null && scrollDelta < 0) {
                      // Scrolling up
                      final isAtBottom = metrics.pixels >= metrics.maxScrollExtent - 50;
                      if (isAtBottom) {
                        // Pass drag info to AI context section
                        _aiContextKey.currentState?.handleScrollUp(scrollDelta.abs());
                      }
                    }
                  }
                  return false;
                },
                child: CustomScrollView(
                  slivers: [
                  SliverAppBar(
                    expandedHeight: 210,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Theme.of(context).colorScheme.primaryContainer,
                              Theme.of(context).colorScheme.secondaryContainer,
                            ],
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 60),
                                // Category at center above the word
                                if (data.category != null) ...[
                                  _buildCategoryChip(context, data.category!.name),
                                  const SizedBox(height: 12),
                                ],
                                Text(
                                  data.word,
                                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                                if (data.pronunciation != null) ...[
                                  const SizedBox(height: 8),
                                  Text(
                                    data.pronunciation!,
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                      color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ],
                                const SizedBox(height: 16),
                                // Tone chip only
                                if (data.tone != null)
                                  _buildToneChip(context, data.tone!),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Expandable Etymology - at bottom of header, before Definitions
                  if (data.etymology != null)
                    SliverToBoxAdapter(
                      child: _ExpandableEtymology(etymology: data.etymology!),
                    ),
                  // Progress Level Indicator - above Definitions
                  if (_wordProgress != null)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 2.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _buildProgressLevelIndicator(_wordProgress!.fibonacciLevel),
                          ],
                        ),
                      ),
                    ),
                  // All Definitions (horizontal scrollable)
                  SliverToBoxAdapter(
                    child: _DefinitionsSection(
                      definitions: data.definitions,
                      partsOfSpeech: data.partsOfSpeech,
                    ),
                  ),
                  // Examples
                  SliverToBoxAdapter(
                    child: _ExamplesSection(definitions: data.definitions),
                  ),
                  // Media Gallery
                  if (data.media.isNotEmpty)
                    SliverToBoxAdapter(
                      child: _MediaGallery(media: data.media),
                    ),
                  // AI Context Section (Pull-up), pinned to bottom if there's extra space
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        const Spacer(),
                        _AIContextSection(
                          key: _aiContextKey,
                          wordId: widget.wordId,
                          word: data.word,
                          fromReview: widget.fromReview,
                        ),
                      ],
                    ),
                  ),
                ],
                ),
              );
            } else if (state is WordDetailError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _DefinitionsSection extends StatelessWidget {
  final List<WordDefinition> definitions;
  final List<String> partsOfSpeech;

  const _DefinitionsSection({
    required this.definitions,
    required this.partsOfSpeech,
  });

  @override
  Widget build(BuildContext context) {
    if (definitions.isEmpty) return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Icon(
                Icons.book,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Definitions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: definitions.length,
            itemBuilder: (context, index) {
              final definition = definitions[index];
              // Get POS for this definition by index, or empty list if none
              final definitionPOS = index < partsOfSpeech.length 
                  ? [partsOfSpeech[index]] 
                  : <String>[];
              return _DefinitionTile(
                definition: definition,
                isPrimary: definition.isPrimary,
                index: index + 1,
                partsOfSpeech: definitionPOS,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _DefinitionTile extends StatelessWidget {
  final WordDefinition definition;
  final bool isPrimary;
  final int index;
  final List<String> partsOfSpeech;

  const _DefinitionTile({
    required this.definition,
    required this.isPrimary,
    required this.index,
    required this.partsOfSpeech,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isPrimary
                  ? [
                      Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
                      Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.4),
                    ]
                  : [
                      Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                      Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
                    ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    if (isPrimary)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'PRIMARY',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'DEF #$index',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    // POS chips next to the badge
                    if (partsOfSpeech.isNotEmpty)
                      ...partsOfSpeech.map((pos) => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          pos,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )),
                  ],
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: Text(
                    definition.text,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.6,
                      fontSize: 15,
                    ),
                    maxLines: 6,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PartsOfSpeechChips extends StatelessWidget {
  final List<String> parts;

  const _PartsOfSpeechChips({required this.parts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        children: parts
            .map((part) => Chip(label: Text(part)))
            .toList(),
      ),
    );
  }
}

class _ExpandableEtymology extends StatefulWidget {
  final Etymology etymology;

  const _ExpandableEtymology({required this.etymology});

  @override
  State<_ExpandableEtymology> createState() => _ExpandableEtymologyState();
}

class _ExpandableEtymologyState extends State<_ExpandableEtymology> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primaryContainer.withOpacity(0.4),
            Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.4),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Icon(
                    Icons.history,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Etymology',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const Spacer(),
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Container(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.etymology.originLanguage != null) ...[
                    Row(
                      children: [
                        Text(
                          'Origin: ',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.etymology.originLanguage!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (widget.etymology.rootWord != null) ...[
                    Row(
                      children: [
                        Text(
                          'Root: ',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            widget.etymology.rootWord!,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontStyle: FontStyle.italic,
                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (widget.etymology.evolution != null) ...[
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        widget.etymology.evolution!,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          height: 1.5,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}

class _ExamplesSection extends StatelessWidget {
  final List<WordDefinition> definitions;

  const _ExamplesSection({required this.definitions});

  @override
  Widget build(BuildContext context) {
    // Group examples by definition
    final examplesWithDefs = <MapEntry<WordDefinition, String>>[];
    for (final def in definitions) {
      for (final example in def.examples) {
        if (example.isNotEmpty) {
          examplesWithDefs.add(MapEntry(def, example));
        }
      }
    }
    
    if (examplesWithDefs.isEmpty) return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Icon(
                Icons.format_quote,
                color: Theme.of(context).colorScheme.secondary,
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Examples',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: examplesWithDefs.length,
            itemBuilder: (context, index) {
              final entry = examplesWithDefs[index];
              final isPrimary = entry.key.isPrimary;
              return _ExampleTile(
                example: entry.value,
                isPrimary: isPrimary,
                index: index + 1,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ExampleTile extends StatelessWidget {
  final String example;
  final bool isPrimary;
  final int index;

  const _ExampleTile({
    required this.example,
    required this.isPrimary,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      margin: const EdgeInsets.only(right: 12),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isPrimary
                  ? [
                      Theme.of(context).colorScheme.secondaryContainer.withOpacity(0.4),
                      Theme.of(context).colorScheme.tertiaryContainer.withOpacity(0.4),
                    ]
                  : [
                      Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                      Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.3),
                    ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.format_quote,
                      size: 18,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: 6),
                    if (isPrimary)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'PRIMARY',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'EX #$index',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    example,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.4,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MediaGallery extends StatelessWidget {
  final List<MediaItem> media;

  const _MediaGallery({required this.media});

  @override
  Widget build(BuildContext context) {
    final images = media.where((m) => m.type == 'image').toList();
    if (images.isEmpty) return const SizedBox.shrink();
    
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Media',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, index) {
                  final item = images[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: CachedNetworkImage(
                      imageUrl: item.url,
                      placeholder: (context, url) => const SizedBox(
                        width: 200,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper functions for chips
Widget _buildToneChip(BuildContext context, String tone) {
  String emoji;
  Color color;
  
  switch (tone.toLowerCase()) {
    case 'positive':
      emoji = '😊';
      color = Colors.green;
      break;
    case 'negative':
      emoji = '😞';
      color = Colors.red;
      break;
    default: // neutral
      emoji = '😐';
      color = Colors.grey;
      break;
  }
  
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withOpacity(0.2),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: color.withOpacity(0.5), width: 1.5),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 6),
        Text(
          tone.toUpperCase(),
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCategoryChip(BuildContext context, String category) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.secondaryContainer,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        width: 1.5,
      ),
    ),
    child: Text(
      category,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildCEFRChip(BuildContext context, String cefrLevel) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.tertiaryContainer,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
        width: 1.5,
      ),
    ),
    child: Text(
      'CEFR: $cefrLevel',
      style: TextStyle(
        color: Theme.of(context).colorScheme.onTertiaryContainer,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildPartOfSpeechChip(BuildContext context, String pos) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
        width: 1,
      ),
    ),
    child: Text(
      pos,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onPrimaryContainer,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _buildProgressLevelIndicator(int level) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: List.generate(10, (index) {
      final isActive = index < level;
      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 3.w,
        height: isActive ? 12.h : 12.h,
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(2.r),
        ),
      );
    }),
  );
}

class _AIContextSection extends StatefulWidget {
  final int wordId;
  final String word;
  final bool fromReview;

  const _AIContextSection({
    Key? key,
    required this.wordId,
    required this.word,
    this.fromReview = false,
  }) : super(key: key);

  @override
  State<_AIContextSection> createState() => _AIContextSectionState();
}

class _AIContextSectionState extends State<_AIContextSection> {
  final ApiService _apiService = getIt<ApiService>();
  WordContextResponse? _contextData;
  bool _isLoading = false;
  bool _isExpanded = false;
  bool _hasLoaded = false;
  double _dragOffset = 0.0;
  static const double _dragThreshold = 40.0;
  Timer? _resetTimer;
  
  @override
  void dispose() {
    _resetTimer?.cancel();
    super.dispose();
  }
  
  // Auto-load if from review and first time (called after progress is loaded)
  void autoLoadIfFirstTime() {
    if (widget.fromReview && !_hasLoaded && !_isLoading && !_isExpanded) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _loadContext();
        }
      });
    }
  }
  
  // Handle scroll up from the content area (definitions/examples)
  void handleScrollUp(double delta) {
    if (!_isExpanded && !_isLoading) {
      // Cancel any pending reset
      _resetTimer?.cancel();
      
      setState(() {
        _dragOffset = (_dragOffset + delta * 2).clamp(0.0, _dragThreshold);
      });
      
      // If threshold reached, expand and load
      if (_dragOffset >= _dragThreshold * 0.7) {
        if (!_hasLoaded) {
          _loadContext();
        } else {
          setState(() {
            _isExpanded = true;
            _dragOffset = 0.0;
          });
        }
      } else {
        // Reset drag offset after a delay if not at threshold
        _resetTimer = Timer(const Duration(milliseconds: 300), () {
          if (mounted && !_isExpanded) {
            setState(() {
              _dragOffset = 0.0;
            });
          }
        });
      }
    }
  }
  
  // Method to auto-expand when scrolling up (legacy)
  void autoExpand() {
    if (!_hasLoaded && !_isLoading && !_isExpanded) {
      _loadContext();
    }
  }

  Future<void> _loadContext() async {
    if (_hasLoaded || _isLoading) return;

    setState(() {
      _isLoading = true;
      _isExpanded = true;
    });

    try {
      final response = await _apiService.generateWordContext(
        WordContextRequest(wordId: widget.wordId),
      );
      if (mounted) {
        setState(() {
          _contextData = response;
          _isLoading = false;
          _hasLoaded = true;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load context: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final baseColor = theme.colorScheme.surfaceContainer;
    final highlightColor = theme.colorScheme.surfaceContainerHighest;
    final progress = (_dragOffset / _dragThreshold).clamp(0.0, 1.0);
    final headerColor = Color.lerp(baseColor, highlightColor, progress) ?? baseColor;
    final translateY = -4.h * progress;

    return Container(
      margin: EdgeInsets.only(top: 16.h),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          // Pull-up handle with drag feedback
          GestureDetector(
            onTap: () {
              if (!_hasLoaded && !_isLoading) {
                _loadContext();
              } else {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              }
            },
            onVerticalDragUpdate: (details) {
              if (details.delta.dy < 0) {
                // Dragging up
                setState(() {
                  _dragOffset = (_dragOffset - details.delta.dy)
                      .clamp(0.0, _dragThreshold);
                });
              } else {
                // Dragging down - reset if not at threshold
                if (_dragOffset < _dragThreshold * 0.7) {
                  setState(() {
                    _dragOffset = (_dragOffset - details.delta.dy)
                        .clamp(0.0, _dragThreshold);
                  });
                }
              }
            },
            onVerticalDragEnd: (_) {
              if (_dragOffset >= _dragThreshold * 0.7) {
                // Threshold reached: expand and load if needed
                if (!_hasLoaded && !_isLoading) {
                  _loadContext();
                } else if (!_isExpanded) {
                  setState(() {
                    _isExpanded = true;
                  });
                }
              }
              // Reset drag state with animation
              Future.delayed(const Duration(milliseconds: 100), () {
                if (mounted) {
                  setState(() {
                    _dragOffset = 0.0;
                  });
                }
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              transform: Matrix4.translationValues(0, translateY, 0),
              padding: EdgeInsets.symmetric(vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: theme.colorScheme.onSurface.withOpacity(
                      0.7 + 0.3 * progress,
                    ),
                    size: 24.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    _isLoading
                        ? 'Loading AI content...'
                        : _hasLoaded
                            ? (_isExpanded ? 'Hide AI Content' : 'Show AI Content')
                            : 'Pull up for more AI content',
                    style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface.withOpacity(
                            0.7 + 0.3 * progress,
                          ),
                        ),
                  ),
                ],
              ),
            ),
          ),
          // Content area
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: _isLoading
                ? Padding(
                    padding: EdgeInsets.all(24.w),
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : _contextData != null
                    ? _buildContextContent(_contextData!)
                    : const SizedBox.shrink(),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }

  Widget _buildContextContent(WordContextResponse data) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (data.tweets.isNotEmpty) ...[
            _buildSection(
              title: 'Tweets',
              icon: Icons.chat_bubble_outline,
              items: data.tweets,
              color: Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 16.h),
          ],
          if (data.references.isNotEmpty) ...[
            _buildSection(
              title: 'Movie/TV/Book References',
              icon: Icons.movie_outlined,
              items: data.references,
              color: Theme.of(context).colorScheme.secondary,
            ),
            SizedBox(height: 16.h),
          ],
          if (data.quotes.isNotEmpty) ...[
            _buildSection(
              title: 'Quotes',
              icon: Icons.format_quote,
              items: data.quotes,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            SizedBox(height: 16.h),
          ],
          if (data.events.isNotEmpty) ...[
            _buildSection(
              title: 'Popular Events',
              icon: Icons.event,
              items: data.events,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<String> items,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        ...items.map((item) => Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: color.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: _buildHighlightedText(
                  text: item,
                  wordToHighlight: widget.word,
                  baseStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                        color: Theme.of(context).colorScheme.onSurface,
                      ) ?? const TextStyle(height: 1.5),
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildHighlightedText({
    required String text,
    required String wordToHighlight,
    required TextStyle baseStyle,
  }) {
    final wordHighlightColor = Theme.of(context).colorScheme.primary;
    final asteriskHighlightColor = Theme.of(context).colorScheme.secondary;
    
    // Parse text to find word and asterisked content
    final spans = <TextSpan>[];
    final wordLower = wordToHighlight.toLowerCase();
    final textLower = text.toLowerCase();
    
    int currentIndex = 0;
    final regex = RegExp(r'\*([^*]+)\*'); // Match *text*
    
    // Find all asterisked content
    final asteriskMatches = regex.allMatches(text);
    final allMatches = <_MatchInfo>[];
    
    // Add asterisk matches
    for (final match in asteriskMatches) {
      allMatches.add(_MatchInfo(
        start: match.start,
        end: match.end,
        text: match.group(1) ?? '',
        isAsterisk: true,
      ));
    }
    
    // Find word matches (case-insensitive, whole word only)
    final wordRegex = RegExp(r'\b' + RegExp.escape(wordLower) + r'\b', caseSensitive: false);
    final wordMatches = wordRegex.allMatches(text);
    
    for (final match in wordMatches) {
      // Check if this word match overlaps with any asterisk match
      bool overlaps = false;
      for (final asteriskMatch in allMatches) {
        if (match.start >= asteriskMatch.start && match.start < asteriskMatch.end) {
          overlaps = true;
          break;
        }
      }
      if (!overlaps) {
        allMatches.add(_MatchInfo(
          start: match.start,
          end: match.end,
          text: text.substring(match.start, match.end),
          isAsterisk: false,
        ));
      }
    }
    
    // Sort matches by start position
    allMatches.sort((a, b) => a.start.compareTo(b.start));
    
    // Build text spans
    for (final match in allMatches) {
      // Add text before match
      if (match.start > currentIndex) {
        spans.add(TextSpan(
          text: text.substring(currentIndex, match.start),
          style: baseStyle,
        ));
      }
      
      // Add highlighted match
      spans.add(TextSpan(
        text: match.text,
        style: baseStyle.copyWith(
          color: match.isAsterisk ? asteriskHighlightColor : wordHighlightColor,
          fontWeight: FontWeight.bold,
        ),
      ));
      
      currentIndex = match.end;
    }
    
    // Add remaining text
    if (currentIndex < text.length) {
      spans.add(TextSpan(
        text: text.substring(currentIndex),
        style: baseStyle,
      ));
    }
    
    // If no matches, return plain text
    if (spans.isEmpty) {
      return Text(text, style: baseStyle);
    }
    
    return RichText(
      text: TextSpan(children: spans),
    );
  }
}

class _MatchInfo {
  final int start;
  final int end;
  final String text;
  final bool isAsterisk;
  
  _MatchInfo({
    required this.start,
    required this.end,
    required this.text,
    required this.isAsterisk,
  });
}
