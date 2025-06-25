import 'package:cloud_firestore/cloud_firestore.dart';

class Blog {
  final String id;
  final String title;
  final String content;
  final DateTime date;
  final String imageUrl;

  Blog({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.imageUrl,
  });

  factory Blog.fromMap(Map<String, dynamic> data, String documentId) {
    return Blog(
      id: documentId,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      imageUrl: data['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'date': date,
      'imageUrl': imageUrl,
    };
  }
}
