import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import 'package:card_stack_swiper/card_stack_swiper.dart';
import '../../../../app/app_router.dart';
import '../../../core/di/injection.dart';
import '../../../core/network/api_service.dart';
import '../../../core/models/word.dart';
import '../../../core/models/progress.dart';

class DailyStackScreen extends StatefulWidget {
  const DailyStackScreen({super.key});

  @override
  State<DailyStackScreen> createState() => _DailyStackScreenState();
}

class _DailyStackScreenState extends State<DailyStackScreen> {
  final ApiService _apiService = getIt<ApiService>();
  int? _wordsInProgress;
  
  // Card management
  int _currentCardIndex = 0;
  List<DailyStackQuestion> _unreviewedItems = [];
  final CardStackSwiperController _swiperController = CardStackSwiperController();

  @override
  void initState() {
    super.initState();
    _loadWordsInProgress();
  }

  @override
  void dispose() {
    _swiperController.dispose();
    super.dispose();
  }

  Future<void> _loadWordsInProgress() async {
    try {
      final stats = await _apiService.getStats();
      if (mounted) {
        setState(() {
          _wordsInProgress = stats.learningWords;
        });
      }
    } catch (e) {
      // Ignore errors
    }
  }

  // No longer needed - questions come with DailyStackQuestion from API

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DailyStackQuestion>>(
      future: _apiService.getDailyStack(null),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.book_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Daily Review',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.book_outlined,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Daily Review',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }
        
        final allItems = snapshot.data ?? [];
        final unreviewed = allItems.where((item) => !item.isReviewed).toList();
        
        // Initialize state on first load
        if (_unreviewedItems.isEmpty && unreviewed.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                _unreviewedItems = unreviewed;
                _currentCardIndex = 0;
              });
              _swiperController.moveTo(0);
            }
          });
        }
        
        return Scaffold(
          appBar: AppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.book_outlined),
                const SizedBox(width: 8),
                  Text(
                    'Daily Review',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
              ],
            ),
            actions: [],
          ),
          body: unreviewed.isEmpty
              ? _buildEmptyState()
              : _buildDeckUI(context, unreviewed),
        );
      },
    );
  }

  Future<void> _submitAnswer(
    BuildContext context,
    DailyStackQuestion item,
    String selectedWord,
    bool isCorrect,
    MCQQuestion question,
  ) async {
    try {
      // Submit review to backend
      final reviewRequest = ReviewSubmit(
        wordId: item.wordId,
        isCorrect: isCorrect,
        questionType: 'multiple_choice',  // Match backend QuestionType enum
        correctAnswer: question.correctAnswer,
        userAnswer: selectedWord,
        optionsPresented: question.options,
        timeTakenSeconds: null,
      );
      
      final reviewResponse = await _apiService.submitReview(reviewRequest);
      
      // Handle navigation based on correctness
      if (!isCorrect) {
        // Navigate to comprehensive review screen after 3 seconds
        Timer(const Duration(seconds: 2), () {
          if (mounted) {
            Navigator.pushNamed(
              context,
              AppRouter.wordDetail,
              arguments: {
                'wordId': item.wordId,
                'fromReview': true,
              },
            ).then((_) {
              _removeReviewedItem(item.wordId);
            });
          }
        });
      } else {
        // Correct answer - navigate to comprehensive review screen
        // For new words (level 0), always navigate to review screen
        if (question.level == 0) {
          Timer(const Duration(seconds: 1), () {
            if (mounted) {
              Navigator.pushNamed(
                context,
                AppRouter.wordDetail,
                arguments: {'wordId': item.wordId},
              ).then((_) {
                _removeReviewedItem(item.wordId);
              });
            }
          });
        } else {
          // For other levels, show correct answer dialog
          _showCorrectAnswer(context, item, reviewResponse.newLevel);
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error submitting review: $e')),
        );
      }
    }
  }

  void _showCorrectAnswer(BuildContext context, DailyStackQuestion item, int newLevel) {
    // Show correct answer dialog with word details
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _buildCorrectAnswerDialog(
        context,
        item.wordDetail,
        () {
          Navigator.of(context).pop();
          _removeReviewedItem(item.wordId);
        },
      ),
    );
  }

  void _removeReviewedItem(int wordId) {
    if (_unreviewedItems.isEmpty) return;
    
    setState(() {
      final removedIndex = _unreviewedItems.indexWhere((item) => item.wordId == wordId);
      if (removedIndex >= 0) {
        _unreviewedItems = _unreviewedItems.where((item) => item.wordId != wordId).toList();
        
        // Adjust current index
        if (_currentCardIndex >= _unreviewedItems.length && _unreviewedItems.isNotEmpty) {
          _currentCardIndex = _unreviewedItems.length - 1;
        } else if (_currentCardIndex >= _unreviewedItems.length) {
          _currentCardIndex = 0;
        }
        
        // Reload if empty
        if (_unreviewedItems.isEmpty && mounted) {
          setState(() {});
        }
      }
    });
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 80.sp,
              color: Colors.grey[400],
            ),
            SizedBox(height: 24.h),
            Text(
              'All caught up! 🎉',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
              ),
            ),
            SizedBox(height: 16.h),
            if (_wordsInProgress != null && _wordsInProgress! > 0)
              Text(
                'You have $_wordsInProgress ${_wordsInProgress == 1 ? 'word' : 'words'} in progress.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16.sp,
                ),
                textAlign: TextAlign.center,
              )
            else
              Text(
                'You don\'t have any words in progress yet.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16.sp,
                ),
                textAlign: TextAlign.center,
              ),
            SizedBox(height: 8.h),
            Text(
              'Would you like to add new words to your learning stack?',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.stackRecommendations);
              },
              icon: Icon(Icons.add_circle_outline, size: 20.sp),
              label: Text('Discover New Words', style: TextStyle(fontSize: 16.sp)),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 16.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeckUI(BuildContext context, List<DailyStackQuestion> unreviewed) {
    return StatefulBuilder(
      builder: (context, setLocalState) {
        return Column(
          children: [
            // Review count header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reviews left for today',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
                  Text(
                    '${unreviewed.length}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 24.sp,
                    ),
                  ),
                ],
              ),
            ),
            // Card stack swiper
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 0.85.sw,
                  height: 0.6.sh,
                  child: CardStackSwiper(
                    controller: _swiperController,
                    cardsCount: unreviewed.length,
                    initialIndex: _currentCardIndex,
                    isLoop: true,
                    maxAngle: 20,
                    threshold: 30,
                    backCardOffset: const Offset(20, 0),
                    backCardAngle: 0.1,
                    backCardScale: 0.9,
                    allowedSwipeDirection: AllowedSwipeDirection.all(),
                    swipeAnimationDuration: const Duration(milliseconds: 300),
                    returnAnimationDuration: const Duration(milliseconds: 400),
                    onSwipe: (previousIndex, currentIndex, direction) {
                      if (currentIndex != null) {
                        setLocalState(() {
                          _currentCardIndex = currentIndex;
                        });
                      }
                      return true;
                    },
                    cardBuilder: (context, index, horizontalPercentage, verticalPercentage) {
                      if (index >= unreviewed.length) {
                        return const SizedBox.shrink();
                      }
                      
                      final item = unreviewed[index];
                      final question = item.question;
                      
                      return _MCQCardWidget(
                        key: ValueKey('mcq_${item.wordId}_$index'),
                        question: question,
                        wordDetail: item.wordDetail,
                        onAnswerSelected: (selectedWord, isCorrect) async {
                          await _submitAnswer(context, item, selectedWord, isCorrect, question);
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
        // Navigation hint
        if (unreviewed.length > 1)
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.swipe,
                  size: 20.sp,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
                SizedBox(width: 8.w),
                Text(
                  'Swipe to navigate through cards',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          ],
        );
      },
    );
  }

  Widget _buildCorrectAnswerDialog(BuildContext context, WordDetail wordDetail, VoidCallback onContinue) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Success card
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 48.sp, color: Colors.green),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Correct! 🎉',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900],
                          fontSize: 20.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Great job!',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.green[700],
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Word details
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(8.w),
              child: _buildWordDetailsCard(context, wordDetail),
            ),
          ),
          // Continue button
          Padding(
            padding: EdgeInsets.all(16.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onContinue,
                icon: Icon(Icons.arrow_forward, size: 20.sp),
                label: Text('Continue Review', style: TextStyle(fontSize: 16.sp)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWordDetailsCard(BuildContext context, WordDetail wordDetail) {
    final primaryDef = wordDetail.definitions.firstWhere(
      (def) => def.isPrimary,
      orElse: () => wordDetail.definitions.first,
    );
    
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category and tone at top right - horizontal scrollable
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (wordDetail.tone != null) _buildToneIndicator(context, wordDetail.tone!),
                  if (wordDetail.category != null) ...[
                    if (wordDetail.tone != null) SizedBox(width: 8.w),
                    Chip(
                      label: Text(wordDetail.category!.name, style: TextStyle(fontSize: 12.sp)),
                      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp,
                      ),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                        width: 1,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: 12.h),
            // Word
            Text(
              wordDetail.word,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 24.sp,
              ),
            ),
            if (wordDetail.pronunciation != null) ...[
              SizedBox(height: 4.h),
              Text(
                wordDetail.pronunciation!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                  fontSize: 14.sp,
                ),
              ),
            ],
            SizedBox(height: 16.h),
            // Definition
            Text(
              'Definition',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              primaryDef.text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.5,
                fontSize: 14.sp,
              ),
            ),
            // Examples
            if (primaryDef.examples.isNotEmpty) ...[
              SizedBox(height: 16.h),
              Text(
                'Examples',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 8.h),
              ...primaryDef.examples.map((example) => Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Text(
                  '• $example',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[700],
                    fontSize: 14.sp,
                  ),
                ),
              )),
            ],
            // Etymology
            if (wordDetail.etymology != null && wordDetail.etymology!.evolution != null) ...[
              SizedBox(height: 8.h),
              Text(
                'Origin',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                wordDetail.etymology!.evolution!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
                  fontSize: 12.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildToneIndicator(BuildContext context, String tone) {
    String emoji;
    Color color;
    
    switch (tone.toLowerCase()) {
      case 'positive':
        emoji = '😊';
        color = Colors.green;
        break;
      case 'negative':
        emoji = '😞';
        color = Colors.red;
        break;
      default: // neutral
        emoji = '😐';
        color = Colors.grey;
        break;
    }
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: TextStyle(fontSize: 14.sp)),
          SizedBox(width: 4.w),
          Text(
            tone.toUpperCase(),
            style: TextStyle(
              color: color,
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _MCQCardWidget extends StatefulWidget {
  final MCQQuestion question;
  final WordDetail wordDetail;
  final Function(String, bool) onAnswerSelected;

  const _MCQCardWidget({
    super.key,
    required this.question,
    required this.wordDetail,
    required this.onAnswerSelected,
  });

  @override
  State<_MCQCardWidget> createState() => _MCQCardWidgetState();
}

class _MCQCardWidgetState extends State<_MCQCardWidget> {
  String? _selectedAnswer;
  bool _isRevealed = false;
  int _displayLevel = 0;
  double _incorrectProgress = 0.0;
  Timer? _progressTimer;

  @override
  void initState() {
    super.initState();
    _displayLevel = widget.question.level;
  }

  @override
  void didUpdateWidget(_MCQCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset if question changed
    if (oldWidget.question.wordId != widget.question.wordId) {
      _isRevealed = false;
      _selectedAnswer = null;
      _displayLevel = widget.question.level;
      _incorrectProgress = 0.0;
      _progressTimer?.cancel();
    }
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    super.dispose();
  }

  void _startIncorrectAnimation() {
    _incorrectProgress = 0.0;
    _progressTimer?.cancel();
    
    const duration = Duration(seconds: 2);
    const updateInterval = Duration(milliseconds: 50);
    final startTime = DateTime.now();
    
    _progressTimer = Timer.periodic(updateInterval, (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      
      final elapsed = DateTime.now().difference(startTime);
      final progress = (elapsed.inMilliseconds / duration.inMilliseconds).clamp(0.0, 1.0);
      
      setState(() {
        _incorrectProgress = progress;
      });
      
      if (progress >= 1.0) {
        timer.cancel();
      }
    });
  }

  void _handleAnswerTap(String option) {
    if (_isRevealed) return;

    setState(() {
      _selectedAnswer = option;
      _isRevealed = true;
      // Drop level on reveal
      _displayLevel = (_displayLevel - 1).clamp(0, 10);
    });

    final isCorrect = option == widget.question.correctAnswer;
    widget.onAnswerSelected(option, isCorrect);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          constraints: BoxConstraints(
            maxWidth: 0.9.sw,
            maxHeight: 0.75.sh,
          ),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            color: _displayLevel == 0 
                ? Theme.of(context).colorScheme.tertiaryContainer
                : Theme.of(context).colorScheme.surfaceContainer,
            child: Container(
              decoration: _displayLevel == 0
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                      border: Border.all(
                        color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                        width: 2,
                      ),
                    )
                  : BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Theme.of(context).colorScheme.surfaceContainer,
                    ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Progress level indicator with "New Word" chip
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // "New Word" chip on the left for level 0
                        if (_displayLevel == 0)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.tertiaryContainer,
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.school_outlined,
                                  size: 14.sp,
                                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  'New Word',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          const SizedBox.shrink(),
                        // Progress level indicator on the right
                        _buildProgressLevelIndicator(_displayLevel),
                      ],
                    ),
                  SizedBox(height: 12.h),
                  // Question (definition)
                  Text(
                    'What word matches this definition?',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    padding: EdgeInsets.all(10.w),
                    constraints: BoxConstraints(minHeight: 0.12.sh),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      widget.question.definition,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 16.sp,
                        height: 1.4,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: 14.h),
                  // Options - use Flexible to distribute space evenly
                  ...widget.question.options.asMap().entries.map((entry) {
                    final index = entry.key;
                    final option = entry.value;
                    final isCorrect = option == widget.question.correctAnswer;
                    final isSelected = option == _selectedAnswer;
                    final isLast = index == widget.question.options.length - 1;
                    
                    return Padding(
                      padding: EdgeInsets.only(bottom: isLast ? 0 : 8.h),
                      child: _MCQOptionButton(
                        option: option,
                        isCorrect: isCorrect,
                        isSelected: isSelected,
                        isRevealed: _isRevealed,
                        isNewWord: _displayLevel == 0,
                        onTap: () => _handleAnswerTap(option),
                      ),
                    );
                  }),
                ],
              ),
            ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProgressLevelIndicator(int level) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(10, (index) {
        final isActive = index < level;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 3.w,
          height: isActive ? 10.h : 10.h,
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(1.r),
          ),
        );
      }),
    );
  }
}


class _MCQOptionButton extends StatefulWidget {
  final String option;
  final bool isCorrect;
  final bool isSelected;
  final bool isRevealed;
  final bool isNewWord;
  final VoidCallback onTap;

  const _MCQOptionButton({
    required this.option,
    required this.isCorrect,
    required this.isSelected,
    required this.isRevealed,
    required this.isNewWord,
    required this.onTap,
  });

  @override
  State<_MCQOptionButton> createState() => _MCQOptionButtonState();
}

class _MCQOptionButtonState extends State<_MCQOptionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _progressController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void didUpdateWidget(_MCQOptionButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Trigger animation when answer is revealed and this option is selected but incorrect
    if (widget.isRevealed && widget.isSelected && !widget.isCorrect) {
      if (!oldWidget.isRevealed) {
        _progressController.forward();
      }
    } else {
      _progressController.reset();
    }
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color? backgroundColor;
    Color? textColor;
    Color? borderColor;

    if (widget.isRevealed) {
      if (widget.isCorrect) {
        backgroundColor = Colors.green.withOpacity(0.1);
        textColor = Colors.green[700];
        borderColor = Colors.green.withOpacity(0.5);
      } else if (widget.isSelected && !widget.isCorrect) {
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red[700];
        borderColor = Colors.red.withOpacity(0.5);
      } else {
        backgroundColor = Theme.of(context).colorScheme.surfaceContainerHighest;
        textColor = Theme.of(context).colorScheme.onSurface.withOpacity(0.6);
        borderColor = Theme.of(context).colorScheme.outline.withOpacity(0.3);
      }
    } else {
      // For new word cards, use lighter background that works with tertiary container
      if (widget.isNewWord) {
        backgroundColor = Theme.of(context).colorScheme.surfaceContainerHighest;
        textColor = Theme.of(context).colorScheme.onSurface;
        borderColor = Theme.of(context).colorScheme.outline.withOpacity(0.3);
      } else {
        backgroundColor = Theme.of(context).colorScheme.surfaceContainer;
        textColor = Theme.of(context).colorScheme.onSurface;
        borderColor = Theme.of(context).colorScheme.outline.withOpacity(0.4);
      }
    }

    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          child: Material(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12.r),
            child: InkWell(
              onTap: widget.isRevealed ? null : widget.onTap,
              borderRadius: BorderRadius.circular(12.r),
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                    constraints: BoxConstraints(minHeight: 36.h),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: borderColor!,
                        width: widget.isRevealed && (widget.isCorrect || (widget.isSelected && !widget.isCorrect)) ? 2 : 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.option,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        if (widget.isRevealed && widget.isCorrect)
                          Icon(Icons.check_circle, color: Colors.green[700], size: 18.sp)
                        else if (widget.isRevealed && widget.isSelected && !widget.isCorrect)
                          Icon(Icons.cancel, color: Colors.red[700], size: 18.sp),
                      ],
                    ),
                  ),
                   // Progress fill animation for incorrectly selected option
                   if (widget.isRevealed && widget.isSelected && !widget.isCorrect && _progressAnimation.value > 0)
                     Positioned.fill(
                       child: IgnorePointer(
                         child: ClipRRect(
                           borderRadius: BorderRadius.circular(12.r),
                           child: Align(
                             alignment: Alignment.centerLeft,
                             widthFactor: _progressAnimation.value,
                             child: Container(
                               width: double.infinity,
                               decoration: BoxDecoration(
                                 gradient: LinearGradient(
                                   begin: Alignment.centerLeft,
                                   end: Alignment.centerRight,
                                   colors: [
                                     Colors.redAccent.withOpacity(0.4),
                                     Colors.red.withOpacity(0.3),
                                   ],
                                 ),
                                 borderRadius: BorderRadius.circular(12.r),
                               ),
                             ),
                           ),
                         ),
                       ),
                     ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}