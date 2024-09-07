part of 'book_details_bloc.dart';

@immutable
sealed class BookDetailsEvent {}

// Request details event
class BookDetailsRequested extends BookDetailsEvent {
  final String isbn13;

  BookDetailsRequested(this.isbn13);
}
