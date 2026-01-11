import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:math';
import '../../../core/di/injection.dart';
import '../../../core/network/api_service.dart';
import '../../../core/models/progress.dart';
import '../../../core/models/models.dart';
import '../../../core/models/word.dart';

part 'daily_review_event.dart';
part 'daily_review_state.dart';

class DailyReviewBloc extends Bloc<DailyReviewEvent, DailyReviewState> {
  final ApiService _apiService = getIt<ApiService>();
  final Random _random = Random();
  final Map<int, WordDetail> _wordsCache = {}; // Cache for word details

  DailyReviewBloc() : super(DailyReviewInitial()) {
    on<LoadDailyStack>(_onLoadDailyStack);
    on<LoadMCQQuestion>(_onLoadMCQQuestion);
    on<SubmitMCQAnswer>(_onSubmitMCQAnswer);
  }

  Future<void> _onLoadDailyStack(
    LoadDailyStack event,
    Emitter<DailyReviewState> emit,
  ) async {
    emit(DailyReviewLoading());
    try {
      final items = await _apiService.getDailyStack(null);
      
      // Cache all word details from the questions
      _wordsCache.clear();
      for (final item in items) {
        _wordsCache[item.wordId] = item.wordDetail;
      }
      
      emit(DailyReviewLoaded(items));
    } catch (e) {
      emit(DailyReviewError(e.toString()));
    }
  }

  Future<void> _onLoadMCQQuestion(
    LoadMCQQuestion event,
    Emitter<DailyReviewState> emit,
  ) async {
    emit(MCQQuestionLoading());
    try {
      // Get word details from cache or fetch individually
      WordDetail wordDetail;
      if (_wordsCache.containsKey(event.wordId)) {
        wordDetail = _wordsCache[event.wordId]!;
      } else {
        // Fallback to individual fetch if not in cache
        wordDetail = await _apiService.getWord(event.wordId);
        _wordsCache[event.wordId] = wordDetail;
      }
      
      // Get primary definition
      final primaryDef = wordDetail.definitions.firstWhere(
        (def) => def.isPrimary,
        orElse: () => wordDetail.definitions.first,
      );
      
      // Get random words for wrong options
      // Try to get words from similar difficulty and category
      final difficulty = wordDetail.difficultyLevel;
      final categoryId = wordDetail.category?.id;
      
      final wrongOptions = <String>[];
      final usedWordIds = {event.wordId};
      
      // Try to get words from same category first
      if (categoryId != null) {
        try {
          final categoryWords = await _apiService.getWords({
            'category_id': categoryId,
            'difficulty_min': difficulty - 1.0,
            'difficulty_max': difficulty + 1.0,
            'limit': 20,
          });
          
          for (final word in categoryWords) {
            if (word.id != event.wordId && !usedWordIds.contains(word.id) && word.categoryId != null) {
              wrongOptions.add(word.word);
              usedWordIds.add(word.id);
              if (wrongOptions.length >= 3) break;
            }
          }
        } catch (e) {
          // If category search fails, continue to general search
        }
      }
      
      // If we don't have enough, get random words from similar difficulty
      if (wrongOptions.length < 3) {
        final similarWords = await _apiService.getWords({
          'difficulty_min': difficulty - 1.5,
          'difficulty_max': difficulty + 1.5,
          'limit': 30,
        });
        
        for (final word in similarWords) {
          if (word.id != event.wordId && !usedWordIds.contains(word.id)) {
            wrongOptions.add(word.word);
            usedWordIds.add(word.id);
            if (wrongOptions.length >= 3) break;
          }
        }
      }
      
      // Shuffle and take 3 wrong options
      wrongOptions.shuffle(_random);
      final selectedWrongOptions = wrongOptions.take(3).toList();
      
      // Create 4 options: correct answer + 3 wrong options
      final allOptions = [wordDetail.word, ...selectedWrongOptions];
      allOptions.shuffle(_random);
      
      emit(MCQQuestionLoaded(
        wordId: event.wordId,
        word: wordDetail.word,
        definition: primaryDef.text,
        options: allOptions,
        correctAnswer: wordDetail.word,
        level: event.level,
      ));
    } catch (e) {
      emit(DailyReviewError(e.toString()));
    }
  }

  Future<void> _onSubmitMCQAnswer(
    SubmitMCQAnswer event,
    Emitter<DailyReviewState> emit,
  ) async {
    try {
      // Submit review to backend
      final reviewRequest = ReviewSubmit(
        wordId: event.wordId,
        isCorrect: event.isCorrect,
        questionType: 'mcq',
        correctAnswer: event.correctWord,
        userAnswer: event.selectedWord,
        optionsPresented: null, // Backend expects Optional, null is fine
        timeTakenSeconds: null, // Optional field
      );
      
      print('Submitting review: ${reviewRequest.toJson()}');
      final reviewResponse = await _apiService.submitReview(reviewRequest);
      
      // Load word details to show below card (from cache or fetch)
      WordDetail? wordDetail;
      if (_wordsCache.containsKey(event.wordId)) {
        wordDetail = _wordsCache[event.wordId]!;
      } else {
        try {
          wordDetail = await _apiService.getWord(event.wordId);
          if (wordDetail != null) {
            _wordsCache[event.wordId] = wordDetail;
          }
        } catch (e) {
          print('Error loading word details: $e');
        }
      }
      
      emit(MCQAnswerRevealed(
        wordId: event.wordId,
        selectedWord: event.selectedWord,
        correctAnswer: event.correctWord,
        isCorrect: event.isCorrect,
        newLevel: reviewResponse.newLevel,
        wordDetail: wordDetail,
      ));
    } catch (e) {
      // Log the error for debugging
      print('Error submitting review: $e');
      // Still emit the revealed state so UI can show the answer
      // The backend will handle the review update on next load
      WordDetail? wordDetail;
      if (_wordsCache.containsKey(event.wordId)) {
        wordDetail = _wordsCache[event.wordId]!;
      } else {
        try {
          wordDetail = await _apiService.getWord(event.wordId);
          if (wordDetail != null) {
            _wordsCache[event.wordId] = wordDetail;
          }
        } catch (e) {
          print('Error loading word details: $e');
        }
      }
      
      emit(MCQAnswerRevealed(
        wordId: event.wordId,
        selectedWord: event.selectedWord,
        correctAnswer: event.correctWord,
        isCorrect: event.isCorrect,
        newLevel: event.level - 1, // Drop level on reveal as requested
        wordDetail: wordDetail,
      ));
    }
  }
}
