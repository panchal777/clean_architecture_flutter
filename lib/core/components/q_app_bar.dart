import 'package:clean_architecture_flutter/core/utils/common.dart';
import 'package:flutter/material.dart';

class QAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? titleStyle;
  final bool centerTitle;
  final Color? backgroundColor;

  //toolBar height
  final double height;

  const QAppBar({
    super.key,
    this.height = kToolbarHeight,
    this.title = '',
    this.titleStyle,
    this.centerTitle = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final appBarTheme = Theme.of(context).appBarTheme;

    return AppBar(
      toolbarHeight: height,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? appBarTheme.backgroundColor,
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: appBarTheme.iconTheme?.size,
          ),
          onPressed: () {
            QCommon.hideKeyboard();
            Navigator.of(context).pop();
          }),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: titleStyle ?? TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
