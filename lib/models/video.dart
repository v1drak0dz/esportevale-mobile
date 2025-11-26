class Video {
  final String id;
  final String titulo;
  final String cover;
  final String link;

  Video({
    required this.id,
    required this.titulo,
    required this.cover,
    required this.link,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'].toString(),
      titulo: json['titulo'] ?? '',
      cover: json['cover'] ?? '',
      link: json['link'] ?? '',
    );
  }
}
