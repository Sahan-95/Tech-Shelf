part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteEvent {}

// Add to favorite
class AddToFavorites extends FavoriteEvent {
  final Book book;
  final String author;

  AddToFavorites(this.book, this.author);
}

// Remove books in favorite
class RemoveFromFavorites extends FavoriteEvent {
  final Book book;
  final String author;

  RemoveFromFavorites(this.book, this.author);
}

// Load the books into favorite
class LoadFavorites extends FavoriteEvent {
  final List<Book> books;
  final String author;

  LoadFavorites(this.books, this.author);
}

