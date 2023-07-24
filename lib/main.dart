import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_bloc/blocs/bloc/news_bloc.dart';

import 'package:news_bloc/repository/news_service.dart';

import 'model/article.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => NewsRepository(),
        child: const Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(
        RepositoryProvider.of<NewsRepository>(context),
      )..add(NewsLoadEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News Bloc'),
        ),
        body: BlocBuilder<NewsBloc, NewsState>(
          builder: (context, state) {
            if (state is NewsLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is NewsLoadedState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      // Use a ListView.builder to display the articles
                      child: ListView.builder(
                        itemCount: state.article.length,
                        itemBuilder: (context, index) {
                          // Get the article at the current index
                          Article article = state.article[index];
                          return ExpansionTile(
                            title: Text(
                              article.title,
                              textAlign: TextAlign.center,
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  article.description,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<NewsBloc>(context).add(NewsLoadEvent());
                      },
                      child: const Text('Generate a joke'),
                    )
                  ],
                ),
              );
            }
            if (state is NewsErrorState) {
              return Center(
                child: Text(state.error.toString()),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
