part of 'book_details_bloc.dart';

@immutable
sealed class BookDetailsState {}

// Initial
final class BookDetailsInitial extends BookDetailsState {}

// Loading
final class BookDetailsLoading extends BookDetailsState {}

// Loaded
final class BookDetailsLoaded extends BookDetailsState {
  final Book book;

  BookDetailsLoaded(this.book);
}

// Error
final class BookDetailsError extends BookDetailsState {
  final String message;

  BookDetailsError(this.message);
}