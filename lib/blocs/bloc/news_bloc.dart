import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_bloc/model/article.dart';
import 'package:news_bloc/repository/news_service.dart';

part 'news_event.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;
  NewsBloc(this.newsRepository) : super(NewsLoadingState()) {
    on<NewsLoadEvent>((event, emit) async {
      emit(NewsLoadingState());
      try {
        final List<Article> article = await newsRepository.getNews();
        emit(NewsLoadedState(article));
      } catch (e) {
        emit(NewsErrorState(e.toString()));
      }
    });
  }
}
