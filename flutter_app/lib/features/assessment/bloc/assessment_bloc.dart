import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/di/injection.dart';
import '../../../core/models/models.dart';
import '../../../core/network/api_service.dart';

part 'assessment_event.dart';
part 'assessment_state.dart';

class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  final ApiService _apiService = getIt<ApiService>();

  AssessmentBloc() : super(AssessmentInitial()) {
    on<LoadAssessmentStack>(_onLoadAssessmentStack);
    on<SubmitAssessmentResponse>(_onSubmitAssessmentResponse);
    on<SubmitAssessment>(_onSubmitAssessment);
    on<ResetAssessment>(_onResetAssessment);
  }

  Future<void> _onLoadAssessmentStack(
    LoadAssessmentStack event,
    Emitter<AssessmentState> emit,
  ) async {
    emit(AssessmentLoading());
    try {
      final stack = await _apiService.getAssessmentStack();
      emit(AssessmentStackLoaded(
        stack: stack,
        responses: {},
        currentIndex: 0,
      ));
    } catch (e) {
      emit(AssessmentError(e.toString()));
    }
  }

  void _onSubmitAssessmentResponse(
    SubmitAssessmentResponse event,
    Emitter<AssessmentState> emit,
  ) {
    if (state is AssessmentStackLoaded) {
      final currentState = state as AssessmentStackLoaded;
      final updatedResponses = Map<int, String>.from(currentState.responses);
      updatedResponses[event.wordId] = event.response;

      // Move to next word if available
      int nextIndex = currentState.currentIndex;
      if (nextIndex < currentState.stack.words.length - 1) {
        nextIndex++;
      }

      emit(currentState.copyWith(
        responses: updatedResponses,
        currentIndex: nextIndex,
      ));
    }
  }

  Future<void> _onSubmitAssessment(
    SubmitAssessment event,
    Emitter<AssessmentState> emit,
  ) async {
    if (state is AssessmentStackLoaded) {
      final currentState = state as AssessmentStackLoaded;
      emit(AssessmentSubmitting(
        stack: currentState.stack,
        responses: currentState.responses,
      ));

      try {
        final responses = currentState.responses.entries.map((entry) {
          return AssessmentResponse(
            wordId: entry.key,
            response: entry.value,
          );
        }).toList();

        final result = await _apiService.submitAssessment(
          AssessmentSubmit(responses: responses),
        );

        emit(AssessmentCompleted(result));
      } catch (e) {
        emit(AssessmentError(e.toString()));
      }
    }
  }

  void _onResetAssessment(
    ResetAssessment event,
    Emitter<AssessmentState> emit,
  ) {
    emit(AssessmentInitial());
  }
}
