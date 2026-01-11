part of 'assessment_bloc.dart';

abstract class AssessmentState extends Equatable {
  const AssessmentState();

  @override
  List<Object?> get props => [];
}

class AssessmentInitial extends AssessmentState {}

class AssessmentLoading extends AssessmentState {}

class AssessmentStackLoaded extends AssessmentState {
  final AssessmentStack stack;
  final Map<int, String> responses; // wordId -> response
  final int currentIndex;

  const AssessmentStackLoaded({
    required this.stack,
    required this.responses,
    this.currentIndex = 0,
  });

  AssessmentStackLoaded copyWith({
    AssessmentStack? stack,
    Map<int, String>? responses,
    int? currentIndex,
  }) {
    return AssessmentStackLoaded(
      stack: stack ?? this.stack,
      responses: responses ?? this.responses,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [stack, responses, currentIndex];
}

class AssessmentSubmitting extends AssessmentState {
  final AssessmentStack stack;
  final Map<int, String> responses;

  const AssessmentSubmitting({
    required this.stack,
    required this.responses,
  });

  @override
  List<Object?> get props => [stack, responses];
}

class AssessmentCompleted extends AssessmentState {
  final AssessmentResult result;

  const AssessmentCompleted(this.result);

  @override
  List<Object?> get props => [result];
}

class AssessmentError extends AssessmentState {
  final String message;

  const AssessmentError(this.message);

  @override
  List<Object?> get props => [message];
}
