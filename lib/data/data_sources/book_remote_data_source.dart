// ignore_for_file: avoid_print

import '../models/book_model.dart';
import '../services/api_client.dart';

abstract class BookRemoteDataSource {
  Future<List<BookModel>> searchBooks(String query);
  Future<List<BookModel>> getNewReleases();
  Future<BookModel> getBookDetails(String isbn13);
}

class BookRemoteDataSourceImpl implements BookRemoteDataSource {
  final ApiClient apiClient;

  BookRemoteDataSourceImpl(this.apiClient);

  // Fetch data in search
  @override
  Future<List<BookModel>> searchBooks(String query) async {
    final response = await apiClient.searchBooks(query);
    return response.books;
  }

  @override
  Future<List<BookModel>> getNewReleases() async {
    final response = await apiClient.getNewReleases();
    return response.books;
  }

  // Fetch data for book details
  @override
  Future<BookModel> getBookDetails(String isbn13) async {
    try {
      final response = await apiClient.getBookDetails(isbn13);

      return response.book;
    } catch (e) {
      print("Error fetching book details: $e");
      rethrow;
    }
  }
}
