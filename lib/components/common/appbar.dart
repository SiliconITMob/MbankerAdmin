import 'package:flutter/material.dart';

class AppbarTitleCommon extends StatelessWidget {
  final String header;

  const AppbarTitleCommon({Key? key, required this.header}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(header,
        style: const TextStyle(
            color: Color(0xff202020),
            fontFamily: "Poppins-SemiBold",
            fontSize: 18.0));
  }
}
