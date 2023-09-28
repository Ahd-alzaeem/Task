import 'package:flutter/material.dart';

import '../../../../core/api/end_point.dart';
import '../../../../core/network/http.dart';
import '../model/add_post_model.dart';

class CreatePostService {
  Future<void> createPost(AddPost addPost) async {
    debugPrint('theerrorbeforeeee request');
    Request request = Request(
      EndPoint.createpost,
      RequestMethod.post,
      authorized: true,
      body: addPost.toJson(),
    );

    debugPrint('theerrorbeforeeee');
    Map<String, dynamic> response = await request.sendRequest();
    debugPrint('theerrorbeforeeee return');
  }
}
