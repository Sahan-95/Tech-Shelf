import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:book_store/presentation/utils/extensions/color_extension.dart';

import '../../blocs/book_details/bloc/book_details_bloc.dart';
import '../../blocs/theme/bloc/theme_bloc.dart';
import '../../utils/colors/color_coding.dart';
import '../../utils/responsive/screen_sizes.dart';
import '../../widgets/custom_app_bar.dart';

class BookDetailsScreen extends StatelessWidget {
  final String isbn13;
  final bool isFavourite;

  const BookDetailsScreen(
      {required this.isbn13, super.key, required this.isFavourite});

  @override
  Widget build(BuildContext context) {
    // Trigger the event to load book details
    context.read<BookDetailsBloc>().add(BookDetailsRequested(isbn13));

    double screenHeight = displayHeight(context);
    double screenWidth = displayWidth(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBarWidget(
              padding: screenWidth * 0.01,
              title: "Book Details",
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
              actionWidget: Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.01),
                child: IconButton(
                  icon: Icon(
                    isFavourite ? Icons.favorite : Icons.favorite_border,
                    color:
                        isFavourite ? favoriteIconColor.toColor() : Colors.grey,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<BookDetailsBloc, BookDetailsState>(
                builder: (context, state) {
                  if (state is BookDetailsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is BookDetailsLoaded) {
                    //   Convert the rating from String to double
                    double ratingValue =
                        double.tryParse(state.book.rating!) ?? 0.0;

                    return Padding(
                      padding: EdgeInsets.only(top: screenHeight * 0.01),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: imageContainerColor.toColor(),
                              child: CachedNetworkImage(
                                imageUrl: state.book.image,
                                height: screenHeight * 0.4,
                                width: double.infinity,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: screenHeight * 0.01),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: screenWidth * 0.02),
                                    child: SizedBox(
                                      width: screenWidth * 0.7,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: screenHeight * 0.01),
                                            child: Text(
                                              state.book.title,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 0.8,
                                                  fontSize:
                                                      screenHeight * 0.02),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: screenHeight * 0.015),
                                            child: Text(
                                              state.book.subtitle,
                                              style: TextStyle(
                                                  color: subtitleFontColor
                                                      .toColor()),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                      width: screenWidth * 0.1 +
                                          state.book.price.length *
                                              screenWidth *
                                              0.02,
                                      height: screenWidth * 0.1 +
                                          state.book.price.length *
                                              screenWidth *
                                              0.02,
                                      decoration: BoxDecoration(
                                        color: priceTagContainerColor.toColor(),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            state.book.price,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: screenWidth * 0.04),
                                          ))),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight * 0.02,
                                  left: screenWidth * 0.02),
                              child: RatingBar.builder(
                                initialRating: ratingValue,
                                minRating: 0,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: screenWidth * 0.08,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 3.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {},
                                ignoreGestures: true,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: screenHeight * 0.03,
                                  left: screenWidth * 0.02),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Description",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: screenHeight * 0.018),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.01),
                                    child: Text(state.book.description!),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is BookDetailsError) {
                    return Center(child: Text(state.message));
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
