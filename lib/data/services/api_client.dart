import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/book_model.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://api.itbook.store/1.0')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/search/{query}')
  Future<BookSearchResponse> searchBooks(@Path('query') String query);

  @GET('/new')
  Future<NewReleasesResponse> getNewReleases();

  @GET('/books/{isbn13}')
  Future<BookDetailResponse> getBookDetails(@Path('isbn13') String isbn13);
}
