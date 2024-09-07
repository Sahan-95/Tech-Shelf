import '../entities/book.dart';
import '../repositories/book_repository.dart';

// Get new release use case
class GetNewReleases {
  final BookRepository repository;

  GetNewReleases(this.repository);

  Future<List<Book>> execute() async {
    return await repository.getNewReleases();
  }
}
