part of 'favorite_bloc.dart';

@immutable
sealed class FavoriteState {}

// initial
final class FavoriteInitial extends FavoriteState {}

// Loaded
final class FavoritesLoaded extends FavoriteState {
  final List<Book> favorites;
  final Map<String, String> author;

  FavoritesLoaded(this.favorites, this.author);
}

// Error
final class FavoritesError extends FavoriteState {
  final String message;

  FavoritesError(this.message);
}
