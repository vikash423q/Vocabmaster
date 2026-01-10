import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/di/injection.dart';
import '../../../core/network/api_service.dart';
import '../../../core/models/progress.dart';

part 'daily_review_event.dart';
part 'daily_review_state.dart';

class DailyReviewBloc extends Bloc<DailyReviewEvent, DailyReviewState> {
  final ApiService _apiService = getIt<ApiService>();

  DailyReviewBloc() : super(DailyReviewInitial()) {
    on<LoadDailyStack>(_onLoadDailyStack);
  }

  Future<void> _onLoadDailyStack(
    LoadDailyStack event,
    Emitter<DailyReviewState> emit,
  ) async {
    emit(DailyReviewLoading());
    try {
      final items = await _apiService.getDailyStack(null);
      emit(DailyReviewLoaded(items));
    } catch (e) {
      emit(DailyReviewError(e.toString()));
    }
  }
}
