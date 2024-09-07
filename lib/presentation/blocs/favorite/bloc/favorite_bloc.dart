// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/domain/entities/book.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState>{
  FavoriteBloc() : super(FavoriteInitial()) {
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
    on<LoadFavorites>(_onLoadFavorites);

    _loadFavoritesFromStorage();
  }



  // Save favorites to local storage
  Future<void> _saveFavoritesToStorage(
      List<Book> favorites, Map<String, String> authors) async {

    final prefs = await SharedPreferences.getInstance();

    // Convert favorite to JSON
    final booksJson =
        jsonEncode(favorites.map((book) => book.toJson()).toList());
    final authorsJson = jsonEncode(authors);

    // Save to local storage
    await prefs.setString('favorite_books', booksJson);
    await prefs.setString('favorite_authors', authorsJson);
  }

  // Load favorites to local storage
  Future<void> _loadFavoritesFromStorage() async {
    final prefs = await SharedPreferences.getInstance();

    // Get stored data from local
    final booksJson = prefs.getString('favorite_books');
    final authorsJson = prefs.getString('favorite_authors');

    if (booksJson != null && authorsJson != null) {
      // Convert back from JSON
      final List<dynamic> booksList = jsonDecode(booksJson);
      final List<Book> favorites =
          booksList.map((json) => Book.fromJson(json)).toList();
      final Map<String, String> authors =
          Map<String, String>.from(jsonDecode(authorsJson));

      // Emit loaded state
      add(LoadFavorites(favorites, authors.values.first));
    }
  }

  void _onAddToFavorites(
      AddToFavorites event, Emitter<FavoriteState> emit) async {
    if (state is FavoritesLoaded) {
      // Add favorite
      final updatedFavorites =
          List<Book>.from((state as FavoritesLoaded).favorites)
            ..add(event.book);

      // Add particular authors to favorite books
      final updatedAuthors =
          Map<String, String>.from((state as FavoritesLoaded).author)
            ..[event.book.isbn13] = event.author;

      emit(FavoritesLoaded(updatedFavorites, updatedAuthors));
      await _saveFavoritesToStorage(updatedFavorites, updatedAuthors);
    } else {
      emit(FavoritesLoaded([event.book], {event.book.isbn13: event.author}));
    }
  }

  void _onRemoveFromFavorites(
      RemoveFromFavorites event, Emitter<FavoriteState> emit) async {
    if (state is FavoritesLoaded) {
      // Remove favorite
      final updatedFavorites =
          List<Book>.from((state as FavoritesLoaded).favorites)
            ..remove(event.book);
      // Remove particular authors to favorite books
      final updatedAuthors =
          Map<String, String>.from((state as FavoritesLoaded).author)
            ..remove(event.book.isbn13);
      emit(FavoritesLoaded(updatedFavorites, updatedAuthors));

      await _saveFavoritesToStorage(updatedFavorites, updatedAuthors);
    }
  }

  void _onLoadFavorites(LoadFavorites event, Emitter<FavoriteState> emit) {
    // Books and authors for load
    final bookAuthors = <String, String>{};
    for (var book in event.books) {
      bookAuthors[book.isbn13] = event.author;
    }
    emit(FavoritesLoaded(event.books, bookAuthors));
  }
}
