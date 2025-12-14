import 'package:flutter/material.dart';

class CardWithPadding extends StatelessWidget {
  final Widget child;
  final List<Widget>? items;

  const CardWithPadding({Key? key, required this.child, this.items})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, top: 3, bottom: 3, right: 0),
      child: Stack(
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 15, top: 19, bottom: 19, right: 15),
              child: child,
            ),
          ),
          if (items != null) ...items!
        ],
      ),
    );
  }
}
