import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;
import '../../../core/di/injection.dart';
import '../../../core/network/api_service.dart';
import '../../../core/models/models.dart';
import '../../../app/app_router.dart';
import '../../assessment/screens/stack_recommendation_screen.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  final ApiService _apiService = getIt<ApiService>();
  UserStats? _stats;
  Map<String, int>? _pastReviews;
  Map<String, int>? _upcomingReviews;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final stats = await _apiService.getStats();
      final history = await _apiService.getReviewHistory(365); // Last year
      
      setState(() {
        _stats = stats;
        _pastReviews = Map<String, int>.from(history['past_reviews'] ?? {});
        _upcomingReviews = Map<String, int>.from(history['upcoming_reviews'] ?? {});
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
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.trending_up_rounded),
            const SizedBox(width: 8),
            Text(
              'Progress',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
          ],
        ),
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
                        onPressed: _loadData,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _loadData,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Overview stats
                        _buildStatsSection(context),
                        SizedBox(height: 24.h),
                        // Review calendar
                        _buildCalendarSection(context),
                        SizedBox(height: 24.h),
                        // Actions
                        _buildActionsSection(context),
                        SizedBox(height: 24.h),
                        // Browse words
                        _buildBrowseWordsSection(context),
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildStatsSection(BuildContext context) {
    if (_stats == null) return const SizedBox.shrink();
    
    // Calculate total words as sum of learning + reviewing + mastered
    final totalWordsInProgress = _stats!.learningWords + _stats!.reviewingWords + _stats!.masteredWords;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Total Words',
                value: totalWordsInProgress.toString(),
                icon: Icons.library_books,
                color: Colors.blue,
                onTap: () => _navigateToWordList(context, 'all'),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _StatCard(
                title: 'Mastered',
                value: '${_stats!.masteredWords}',
                icon: Icons.check_circle,
                color: Colors.green,
                onTap: () => _navigateToWordList(context, 'mastered'),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Learning',
                value: '${_stats!.learningWords}',
                icon: Icons.school,
                color: Colors.orange,
                onTap: () => _navigateToWordList(context, 'learning'),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _StatCard(
                title: 'Reviewing',
                value: '${_stats!.reviewingWords}',
                icon: Icons.refresh,
                color: Colors.purple,
                onTap: () => _navigateToWordList(context, 'reviewing'),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Card(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Text(
                  'Accuracy Rate',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  '${_stats!.accuracyRate.toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 36.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                LinearProgressIndicator(
                  value: _stats!.accuracyRate / 100.0,
                  backgroundColor: Colors.grey[300],
                  minHeight: 8.h,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress Calendar',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 12.h),
        Card(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: _ReviewCalendar(
              pastReviews: _pastReviews ?? {},
              upcomingReviews: _upcomingReviews ?? {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, AppRouter.stackRecommendations);
          },
          icon: Icon(Icons.recommend, size: 20.sp),
          label: Text('Recommend New Words', style: TextStyle(fontSize: 16.sp)),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16.h),
          ),
        ),
        SizedBox(height: 12.h),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.pushNamed(context, AppRouter.assessment);
          },
          icon: Icon(Icons.quiz, size: 20.sp),
          label: Text('Start New Assessment', style: TextStyle(fontSize: 16.sp)),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16.h),
          ),
        ),
      ],
    );
  }

  void _navigateToWordList(BuildContext context, String filter) async {
    await Navigator.pushNamed(
      context,
      AppRouter.browseWords,
      arguments: {'filter': filter},
    );
    // Refresh stats when returning from word list
    if (mounted) {
      _loadData();
    }
  }

  Widget _buildBrowseWordsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Browse All Words',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        SizedBox(height: 12.h),
        Card(
          child: ListTile(
            leading: const Icon(Icons.search),
            title: const Text('Explore Vocabulary'),
            subtitle: const Text('Browse and add words to your learning stack'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(context, AppRouter.browseWords);
            },
          ),
        ),
        SizedBox(height: 12.h),
        Card(
          child: ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Explore by Category'),
            subtitle: const Text('Browse words organized by categories'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(context, AppRouter.categoryExploration);
            },
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24.sp),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      value,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null)
                Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  size: 20.sp,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReviewCalendar extends StatelessWidget {
  final Map<String, int> pastReviews;
  final Map<String, int> upcomingReviews;

  const _ReviewCalendar({
    required this.pastReviews,
    required this.upcomingReviews,
  });

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    // Show: previous month, current month (2nd), then 6 future months
    final startDate = DateTime(today.year, today.month - 1, 1); // Previous month
    final endDate = DateTime(today.year, today.month + 7, 0); // 6 months in future (month + 7 gives us 6 months ahead)
    final totalDays = endDate.difference(startDate).inDays + 1;
    
    // Group days by month
    final months = <String, List<DateTime>>{};
    final monthNames = <String, String>{};
    
    for (int i = 0; i < totalDays; i++) {
      final day = startDate.add(Duration(days: i));
      final monthKey = '${day.year}-${day.month.toString().padLeft(2, '0')}';
      final monthName = '${_getMonthName(day.month)} ${day.year}';
      
      if (!months.containsKey(monthKey)) {
        months[monthKey] = [];
        monthNames[monthKey] = monthName;
      }
      months[monthKey]!.add(day);
    }
    
    // Sort months: previous month first, then current month (2nd), then future months
    final todayKey = '${today.year}-${today.month.toString().padLeft(2, '0')}';
    final previousMonthKey = today.month == 1 
        ? '${today.year - 1}-12'
        : '${today.year}-${(today.month - 1).toString().padLeft(2, '0')}';
    
    // Sort months: previous month first, then current month (2nd), then future months
    final sortedMonths = months.entries.toList()
      ..sort((a, b) {
        final aKey = a.key;
        final bKey = b.key;
        
        // Previous month always first
        if (aKey == previousMonthKey) return -1;
        if (bKey == previousMonthKey) return 1;
        
        // Current month always second (if not previous)
        if (aKey == todayKey) return -1;
        if (bKey == todayKey) return 1;
        
        // All other months in ascending order (future months)
        return aKey.compareTo(bKey);
      });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Legend
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: [
            _buildLegendItem('Past Reviews', Colors.green),
            _buildLegendItem('Upcoming', Colors.orange),
            _buildLegendItem('No Activity', Theme.of(context).colorScheme.surfaceContainerHighest),
            _buildLegendItem('Today', Theme.of(context).colorScheme.primary),
          ],
        ),
        const SizedBox(height: 16),
        // Calendar grid grouped by months
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: sortedMonths.map((monthEntry) {
              final monthKey = monthEntry.key;
              final days = monthEntry.value;
              final monthName = monthNames[monthKey]!;
              
              // Group days by weeks within the month
              final weeks = <List<DateTime?>>[];
              List<DateTime?> currentWeek = [];
              
              // Find the first day of the week for the first day of the month
              final firstDay = days.first;
              final firstDayOfWeek = firstDay.weekday; // 1 = Monday, 7 = Sunday
              
              // Add null placeholders at the start if needed
              for (int i = 1; i < firstDayOfWeek; i++) {
                currentWeek.add(null);
              }
              
              for (final day in days) {
                currentWeek.add(day);
                if (currentWeek.length == 7) {
                  weeks.add(List.from(currentWeek));
                  currentWeek.clear();
                }
              }
              
              // Add remaining days to last week with null placeholders
              if (currentWeek.isNotEmpty) {
                while (currentWeek.length < 7) {
                  currentWeek.add(null);
                }
                weeks.add(currentWeek);
              }

              return Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Month label
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        monthName,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Week day labels
                    Row(
                      children: ['M', 'T', 'W', 'Th', 'F', 'S', 'Su']
                          .map((label) => SizedBox(
                                width: 14,
                                child: Text(
                                  label,
                                  style: const TextStyle(fontSize: 9),
                                  textAlign: TextAlign.center,
                                ),
                              ))
                          .toList(),
                    ),
                    const SizedBox(height: 4),
                    // Calendar grid for this month
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: weeks.map((week) {
                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: week.map((day) {
                            // Skip placeholder days (null)
                            if (day == null) {
                              return const SizedBox(width: 14, height: 14);
                            }
                            
                            // Format date as YYYY-MM-DD to match backend
                            final dateStr = '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}';
                            final dayDate = DateTime(day.year, day.month, day.day);
                            final todayDate = DateTime(today.year, today.month, today.day);
                            final isPast = dayDate.isBefore(todayDate);
                            final isToday = dayDate.isAtSameMomentAs(todayDate);
                            
                            int count = 0;
                            Color color = Theme.of(context).colorScheme.surfaceContainerHighest;
                            
                            if (isPast) {
                              count = pastReviews[dateStr] ?? 0;
                              if (count > 0) {
                                // Green gradient based on count - dark mode compatible
                                final intensity = math.min(count / 10.0, 1.0);
                                if (Theme.of(context).brightness == Brightness.dark) {
                                  color = Color.lerp(Colors.green[400]!, Colors.green[600]!, intensity)!;
                                } else {
                                  color = Color.lerp(Colors.green[300]!, Colors.green[700]!, intensity)!;
                                }
                              }
                            } else {
                              count = upcomingReviews[dateStr] ?? 0;
                              if (count > 0) {
                                // Orange/amber gradient based on count - dark mode compatible
                                final intensity = math.min(count / 10.0, 1.0);
                                if (Theme.of(context).brightness == Brightness.dark) {
                                  color = Color.lerp(Colors.orange[400]!, Colors.orange[600]!, intensity)!;
                                } else {
                                  color = Color.lerp(Colors.orange[300]!, Colors.orange[700]!, intensity)!;
                                }
                              } else {
                                // No activity - use theme color
                                color = Theme.of(context).colorScheme.surfaceContainerHighest;
                              }
                            }
                            
                            if (isToday) {
                              color = Theme.of(context).colorScheme.primary;
                            }

                            return Container(
                              width: 12,
                              height: 12,
                              margin: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(2),
                                border: isToday
                                    ? Border.all(color: Colors.blue[900]!, width: 1)
                                    : null,
                              ),
                            );
                          }).toList(),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 16),
        // Intensity scale
        Row(
          children: [
            Text(
              'Less',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(width: 8),
            Container(width: 12, height: 12, color: Colors.green[300]),
            const SizedBox(width: 4),
            Container(width: 12, height: 12, color: Colors.green[500]),
            const SizedBox(width: 4),
            Container(width: 12, height: 12, color: Colors.green[700]),
            const SizedBox(width: 8),
            Text(
              'More',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
