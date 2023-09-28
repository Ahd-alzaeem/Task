import 'package:task/features/home/data/model/post_model.dart';

import '../../../../core/api/end_point.dart';
import '../../../../core/local_storage/local_storage.dart';
import '../../../../core/network/http.dart';

class HomeService {
  LocalStorage local = LocalStorage();

  Future<List<PostModel>> getPosts(
      {int postsPerPage = 15, int page = 1}) async {
    Request request = Request(
      EndPoint.posts,
      RequestMethod.get,
      queryParams: {
        'page': page,
        'limit': postsPerPage,
      },
      // headers: {
      //   'Authorization': local.getToken(),
      // },
    );
    Map<String, dynamic> response = await request.sendRequest();
    return PostModel.fromJsonList(response);
  }
}
