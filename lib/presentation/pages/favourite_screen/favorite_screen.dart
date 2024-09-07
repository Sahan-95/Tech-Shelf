import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:book_store/presentation/utils/extensions/color_extension.dart';

import '../../blocs/favorite/bloc/favorite_bloc.dart';
import '../../blocs/theme/bloc/theme_bloc.dart';
import '../../utils/colors/color_coding.dart';
import '../../utils/responsive/screen_sizes.dart';
import '../../widgets/book_list_item.dart';
import '../../widgets/custom_app_bar.dart';
import '../book_details_screen/book_details_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = displayWidth(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBarWidget(
              padding: screenWidth * 0.01,
              title: "Favourite Books",
              elevatedButtonWidget: BlocBuilder<ThemeBloc, ThemeState>(
                builder: (context, state) {
                  bool isDarkMode = state is ThemeDark;

                  return ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDarkMode
                            ? Colors.white
                            : backButtonBackgroundColor.toColor(),
                        side: BorderSide(
                            color: backButtonBorderColor.toColor(), width: 2),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios_new,
                            size: screenWidth * 0.04,
                            color: isDarkMode
                                ? Colors.black
                                : backButtonBorderColor.toColor(),
                          ),
                          Text(
                            "Back",
                            style: TextStyle(
                                color: isDarkMode
                                    ? Colors.black
                                    : backButtonBorderColor.toColor()),
                          )
                        ],
                      ));
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<FavoriteBloc, FavoriteState>(
                builder: (context, state) {
                  if (state is FavoritesLoaded) {
                    final favoriteBooks = state.favorites;
                    final bookAuthor = state.author;

                    if (favoriteBooks.isEmpty) {
                      return const Center(
                        child: Text('No favorite books selected.'),
                      );
                    }

                    return ListView.separated(
                      padding: EdgeInsets.zero,
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: favoriteBooks.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final book = favoriteBooks[index];
                        final author = bookAuthor[book.isbn13];

                        return BookListItem(
                          book: book,
                          author: author,
                          trailingWidget: IconButton(
                            icon: const Icon(Icons.favorite, color: Colors.red),
                            onPressed: () {
                              // Remove from favorites directly in the list
                              context
                                  .read<FavoriteBloc>()
                                  .add(RemoveFromFavorites(book, author!));
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDetailsScreen(
                                  isbn13: book.isbn13,
                                  isFavourite: true,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  } else if (state is FavoriteInitial) {
                    return const Center(
                        child: Text('Loading favorite books...'));
                  } else {
                    return const Center(child: Text('Something went wrong!'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
