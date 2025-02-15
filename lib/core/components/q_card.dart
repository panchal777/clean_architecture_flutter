import 'package:clean_architecture_flutter/core/utils/color_constant.dart';
import 'package:flutter/material.dart';

class QCard extends StatelessWidget {
  final Color? cardColor;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget? child;

  const QCard({
    super.key,
    required this.child,
    this.cardColor,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: margin,
      color: cardColor ?? ColorConstant.cardColor,
      elevation: 0.2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(10.0),
        child: child,
      ),
    );
  }
}
