import 'package:clean_architecture_flutter/core/components/q_text.dart';
import 'package:flutter/material.dart';

class QInput extends StatelessWidget {
  final String? title;
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged? onChanged;

  const QInput({
    super.key,
    this.title,
    this.controller,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (title!.isNotEmpty) QText(text: title!, qTextType: QTextType.medium),
        if (title!.isNotEmpty) SizedBox(height: 10),
        TextFormField(
          controller: controller ??
              TextEditingController(
                text: initialValue ?? '',
              ),
          onChanged: (value) => onChanged,
        )
      ],
    );
  }
}
