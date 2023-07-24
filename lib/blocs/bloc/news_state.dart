part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final List<Article> article;

  NewsLoadedState(this.article);

  @override
  List<Object> get props => [article];
}

class NewsErrorState extends NewsState {
  final String error;

  const NewsErrorState(this.error);

  @override
  List<Object> get props => [error];
}
