import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../bloc/word_detail_bloc.dart';
import '../../../core/models/word.dart';

class ComprehensiveReviewScreen extends StatelessWidget {
  final int wordId;

  const ComprehensiveReviewScreen({super.key, required this.wordId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => WordDetailBloc()..add(LoadReviewPage(wordId)),
        child: BlocBuilder<WordDetailBloc, WordDetailState>(
          builder: (context, state) {
            if (state is WordDetailLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WordDetailLoaded) {
              final data = state.data;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 200,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text(data.word),
                      subtitle: data.pronunciation != null
                          ? Text(data.pronunciation!)
                          : null,
                    ),
                  ),
                  // Primary Definition
                  SliverToBoxAdapter(
                    child: _DefinitionCard(definitions: data.definitions),
                  ),
                  // Part of Speech
                  if (data.partsOfSpeech.isNotEmpty)
                    SliverToBoxAdapter(
                      child: _PartsOfSpeechChips(parts: data.partsOfSpeech),
                    ),
                  // Etymology
                  if (data.etymology != null)
                    SliverToBoxAdapter(
                      child: _EtymologyCard(etymology: data.etymology!),
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
                ],
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

class _DefinitionCard extends StatelessWidget {
  final List<WordDefinition> definitions;

  const _DefinitionCard({required this.definitions});

  @override
  Widget build(BuildContext context) {
    if (definitions.isEmpty) return const SizedBox.shrink();
    
    final primary = definitions.firstWhere(
      (d) => d.isPrimary,
      orElse: () => definitions.first,
    );
    
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Definition',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(primary.text),
          ],
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

class _EtymologyCard extends StatelessWidget {
  final Etymology etymology;

  const _EtymologyCard({required this.etymology});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Etymology',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (etymology.originLanguage != null) ...[
              const SizedBox(height: 8),
              Text('Origin: ${etymology.originLanguage}'),
            ],
            if (etymology.rootWord != null) ...[
              const SizedBox(height: 4),
              Text('Root: ${etymology.rootWord}'),
            ],
            if (etymology.evolution != null) ...[
              const SizedBox(height: 8),
              Text(etymology.evolution!),
            ],
          ],
        ),
      ),
    );
  }
}

class _ExamplesSection extends StatelessWidget {
  final List<WordDefinition> definitions;

  const _ExamplesSection({required this.definitions});

  @override
  Widget build(BuildContext context) {
    final examples = definitions
        .expand((d) => d.examples)
        .where((e) => e.isNotEmpty)
        .toList();
    
    if (examples.isEmpty) return const SizedBox.shrink();
    
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Examples',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ...examples.map((ex) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text('• $ex'),
                )),
          ],
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
              height: 200,
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
