// import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/data_sources/book_remote_data_source.dart';
import 'data/repositories/book_repository_impl.dart';
import 'data/services/api_client.dart';
import 'domain/use_cases/get_book_details.dart';
import 'domain/use_cases/get_new_releases.dart';
import 'domain/use_cases/search_book.dart';
import 'presentation/blocs/book_details/bloc/book_details_bloc.dart';
import 'presentation/blocs/book_search/bloc/book_search_bloc.dart';
import 'presentation/blocs/favorite/bloc/favorite_bloc.dart';
import 'presentation/blocs/theme/bloc/theme_bloc.dart';
import 'presentation/pages/welcome_screen/welcome_screen.dart';

void main() {
  final dio = Dio();
  final apiClient = ApiClient(dio);
  final bookRemoteDataSource = BookRemoteDataSourceImpl(apiClient);
  final bookRepository = BookRepositoryImpl(bookRemoteDataSource);

  runApp(MyApp(
    searchBooksUseCase: SearchBooks(bookRepository),
    getBookDetailsUseCase: GetBookDetails(bookRepository),
    getNewReleasesUseCase: GetNewReleases(bookRepository),
  ));

  //...... this is for Responsive check.....//

  // runApp(
  //   DevicePreview(
  //     builder: (context) => MyApp(
  //       searchBooksUseCase: SearchBooks(bookRepository),
  //       getBookDetailsUseCase: GetBookDetails(bookRepository),
  //       getNewReleasesUseCase: GetNewReleases(bookRepository),
  //     ),
  //   ),
  // );
}

class MyApp extends StatelessWidget {
  final SearchBooks searchBooksUseCase;
  final GetBookDetails getBookDetailsUseCase;
  final GetNewReleases getNewReleasesUseCase;

  const MyApp(
      {required this.searchBooksUseCase,
      required this.getBookDetailsUseCase,
      required this.getNewReleasesUseCase,
      super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookSearchBloc(searchBooksUseCase, getBookDetailsUseCase),
        ),
        BlocProvider(
          create: (context) => BookDetailsBloc(getBookDetailsUseCase),
        ),
        BlocProvider(
          create: (context) => FavoriteBloc(),
        ),
        BlocProvider(create: (context) => ThemeBloc())
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          final ThemeData theme = state is ThemeLight
              ? state.themeData
              : (state is ThemeDark ? state.themeData : ThemeData.light());
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Tech Shelf',
              theme: theme,

              // ....... This is for responsive check .........//
              // locale: DevicePreview.locale(context),
              // builder: DevicePreview.appBuilder,

              home: const WelcomeScreen());
        },
      ),
    );
  }
}
