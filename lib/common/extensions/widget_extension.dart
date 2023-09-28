import 'package:flutter/material.dart';

extension MyExtension on Widget {
  Widget makeSafeArea() {
    return SafeArea(child: this);
  }

  Widget center() => Center(
        child: this,
      );

  Widget expanded(int? flex) => Expanded(
        flex: flex ?? 0,
        child: this,
      );

  Widget padding(EdgeInsets? padding) => Padding(
        padding: padding ?? const EdgeInsets.all(8),
        child: this,
      );

  Widget onTap(VoidCallback onTap) => InkWell(
        onTap: onTap,
        child: this,
      );
}
