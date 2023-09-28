import 'package:flutter/material.dart';
import 'package:task/features/create_post/presentation/widgets/text.dart';

import '../../../../common/constant/const.dart';
import '../../../../common/extensions/widget_extension.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final Color? backGroundColor;
  final Color? borderColor;
  final Color? textColor;
  final bool isLoading;
  final double? width;
  const ButtonWidget(this.title,
      {super.key,
      required this.onTap,
      this.backGroundColor,
      this.width,
      this.isLoading = false,
      this.borderColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 150,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? Colors.transparent),
        color: backGroundColor ?? CustomColors.primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: isLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SemiBoldText(
                  title,
                  textColor: textColor ?? Colors.white,
                  size: 15,
                ),
                SizedBox(
                    height: 20, width: 20, child: CircularProgressIndicator()),
              ],
            )
          : SemiBoldText(
              title,
              textColor: textColor ?? Colors.white,
              size: 15,
            ),
    ).onTap(onTap);
  }
}
