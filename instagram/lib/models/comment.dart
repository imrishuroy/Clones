import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:instagram/config/paths.dart';

import 'package:instagram/models/app_user.dart';
import 'package:meta/meta.dart';

class Comment extends Equatable {
  final String? id;
  final String? postId;
  final AppUser? author;
  final String? content;
  final DateTime? date;
  Comment({
    this.id,
    @required this.postId,
    @required this.author,
    @required this.content,
    @required this.date,
  });

  @override
  List<Object?> get props {
    return [
      id,
      postId,
      author,
      content,
      date,
    ];
  }

  Comment copyWith({
    String? id,
    String? postId,
    AppUser? author,
    String? content,
    DateTime? date,
  }) {
    return Comment(
      id: id ?? this.id,
      postId: postId ?? this.postId,
      author: author ?? this.author,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'postId': postId,
      'author':
          FirebaseFirestore.instance.collection(Paths.users).doc(author?.id),
      'content': content,
      'date': Timestamp.fromDate(date ?? DateTime.now()),
    };
  }

  static Future<Comment?> fromDocument(DocumentSnapshot? doc) async {
    if (doc == null) return null;
    final data = doc.data() as Map?;
    final authorRef = data?['author'] as DocumentReference?;
    if (authorRef == null) {
      final authorDoc = await authorRef?.get();
      return Comment(
        id: doc.id,
        postId: data?['postId'] ?? '',
        author: AppUser.fromDocument(authorDoc),
        content: data?['content'] ?? '',
        date: (data?['date'] as Timestamp?)?.toDate(),
      );
    }
    return null;
  }

  @override
  bool get stringify => true;
}

// DFCCIL777143
// Laltu

// #LALTU2024
