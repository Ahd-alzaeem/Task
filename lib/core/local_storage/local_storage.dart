import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:task/features/home/data/model/post_model.dart';

class StorageKeys {
  static const posts = 'posts';
}

class LocalStorage {
  static GetStorage storage = GetStorage();

  static Future<void> saveData(String key, dynamic value) async {
    await storage.write(key, value);
  }

  static dynamic readData(String key) {
    return storage.read(key);
  }

  static Future<void> storePosts(List<PostModel> posts) async => await saveData(
        StorageKeys.posts,
        json.encode(PostModel.toJsonList(posts)),
      );

  static List<dynamic>? getCachedPost() {
    final cachedData = readData(StorageKeys.posts);
    return cachedData != null ? json.decode(cachedData) : null;
  }

  // static List<dynamic>? getCachedPost() {
  //   return json.decode(readData(StorageKeys.posts));
  // }
}

class StorageService {
  final postsKey = 'posts';

  void savePosts(List<PostModel> posts) {
    final postListJson = posts.map((post) => post.toJson()).toList();
    GetStorage().write(postsKey, postListJson);
  }

  List<PostModel> getPosts() {
    final postListJson =
        GetStorage().read<List<Map<String, dynamic>>>(postsKey);
    if (postListJson != null) {
      return postListJson.map((json) => PostModel.fromJson(json)).toList();
    }
    return [];
  }
}
