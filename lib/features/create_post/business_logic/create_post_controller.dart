// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:rx_future/rx_future.dart';
// import 'package:task/features/firebase/business_logic/firebase_manager.dart';

// import '../data/model/add_post_model.dart';
// import '../data/source/create_post_service.dart';

// class CreatePostController extends GetxController {
//   CreatePostService createPostService = CreatePostService();
//   RxFuture<void> createResponseState = RxFuture(null);
//   Rx<AddPost> createRequest = AddPost.zero().obs;

//   Future<void> createPost({
//     void Function(void)? whenSuccess,
//   }) async {
//     createResponseState.observe(
//       (p0) async {
//         await createPostService.createPost(createRequest.value);
//       },
//       onSuccess: ((p0) {
//         // whenSuccess?.call(p0);
//       }),
//       onError: (error) {
//         debugPrint('theerror ${error.toString()}');
//         Get.snackbar('error', error.toString());
//       },
//     );
//   }

//   Future<void> uploadImagesToFirebase(File image) async {
//     await FireBaseManager.uploadImageToFirebase(image);
//   }

//   final selectImages = List<File>.empty(growable: true).obs;
//   void addImages(List<File> newImages) async {
//     selectImages.addAll(newImages);
//     for (var image in newImages) {
//       final media = Media(
//         srcUrl:
//             image.path, // Assuming path is the appropriate srcUrl for the image
//         mediaType: 'image',
//         mimeType: 'image/jpeg', // Assuming JPEG format, adjust as needed
//         fullPath: image.path,
//         size: await image.length(),
//       );
//       createRequest.value.media.add(media);
//     }
//   }

//   void removeImage(File image) {
//     selectImages.remove(image);
//   }

//   var isDeleting = false.obs;
// }

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rx_future/rx_future.dart';
import 'package:task/features/firebase/business_logic/firebase_manager.dart';

import '../../home/data/model/post_model.dart';
import '../data/model/add_post_model.dart';
import '../data/source/create_post_service.dart';

class CreatePostController extends GetxController {
  CreatePostService createPostService = CreatePostService();
  RxFuture<void> createResponseState = RxFuture(null);

  List<Media> get uploadedImages => createRequest.value.media;

  bool get emptyImages => uploadedImages.isEmpty;

  bool get emptyContent => createRequest.value.isContentEmpty;

  Rx<AddPost> createRequest = Rx(AddPost.zero());

  Future<void> setFireBasePaths() async {
    for (var i = 0; i < uploadedImages.length; i++) {
      uploadedImages[i].srcUrl = await FireBaseManager.uploadImageToFirebase(
            File(uploadedImages[i].imagePath),
          ) ??
          '';
    }
  }

  Future<void> createPost({
    void Function(void)? whenSuccess,
  }) async {
    createResponseState.observe(
      (p0) async {
        await setFireBasePaths();
        await createPostService.createPost(createRequest.value);
      },
      onSuccess: ((p0) {
        whenSuccess?.call(p0);
        createRequest.value.clear();
      }),
      onError: (error) {
        debugPrint('theerror ${error.toString()}');
        Get.snackbar('error', error.toString());
        createRequest.value.clear();
      },
    );
  }

  // Future<String?> uploadImagesToFirebase() async {
  //   File image = await FireBaseManager.getDownloadedImagePath(
  //       uploadImage); // You need to provide the image file here
  //   return await FireBaseManager.uploadImageToFirebase(image);
  // }

  // final selectImages = List<File>.empty(growable: true).obs;
  void addImages(List<File> newImages) async {
    // selectImages.addAll(newImages);
    for (var image in newImages) {
      final media = Media(
        imagePath: image.path,
        mediaType: 'image',
        mimeType: 'image/jpeg', // Assuming JPEG format, adjust as needed
        fullPath: image.path,
        size: await image.length(),
      );
      createRequest.update((val) {
        val!.media.add(media);
      });
    }
  }

  void removeImage(File image) {
    createRequest.update((val) {
      val!.media.removeWhere((media) => media.imagePath == image.path);
    });

    // selectImages.remove(image);
  }

  var isDeleting = false.obs;
}
