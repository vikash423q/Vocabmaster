part of 'assessment_bloc.dart';

abstract class AssessmentEvent extends Equatable {
  const AssessmentEvent();

  @override
  List<Object?> get props => [];
}

class LoadAssessmentStack extends AssessmentEvent {
  const LoadAssessmentStack();
}

class SubmitAssessmentResponse extends AssessmentEvent {
  final int wordId;
  final String response; // "know", "maybe", "don't_know"

  const SubmitAssessmentResponse({
    required this.wordId,
    required this.response,
  });

  @override
  List<Object?> get props => [wordId, response];
}

class SubmitAssessment extends AssessmentEvent {
  const SubmitAssessment();
}

class ResetAssessment extends AssessmentEvent {
  const ResetAssessment();
}
