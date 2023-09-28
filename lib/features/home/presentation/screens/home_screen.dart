import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:task/common/toasts.dart';

import '../../../../common/constant/const.dart';

import '../../../../core/routing/routing_manager.dart';
import '../../business_logic/home_controller.dart';
import '../widgets/posts_grid_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController homeController = Get.find<HomeController>();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await homeController.getPosts(
        whenFirstTime: () {
          Toasts.showToast(
            message:
                'You Should Connect To InternetConnection To Have All Posts',
            titleColor: Colors.purpleAccent,
            backgroundColor: Colors.orangeAccent,
          );
        },
      );
    });

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: CustomColors.primaryColor,
        title: const Text('Posts'),
        actions: <Widget>[
          IconButton(
            color: Colors.black,
            icon: const Icon(Icons.add_circle),
            onPressed: () {
              Get.toNamed(RoutesName.createPostScreen);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              if (homeController.postState.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (homeController.postState.hasError) {
                return Text(homeController.postState.error.toString());
              } else {
                return PostsGridWidget(
                  postsList: homeController.postState.result,
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
