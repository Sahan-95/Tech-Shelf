import '../../domain/entities/book.dart';
import '../../domain/repositories/book_repository.dart';
import '../data_sources/book_remote_data_source.dart';

class BookRepositoryImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;

  BookRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Book>> searchBooks(String query) async {
    final bookModels = await remoteDataSource.searchBooks(query);
    return bookModels.map((model) => Book.fromModel(model)).toList();
  }

  @override
  Future<List<Book>> getNewReleases() async {
    final bookModels = await remoteDataSource.getNewReleases();
    return bookModels.map((model) => Book.fromModel(model)).toList();
  }

  @override
  Future<Book> getBookDetails(String isbn13) async {
    final bookModel = await remoteDataSource.getBookDetails(isbn13);
    return Book.fromModel(bookModel);
  }
}
