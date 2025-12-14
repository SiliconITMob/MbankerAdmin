import 'package:flutter/material.dart';

class SegmentTab extends StatelessWidget {
  final GestureTapCallback onTap;

  final bool isSelected;

  final String item;
  final Color? selectedColor;
  final Color? selectedTextColor;
  final Color? unSelectedTextColor;
  final String? unSelectedFontFamily;
  final double? height;

  const SegmentTab(
      {Key? key,
      required this.onTap,
      required this.isSelected,
      required this.item,
      this.height = 34,
      this.unSelectedFontFamily = 'Poppins-Regular',
      this.selectedColor = const Color(0xfff2ab00),
      this.unSelectedTextColor = const Color(0xff5b5959),
      this.selectedTextColor = const Color(0xff202020)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
              color: isSelected ? selectedColor : Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(34))),
          child: Center(
            child: Text(item,
                style: TextStyle(
                    color: isSelected ? selectedTextColor : unSelectedTextColor,
                    fontFamily:
                        isSelected ? 'Poppins-SemiBold' : unSelectedFontFamily ,
                    fontSize: 12.0)),
          )),
    ));
  }
}
