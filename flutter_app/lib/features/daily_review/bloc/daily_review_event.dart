part of 'daily_review_bloc.dart';

abstract class DailyReviewEvent extends Equatable {
  const DailyReviewEvent();

  @override
  List<Object> get props => [];
}

class LoadDailyStack extends DailyReviewEvent {}
