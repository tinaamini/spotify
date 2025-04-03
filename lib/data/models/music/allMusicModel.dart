class MusicModel {
  final int id;
  final String name;
  final int artistId;
  final String audioUrl;
  final String coverUrl;
  bool isLiked;

  MusicModel({
    required this.id,
    required this.name,
    required this.artistId,
    required this.audioUrl,
    required this.coverUrl,
    this.isLiked = false,
  });

  factory MusicModel.fromJson(Map<String, dynamic> json) {
    return MusicModel(
      id: json['id'] as int? ?? int.parse(json['id'].toString()),
      name: json['name'] as String,
      artistId: json['artist_id'] as int,
      audioUrl: json['audio_url'] as String,
      coverUrl: json['cover_url'] as String,
      isLiked: json['is_liked'] ?? false,
    );
  }
}