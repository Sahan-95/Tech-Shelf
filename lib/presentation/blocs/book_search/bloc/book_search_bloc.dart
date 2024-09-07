// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '/domain/entities/book.dart';
import '/domain/use_cases/get_book_details.dart';
import '/domain/use_cases/search_book.dart';

part 'book_search_event.dart';
part 'book_search_state.dart';

class BookSearchBloc extends Bloc<BookSearchEvent, BookSearchState> {
  final SearchBooks searchBooksUseCase;
  final GetBookDetails getBookDetailsUseCase;

  BookSearchBloc(this.searchBooksUseCase, this.getBookDetailsUseCase)
      : super(BookSearchInitial()) {
    on<BookSearchQueryChanged>(_onSearchQueryChanged);
  }

  Future<void> _onSearchQueryChanged(
      event, Emitter<BookSearchState> emit) async {
    final query = event.query.trim();

    if (query.isEmpty) {
      // Emit initial state to clear the search results
      emit(BookSearchInitial());
      return;
    } else {
      emit(BookSearchLoading());
    }

    try {
      final books = await searchBooksUseCase.execute(event.query);

      // To get a book authors
      final bookAuthors = <String, String>{};
      for (var book in books) {
        final bookDetail = await getBookDetailsUseCase.execute(book.isbn13);
        bookAuthors[book.isbn13] = bookDetail.author!;
      }

      emit(BookSearchLoaded(books, bookAuthors));
    } catch (e) {
      emit(BookSearchError(e.toString()));
    }
  }
}
