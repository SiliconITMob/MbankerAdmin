import 'package:flutter/material.dart';

class NoResult extends StatelessWidget {
  const NoResult({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("Search Results Here!",
          style: TextStyle(
              color: Color(0xff202020),
              fontFamily: "Poppins-SemiBold",
              fontSize: 16.0)),
      SizedBox(height: 4),
      Text("Enter search criteria to see search\nresults here.",
          style: TextStyle(
              color: Color(0xff5b5959),
              fontFamily: "Poppins-Regular",
              fontSize: 12.0),
          textAlign: TextAlign.center)
    ]);
  }
}
