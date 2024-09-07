import 'package:json_annotation/json_annotation.dart';

part 'book_model.g.dart';

@JsonSerializable()
class BookModel {
  final String title;
  final String subtitle;
  final String isbn13;
  final String image;
  final String? authors;
  final String? rating;
  final String price;
  final String? desc;

  BookModel({
    required this.title,
    required this.subtitle,
    required this.isbn13,
    required this.image,
    this.authors,
    this.rating,
    required this.price,
    this.desc,
  });

  factory BookModel.fromJson(Map<String, dynamic> json) =>
      _$BookModelFromJson(json);
  Map<String, dynamic> toJson() => _$BookModelToJson(this);
}

@JsonSerializable()
class BookSearchResponse {
  final List<BookModel> books;

  BookSearchResponse({required this.books});

  factory BookSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$BookSearchResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BookSearchResponseToJson(this);
}

@JsonSerializable()
class BookDetailResponse {
  @JsonKey(name: 'book')
  final BookModel book;

  BookDetailResponse({required this.book});

  factory BookDetailResponse.fromJson(Map<String, dynamic> json) {
    if (json['book'] != null) {
      return _$BookDetailResponseFromJson(json);
    } else {
      return BookDetailResponse(
        book: BookModel.fromJson(json),
      );
    }
  }
  Map<String, dynamic> toJson() => _$BookDetailResponseToJson(this);
}

@JsonSerializable()
class NewReleasesResponse {
  final List<BookModel> books;

  NewReleasesResponse({required this.books});

  factory NewReleasesResponse.fromJson(Map<String, dynamic> json) =>
      _$NewReleasesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$NewReleasesResponseToJson(this);
}
