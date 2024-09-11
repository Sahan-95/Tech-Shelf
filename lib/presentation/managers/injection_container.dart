import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../data/data_sources/book_remote_data_source.dart';
import '../../data/repositories/book_repository_impl.dart';
import '../../data/services/api_client.dart';
import '../../domain/use_cases/get_book_details.dart';
import '../../domain/use_cases/get_new_releases.dart';
import '../../domain/use_cases/search_book.dart';


final getIt = GetIt.instance;

void setupLocator() {
  // Register Dio
  getIt.registerLazySingleton<Dio>(() => Dio());

  // Register ApiClient
  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt<Dio>()));

  // Register Remote Data Source
  getIt.registerLazySingleton<BookRemoteDataSource>(
      () => BookRemoteDataSourceImpl(getIt<ApiClient>()));

  // Register Repository
  getIt.registerLazySingleton<BookRepositoryImpl>(
      () => BookRepositoryImpl(getIt<BookRemoteDataSource>()));

  // Register Use Cases
  getIt.registerLazySingleton<SearchBooks>(
      () => SearchBooks(getIt<BookRepositoryImpl>()));
  getIt.registerLazySingleton<GetBookDetails>(
      () => GetBookDetails(getIt<BookRepositoryImpl>()));
  getIt.registerLazySingleton<GetNewReleases>(
      () => GetNewReleases(getIt<BookRepositoryImpl>()));
}
