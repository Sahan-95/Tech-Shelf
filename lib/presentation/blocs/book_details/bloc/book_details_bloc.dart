// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '/domain/entities/book.dart';
import '/domain/use_cases/get_book_details.dart';

part 'book_details_event.dart';
part 'book_details_state.dart';

class BookDetailsBloc extends Bloc<BookDetailsEvent, BookDetailsState> {
  final GetBookDetails getbookDetailsUseCase;

  BookDetailsBloc(this.getbookDetailsUseCase) : super(BookDetailsInitial()) {
    on<BookDetailsRequested>(_onBookDetailsRequested);
  }

  Future<void> _onBookDetailsRequested(
      BookDetailsRequested event, Emitter<BookDetailsState> emit) async {
    emit(BookDetailsLoading());

    try {
      final book = await getbookDetailsUseCase.execute(event.isbn13);
      emit(BookDetailsLoaded(book));
    } catch (e) {
      emit(BookDetailsError(e.toString()));
    }
  }
}
