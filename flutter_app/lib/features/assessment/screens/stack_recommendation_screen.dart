import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/models.dart';
import '../../../core/di/injection.dart';
import '../../../core/network/api_service.dart';
import '../../../../app/app_router.dart';

class StackRecommendationScreen extends StatefulWidget {
  final AssessmentResult? result;

  const StackRecommendationScreen({super.key, this.result});

  @override
  State<StackRecommendationScreen> createState() =>
      _StackRecommendationScreenState();
}

class _StackRecommendationScreenState
    extends State<StackRecommendationScreen> {
  final ApiService _apiService = getIt<ApiService>();
  StackRecommendation? _recommendation;
  bool _loading = true;
  String? _error;
  final Set<int> _selectedWords = {};
  final Set<int> _discardedWords = {};

  @override
  void initState() {
    super.initState();
    _loadRecommendations();
  }

  Future<void> _loadRecommendations() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final recommendation = await _apiService.getStackRecommendations();
      // Filter out duplicates based on word ID
      final seenIds = <int>{};
      final uniqueWords = recommendation.words.where((w) {
        if (seenIds.contains(w.id)) {
          return false;
        }
        seenIds.add(w.id);
        return true;
      }).toList();
      
      setState(() {
        _recommendation = StackRecommendation(
          words: uniqueWords,
          recommendedLevel: recommendation.recommendedLevel,
          userCurrentLevel: recommendation.userCurrentLevel,
          totalRecommended: uniqueWords.length,
        );
        _selectedWords.clear();
        _discardedWords.clear();
        _selectedWords.addAll(uniqueWords.map((w) => w.id));
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _fetchMoreIfNeeded() async {
    if (_selectedWords.length < 15 && _recommendation != null) {
      // Fetch more recommendations
      try {
        final newRec = await _apiService.getStackRecommendations(limit: 30);
        
        // Get existing word IDs to avoid duplicates
        final existingIds = _recommendation!.words.map((w) => w.id).toSet();
        
        // Add words that weren't discarded and aren't already in the list
        final newWords = newRec.words
            .where((w) => !_discardedWords.contains(w.id) && !existingIds.contains(w.id))
            .take(20 - _selectedWords.length)
            .toList();

        // Filter out duplicates from existing words and merge with new words
        final seenIds = <int>{};
        final allWords = <RecommendedWord>[];
        
        // Add existing words first (only selected ones)
        for (final word in _recommendation!.words) {
          if (!seenIds.contains(word.id)) {
            seenIds.add(word.id);
            allWords.add(word);
          }
        }
        
        // Add new words that aren't duplicates
        for (final word in newWords) {
          if (!seenIds.contains(word.id)) {
            seenIds.add(word.id);
            allWords.add(word);
          }
        }

        setState(() {
          _recommendation = StackRecommendation(
            words: allWords,
            recommendedLevel: _recommendation!.recommendedLevel,
            userCurrentLevel: _recommendation!.userCurrentLevel,
            totalRecommended: allWords.length,
          );
          // Don't auto-select new words - let user choose
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching more words: $e')),
        );
      }
    }
  }

  void _toggleWord(int wordId) {
    setState(() {
      if (_selectedWords.contains(wordId)) {
        _selectedWords.remove(wordId);
        _discardedWords.add(wordId);
      } else {
        _selectedWords.add(wordId);
        _discardedWords.remove(wordId);
      }
    });

    // Fetch more if too many discarded
    if (_selectedWords.length < 15) {
      _fetchMoreIfNeeded();
    }
  }

  void _selectAll() {
    setState(() {
      if (_recommendation != null) {
        for (final word in _recommendation!.words) {
          _selectedWords.add(word.id);
          _discardedWords.remove(word.id); // Remove from discarded if it was there
        }
      }
    });
  }

  void _deselectAll() {
    setState(() {
      // Move all selected words to discarded (so they won't be auto-selected if fetched again)
      _discardedWords.addAll(_selectedWords);
      _selectedWords.clear();
    });
  }

  Future<void> _addToStack() async {
    if (_selectedWords.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one word')),
      );
      return;
    }

    try {
      // Add words to stack
      final addWordsRequest = AddWordsRequest(wordIds: _selectedWords.toList());
      await _apiService.addWords(addWordsRequest);

      // Navigate to main review page
      Navigator.pushReplacementNamed(context, AppRouter.main);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding words: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommended Words'),
        actions: [
          // Select/Deselect All buttons
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'select_all') {
                _selectAll();
              } else if (value == 'deselect_all') {
                _deselectAll();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'select_all',
                child: Row(
                  children: [
                    Icon(Icons.select_all, size: 20),
                    SizedBox(width: 8),
                    Text('Select All'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'deselect_all',
                child: Row(
                  children: [
                    Icon(Icons.deselect, size: 20),
                    SizedBox(width: 8),
                    Text('Deselect All'),
                  ],
                ),
              ),
            ],
          ),
          if (_selectedWords.isNotEmpty)
            TextButton(
              onPressed: _addToStack,
              child: Text(
                'Add ${_selectedWords.length}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_error!),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadRecommendations,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _recommendation == null
                  ? const Center(child: Text('No recommendations available'))
                  : Column(
                      children: [
                        // Assessment result banner
                        if (widget.result != null)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            color: Theme.of(context).colorScheme.primaryContainer,
                            child: Column(
                              children: [
                                Text(
                                  'Your Vocabulary Level',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${widget.result!.calculatedLevel.toStringAsFixed(1)} / 10.0',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Based on ${widget.result!.wordsAssessed} words',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        // Word list
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: _recommendation!.words.length,
                            itemBuilder: (context, index) {
                              final word = _recommendation!.words[index];
                              final isSelected = _selectedWords.contains(word.id);

                              return Card(
                                key: ValueKey('word_${word.id}'), // Add unique key
                                margin: const EdgeInsets.only(bottom: 12),
                                child: ListTile(
                                  title: Text(
                                    word.word,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (word.pronunciation != null)
                                        Text(word.pronunciation!),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          if (word.cefrLevel != null)
                                            Chip(
                                              label: Text(word.cefrLevel!),
                                              padding: EdgeInsets.zero,
                                              labelStyle:
                                                  const TextStyle(fontSize: 10),
                                            ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Difficulty: ${word.difficultyLevel.toStringAsFixed(1)}',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Checkbox(
                                    value: isSelected,
                                    onChanged: (_) => _toggleWord(word.id),
                                  ),
                                  onTap: () => _toggleWord(word.id),
                                ),
                              );
                            },
                          ),
                        ),
                        // Add button
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed:
                                  _selectedWords.isEmpty ? null : _addToStack,
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: Text(
                                _selectedWords.isEmpty
                                    ? 'Select words to add'
                                    : 'Add ${_selectedWords.length} words to stack',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
    );
  }
}
