import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';

class Toasts {
  static Future<bool?> showToast({
    required String message,
    required Color titleColor,
    required Color backgroundColor,
  }) {
    return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor,
      textColor: titleColor,
      fontSize: 16.0,
    );
  }
}
