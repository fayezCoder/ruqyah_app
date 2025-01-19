class AudioItem {
  final String title;
  final String url;
  final String? subtitle;
  final String? imageUrl;

  AudioItem({
    required this.title,
    required this.url,
    this.subtitle,
    this.imageUrl,
  });
}
