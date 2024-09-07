import '../../data/models/book_model.dart';

// To map book model to book in domain layer
class Book {
  final String title;
  final String subtitle;
  final String isbn13;
  final String image;
  final String? author;
  final String? rating;
  final String price;
  final String? description;

  Book({
    required this.title,
    required this.subtitle,
    required this.isbn13,
    required this.image,
    this.author,
    this.rating,
    required this.price,
    this.description,
  });

  factory Book.fromModel(BookModel model) {
    return Book(
      title: model.title,
      subtitle: model.subtitle,
      isbn13: model.isbn13,
      image: model.image,
      author: model.authors ?? "",
      rating: model.rating ?? "",
      price: model.price,
      description: model.desc ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'subtitle': subtitle,
    'isbn13': isbn13,
    'image': image,
    'author': author,
    'rating': rating,
    'price': price,
    'description': description,
  };

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
      subtitle: json['subtitle'],
      isbn13: json['isbn13'],
      image: json['image'],
      author: json['author'],
      rating: json['rating'],
      price: json['price'],
      description: json['description'],
    );
  }
}
