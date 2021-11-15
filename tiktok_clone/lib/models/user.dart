import 'dart:convert';

class User {
  final String? handle;
  final String? imageUrl;
  final String? userDetailsKey;

  const User({
    this.handle,
    this.imageUrl,
    this.userDetailsKey,
  });

  User copyWith({
    String? handle,
    String? imageUrl,
    String? userDetailsKey,
  }) {
    return User(
      handle: handle ?? this.handle,
      imageUrl: imageUrl ?? this.imageUrl,
      userDetailsKey: userDetailsKey ?? this.userDetailsKey,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'handle': handle,
      'imageUrl': imageUrl,
      'userDetailsKey': userDetailsKey,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      handle: map['handle'],
      imageUrl: map['imageUrl'],
      userDetailsKey: map['userDetailsKey'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() =>
      'User(handle: $handle, imageUrl: $imageUrl, userDetailsKey: $userDetailsKey)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.handle == handle &&
        other.imageUrl == imageUrl &&
        other.userDetailsKey == userDetailsKey;
  }

  @override
  int get hashCode =>
      handle.hashCode ^ imageUrl.hashCode ^ userDetailsKey.hashCode;
}
