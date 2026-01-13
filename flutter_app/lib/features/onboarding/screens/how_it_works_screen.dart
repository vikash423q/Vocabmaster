import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../app/app_router.dart';

class HowItWorksScreen extends StatelessWidget {
  final bool showSkipButton;
  final VoidCallback? onComplete;

  const HowItWorksScreen({
    super.key,
    this.showSkipButton = false,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (showSkipButton)
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRouter.assessment,
                        );
                      },
                      child: const Text('Skip'),
                    )
                  else
                    const SizedBox.shrink(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.lightbulb_outline,
                            size: 64.sp,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'How VocabMaster Works',
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Master vocabulary with science-backed learning',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    // Step 1: Assessment
                    _buildStepWithConnector(
                      context,
                      stepNumber: 1,
                      icon: Icons.psychology_outlined,
                      title: 'Take Your Assessment',
                      description:
                          'Start with a quick assessment to determine your vocabulary level. We personalize your learning journey.',
                      color: Theme.of(context).colorScheme.primary,
                      showConnectorBelow: true,
                    ),
                    // Step 2: Add Words
                    _buildStepWithConnector(
                      context,
                      stepNumber: 2,
                      icon: Icons.add_circle_outline,
                      title: 'Add Words to Your Stack',
                      description:
                          'Browse thousands of words or explore by category. Add words that interest you or align with your learning goals.',
                      color: Theme.of(context).colorScheme.secondary,
                      showConnectorBelow: true,
                    ),
                    // Step 3: Daily Review
                    _buildStepWithConnector(
                      context,
                      stepNumber: 3,
                      icon: Icons.quiz_outlined,
                      title: 'Daily Review Sessions',
                      description:
                          'Review your words through interactive quizzes. Answer multiple-choice questions and get immediate feedback.',
                      color: Theme.of(context).colorScheme.tertiary,
                      showConnectorBelow: true,
                    ),
                    // Step 4: Fibonacci Spaced Repetition
                    _buildStepWithConnector(
                      context,
                      stepNumber: 4,
                      icon: Icons.timeline_outlined,
                      title: 'Fibonacci Spaced Repetition',
                      description:
                          'Our algorithm uses Fibonacci intervals to schedule reviews. Words you know well appear less frequently, maximizing retention.',
                      color: Theme.of(context).colorScheme.primary,
                      highlight: true,
                      showConnectorBelow: true,
                    ),
                    // Step 5: Track Progress
                    _buildStepWithConnector(
                      context,
                      stepNumber: 5,
                      icon: Icons.trending_up_outlined,
                      title: 'Track Your Progress',
                      description:
                          'Monitor your learning journey with detailed statistics. See how many words you\'re learning, reviewing, and have mastered.',
                      color: Theme.of(context).colorScheme.primary,
                      showConnectorBelow: false,
                    ),
                    SizedBox(height: 32.h),
                    // Fibonacci Explanation Card - at bottom
                    _buildFibonacciCard(context),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
            // Action Button
            if (showSkipButton)
              Padding(
                padding: EdgeInsets.all(24.w),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (showSkipButton) {
                        Navigator.pushReplacementNamed(
                          context,
                          AppRouter.assessment,
                        );
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Start Assessment',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepWithConnector(
    BuildContext context, {
    required int stepNumber,
    required IconData icon,
    required String title,
    required String description,
    required Color color,
    bool highlight = false,
    required bool showConnectorBelow,
  }) {
    final numberSize = 22.w;
    final halfNumber = numberSize / 2;
    
    return Column(
      children: [
        // Step content card with groove for number
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(14.w, 8.h + halfNumber, 14.w, 14.w),
              decoration: BoxDecoration(
                color: highlight
                    ? color.withOpacity(0.2)
                    : Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(12.r),
                border: highlight
                    ? Border.all(
                        color: color,
                        width: 2,
                      )
                    : null,
              ),
              child: Column(
                children: [
                  // Icon and content (no extra spacing needed since number is positioned absolutely)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Icon
                      Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(icon, color: color, size: 22.sp),
                      ),
                      SizedBox(width: 12.w),
                      // Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: color,
                                    fontSize: 15.sp,
                                  ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              description,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    height: 1.4,
                                    fontSize: 12.sp,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Step number positioned half above, half inside (in groove)
            Positioned(
              top: -halfNumber,
              child: Container(
                width: numberSize,
                height: numberSize,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: highlight
                        ? color.withOpacity(0.2)
                        : Theme.of(context).colorScheme.surfaceContainerHighest,
                    width: 3,
                  ),
                ),
                child: Center(
                  child: Text(
                    '$stepNumber',
                    style: TextStyle(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // Solid connector below (if not last step)
        if (showConnectorBelow) ...[
          SizedBox(height: 8.h),
          Container(
            width: 2.w,
            height: 24.h,
            color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
          ),
          SizedBox(height: 8.h),
        ],
      ],
    );
  }

  Widget _buildFibonacciCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.auto_awesome,
                color: Theme.of(context).colorScheme.primary,
                size: 28.sp,
              ),
              SizedBox(width: 12.w),
              Text(
                'Why Fibonacci?',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'The Fibonacci sequence creates optimal spacing between reviews. As you master words, the intervals grow naturally, ensuring you review at the perfect moment for long-term retention.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
          ),
          SizedBox(height: 16.h),
          // Visual representation - Fibonacci sequence: 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 180
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: _generateFibonacciSequence().map((num) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Text(
                  '$num',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 8.h),
          Text(
            'Review days',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
                  fontStyle: FontStyle.italic,
                ),
          ),
        ],
      ),
    );
  }

  // Generate Fibonacci sequence: 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 180
  List<int> _generateFibonacciSequence() {
    return [1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 180];
  }
}
