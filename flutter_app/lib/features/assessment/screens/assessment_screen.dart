import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

            // Count "know" responses as correct
            final correctCount = state.responses.values
                .where((r) => r == 'know')
                .length;

            return SafeArea(
              child: Column(
                children: [
                  // Description and progress bar
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Assessment',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _isFirstTime
                              ? 'This assessment helps us understand your vocabulary knowledge base to provide better word recommendations tailored to your level.'
                              : 'This assessment will help align your progress and ensure you\'re learning words at the right difficulty level.',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        LinearProgressIndicator(
                          value: completed / total,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$completed of $total words',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  // Card area with hints in a tight column
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Question text immediately above card
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Do you know the word?',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'Swipe to answer or click on can\'t say.',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // Card
                          _SwipeableCard(
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
                          // Instructions immediately below card
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              children: [
                                
                                const SizedBox(height: 24),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _InstructionChip(
                                      icon: Icons.arrow_back,
                                      label: "Don't know",
                                      color: Colors.red,
                                    ),
                                    _InstructionChip(
                                      icon: Icons.help_outline,
                                      label: "Can't say",
                                      color: Colors.orange,
                                    ),
                                    _InstructionChip(
                                      icon: Icons.arrow_forward,
                                      label: "I know",
                                      color: Colors.green,
                                    ),
                                  ],
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
                          return Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                const CircularProgressIndicator(),
                                const SizedBox(height: 16),
                                Text(
                                  'Processing your assessment...',
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
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
    final opacity = 1.0 - (_dragPosition.abs() / screenWidth).clamp(0.0, 0.5);

    return GestureDetector(
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background indicators
          if (_dragPosition > 50)
            Positioned(
              right: 20,
              child: Icon(
                Icons.check_circle,
                color: Colors.green.withOpacity(opacity),
                size: 60,
              ),
            ),
          if (_dragPosition < -50)
            Positioned(
              left: 20,
              child: Icon(
                Icons.cancel,
                color: Colors.red.withOpacity(opacity),
                size: 60,
              ),
            ),
          // Card
          Transform.translate(
            offset: Offset(_dragPosition, 0),
            child: Opacity(
              opacity: opacity,
              child: Card(
                elevation: 8,
                margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                child: Container(
                  constraints: const BoxConstraints(minWidth: 300, minHeight: 400, maxWidth: 400, maxHeight: 500),
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.word.word,
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      if (widget.word.pronunciation != null) ...[
                        const SizedBox(height: 16),
                        Text(
                          widget.word.pronunciation!,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Colors.grey[600],
                              ),
                        ),
                      ],
                      const SizedBox(height: 42),
                      // Can't say button
                      OutlinedButton.icon(
                        onPressed: widget.onMaybe,
                        icon: const Icon(Icons.help_outline),
                        label: const Text('Can\'t say'),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(color: color, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
