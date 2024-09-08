// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '/domain/entities/book.dart';
import '../../../managers/local_storage_managers.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
    on<LoadFavorites>(_onLoadFavorites);

    loadFavoritesFromLocalStorage();
  }

  final localStorageMananger = LocalStorageManagers();

  Future<void> loadFavoritesFromLocalStorage() async {
    final result = await localStorageMananger.loadFavoritesFromStorage();

    final List<Book> favorites = result['favorites'];
    final Map<String, String> authors = result['authors'];

    // Emit loaded state
    add(LoadFavorites(favorites, authors.values.first));
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
      await localStorageMananger.saveFavoritesToStorage(
          updatedFavorites, updatedAuthors);
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
            ..removeWhere((book) => book.isbn13 == event.book.isbn13);
      // Remove particular authors to favorite books
      final updatedAuthors =
          Map<String, String>.from((state as FavoritesLoaded).author)
            ..remove(event.book.isbn13);
      emit(FavoritesLoaded(updatedFavorites, updatedAuthors));

      await localStorageMananger.saveFavoritesToStorage(
          updatedFavorites, updatedAuthors);
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
