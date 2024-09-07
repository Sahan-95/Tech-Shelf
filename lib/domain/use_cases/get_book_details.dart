import '../entities/book.dart';
import '../repositories/book_repository.dart';

// Get book details use case
class GetBookDetails {
  final BookRepository repository;

  GetBookDetails(this.repository);

  Future<Book> execute(String isbn13) async {
    return await repository.getBookDetails(isbn13);
  }
}
