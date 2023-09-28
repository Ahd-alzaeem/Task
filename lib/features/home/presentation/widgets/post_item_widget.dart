import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task/features/home/data/model/post_model.dart';
import 'package:task/features/home/presentation/widgets/post_image_widget.dart';

import '../../business_logic/home_controller.dart';

class PostItemWidget extends StatefulWidget {
  const PostItemWidget({
    super.key,
    required this.postModel,
  });
  final PostModel postModel;

  @override
  State<PostItemWidget> createState() => _PostItemWidgetState();
}

class _PostItemWidgetState extends State<PostItemWidget> {
  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 5,
      color: Colors.white,
      child: Stack(
        children: [
          widget.postModel.images.isEmpty
              ? Container(
                  color: Colors.grey[300],
                )
              : PostImagesSlider(images: widget.postModel.images),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const Opacity(
                            opacity: 0,
                            child: SizedBox(
                              width: double.infinity,
                              height: 25,
                            ),
                          ),
                          Container(
                            width: Get.width,
                            color: Colors.white.withAlpha(160),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 50.0, top: 4, bottom: 4),
                              child: Text(
                                widget.postModel.date,
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.postModel.authorName),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
