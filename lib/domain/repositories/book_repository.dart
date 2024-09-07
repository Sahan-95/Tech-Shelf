import '../entities/book.dart';

abstract class BookRepository {
  Future<List<Book>> searchBooks(String query);
  Future<List<Book>> getNewReleases();
  Future<Book> getBookDetails(String isbn13);
}
