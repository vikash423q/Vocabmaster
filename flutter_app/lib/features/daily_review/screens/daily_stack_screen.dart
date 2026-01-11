import 'package:flutter/material.dart';
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
                  const Text(
                    'Daily Review',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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
                  const Text(
                    'Daily Review',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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
                const Text(
                  'Daily Review',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            actions: [
              if (unreviewed.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Center(
                    child: Text(
                      '${unreviewed.length} left',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
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
        Timer(const Duration(seconds: 3), () {
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
        // Correct answer - show word details and continue
        _showCorrectAnswer(context, item, reviewResponse.newLevel);
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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check_circle_outline,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
            Text(
              'All caught up! 🎉',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (_wordsInProgress != null && _wordsInProgress! > 0)
              Text(
                'You have $_wordsInProgress ${_wordsInProgress == 1 ? 'word' : 'words'} in progress.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              )
            else
              Text(
                'You don\'t have any words in progress yet.',
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 8),
            Text(
              'Would you like to add new words to your learning stack?',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.stackRecommendations);
              },
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('Discover New Words'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
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
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Reviews left for today',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${unreviewed.length}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            // Card stack swiper
            Expanded(
              child: Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.6,
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
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.swipe,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
                const SizedBox(width: 8),
                Text(
                  'Swipe to navigate through cards',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Success card
          Container(
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 48, color: Colors.green),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Correct! 🎉',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900],
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Great job! Here are the details:',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.green[700],
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
              padding: const EdgeInsets.all(24.0),
              child: _buildWordDetailsCard(context, wordDetail),
            ),
          ),
          // Continue button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: onContinue,
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Continue Review'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
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
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
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
                    if (wordDetail.tone != null) const SizedBox(width: 8),
                    Chip(
                      label: Text(wordDetail.category!.name),
                      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
                      labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                        width: 1,
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Word
            Text(
              wordDetail.word,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (wordDetail.pronunciation != null) ...[
              const SizedBox(height: 4),
              Text(
                wordDetail.pronunciation!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
            const SizedBox(height: 16),
            // Definition
            Text(
              'Definition',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              primaryDef.text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.5,
              ),
            ),
            // Examples
            if (primaryDef.examples.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Examples',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ...primaryDef.examples.map((example) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  '• $example',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[700],
                  ),
                ),
              )),
            ],
            // Etymology
            if (wordDetail.etymology != null && wordDetail.etymology!.evolution != null) ...[
              const SizedBox(height: 16),
              Text(
                'Origin',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                wordDetail.etymology!.evolution!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[700],
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 4),
          Text(
            tone.toUpperCase(),
            style: TextStyle(
              color: color,
              fontSize: 11,
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
    
    const duration = Duration(seconds: 3);
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
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.80,
        maxHeight: MediaQuery.of(context).size.height * 0.55,
      ),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Progress level indicator (top right)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildProgressLevelIndicator(_displayLevel),
                ],
              ),
              const SizedBox(height: 24),
              // Question (definition)
              Text(
                'What word matches this definition?',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                child: Text(
                  widget.question.definition,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 18,
                    height: 1.5,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Options
              ...widget.question.options.map((option) {
                final isCorrect = option == widget.question.correctAnswer;
                final isSelected = option == _selectedAnswer;
                
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _MCQOptionButton(
                    option: option,
                    isCorrect: isCorrect,
                    isSelected: isSelected,
                    isRevealed: _isRevealed,
                    onTap: () => _handleAnswerTap(option),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressLevelIndicator(int level) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(10, (index) {
        final isActive = index < level;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 4,
          height: isActive ? 20 : 8,
          margin: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: isActive ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(2),
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
  final VoidCallback onTap;

  const _MCQOptionButton({
    required this.option,
    required this.isCorrect,
    required this.isSelected,
    required this.isRevealed,
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
      backgroundColor = Theme.of(context).colorScheme.surface;
      textColor = Theme.of(context).colorScheme.onSurface;
      borderColor = Theme.of(context).colorScheme.outline.withOpacity(0.3);
    }

    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          child: Material(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              onTap: widget.isRevealed ? null : widget.onTap,
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: borderColor!,
                        width: widget.isRevealed && (widget.isCorrect || (widget.isSelected && !widget.isCorrect)) ? 2 : 1.5,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.option,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: textColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (widget.isRevealed && widget.isCorrect)
                          Icon(Icons.check_circle, color: Colors.green[700], size: 24)
                        else if (widget.isRevealed && widget.isSelected && !widget.isCorrect)
                          Icon(Icons.cancel, color: Colors.red[700], size: 24),
                      ],
                    ),
                  ),
                   // Progress fill animation for incorrectly selected option
                   if (widget.isRevealed && widget.isSelected && !widget.isCorrect && _progressAnimation.value > 0)
                     Positioned.fill(
                       child: IgnorePointer(
                         child: ClipRRect(
                           borderRadius: BorderRadius.circular(12),
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
                                 borderRadius: BorderRadius.circular(12),
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