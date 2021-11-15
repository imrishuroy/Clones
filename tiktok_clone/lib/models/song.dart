import 'dart:convert';

class Song {
  final String? name;
  final String? arstist;
  final String? audioUrl;
  final String? coverArtUrl;

  const Song({
    this.name,
    this.arstist,
    this.audioUrl,
    this.coverArtUrl,
  });

  Song copyWith({
    String? name,
    String? arstist,
    String? audioUrl,
    String? coverArtUrl,
  }) {
    return Song(
      name: name ?? this.name,
      arstist: arstist ?? this.arstist,
      audioUrl: audioUrl ?? this.audioUrl,
      coverArtUrl: coverArtUrl ?? this.coverArtUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'arstist': arstist,
      'audioUrl': audioUrl,
      'coverArtUrl': coverArtUrl,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      name: map['name'],
      arstist: map['arstist'],
      audioUrl: map['audioUrl'],
      coverArtUrl: map['coverArtUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Song.fromJson(String source) => Song.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Song(name: $name, arstist: $arstist, audioUrl: $audioUrl, coverArtUrl: $coverArtUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Song &&
        other.name == name &&
        other.arstist == arstist &&
        other.audioUrl == audioUrl &&
        other.coverArtUrl == coverArtUrl;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        arstist.hashCode ^
        audioUrl.hashCode ^
        coverArtUrl.hashCode;
  }
}
