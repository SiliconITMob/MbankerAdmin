import 'package:flutter/material.dart';

class LabelMB extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double fontSize;
  final Color color;
  final TextOverflow? overflow;

  const LabelMB({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.left,
    this.fontSize = 12,
    required this.color,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      style: TextStyle(
          fontFamily: "Poppins-Bold", fontSize: fontSize, color: color),
    );
  }
}

class LabelMM extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double fontSize;
  final Color color;
  final TextOverflow? overflow;

  const LabelMM({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.left,
    this.fontSize = 12,
    required this.color,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: overflow,
        textAlign: textAlign,
        style: TextStyle(
            fontFamily: "Poppins-SemiBold", fontSize: fontSize, color: color));
  }
}

class LabelMR extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double fontSize;
  final bool underline;
  final Color color;

  const LabelMR({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.left,
    this.fontSize = 12,
    this.underline = false,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: "Poppins-Regular",
        fontSize: fontSize,
        color: color,
        decoration: underline ? TextDecoration.underline : TextDecoration.none,
      ),
    );
  }
}

class LabelSB extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double fontSize;
  final Color color;

  const LabelSB({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.left,
    this.fontSize = 12,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: "Poppins-SemiBold", fontSize: fontSize, color: color),
    );
  }
}

class LabelWB extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double fontSize;
  final Color color;
  final double? letterSpacing;

  const LabelWB({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.left,
    this.fontSize = 12,
    this.letterSpacing,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: "Poppins-Bold",
          fontSize: fontSize,
          color: color,
          letterSpacing: letterSpacing),
    );
  }
}

class LabelWM extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double fontSize;
  final Color color;

  const LabelWM({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.left,
    this.fontSize = 12,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: "WorksansMedium", fontSize: fontSize, color: color),
    );
  }
}

class LabelWR extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double? lineSpacingExtra;
  final double fontSize;
  final Color color;
  final double? letterSpacing;
  final TextOverflow? overflow;

  const LabelWR({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.left,
    this.fontSize = 12,
    this.lineSpacingExtra,
    this.letterSpacing,
    required this.color,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyle(
          fontFamily: "Poppins-Regular",
          fontSize: fontSize,
          color: color,
          letterSpacing: letterSpacing,
          height: lineSpacingExtra),
    );
  }
}

class LabelWSB extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final double fontSize;
  final Color color;

  const LabelWSB({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.left,
    this.fontSize = 12,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontFamily: "Poppins-SemiBold", fontSize: fontSize, color: color),
    );
  }
}
