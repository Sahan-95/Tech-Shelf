part of 'book_search_bloc.dart';

@immutable
sealed class BookSearchState {}

// initial
final class BookSearchInitial extends BookSearchState {}

// loading
final class BookSearchLoading extends BookSearchState {}

// Loaded
final class BookSearchLoaded extends BookSearchState {
  final List<Book> books;
  final Map<String, String> bookAuthors;
  BookSearchLoaded(this.books, this.bookAuthors);
}

// Error
final class BookSearchError extends BookSearchState {
  final String message;

  BookSearchError(this.message);
}
