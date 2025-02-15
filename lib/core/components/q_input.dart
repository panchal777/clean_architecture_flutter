import 'package:clean_architecture_flutter/core/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QInput extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged? onChanged;
  final bool isMandatory;
  final TextInputType keyBoardType;
  final List<TextInputFormatter>? inputFormatters;

  const QInput(
      {super.key,
      this.title,
      this.controller,
      this.initialValue,
      this.onChanged,
      this.isMandatory = true,
      this.keyBoardType = TextInputType.text,
      this.inputFormatters});

  @override
  Widget build(BuildContext context) {
    var outlineBorder = OutlineInputBorder(borderSide: BorderSide(width: 0.2));
    var titleStyle = TextStyle(fontSize: 15, color: Colors.black);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title!.isNotEmpty)
          RichText(
            text: TextSpan(
              text: title!,
              style: titleStyle,
              children: [
                TextSpan(
                  text: isMandatory ? ' *' : '',
                  style: titleStyle.copyWith(color: Colors.red),
                )
              ],
            ),
          ),
        if (title!.isNotEmpty) SizedBox(height: 10),
        TextFormField(
          controller: controller ??
              TextEditingController(
                text: initialValue ?? '',
              ),
          onChanged: (value) {
            if (onChanged != null) {
              onChanged!(value);
            }
          },
          keyboardType: keyBoardType,
          inputFormatters: inputFormatters,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            isDense: true,
            fillColor: ColorConstant.inputFilledColor,
            filled: true,
            focusedBorder: outlineBorder,
            border: outlineBorder,
            enabledBorder: outlineBorder,
          ),
        )
      ],
    );
  }
}
