part of 'word_detail_bloc.dart';

abstract class WordDetailEvent extends Equatable {
  const WordDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadReviewPage extends WordDetailEvent {
  final int wordId;

  const LoadReviewPage(this.wordId);

  @override
  List<Object> get props => [wordId];
}
