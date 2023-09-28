import 'package:flutter/material.dart';

import '../../../../common/constant/const.dart';

class SemiBoldText extends StatelessWidget {
  final String title;
  final Color? textColor;
  final double? size;
  const SemiBoldText(this.title, {super.key, this.textColor, this.size});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: textColor ?? Colors.black,
        fontFamily: AppFont.semiBold,
        fontSize: size ?? 10,
      ),
    );
  }
}
