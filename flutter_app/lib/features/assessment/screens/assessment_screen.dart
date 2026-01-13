import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../bloc/assessment_bloc.dart';
import '../../../core/models/models.dart';
import '../../../core/di/injection.dart';
import '../../../core/network/api_service.dart';
import '../../../../app/app_router.dart';

class AssessmentScreen extends StatefulWidget {
  const AssessmentScreen({super.key});

  @override
  State<AssessmentScreen> createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  bool _isFirstTime = true;
  bool _checkingFirstTime = true;

  @override
  void initState() {
    super.initState();
    _checkIfFirstTime();
    context.read<AssessmentBloc>().add(LoadAssessmentStack());
  }

  Future<void> _checkIfFirstTime() async {
    try {
      final apiService = getIt<ApiService>();
      final stats = await apiService.getStats();
      if (mounted) {
        setState(() {
          _isFirstTime = stats.learningWords == 0 && stats.masteredWords == 0 && stats.reviewingWords == 0;
          _checkingFirstTime = false;
        });
  }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isFirstTime = true; // Default to first time on error
          _checkingFirstTime = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AssessmentBloc, AssessmentState>(
        listener: (context, state) async {
          if (state is AssessmentCompleted) {
            // Check if user has words in progress
            try {
              final apiService = getIt<ApiService>();
              final stats = await apiService.getStats();
              
              // If no words in progress, navigate to recommendations
              if (stats.learningWords == 0) {
                Navigator.pushReplacementNamed(
                  context,
                  AppRouter.stackRecommendations,
                  arguments: {'result': state.result},
                );
              } else {
                // User already has words, go to main app
                Navigator.pushReplacementNamed(context, AppRouter.main);
              }
            } catch (e) {
              // On error, still navigate to recommendations
              Navigator.pushReplacementNamed(
                context,
                AppRouter.stackRecommendations,
                arguments: {'result': state.result},
              );
            }
          } else if (state is AssessmentError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AssessmentLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AssessmentError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AssessmentBloc>().add(LoadAssessmentStack());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is AssessmentStackLoaded) {
            final words = state.stack.words;
            final currentIndex = state.currentIndex;
            final currentWord = words[currentIndex];
            final completed = state.responses.length;
            final total = words.length;
            final progress = completed / total;

            return Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              body: SafeArea(
                child: Column(
                  children: [
                    // Modern header with progress
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.quiz_outlined,
                                color: Theme.of(context).colorScheme.primary,
                                size: 24.sp,
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Vocabulary Assessment',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      _isFirstTime
                                          ? 'Help us understand your vocabulary level'
                                          : 'Align your progress and difficulty level',
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                                child: Text(
                                  '$completed/$total',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          // Modern progress bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 8.h,
                              backgroundColor: Theme.of(context).colorScheme.surface,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Card area
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Question prompt
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                'Do you know this word?',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 32.h),
                            // Swipeable card
                            Expanded(
                              child: _SwipeableCard(
                                word: currentWord,
                                onSwipeLeft: () {
                                  context.read<AssessmentBloc>().add(
                                        SubmitAssessmentResponse(
                                          wordId: currentWord.id,
                                          response: 'don\'t_know',
                                        ),
                                      );
                                },
                                onSwipeRight: () {
                                  context.read<AssessmentBloc>().add(
                                        SubmitAssessmentResponse(
                                          wordId: currentWord.id,
                                          response: 'know',
                                        ),
                                      );
                                },
                                onMaybe: () {
                                  context.read<AssessmentBloc>().add(
                                        SubmitAssessmentResponse(
                                          wordId: currentWord.id,
                                          response: 'maybe',
                                        ),
                                      );
                                },
                              ),
                            ),
                            SizedBox(height: 12.h),
                            // Swipe instruction text - right below card
                            Text(
                              'Swipe left or right, or tap "Can\'t say"',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            // Instruction chips - closer to card
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: _InstructionChip(
                                      icon: Icons.arrow_back_rounded,
                                      label: "Don't know",
                                      color: Colors.red,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Expanded(
                                    child: _InstructionChip(
                                      icon: Icons.arrow_forward_rounded,
                                      label: "I know",
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Auto-submit when all words are answered
                    if (completed == total)
                      BlocBuilder<AssessmentBloc, AssessmentState>(
                        builder: (context, state) {
                          if (state is AssessmentSubmitting) {
                            return Container(
                              padding: EdgeInsets.all(24.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircularProgressIndicator(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                  SizedBox(height: 16.h),
                                  Text(
                                    'Processing your assessment...',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).colorScheme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          // Auto-submit when all words answered
                          if (state is AssessmentStackLoaded && completed == total) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              context.read<AssessmentBloc>().add(SubmitAssessment());
                            });
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                  ],
                ),
              ),
            );
          }

          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }
}

class _SwipeableCard extends StatefulWidget {
  final AssessmentWord word;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback onMaybe;

  const _SwipeableCard({
    required this.word,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    required this.onMaybe,
  });

  @override
  State<_SwipeableCard> createState() => _SwipeableCardState();
}

class _SwipeableCardState extends State<_SwipeableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  double _dragPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(1.5, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragPosition += details.primaryDelta!;
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    const threshold = 100.0;
    if (_dragPosition > threshold) {
      // Swipe right - know
      widget.onSwipeRight();
      _controller.forward().then((_) {
        setState(() {
          _dragPosition = 0.0;
        });
        _controller.reset();
      });
    } else if (_dragPosition < -threshold) {
      // Swipe left - don't know
      widget.onSwipeLeft();
      _controller.forward().then((_) {
        setState(() {
          _dragPosition = 0.0;
        });
        _controller.reset();
      });
    } else {
      // Return to center
      setState(() {
        _dragPosition = 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dragRatio = (_dragPosition / screenWidth).clamp(-1.0, 1.0);
    final opacity = 1.0 - (dragRatio.abs() * 0.5).clamp(0.0, 0.5);
    final rotation = dragRatio * 0.1;

    return GestureDetector(
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background indicators with better styling
          if (_dragPosition > 50)
            Positioned(
              right: 40.w,
              child: AnimatedOpacity(
                opacity: (_dragPosition / 200).clamp(0.0, 1.0),
                duration: const Duration(milliseconds: 100),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.green.withOpacity(0.5),
                      width: 3,
                    ),
                  ),
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: Colors.green,
                    size: 48.sp,
                  ),
                ),
              ),
            ),
          if (_dragPosition < -50)
            Positioned(
              left: 40.w,
              child: AnimatedOpacity(
                opacity: (_dragPosition.abs() / 200).clamp(0.0, 1.0),
                duration: const Duration(milliseconds: 100),
                child: Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.red.withOpacity(0.5),
                      width: 3,
                    ),
                  ),
                  child: Icon(
                    Icons.cancel_rounded,
                    color: Colors.red,
                    size: 48.sp,
                  ),
                ),
              ),
            ),
          // Modern card design
          Transform.translate(
            offset: Offset(_dragPosition, 0),
            child: Transform.rotate(
              angle: rotation,
              child: Opacity(
                opacity: opacity,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 0.9.sw,
                    maxHeight: 0.6.sh,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Theme.of(context).colorScheme.surface,
                          Theme.of(context).colorScheme.surfaceContainerHighest,
                        ],
                      ),
                      boxShadow: [
                        // Multiple shadow layers for depth and elevation
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                          spreadRadius: 2,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 40,
                          offset: const Offset(0, 16),
                          spreadRadius: -4,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 60,
                          offset: const Offset(0, 24),
                          spreadRadius: -8,
                        ),
                      ],
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    padding: EdgeInsets.all(32.w),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Word
                          Text(
                            widget.word.word,
                            style: TextStyle(
                              fontSize: 48.sp * 0.8,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                              letterSpacing: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          // Pronunciation
                          if (widget.word.pronunciation != null) ...[
                            SizedBox(height: 16.h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                widget.word.pronunciation!,
                                style: TextStyle(
                                  fontSize: 20.sp * 0.8,
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ],
                          SizedBox(height: 48.h),
                          // Can't say button - modern design
                          OutlinedButton.icon(
                            onPressed: widget.onMaybe,
                            icon: Icon(
                              Icons.help_outline_rounded,
                              size: 20.sp * 0.8,
                            ),
                            label: Text(
                              'Can\'t say',
                              style: TextStyle(
                                fontSize: 16.sp * 0.8,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: 32.w,
                                vertical: 16.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              side: BorderSide(
                                color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
                                width: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _InstructionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _InstructionChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16.sp),
          SizedBox(width: 4.w),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 11.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
