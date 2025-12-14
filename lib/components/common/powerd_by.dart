import 'package:flutter/material.dart';

class PoweredBy extends StatelessWidget {
  final Color? color;

  const PoweredBy({Key? key, this.color = const Color(0xfff9f8f8)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 30,
      color:color,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Powered By",
            style: TextStyle(
                color: Color(0xff8f8f8f),
                fontFamily: "Poppins-Regular",
                fontSize: 10.0),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            "Silicon IT Solutions Private Limited",
            style: TextStyle(
                color: Color(0xff202020),
                fontFamily: "Poppins-Regular",
                fontSize: 12.0),
          )
        ],
      ),
    );
  }
}
