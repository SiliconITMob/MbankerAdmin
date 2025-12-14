import 'package:flutter/material.dart';

class TextBlackCard1 extends StatelessWidget {
  final String value;

  const TextBlackCard1({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(value,
        style: const TextStyle(
            color: Colors.white,
            fontFamily: "Poppins-Regular",
            fontSize: 12.0));
  }
}

class TextBlackCard2 extends StatelessWidget {
  final String value;

  const TextBlackCard2({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(value,
        style: const TextStyle(
            color: Colors.white,
            fontFamily: "Poppins-SemiBold",
            fontSize: 16.0));
  }
}

class TextBlackCard3 extends StatelessWidget {
  final Widget item1;
  final Widget? item2;

  const TextBlackCard3({Key? key, required this.item1, required this.item2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Container();
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(child: item1),
      if (item2 != null) Expanded(child: item2!)
    ]);
  }
}
