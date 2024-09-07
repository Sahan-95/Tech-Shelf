part of 'book_search_bloc.dart';

@immutable
sealed class BookSearchEvent {}

// Search Query change event
class BookSearchQueryChanged extends BookSearchEvent {
  final String query;

  BookSearchQueryChanged(this.query);
}
