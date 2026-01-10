import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/di/injection.dart';
import '../../../core/network/api_service.dart';
import '../../../core/models/word.dart';

part 'word_detail_event.dart';
part 'word_detail_state.dart';

class WordDetailBloc extends Bloc<WordDetailEvent, WordDetailState> {
  final ApiService _apiService = getIt<ApiService>();

  WordDetailBloc() : super(WordDetailInitial()) {
    on<LoadReviewPage>(_onLoadReviewPage);
  }

  Future<void> _onLoadReviewPage(
    LoadReviewPage event,
    Emitter<WordDetailState> emit,
  ) async {
    emit(WordDetailLoading());
    try {
      final data = await _apiService.getReviewPage(event.wordId);
      emit(WordDetailLoaded(data));
    } catch (e) {
      emit(WordDetailError(e.toString()));
    }
  }
}
