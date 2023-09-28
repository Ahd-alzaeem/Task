class PostModel {
  String authorName;
  List<String> images;
  String date;

  PostModel({
    required this.authorName,
    required this.date,
    required this.images,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        authorName: json["model"]["first_name"] ?? 'ahmad',
        images: PostModel.jsonToImages(json),
        date: json["model"]["created_at"],
      );

  static List<PostModel> fromJsonList(Map<String, dynamic> json) {
    List<PostModel> list = [];
    json["data"]["items"].forEach(
      (post) => list.add(
        PostModel.fromJson(post),
      ),
    );
    return list;
  }

  static List<String> jsonToImages(Map<String, dynamic> json) {
    List<String> list = [];
    json["media"].forEach(
      (img) => list.add(img["src_url"].toString()),
    );
    return list;
  }

  Map<String, dynamic> toJson() {
    return {
      "model": {
        'first_name': authorName,
        'created_at': date,
      },
      "media": imagesToJson(images)
    };
  }

  static List<Map<String, dynamic>> imagesToJson(List<String> images) {
    List<Map<String, dynamic>> list = [];
    images.forEach((image) {
      list.add({'src_url': image});
    });
    return list;
  }

  static List<Map<String, dynamic>> toJsonList(List<PostModel> posts) {
    List<Map<String, dynamic>> jsonList = [];
    for (var post in posts) {
      jsonList.add(post.toJson());
    }
    return jsonList;
  }
}
