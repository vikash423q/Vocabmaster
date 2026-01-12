import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/di/injection.dart';
import '../../../core/network/api_service.dart';
import '../../../core/models/models.dart';
import '../../../app/app_router.dart';

class SubcategoriesScreen extends StatefulWidget {
  final Category parentCategory;

  const SubcategoriesScreen({
    super.key,
    required this.parentCategory,
  });

  @override
  State<SubcategoriesScreen> createState() => _SubcategoriesScreenState();
}

class _SubcategoryWithCount {
  final Category category;
  final int wordCount;

  _SubcategoryWithCount({
    required this.category,
    required this.wordCount,
  });
}

class _SubcategoriesScreenState extends State<SubcategoriesScreen> {
  final ApiService _apiService = getIt<ApiService>();
  List<_SubcategoryWithCount> _subcategories = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSubcategories();
  }

  Future<int> _getWordCount(int categoryId) async {
    try {
      // Fetch words with pagination to count them
      // API has max limit of 500, so we'll fetch in batches
      const maxLimit = 500;
      int totalCount = 0;
      int offset = 0;
      bool hasMore = true;
      
      while (hasMore) {
        final words = await _apiService.getWords({
          'category_id': categoryId,
          'limit': maxLimit,
          'offset': offset,
        });
        
        totalCount += words.length;
        offset += words.length;
        hasMore = words.length >= maxLimit;
      }
      
      return totalCount;
    } catch (e) {
      // Log error for debugging
      debugPrint('Error getting word count for category $categoryId: $e');
      return 0;
    }
  }

  Future<void> _loadSubcategories() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final categories = await _apiService.getCategories();
      // Filter to subcategories of this parent
      final subcategories = categories
          .where((c) => c.parentCategoryId == widget.parentCategory.id)
          .toList();
      
      // If no subcategories, use the parent category itself
      final categoriesToShow = subcategories.isEmpty 
          ? [widget.parentCategory] 
          : subcategories;
      
      // Get word counts for each category
      final List<_SubcategoryWithCount> subcategoriesWithCounts = [];
      for (final category in categoriesToShow) {
        final wordCount = await _getWordCount(category.id);
        subcategoriesWithCounts.add(_SubcategoryWithCount(
          category: category,
          wordCount: wordCount,
        ));
      }
      
      setState(() {
        _subcategories = subcategoriesWithCounts;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _addCategoryToStack(int categoryId) async {
    try {
      // Show loading indicator
      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const Center(child: CircularProgressIndicator()),
        );
      }

      // Get all words in this category/subcategory
      // Fetch in batches since limit might be enforced
      List<int> allWordIds = [];
      int offset = 0;
      const limit = 100;
      bool hasMore = true;

      while (hasMore) {
        final words = await _apiService.getWords({
          'category_id': categoryId,
          'limit': limit,
          'offset': offset,
        });

        if (words.isEmpty) {
          hasMore = false;
        } else {
          allWordIds.addAll(words.map((w) => w.id));
          offset += words.length;
          hasMore = words.length >= limit;
        }
      }

      // Close loading dialog
      if (mounted) {
        Navigator.pop(context);
      }

      if (allWordIds.isEmpty) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No words found in this category')),
          );
        }
        return;
      }

      // Add all words to stack
      await _apiService.addWords(AddWordsRequest(wordIds: allWordIds));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added ${allWordIds.length} word(s) to your learning stack'),
          ),
        );
      }
    } catch (e) {
      // Close loading dialog if still open
      if (mounted && Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.parentCategory.name),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_error!),
                      SizedBox(height: 16.h),
                      ElevatedButton(
                        onPressed: _loadSubcategories,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _subcategories.isEmpty
                  ? Center(
                      child: Text(
                        'No subcategories available',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.all(16.w),
                      itemCount: _subcategories.length,
                      itemBuilder: (context, index) {
                        final item = _subcategories[index];
                        final subcategory = item.category;
                        return Card(
                          margin: EdgeInsets.only(bottom: 8.h),
                          child: Padding(
                            padding: EdgeInsets.all(12.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        subcategory.name,
                                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).colorScheme.primaryContainer,
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                      child: Text(
                                        '${item.wordCount}',
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: OutlinedButton.icon(
                                        onPressed: () => _addCategoryToStack(subcategory.id),
                                        icon: const Icon(Icons.add_circle_outline, size: 18),
                                        label: const Text('Add to Stack'),
                                        style: OutlinedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(vertical: 8.h),
                                          minimumSize: Size.zero,
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                            context,
                                            AppRouter.browseWords,
                                            arguments: {
                                              'subcategory_id': subcategory.id,
                                            },
                                          );
                                        },
                                        icon: const Icon(Icons.visibility, size: 18),
                                        label: const Text('View Words'),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(vertical: 8.h),
                                          minimumSize: Size.zero,
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
