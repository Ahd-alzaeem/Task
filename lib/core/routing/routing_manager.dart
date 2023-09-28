import 'package:get/get.dart';

import '../../features/create_post/presentation/screens/create_post_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';

class RoutesName {
  static String homeScreen = '/home-screen';
  static String createPostScreen = '/create-Post-Screen';
}

class RoutingManager {
  static List<GetPage<dynamic>> pages = [
    GetPage(
      name: RoutesName.homeScreen,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: RoutesName.createPostScreen,
      page: () => CreatePostScreen(),
    ),
  ];

  // RoutingManager(String settingsScreen);
  // static void off(String route) {
  //   Get.offNamed(route);
  // }

  static void offAll(String route) {
    Get.offAllNamed(route);
  }

  static void to(String route, {dynamic arguments}) {
    Get.toNamed(route, arguments: arguments);
  }

  static void back() {
    Get.back();
  }
}
