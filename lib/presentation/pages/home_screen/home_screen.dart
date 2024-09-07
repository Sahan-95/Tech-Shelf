import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import 'package:book_store/presentation/utils/extensions/color_extension.dart';

import '../../../domain/entities/book.dart';
import '../../blocs/book_search/bloc/book_search_bloc.dart';
import '../../blocs/favorite/bloc/favorite_bloc.dart';
import '../../blocs/theme/bloc/theme_bloc.dart';
import '../../utils/colors/color_coding.dart';
import '../../utils/responsive/screen_sizes.dart';
import '../../utils/routes/custom_routes.dart';
import '../../widgets/book_list_item.dart';
import '../../widgets/custom_app_bar.dart';
import '../book_details_screen/book_details_screen.dart';
import '../favourite_screen/favorite_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controller
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // To load favorite items
    context.read<FavoriteBloc>().add(LoadFavorites(const [], ""));

    // Listening to input changes
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = displayHeight(context);
    double screenWidth = displayWidth(context);

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        // Get mode using state
        bool isDarkMode = state is ThemeDark;

        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: const AssetImage(
                      'assets/images/home_screen/background.jpg'),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.9), BlendMode.lighten))),
          child: Scaffold(
            backgroundColor: isDarkMode ? Colors.black : Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: GestureDetector(
              // Remove keyboard when click anywhere in the screen
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SafeArea(
                child: Column(
                  children: [
                    CustomAppBarWidget(
                      padding: screenWidth * 0.01,
                      title: "IT Book Store",
                      actionWidget: Padding(
                        padding: EdgeInsets.only(right: screenWidth * 0.025),
                        child: BlocBuilder<ThemeBloc, ThemeState>(
                          builder: (context, state) {
                            return Transform.scale(
                              scale: screenWidth * 0.0025,
                              child: Switch(
                                  value: state is ThemeDark,
                                  onChanged: (value) {
                                    // Mode change
                                    context
                                        .read<ThemeBloc>()
                                        .add(ToggleTheme());
                                  },
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap),
                            );
                          },
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSearchField(context, screenHeight, screenWidth),
                        Padding(
                          padding: EdgeInsets.only(right: screenWidth * 0.01),
                          child: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              size: screenWidth * 0.1,
                            ),
                            color: isDarkMode
                                ? favouriteScreenNavigationIconColorDarkMode
                                    .toColor()
                                : favouriteScreenNavigationIconColor.toColor(),
                            onPressed: () {
                              Navigator.push(
                                  context, createRoute(const FavoriteScreen()));
                            },
                          ),
                        ),
                      ],
                    ),
                    BlocBuilder<BookSearchBloc, BookSearchState>(
                      builder: (context, state) {
                        if (state is BookSearchInitial) {
                          return Expanded(
                            child: SingleChildScrollView(
                              child: Center(
                                  child: Column(
                                children: [
                                  // Animation
                                  SizedBox(
                                      height: screenHeight * 0.4,
                                      width: screenWidth * 0.7,
                                      child: LottieBuilder.asset(
                                        'assets/animations/books.json',
                                        repeat: true,
                                      )),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.1),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      width: screenWidth * 0.55,
                                      height: screenHeight * 0.058,
                                      decoration: BoxDecoration(
                                        color: isDarkMode
                                            ? Colors.white
                                            : initialMessageContainerColor
                                                .toColor(),
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        border: Border.all(
                                          color:
                                              searchIconEnableColor.toColor(),
                                          width: 2.0,
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              // Focus input field when clicked
                                              _searchFocusNode.requestFocus();
                                            },
                                            child: const Text(
                                              'Search for books',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          IconButton(
                                              icon: FaIcon(
                                                FontAwesomeIcons.handPointUp,
                                                size: screenHeight * 0.02,
                                                color: isDarkMode
                                                    ? Colors.black
                                                    : searchIconEnableColor
                                                        .toColor(),
                                              ),
                                              onPressed: () {
                                                // Focus input field when clicked
                                                _searchFocusNode.requestFocus();
                                              })
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            ),
                          );
                        } else if (state is BookSearchLoading) {
                          return const Expanded(
                            child: Center(child: CircularProgressIndicator()),
                          );
                        } else if (state is BookSearchLoaded) {
                          // Find whether favorite is there or not
                          return BlocBuilder<FavoriteBloc, FavoriteState>(
                            builder: (context, favoriteState) {
                              if (favoriteState is FavoritesLoaded) {
                                return Expanded(
                                    child: Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.04),
                                  child: _buildBookList(
                                      state.books,
                                      state.bookAuthors,
                                      favoriteState.favorites),
                                ));
                              } else {
                                return Expanded(
                                    child: Padding(
                                  padding:
                                      EdgeInsets.only(top: screenHeight * 0.04),
                                  child: _buildBookList(
                                      state.books, state.bookAuthors, []),
                                ));
                              }
                            },
                          );
                        } else if (state is BookSearchError) {
                          return Center(child: Text(state.message));
                        } else {
                          return const Center(
                              child: Text('Something went wrong!'));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchField(
      BuildContext context, double screenHeight, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(
          top: screenHeight * 0.02,
          right: screenWidth * 0.02,
          left: screenWidth * 0.03),
      child: SizedBox(
        width: screenWidth * 0.75,
        child: TextField(
          controller: _searchController,
          focusNode: _searchFocusNode,
          decoration: InputDecoration(
              labelText: 'Search for books',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: searchFieldEnableBorderColor.toColor(),
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                  color: searchFieldActiveBorderColor.toColor(),
                  width: 2.0,
                ),
              ),
              constraints: BoxConstraints(maxHeight: screenHeight * 0.055),
              contentPadding: EdgeInsets.symmetric(
                  vertical: (screenHeight * 0.05 - 16) / 2,
                  horizontal: screenWidth * 0.05),
              suffixIcon: ValueListenableBuilder<TextEditingValue>(
                  valueListenable: _searchController,
                  builder: (context, value, child) {
                    return IconButton(
                        onPressed: value.text.isNotEmpty
                            ? () {
                                // get data when clicked search icon
                                final query = _searchController.text;
                                context
                                    .read<BookSearchBloc>()
                                    .add(BookSearchQueryChanged(query));
                              }
                            : null,
                        icon: Icon(
                          Icons.search,
                          color: value.text.isNotEmpty
                              ? searchIconEnableColor.toColor()
                              : searchFieldEnableBorderColor.toColor(),
                        ));
                  })),
          onSubmitted: (query) {
            context.read<BookSearchBloc>().add(BookSearchQueryChanged(query));
          },
        ),
      ),
    );
  }

  Widget _buildBookList(
      List<Book> books, Map<String, String> bookAuthors, List<Book> favorites) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: books.length,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        final book = books[index];
        final author = bookAuthors[book.isbn13] ?? "Unknown Author";

        return BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
          bool isFavorite = false;

          if (state is FavoritesLoaded) {
            // isFavorite is true when there is a previous favorite
            isFavorite = isFavorite = favorites
                .any((favoriteBook) => favoriteBook.isbn13 == book.isbn13);
          }

          return BookListItem(
            book: book,
            author: author,
            trailingWidget: IconButton(
              icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
              color: isFavorite ? favoriteIconColor.toColor() : Colors.grey,
              onPressed: () {
                if (isFavorite) {
                  // Remove from favorites
                  context
                      .read<FavoriteBloc>()
                      .add(RemoveFromFavorites(book, author));
                } else {
                  // Add to favorites
                  context
                      .read<FavoriteBloc>()
                      .add(AddToFavorites(book, author));
                }
              },
            ),
            onTap: () {
              Navigator.push(
                  context,
                  createRoute(BookDetailsScreen(
                    isbn13: book.isbn13,
                    isFavourite: isFavorite,
                  )));
            },
          );
        });
      },
    );
  }

  // Listening to input changes (Come to initial state ,If user remove all input)
  void _onSearchChanged() {
    if (_searchController.text.isEmpty) {
      context
          .read<BookSearchBloc>()
          .add(BookSearchQueryChanged(_searchController.text));
    }
  }
}
