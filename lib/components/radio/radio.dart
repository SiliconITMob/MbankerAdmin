import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  final String value;

  final String groupValue;

  final ValueChanged onChanged;

  const RadioButton(
      {Key? key,
      required this.value,
      required this.groupValue,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Radio(
      value: value,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: const VisualDensity(
        horizontal: VisualDensity.minimumDensity,
        vertical: VisualDensity.minimumDensity,
      ),
      groupValue: groupValue,
      activeColor: const Color(0xffe54f00),
      onChanged: onChanged,
    );
  }
}

class RadioButtonText extends StatelessWidget {
  final String value;

  final String groupValue;

  const RadioButtonText(
      {Key? key, required this.value, required this.groupValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(value,
        style: TextStyle(
            color: groupValue == value
                ? const Color(0xff202020)
                : const Color(0xff5b5959),
            fontFamily:
                groupValue == value ? "Poppins-SemiBold" : "Poppins-Regular",
            fontSize: 14.0),
        textAlign: TextAlign.center);
  }
}
