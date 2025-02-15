import 'package:flutter/material.dart';

enum QTextType { header, medium, body }

class QText extends StatelessWidget {
  final String text;
  final FontWeight? fontWeight;
  final QTextType qTextType;
  final TextAlign? textAlign;

  const QText({
    super.key,
    required this.text,
    this.fontWeight,
    required this.qTextType,
    this.textAlign,
  });

  final double headerSize = 15;
  final double mediumSize = 14;
  final double bodySize = 12;
  final double generalSize = 14;

  getTextStyle() {
    return TextStyle(
      fontWeight: fontWeight,
      fontSize: qTextType == QTextType.header
          ? headerSize
          : qTextType == QTextType.medium
              ? mediumSize
              : qTextType == QTextType.body
                  ? bodySize
                  : generalSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getTextStyle(),
      textAlign: textAlign,
    );
  }
}
