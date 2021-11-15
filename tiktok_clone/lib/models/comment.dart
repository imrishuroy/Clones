import 'dart:convert';

class Comment {
  final String? key;
  final int? noOfComments;
  Comment({
    this.key,
    this.noOfComments,
  });

  Comment copyWith({
    String? key,
    int? noOfComments,
  }) {
    return Comment(
      key: key ?? this.key,
      noOfComments: noOfComments ?? this.noOfComments,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'noOfComments': noOfComments,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      key: map['key'],
      noOfComments: map['noOfComments'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));

  @override
  String toString() => 'Comment(key: $key, noOfComments: $noOfComments)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment &&
        other.key == key &&
        other.noOfComments == noOfComments;
  }

  @override
  int get hashCode => key.hashCode ^ noOfComments.hashCode;
}
