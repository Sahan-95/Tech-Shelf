// Save favorites to local storage
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/book.dart';

class LocalStorageManagers {
  // Save favorite to local storage
  Future<void> saveFavoritesToStorage(
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

  // Load favorites from local storage
  Future<Map<String, dynamic>> loadFavoritesFromStorage() async {
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

      return {
        'favorites': favorites,
        'authors': authors,
      };
    }

    return {
      'favorites': <Book>[],
      'authors': <String, String>{},
    };
  }
}
