class PostModel{
  const PostModel({this.time, this.content, this.imageUrl, this.isOpened});
  final String time;
  final String content;
  final String imageUrl;
  final bool isOpened;

  PostModel copyWith({
    String time,
    String content,
    String imageUrl,
    bool isOpened
  }) =>PostModel(
    time: time ?? this.time,
    content: content ?? this.content,
    imageUrl: imageUrl ?? this.imageUrl,
    isOpened: isOpened ?? this.isOpened,
  );

  @override
  String toString() => '''$PostModel {
    time: $time,
    content: $content,
    imageUrl: $imageUrl,
    isOpened: $isOpened,
  }''';
}