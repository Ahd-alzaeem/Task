import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rx_future/rx_future.dart';
import 'package:task/core/local_storage/local_storage.dart';
import 'package:task/features/connectivity/internet_connection_checker.dart';
import '../data/model/post_model.dart';
import '../data/source/home_service.dart';

class HomeController extends GetxController {
  // ¬ storage
  HomeService homeService = HomeService();

  bool isRefresh = false;

  RxBool isLoading = RxBool(false);

  RxFuture<List<PostModel>> postState = RxFuture(<PostModel>[]);

  List<PostModel> cachedPosts = [];

  Future<void> getPosts({VoidCallback? whenFirstTime}) async {
    getCachedPosts();
    if (!InternetConnectionChecker.isConnected) {
      if (cachedPosts.isEmpty) {
        whenFirstTime?.call();
        return;
      }
      postState.update((val) {
        val!.value = cachedPosts;
      });
      return;
    }

    Future.delayed(Duration.zero, () async {
      await postState.observe(
        (p0) async {
          return await homeService.getPosts();
        },
        onSuccess: (value) async {
          await LocalStorage.storePosts(value);
        },
        onError: (error) {
          print('%%%%%%%%%%%%%%%%%');
          print(error);
          print('%%%%%%%%%%%%%%%%%');
        },
      );
    });
  }

  void getCachedPosts() {
    LocalStorage.getCachedPost()!.forEach((map) {
      cachedPosts.add(PostModel.fromJson(map));
    });
  }
}
