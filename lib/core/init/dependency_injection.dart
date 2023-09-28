import 'package:get/get.dart';
import 'package:task/features/create_post/business_logic/create_post_controller.dart';

import '../../features/home/business_logic/home_controller.dart';

class DependencyInjection {
  static Future<void> inject() async {
    // @controllers

    Get.put(HomeController());
    Get.put(CreatePostController());
  }
}
