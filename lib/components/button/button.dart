import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ButtonPrimary extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double fontSize;
  final double height;
  final double padding;
  final Color color;
  final Color bg;
  final bool curved;
  final VoidCallback? onPressed;

  const ButtonPrimary({
    Key? key,
    required this.text,
     this.onPressed,
    this.textAlign = TextAlign.center,
    this.fontSize = 16,
    this.height = 50,
    this.color = Colors.white,
    this.curved = true,
    this.padding = 20,
    this.bg = const Color(0xffe54f00),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, height),
          backgroundColor: bg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontFamily: "Poppins-SemiBold",
                fontSize: fontSize,
                color: color),
          ),
        ),
      ),
    );
  }
}

class ButtonSecondary extends StatelessWidget {
  final String text;
  final String? icon;
  final TextAlign textAlign;
  final double fontSize;
  final double height;
  final Color color;
  final Color border;
  final bool curved;
  final VoidCallback onPressed;
  final double padding;

  const ButtonSecondary({
    Key? key,
    required this.text,
    required this.onPressed,
    this.textAlign = TextAlign.center,
    this.fontSize = 16,
    this.height = 50,
    this.padding = 20,
    this.color = const Color(0xffe54f00),
    this.curved = true,
    this.border = const Color(0xffe54f00),
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(padding),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, height),
          side: BorderSide(color: border),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) SvgPicture.asset(icon!, width: 16),
            if (icon != null) const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                  fontFamily: "Poppins-SemiBold",
                  fontSize: fontSize,
                  color: color),
            ),
          ],
        ),
      ),
    );
  }
}
