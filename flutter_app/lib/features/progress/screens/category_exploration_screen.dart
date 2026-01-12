import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/di/injection.dart';
import '../../../core/network/api_service.dart';
import '../../../core/models/category.dart';
import '../../../app/app_router.dart';

class CategoryExplorationScreen extends StatefulWidget {
  const CategoryExplorationScreen({super.key});

  @override
  State<CategoryExplorationScreen> createState() => _CategoryExplorationScreenState();
}

class _CategoryExplorationScreenState extends State<CategoryExplorationScreen> {
  final ApiService _apiService = getIt<ApiService>();
  List<Category> _categories = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final categories = await _apiService.getCategories();
      // Filter to only parent categories (parentCategoryId is null)
      final parentCategories = categories.where((c) => c.parentCategoryId == null).toList();
      setState(() {
        _categories = parentCategories;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore by Category'),
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
                        onPressed: _loadCategories,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : _categories.isEmpty
                  ? Center(
                      child: Text(
                        'No categories available',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  : GridView.builder(
                      padding: EdgeInsets.all(16.w),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.w,
                        mainAxisSpacing: 16.h,
                        childAspectRatio: 1.3,
                      ),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        return Card(
                          elevation: 2,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                AppRouter.subcategories,
                                arguments: {'category': category},
                              );
                            },
                            borderRadius: BorderRadius.circular(12.r),
                            child: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.category,
                                    size: 32.sp,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  SizedBox(height: 8.h),
                                  Flexible(
                                    child: Text(
                                      category.name,
                                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14.sp,
                                          ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}
