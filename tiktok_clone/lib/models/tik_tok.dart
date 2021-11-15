import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:tiktok_clone/models/comment.dart';
import 'package:tiktok_clone/models/user.dart';

class TikTok {
  final String? key;
  final String? videoUrl;
  final String? description;
  final int? likes;
  final Comment? comment;
  final int? shares;
  final User? user;
  final List<String?>? hashTags;

  const TikTok({
    this.key,
    this.videoUrl,
    this.description,
    this.likes,
    this.comment,
    this.shares,
    this.user,
    this.hashTags,
  });

  TikTok copyWith({
    String? key,
    String? videoUrl,
    String? description,
    int? likes,
    Comment? comment,
    int? shares,
    User? user,
    List<String?>? hashTags,
  }) {
    return TikTok(
      key: key ?? this.key,
      videoUrl: videoUrl ?? this.videoUrl,
      description: description ?? this.description,
      likes: likes ?? this.likes,
      comment: comment ?? this.comment,
      shares: shares ?? this.shares,
      user: user ?? this.user,
      hashTags: hashTags ?? this.hashTags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'videoUrl': videoUrl,
      'description': description,
      'likes': likes,
      'comment': comment?.toMap(),
      'shares': shares,
      'user': user?.toMap(),
// 'hashTags': hashTags?.map((x) => x?.toMap())?.toList(),
      'hashTags': hashTags,
    };
  }

  factory TikTok.fromMap(Map<String, dynamic> map) {
    return TikTok(
      key: map['key'],
      videoUrl: map['videoUrl'],
      description: map['description'],
      likes: map['likes'],
      comment: map['comment'] != null ? Comment.fromMap(map['comment']) : null,
      shares: map['shares'],
      user: map['user'] != null ? User.fromMap(map['user']) : null,
      // hashTags: map['hashTags'] != null ? List<String?>.from(map['hashTags']?.map((x) => String?.fromMap(x))) : null,
      hashTags: map['hashTags'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TikTok.fromJson(String source) => TikTok.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TikTok(key: $key, videoUrl: $videoUrl, description: $description, likes: $likes, comment: $comment, shares: $shares, user: $user, hashTags: $hashTags)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TikTok &&
        other.key == key &&
        other.videoUrl == videoUrl &&
        other.description == description &&
        other.likes == likes &&
        other.comment == comment &&
        other.shares == shares &&
        other.user == user &&
        listEquals(other.hashTags, hashTags);
  }

  @override
  int get hashCode {
    return key.hashCode ^
        videoUrl.hashCode ^
        description.hashCode ^
        likes.hashCode ^
        comment.hashCode ^
        shares.hashCode ^
        user.hashCode ^
        hashTags.hashCode;
  }
}
