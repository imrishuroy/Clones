import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:instagram/config/paths.dart';
import 'package:meta/meta.dart';

import 'package:instagram/models/app_user.dart';

class Post extends Equatable {
  final String? id;
  final AppUser? author;
  final String? imageUrl;
  final String? caption;
  final int? likes;
  final DateTime? date;

  Post({
    this.id,
    @required this.author,
    @required this.imageUrl,
    @required this.caption,
    @required this.likes,
    @required this.date,
  });

  @override
  List<Object?> get props {
    return [
      id,
      author,
      imageUrl,
      caption,
      likes,
      date,
    ];
  }

  Post copyWith({
    String? id,
    AppUser? user,
    String? imageUrl,
    String? caption,
    int? likes,
    DateTime? date,
  }) {
    return Post(
      id: id ?? this.id,
      author: user ?? this.author,
      imageUrl: imageUrl ?? this.imageUrl,
      caption: caption ?? this.caption,
      likes: likes ?? this.likes,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'author':
          FirebaseFirestore.instance.collection(Paths.users).doc(author?.id),
      'imageUrl': imageUrl,
      'caption': caption,
      'likes': likes,
      'date': Timestamp.fromDate(date ?? DateTime.now()),
    };
  }

  static Future<Post?> fromDocument(DocumentSnapshot? doc) async {
    if (doc == null) return null;
    final data = doc.data() as Map?;
    final authorRef = data?['author'] as DocumentSnapshot?;
    if (authorRef != null) {
      final authorDoc = await authorRef.data() as DocumentSnapshot?;
      return Post(
        id: doc.id,
        author: AppUser.fromDocument(authorDoc),
        imageUrl: data?['imageUrl'] ?? '',
        caption: data?['caption'] ?? '',
        likes: data?['likes'] ?? 0,
        date: (data?['date'] as Timestamp?)?.toDate(),
      );
    }
    return null;
  }

  // factory Post.fromMap(Map<String, dynamic> map) {
  //   return Post(
  //     id: map['id'],
  //     author: AppUser.fromMap(map['user']),
  //     imageUrl: map['imageUrl'],
  //     caption: map['caption'],
  //     likes: map['likes'],
  //     date: DateTime.fromMillisecondsSinceEpoch(map['date']),
  //   );
  // }

  // String toJson() => json.encode(toMap());

  //factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  @override
  bool get stringify => true;
}
