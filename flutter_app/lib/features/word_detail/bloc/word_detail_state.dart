part of 'word_detail_bloc.dart';

abstract class WordDetailState extends Equatable {
  const WordDetailState();

  @override
  List<Object> get props => [];
}

class WordDetailInitial extends WordDetailState {}

class WordDetailLoading extends WordDetailState {}

class WordDetailLoaded extends WordDetailState {
  final ReviewPageData data;

  const WordDetailLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class WordDetailError extends WordDetailState {
  final String message;

  const WordDetailError(this.message);

  @override
  List<Object> get props => [message];
}
