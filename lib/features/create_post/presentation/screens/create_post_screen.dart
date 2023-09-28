import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task/common/toasts.dart';

import '../../../../common/constant/const.dart';
import '../../../../core/routing/routing_manager.dart';
import '../../business_logic/create_post_controller.dart';
import '../widgets/button.dart';
import '../widgets/post_widget.dart';

class CreatePostScreen extends StatelessWidget {
  CreatePostScreen({super.key});
  final CreatePostController createPostController =
      Get.find<CreatePostController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: CustomColors.primaryColor,
        title: const Text('Add Post'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            PostWidget(createPostController: createPostController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonWidget(
                  'Back',
                  onTap: () {
                    Get.toNamed(RoutesName.homeScreen);
                  },
                  backGroundColor: CustomColors.pink,
                ),
                Obx(
                  () => ButtonWidget(
                    'Next',
                    isLoading: createPostController
                        .createResponseState.value.isLoading,
                    onTap: () async {
                      if (createPostController.emptyContent &&
                          createPostController.emptyImages) {
                        Toasts.showToast(
                          message: 'you must add images and content',
                          titleColor: Colors.greenAccent,
                          backgroundColor: Colors.purpleAccent,
                        );
                        return;
                      }
                      await createPostController.createPost(
                        whenSuccess: (p0) {
                          Toasts.showToast(
                            message: 'Post added successfully',
                            titleColor: Colors.greenAccent,
                            backgroundColor: Colors.purpleAccent,
                          );
                          Get.toNamed(RoutesName.homeScreen);
                        },
                      );
                      //
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
