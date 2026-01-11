import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'dart:math';
import '../../../core/di/injection.dart';
import '../../../core/network/api_service.dart';
import '../../../core/models/models.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  final ApiService _apiService = getIt<ApiService>();
  List<ProgressWord>? _wordsInProgress;
  bool _loading = false;
  bool _generating = false;
  String? _error;
  StoryResponse? _generatedStory;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _loadWordsInProgress();
  }

  Future<void> _loadWordsInProgress() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final response = await _apiService.getProgressWords(status: 'learning', limit: 5);
      setState(() {
        _wordsInProgress = response.words;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  void _shuffleWords() {
    if (_wordsInProgress != null && _wordsInProgress!.isNotEmpty) {
      setState(() {
        _wordsInProgress = List.from(_wordsInProgress!)..shuffle(_random);
      });
    }
  }

  Future<void> _generateStory() async {
    if (_wordsInProgress == null || _wordsInProgress!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No words in progress. Start learning some words first!'),
        ),
      );
      return;
    }

    setState(() {
      _generating = true;
      _error = null;
      _generatedStory = null;
    });

    try {
      final wordIds = _wordsInProgress!.map((w) => w.id).toList();
      if (wordIds.isEmpty) {
        throw Exception('No words available for story generation');
      }
      
      final request = StoryGenerateRequest(
        wordIds: wordIds,
        batchSize: wordIds.length,
        storyType: 'custom',
      );

      final story = await _apiService.generateStory(request);
      setState(() {
        _generatedStory = story;
        _generating = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _generating = false;
      });
    }
  }

  String _formatStoryWithEmphasis(String narrative, List<String> words) {
    String formatted = narrative;
    // Emphasize each word in the story
    for (final word in words) {
      // Match whole words (case-insensitive)
      final regex = RegExp(r'\b' + RegExp.escape(word) + r'\b', caseSensitive: false);
      formatted = formatted.replaceAllMapped(
        regex,
        (match) => '**${match.group(0)}**',
      );
    }
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.auto_awesome_rounded),
            const SizedBox(width: 8),
            const Text(
              'AI Stories',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Words in progress
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Words in Progress',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              if (_wordsInProgress != null && _wordsInProgress!.isNotEmpty)
                                IconButton(
                                  icon: const Icon(Icons.shuffle),
                                  tooltip: 'Shuffle Words',
                                  onPressed: _shuffleWords,
                                ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          if (_wordsInProgress == null || _wordsInProgress!.isEmpty)
                            const Text('No words in progress')
                          else
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: _wordsInProgress!.map((word) {
                                return Chip(
                                  label: Text(
                                    word.word ?? 'Unknown',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                );
                              }).toList(),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Generate story button
                  ElevatedButton.icon(
                    onPressed: _generating ? null : _generateStory,
                    icon: _generating
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.auto_awesome),
                    label: Text(_generating ? 'Generating...' : 'Generate Story'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                  ),
                  // Generated story
                  if (_generatedStory != null) ...[
                    const SizedBox(height: 24),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Guided Story',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(height: 16),
                            // Markdown story with emphasized words
                            MarkdownBody(
                              data: _formatStoryWithEmphasis(
                                _generatedStory!.narrative,
                                _wordsInProgress?.map((w) => w.word ?? '').where((w) => w.isNotEmpty).toList() ?? [],
                              ),
                              styleSheet: MarkdownStyleSheet(
                                p: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  height: 1.6,
                                ),
                                strong: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: Theme.of(context).textTheme.bodyLarge?.fontSize,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                  // Error message
                  if (_error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Card(
                        color: Colors.red[50],
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            _error!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
