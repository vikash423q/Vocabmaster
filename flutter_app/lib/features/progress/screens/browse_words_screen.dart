import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    // Use progress API for 'all' filter too, to show only words in progress
    _useProgressAPI = filter != null && (filter == 'all' || filter == 'mastered' || filter == 'learning' || filter == 'reviewing');
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
    // Disable pagination for 'all' filter to prevent loading all words
    final filter = widget.arguments?['filter'] as String?;
    if (filter == 'all' && _useProgressAPI) {
      return; // Don't load more for 'all' filter
    }
    
    // Load more when user scrolls near the bottom (within 200 pixels)
    if (_scrollController.position.pixels >= 
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreIfNeeded();
    }
  }

  Future<void> _loadMoreIfNeeded() async {
    // Disable pagination for 'all' filter to prevent loading all words
    final filter = widget.arguments?['filter'] as String?;
    if (filter == 'all' && _useProgressAPI) {
      return; // Don't load more for 'all' filter
    }
    
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
      
      // If subcategory_id is passed in arguments, find and set it
      final subcategoryIdArg = widget.arguments?['subcategory_id'] as int?;
      if (subcategoryIdArg != null) {
        final subcategory = categories.firstWhere(
          (c) => c.id == subcategoryIdArg,
          orElse: () => categories.first,
        );
        // Find parent category
        if (subcategory.parentCategoryId != null) {
          final parent = categories.firstWhere(
            (c) => c.id == subcategory.parentCategoryId,
            orElse: () => categories.first,
          );
          setState(() {
            _selectedCategory = parent;
            _selectedSubCategory = subcategory;
          });
        } else {
          setState(() {
            _selectedCategory = subcategory;
          });
        }
        // Load words with the category filter
        _loadWords();
      }
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
        // For 'all' filter, pass 'all' which the API service will handle correctly
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
            // Create modifiable copies of the lists
            _progressWords = List<ProgressWord>.from(response.words);
            _words = List<WordListItem>.from(convertedWords);
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
            // Create modifiable copy of the list
            _words = List<WordListItem>.from(words);
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
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isMastered 
              ? 'Word marked as mastered!' 
              : 'Word unmarked as mastered!'),
          ),
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
            padding: EdgeInsets.all(16.w),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search words...',
                prefixIcon: Icon(Icons.search, size: 20.sp),
                suffixIcon: _searchQuery.isNotEmpty || _selectedCategory != null
                    ? IconButton(
                        icon: Icon(Icons.clear, size: 20.sp),
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
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ),
          // Category filters
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<Category?>(
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
                SizedBox(width: 12.w),
                Expanded(
                  child: DropdownButtonFormField<Category?>(
                    decoration: InputDecoration(
                      labelText: 'Sub-Category',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
          SizedBox(height: 8.h),
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
                            SizedBox(height: 16.h),
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
                              padding: EdgeInsets.all(24.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search_off,
                                    size: 64.sp,
                                    color: Colors.grey[400],
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    'No words found',
                                    style: Theme.of(context).textTheme.titleLarge,
                                  ),
                                  SizedBox(height: 8.h),
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
                                return Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(16.w),
                                    child: const CircularProgressIndicator(),
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
                                margin: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 4.h,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRouter.wordDetail,
                                      arguments: {'wordId': word.id},
                                    );
                                  },
                                  borderRadius: BorderRadius.circular(12.r),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
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
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                                                    borderRadius: BorderRadius.circular(10.r),
                                                    border: Border.all(
                                                      color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                                                      width: 0.5.w,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'Level ${word.difficultyLevel.toStringAsFixed(1)}',
                                                    style: TextStyle(
                                                      fontSize: 10.sp,
                                                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                if (categoryName != null && categoryName.isNotEmpty) ...[
                                                  SizedBox(width: 6.w),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
                                                      borderRadius: BorderRadius.circular(10.r),
                                                      border: Border.all(
                                                        color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                                                        width: 0.5.w,
                                                      ),
                                                    ),
                                                    child: Text(
                                                      categoryName,
                                                      style: TextStyle(
                                                        fontSize: 10.sp,
                                                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                                        fontWeight: FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 6.h),
                                        // Word and buttons row
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text(
                                                    word.word,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20.sp,
                                                    ),
                                                  ),
                                                  if (word.pronunciation != null)
                                                    Padding(
                                                      padding: EdgeInsets.only(top: 2.h),
                                                      child: Text(
                                                        word.pronunciation!,
                                                        style: TextStyle(
                                                          fontStyle: FontStyle.italic,
                                                          color: Colors.grey[600],
                                                          fontSize: 12.sp,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            // Buttons stacked vertically
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                // Add to Stack button
                                                InkWell(
                                                  onTap: () => _addToStack(word.id),
                                                  borderRadius: BorderRadius.circular((8 * 0.8).r),
                                                  child: Container(
                                                    width: 120.w * 0.8,
                                                    height: 32.h * 0.8,
                                                    padding: EdgeInsets.symmetric(horizontal: 8.w * 0.8),
                                                    decoration: BoxDecoration(
                                                      color: Theme.of(context).colorScheme.primaryContainer,
                                                      borderRadius: BorderRadius.circular((8 * 0.8).r),
                                                      border: Border.all(
                                                        color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          Icons.add_circle_outline,
                                                          size: 14.sp * 0.8,
                                                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                                                        ),
                                                        SizedBox(width: 4.w * 0.8),
                                                        Text(
                                                          'Add to Stack',
                                                          style: TextStyle(
                                                            fontSize: 11.sp * 0.8,
                                                            fontWeight: FontWeight.w500,
                                                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 6.h * 0.8),
                                                // I know button
                                                InkWell(
                                                  onTap: () => _toggleMastered(word.id),
                                                  borderRadius: BorderRadius.circular((8 * 0.8).r),
                                                  child: Container(
                                                    width: 120.w * 0.8,
                                                    height: 32.h * 0.8,
                                                    padding: EdgeInsets.symmetric(horizontal: 8.w * 0.8),
                                                    decoration: BoxDecoration(
                                                      color: _isWordMastered(word.id)
                                                          ? Theme.of(context).colorScheme.secondaryContainer
                                                          : Theme.of(context).colorScheme.surfaceContainerHighest,
                                                      borderRadius: BorderRadius.circular((8 * 0.8).r),
                                                      border: Border.all(
                                                        color: _isWordMastered(word.id)
                                                            ? Theme.of(context).colorScheme.secondary.withOpacity(0.3)
                                                            : Theme.of(context).colorScheme.outline.withOpacity(0.3),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisSize: MainAxisSize.min,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Icon(
                                                          _isWordMastered(word.id) ? Icons.check_circle : Icons.check_circle_outline,
                                                          size: 14.sp * 0.8,
                                                          color: _isWordMastered(word.id)
                                                              ? Theme.of(context).colorScheme.onSecondaryContainer
                                                              : Theme.of(context).colorScheme.onSurfaceVariant,
                                                        ),
                                                        SizedBox(width: 4.w * 0.8),
                                                        Text(
                                                          _isWordMastered(word.id) ? 'Mark Unlearned' : 'Mark Learned',
                                                          style: TextStyle(
                                                            fontSize: 11.sp * 0.8,
                                                            fontWeight: FontWeight.w500,
                                                            color: _isWordMastered(word.id)
                                                                ? Theme.of(context).colorScheme.onSecondaryContainer
                                                                : Theme.of(context).colorScheme.onSurfaceVariant,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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
