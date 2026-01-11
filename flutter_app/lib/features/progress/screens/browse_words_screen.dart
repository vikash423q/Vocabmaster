import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/di/injection.dart';
import '../../../core/network/api_service.dart';
import '../../../core/models/models.dart';
import '../../../app/app_router.dart';

class BrowseWordsScreen extends StatefulWidget {
  final Map<String, dynamic>? arguments;
  
  const BrowseWordsScreen({super.key, this.arguments});

  @override
  State<BrowseWordsScreen> createState() => _BrowseWordsScreenState();
}

class _BrowseWordsScreenState extends State<BrowseWordsScreen> {
  final ApiService _apiService = getIt<ApiService>();
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<WordListItem> _words = [];
  List<ProgressWord> _progressWords = [];
  List<Category> _categories = [];
  Category? _selectedCategory;
  Category? _selectedSubCategory;
  bool _loading = false;
  bool _loadingMore = false;
  bool _hasMore = true;
  String? _error;
  String _searchQuery = '';
  final int _limit = 50;
  bool _useProgressAPI = false;
  Timer? _searchDebounceTimer;

  @override
  void initState() {
    super.initState();
    // Check if we should use progress API based on filter
    final filter = widget.arguments?['filter'] as String?;
    _useProgressAPI = filter != null && (filter == 'mastered' || filter == 'learning' || filter == 'reviewing');
    _searchController.addListener(_onSearchChanged);
    _scrollController.addListener(_onScroll);
    _loadCategories();
    _loadWords();
  }

  @override
  void dispose() {
    _searchDebounceTimer?.cancel();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Load more when user scrolls near the bottom (within 200 pixels)
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreIfNeeded();
    }
  }

  Future<void> _loadMoreIfNeeded() async {
    if (!_hasMore || _loading || _loadingMore) return;
    
    await _loadWords(append: true);
  }

  void _onSearchChanged() {
    // Cancel previous debounce timer if it exists
    _searchDebounceTimer?.cancel();
    
    // Update UI immediately
    setState(() {
      _searchQuery = _searchController.text;
    });
    
    // Create new debounce timer
    _searchDebounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        // Call API with the current search query
        _loadWords();
      }
    });
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _apiService.getCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      // Silently fail category loading - it's not critical
    }
  }

  List<Category> get _subCategories {
    if (_selectedCategory == null) return [];
    return _categories.where((c) => c.parentCategoryId == _selectedCategory!.id).toList();
  }


  Future<void> _loadWords({bool append = false}) async {
    if (append && (_loading || _loadingMore || !_hasMore)) return;
    
    setState(() {
      if (append) {
        _loadingMore = true;
      } else {
        _loading = true;
        _hasMore = true;
        _words.clear();
        _progressWords.clear();
      }
      _error = null;
    });

    try {
      final filter = widget.arguments?['filter'] as String?;
      
      if (_useProgressAPI) {
        // Use progress words API for status filters with category, subcategory, and search
        final response = await _apiService.getProgressWords(
          status: filter,
          categoryId: _selectedCategory?.id,
          subcategoryId: _selectedSubCategory?.id,
          search: _searchQuery.isNotEmpty ? _searchQuery : null,
          limit: _limit,
          offset: append ? _progressWords.length : 0,
        );
        
        // Convert ProgressWord to WordListItem for display
        final convertedWords = response.words.map((pw) => WordListItem(
          id: pw.id,
          word: pw.word ?? '',
          pronunciation: pw.pronunciation,
          categoryId: pw.categoryId,
          difficultyLevel: pw.difficultyLevel,
          importanceScore: pw.importanceScore,
        )).toList();
        
        // Check if there are more items to load
        // Use total from response if available, otherwise check if we got a full page
        final currentCount = append ? _progressWords.length + response.words.length : response.words.length;
        final hasMore = response.total > currentCount || response.words.length >= _limit;
        
        setState(() {
          if (append) {
            _progressWords.addAll(response.words);
            _words.addAll(convertedWords);
            _loadingMore = false;
          } else {
            _progressWords = response.words;
            _words = convertedWords;
            _loading = false;
          }
          _hasMore = hasMore;
        });
      } else {
        // Use regular words API with filters
        final queryParams = <String, dynamic>{
          'limit': _limit,
          'offset': append ? _words.length : 0,
        };
        
        if (_selectedCategory != null) {
          if (_selectedSubCategory != null) {
            queryParams['subcategory_id'] = _selectedSubCategory!.id;
          } else {
            queryParams['category_id'] = _selectedCategory!.id;
          }
        }
        
        if (_searchQuery.isNotEmpty) {
          queryParams['search'] = _searchQuery;
        }
        
        final words = await _apiService.getWords(queryParams);

        // Check if there are more items to load (if we got exactly _limit items, there might be more)
        final hasMore = words.length >= _limit;

        setState(() {
          if (append) {
            _words.addAll(words);
            _loadingMore = false;
          } else {
            _words = words;
            _loading = false;
          }
          _hasMore = hasMore;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        if (append) {
          _loadingMore = false;
        } else {
          _loading = false;
        }
      });
    }
  }

  Future<void> _addToStack(int wordId) async {
    try {
      await _apiService.addWords(AddWordsRequest(wordIds: [wordId]));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Word added to your learning stack!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _toggleMastered(int wordId) async {
    try {
      final response = await _apiService.markWordKnown(wordId);
      final isMastered = response['is_mastered'] as bool? ?? true;
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isMastered 
              ? 'Word marked as mastered!' 
              : 'Word unmarked as mastered!'),
          ),
        );
        // Update the status in progress words if available
        setState(() {
          final progressWordIndex = _progressWords.indexWhere((w) => w.id == wordId);
          if (progressWordIndex >= 0) {
            final oldProgressWord = _progressWords[progressWordIndex];
            // Update status (create new ProgressWord with updated status)
            _progressWords[progressWordIndex] = ProgressWord(
              id: oldProgressWord.id,
              word: oldProgressWord.word,
              pronunciation: oldProgressWord.pronunciation,
              categoryId: oldProgressWord.categoryId,
              categoryName: oldProgressWord.categoryName,
              difficultyLevel: oldProgressWord.difficultyLevel,
              importanceScore: oldProgressWord.importanceScore,
              status: isMastered ? 'mastered' : 'learning',
              fibonacciLevel: isMastered ? 10 : 0,
              nextReviewDate: oldProgressWord.nextReviewDate,
              correctCount: oldProgressWord.correctCount,
              incorrectCount: oldProgressWord.incorrectCount,
              lastReviewedAt: oldProgressWord.lastReviewedAt,
              addedAt: oldProgressWord.addedAt,
              masteredAt: isMastered ? DateTime.now().toIso8601String() : null,
              tone: oldProgressWord.tone,
              cefrLevel: oldProgressWord.cefrLevel,
            );
            // Update words list with converted progress word if using progress API
            if (_useProgressAPI) {
              final wordIndex = _words.indexWhere((w) => w.id == wordId);
              if (wordIndex >= 0) {
                _words[wordIndex] = WordListItem(
                  id: oldProgressWord.id,
                  word: oldProgressWord.word ?? '',
                  pronunciation: oldProgressWord.pronunciation,
                  categoryId: oldProgressWord.categoryId,
                  difficultyLevel: oldProgressWord.difficultyLevel,
                  importanceScore: oldProgressWord.importanceScore,
                );
              }
            }
          } else {
            // If not in progress words, reload to get updated status
            _loadWords();
          }
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
  
  bool _isWordMastered(int wordId) {
    // Check if word is mastered from progress words
    if (_useProgressAPI) {
      final progressWord = _progressWords.firstWhere(
        (pw) => pw.id == wordId,
        orElse: () => const ProgressWord(
          id: 0,
          status: '',
          fibonacciLevel: 0,
        ),
      );
      return progressWord.status == 'mastered';
    }
    // For words without progress, default to false
    return false;
  }

  String _getFilterTitle() {
    final filter = widget.arguments?['filter'] as String?;
    switch (filter) {
      case 'mastered':
        return 'Mastered Words';
      case 'learning':
        return 'Learning Words';
      case 'reviewing':
        return 'Reviewing Words';
      case 'all':
        return 'All Words';
      default:
        return 'Browse Words';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getFilterTitle()),
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search words...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty || _selectedCategory != null
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchDebounceTimer?.cancel();
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                            _selectedCategory = null;
                            _selectedSubCategory = null;
                          });
                          _loadWords(); // Call API with cleared filters
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          // Category filters
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<Category?>(
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      isDense: true,
                    ),
                    isExpanded: true,
                    value: _selectedCategory,
                    items: [
                      const DropdownMenuItem<Category?>(
                        value: null,
                        child: Text('All', overflow: TextOverflow.ellipsis),
                      ),
                      ..._categories.where((c) => c.parentCategoryId == null).map((category) {
                        return DropdownMenuItem<Category?>(
                          value: category,
                          child: Text(
                            category.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }),
                    ],
                    onChanged: (Category? value) {
                      setState(() {
                        _selectedCategory = value;
                        _selectedSubCategory = null; // Reset subcategory when parent changes
                      });
                      _loadWords(); // Call API with new category filter
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<Category?>(
                    decoration: InputDecoration(
                      labelText: 'Sub-Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      isDense: true,
                      enabled: _selectedCategory != null,
                    ),
                    isExpanded: true,
                    value: _selectedSubCategory,
                    items: [
                      const DropdownMenuItem<Category?>(
                        value: null,
                        child: Text('All', overflow: TextOverflow.ellipsis),
                      ),
                      ..._subCategories.map((subCategory) {
                        return DropdownMenuItem<Category?>(
                          value: subCategory,
                          child: Text(
                            subCategory.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }),
                    ],
                    onChanged: _selectedCategory != null ? (Category? value) {
                      setState(() {
                        _selectedSubCategory = value;
                      });
                      _loadWords(); // Call API with new subcategory filter
                    } : null,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Words list
          Expanded(
            child: _loading && _words.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(_error!),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () => _loadWords(),
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : _words.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 64,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No words found',
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    widget.arguments?['filter'] != null
                                        ? 'You don\'t have any ${_getFilterTitle().toLowerCase()} yet.'
                                        : 'Try adjusting your search or filters.',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: _words.length + (_loadingMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == _words.length) {
                                // Show loading indicator at the bottom when loading more
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(16),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }

                              final word = _words[index];
                              // Get category name from progress words if available, otherwise lookup from categories
                              String? categoryName;
                              if (_useProgressAPI) {
                                // Find matching progress word by id
                                final progressWord = _progressWords.firstWhere(
                                  (pw) => pw.id == word.id,
                                  orElse: () => const ProgressWord(
                                    id: 0,
                                    status: '',
                                    fibonacciLevel: 0,
                                  ),
                                );
                                categoryName = progressWord.id != 0 ? progressWord.categoryName : null;
                              }
                              
                              // If not found or not using progress API, lookup from categories list
                              if (categoryName == null && word.categoryId != null) {
                                try {
                                  final category = _categories.firstWhere(
                                    (c) => c.id == word.categoryId,
                                  );
                                  categoryName = category.name;
                                } catch (e) {
                                  categoryName = null;
                                }
                              }
                              
                              return Card(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 4,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Badges at top right in scrollable container
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          reverse: true,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Chip(
                                                label: Text(
                                                  'Level ${word.difficultyLevel.toStringAsFixed(1)}',
                                                  style: const TextStyle(fontSize: 8),
                                                ),
                                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                visualDensity: VisualDensity.compact,
                                                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                                                labelStyle: TextStyle(
                                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                                ),
                                              ),
                                              if (categoryName != null && categoryName.isNotEmpty) ...[
                                                const SizedBox(width: 4),
                                                Chip(
                                                  label: Text(
                                                    categoryName,
                                                    style: const TextStyle(fontSize: 8),
                                                  ),
                                                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
                                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                  visualDensity: VisualDensity.compact,
                                                  backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                                                  labelStyle: TextStyle(
                                                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      // Word and buttons row
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  word.word,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                if (word.pronunciation != null)
                                                  Text(
                                                    word.pronunciation!,
                                                    style: TextStyle(
                                                      fontStyle: FontStyle.italic,
                                                      color: Colors.grey[600],
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          // Action buttons
                                          IconButton(
                                            icon: const Icon(Icons.add_circle_outline, size: 24),
                                            tooltip: 'Add to Stack',
                                            onPressed: () => _addToStack(word.id),
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                          ),
                                          // Mastered toggle
                                          Tooltip(
                                            message: _isWordMastered(word.id) 
                                              ? 'Mark as Not Mastered' 
                                              : 'Mark as Mastered',
                                            child: Switch(
                                              value: _isWordMastered(word.id),
                                              onChanged: (value) => _toggleMastered(word.id),
                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                            ),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.arrow_forward, size: 24),
                                            tooltip: 'View Details',
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                context,
                                                AppRouter.wordDetail,
                                                arguments: {'wordId': word.id},
                                              );
                                            },
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
