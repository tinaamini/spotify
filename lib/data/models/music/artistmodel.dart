class ArtistModel {
  final int id;
  final String name;

  ArtistModel({
    required this.id,
    required this.name,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      id: json['id'] as int? ?? int.parse(json['id'].toString()),
      name: json['name'],
    );
  }
}