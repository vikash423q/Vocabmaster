part of 'daily_review_bloc.dart';

abstract class DailyReviewState extends Equatable {
  const DailyReviewState();

  @override
  List<Object> get props => [];
}

class DailyReviewInitial extends DailyReviewState {}

class DailyReviewLoading extends DailyReviewState {}

class DailyReviewLoaded extends DailyReviewState {
  final List<DailyStackItem> items;

  const DailyReviewLoaded(this.items);

  @override
  List<Object> get props => [items];
}

class DailyReviewError extends DailyReviewState {
  final String message;

  const DailyReviewError(this.message);

  @override
  List<Object> get props => [message];
}
