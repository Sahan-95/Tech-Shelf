// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookModel _$BookModelFromJson(Map<String, dynamic> json) => BookModel(
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      isbn13: json['isbn13'] as String,
      image: json['image'] as String,
      authors: json['authors'] as String?,
      rating: json['rating'] as String?,
      price: json['price'] as String,
      desc: json['desc'] as String?,
    );

Map<String, dynamic> _$BookModelToJson(BookModel instance) => <String, dynamic>{
      'title': instance.title,
      'subtitle': instance.subtitle,
      'isbn13': instance.isbn13,
      'image': instance.image,
      'authors': instance.authors,
      'rating': instance.rating,
      'price': instance.price,
      'desc': instance.desc,
    };

BookSearchResponse _$BookSearchResponseFromJson(Map<String, dynamic> json) =>
    BookSearchResponse(
      books: (json['books'] as List<dynamic>)
          .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookSearchResponseToJson(BookSearchResponse instance) =>
    <String, dynamic>{
      'books': instance.books,
    };

BookDetailResponse _$BookDetailResponseFromJson(Map<String, dynamic> json) =>
    BookDetailResponse(
      book: BookModel.fromJson(json['book'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BookDetailResponseToJson(BookDetailResponse instance) =>
    <String, dynamic>{
      'book': instance.book,
    };

NewReleasesResponse _$NewReleasesResponseFromJson(Map<String, dynamic> json) =>
    NewReleasesResponse(
      books: (json['books'] as List<dynamic>)
          .map((e) => BookModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NewReleasesResponseToJson(
        NewReleasesResponse instance) =>
    <String, dynamic>{
      'books': instance.books,
    };
