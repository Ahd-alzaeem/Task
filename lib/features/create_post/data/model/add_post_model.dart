class AddPost {
  String content;
  List<Media> media;

  AddPost({
    required this.content,
    required this.media,
  });

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'media': media.map((m) => m.toJson()).toList(),
    };
  }

  bool get isContentEmpty => content == '';

  factory AddPost.zero() => AddPost(
        content: '',
        media: [],
      );

  void clear() {
    content = '';
    media = [];
  }
}

class Media {
  String imagePath;
  String? srcUrl;
  final String mediaType;
  final String mimeType;
  final String fullPath;
  final int size;

  Media({
    required this.imagePath,
    this.srcUrl,
    required this.mediaType,
    required this.mimeType,
    required this.fullPath,
    required this.size,
  });

  factory Media.zero() => Media(
        srcUrl: '',
        mediaType: '',
        mimeType: '',
        fullPath: '',
        imagePath: '',
        size: 0,
      );

  Map<String, dynamic> toJson() {
    return {
      'src_url': srcUrl,
      'media_type': mediaType,
      'mime_type': mimeType,
      'fullPath': fullPath,
      'size': size,
    };
  }
}
