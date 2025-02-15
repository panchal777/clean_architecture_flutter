import 'package:flutter/material.dart';

class QDropDown extends StatefulWidget {
  final List<dynamic> dropDownList;
  final dynamic initialValue;
  final String? title;
  final bool isMandatory;
  final ValueChanged<dynamic> onChanged;

  const QDropDown(
      {super.key,
      required this.dropDownList,
      this.initialValue,
      this.title = '',
      this.isMandatory = true,
      required this.onChanged});

  @override
  State<QDropDown> createState() => _QDropDownState();
}

class _QDropDownState extends State<QDropDown> {
  dynamic selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    var titleStyle = TextStyle(fontSize: 15, color: Colors.black);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title!.isNotEmpty)
          RichText(
            text: TextSpan(
              text: widget.title!,
              style: titleStyle,
              children: [
                TextSpan(
                  text: widget.isMandatory ? ' *' : '',
                  style: titleStyle.copyWith(color: Colors.red),
                )
              ],
            ),
          ),
        if (widget.title!.isNotEmpty) SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          // Padding inside the dropdown
          decoration: BoxDecoration(
            border: Border.all(width: 0.2),
            borderRadius: BorderRadius.circular(2),
            // Rounded corners
            color: Colors.white, // Background color
          ),
          child: DropdownButton<dynamic>(
            value: selectedValue,
            icon: Icon(Icons.arrow_drop_down),
            style: Theme.of(context).inputDecorationTheme.labelStyle,
            underline: SizedBox(),
            isExpanded: true,
            isDense: true,
            padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
            hint: Text(
              'Select ${widget.title}',
              style: TextStyle(fontSize: 14),
            ),
            onChanged: (dynamic newValue) {
              setState(() {
                selectedValue = newValue!;
                widget.onChanged(newValue);
              });
            },
            items: widget.dropDownList
                .map<DropdownMenuItem<dynamic>>((dynamic value) {
              return DropdownMenuItem<dynamic>(
                value: value,
                child: Text(
                  value.toString(),
                  style: Theme.of(context).inputDecorationTheme.labelStyle,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
