import 'package:flutter/material.dart';
import 'package:task/features/home/presentation/widgets/post_item_widget.dart';

import '../../data/model/post_model.dart';

class PostsGridWidget extends StatelessWidget {
  const PostsGridWidget({
    Key? key,
    required this.postsList,
  }) : super(key: key);

  final List<PostModel> postsList;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.8,
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemBuilder: (context, index) {
        return PostItemWidget(
          postModel: postsList[index],
        );
      },
      itemCount: postsList.length,
      padding: const EdgeInsets.all(14),
    );
  }
}
