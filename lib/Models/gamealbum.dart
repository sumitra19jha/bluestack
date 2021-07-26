class Album {
  final String name;
  final String coverUrl;
  final String gameName;

  Album({
    required this.name,
    required this.coverUrl,
    required this.gameName,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'],
      coverUrl: json['cover_url'],
      gameName: json['game_name'],
    );
  }
}
