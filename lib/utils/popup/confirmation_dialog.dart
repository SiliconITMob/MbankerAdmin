import 'package:flutter/material.dart';

import '../../components/button/button.dart';
import '../../components/label/label.dart';


class ConfirmationMessageDialog extends StatelessWidget {
  final Color backgroundColor;
  final String message;
  final String title;
  final double height;

  const ConfirmationMessageDialog(
      {Key? key,
      required this.message,
      required this.title,
      required this.height,
      this.backgroundColor = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: height,
        child: Column(
          children: [
            const SizedBox(height: 12),
            LabelMM(text: title, color: Colors.black, fontSize: 14),
            const SizedBox(height: 20),
            LabelWR(
              text: message,
              color: Colors.black,
              fontSize: 16,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Buttons(buttonText2: 'Yes',buttonText1: 'No',),
          ],
        ),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  final String buttonText1;
  final String buttonText2;

  const Buttons(
      {super.key, this.buttonText1 = 'Cancel', this.buttonText2 = 'Send'});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(children: [
        Expanded(
          child: ButtonSecondary(
              curved: true,
              padding: 0,
              text: buttonText1,
              onPressed: () => Navigator.pop(context)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ButtonPrimary(
              padding: 0,
              curved: true,
              text: buttonText2,
              onPressed: () => Navigator.pop(context, true)),
        )
      ]),
    );
  }
}

