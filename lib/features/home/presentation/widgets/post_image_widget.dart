import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostImageWidget extends StatelessWidget {
  const PostImageWidget({
    super.key,
    required this.image,
  });

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
        imageUrl: image,
        placeholder: (context, url) => Container(
          color: Colors.grey,
          child: SizedBox(
              width: 10, height: 10, child: CircularProgressIndicator()),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.07),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(1, 1))
        ],
        color: Colors.white,
        // image: DecorationImage(
        //     alignment: Alignment.topCenter,
        //     image: NetworkImage(image),
        //     fit: BoxFit.cover),
      ),
    );
  }
}

class PostImagesSlider extends StatelessWidget {
  const PostImagesSlider({
    super.key,
    required this.images,
  });
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        for (int i = 0; i < images.length; i++)
          PostImageWidget(image: images[i]),
      ],
      options: CarouselOptions(
        aspectRatio: 2.2, viewportFraction: 0.85,
        // height: 125,
        disableCenter: true,
        autoPlay: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
      ),
    );
  }
}
