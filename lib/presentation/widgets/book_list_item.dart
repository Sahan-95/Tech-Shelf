import 'package:flutter/material.dart';

import '../../domain/entities/book.dart';

class BookListItem extends StatelessWidget {
  final Book book;
  final String? author;
  final VoidCallback onTap;
  final Widget? trailingWidget;

  const BookListItem({
    required this.book,
    required this.onTap,
    this.trailingWidget,
    super.key, this.author,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(book.image),
      title: Text(
        book.title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text('Author: $author'),
      trailing: trailingWidget,
      onTap: onTap,
    );
  }
}
