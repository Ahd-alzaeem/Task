import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../common/constant/const.dart';
import '../../business_logic/create_post_controller.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.createPostController,
  });

  final CreatePostController createPostController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: DottedBorder(
            dashPattern: const [8, 2],
            borderType: BorderType.Rect,
            color: CustomColors.accentColor,
            borderPadding: const EdgeInsets.all(2),
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              height: Get.height * 0.25,
              width: Get.width * 0.8,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        createPostController.createRequest.value.content =
                            value;
                      },
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'What about think...',
                        hintStyle: TextStyle(
                          color: Colors.grey.withOpacity(0.8),
                        ),
                      ),
                    ).paddingOnly(left: 90),
                    GestureDetector(
                      onTap: () async {
                        final picker = ImagePicker();
                        final pickedImages = await picker.pickMultiImage();
                        if (pickedImages != null) {
                          final newImages = pickedImages
                              .map((image) => File(image.path))
                              .toList();
                          createPostController.addImages(newImages);
                          //  firebase
                        }
                      },
                      child: SvgPicture.asset(
                        'assets/icons/Add-Image.svg',
                        color: CustomColors.accentColor.withOpacity(0.2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: Obx(() {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: createPostController.createRequest.value.media.length,
              itemBuilder: (BuildContext context, index) {
                final String image = createPostController
                    .createRequest.value.media[index].imagePath;
                return Column(
                  children: [
                    Stack(children: [
                      Container(
                        margin: const EdgeInsets.only(left: 5, right: 5),
                        width: Get.width * 0.32,
                        height: 126,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.07),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3))
                          ],
                          color: Colors.white,
                          image: DecorationImage(
                            image: Image.file(File(image)).image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 14,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.07),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3))
                            ],
                            color: Colors.white,
                          ),
                          height: 20,
                          width: 20,
                          child: GestureDetector(
                            onTap: () {
                              createPostController.isDeleting.value = true;
                              createPostController.removeImage(File(image));
                              createPostController.update();

                              createPostController.isDeleting.value = false;
                              createPostController.update();
                            },
                            child: SvgPicture.asset(
                              'assets/icons/Close Square.svg',
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ],
                ).paddingOnly(left: 18);
              },
            );
          }),
        ),
      ],
    );
  }
}
