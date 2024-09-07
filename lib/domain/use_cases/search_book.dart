import '../entities/book.dart';
import '../repositories/book_repository.dart';

// Get search book use case
class SearchBooks {
  final BookRepository repository;

  SearchBooks(this.repository);

  Future<List<Book>> execute(String query) async {
    return await repository.searchBooks(query);
  }
}
