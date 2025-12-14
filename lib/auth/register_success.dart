import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../components/button/button.dart';
import '../components/common/powerd_by.dart';
import '../utils/images.dart';
import '../utils/utils.dart';
import 'change_pin.dart';

class RegisterSuccess extends StatelessWidget {
  final String bname;
  final String uname;

  const RegisterSuccess({Key? key, required this.bname, required this.uname})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xfff9f8f8),
        title: SvgPicture.asset(
          Images.logo02,
          height: 33,
        ),
      ),
      backgroundColor: const Color(0xfff9f8f8),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 100, child: Container()),
            Expanded(
                flex: 300,
                child: SvgPicture.asset(
                  Images.welcome01,
                )),
            Expanded(flex: 54, child: Container()),
            Text(
              'Welcome $uname',
              style: const TextStyle(
                  color: Color(0xff202020),
                  fontFamily: "Poppins-SemiBold",
                  fontSize: 22.0),
            ),
            Expanded(flex: 15, child: Container()),
            Padding(
              padding: const EdgeInsets.all(6),
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    const TextSpan(
                        style: TextStyle(
                          color: Color(0xff5b5959),
                          fontFamily: "Poppins-Regular",
                        ),
                        text: "You are successfully registered with "),
                    TextSpan(
                        style: const TextStyle(
                          color: Color(0xff202020),
                          fontFamily: "Poppins-SemiBold",
                        ),
                        text: '\n$bname Bank'),
                    const TextSpan(
                        style: TextStyle(
                          color: Color(0xff5b5959),
                          fontFamily: "Poppins-Regular",
                        ),
                        text:
                            " Pin is sent by SMS to your\nregistered Mobile Number.")
                  ])),
            ),
            Expanded(flex: 100, child: Container()),
            const Text(
              "Admin’s Application",
              style: TextStyle(
                  color: Color(0xff202020),
                  fontFamily: "Poppins-SemiBold",
                  fontSize: 12),
            ),
            Expanded(flex: 15, child: Container()),
            ButtonPrimary(
                text: 'Continue',
                bg: const Color(0xfff76b1c),
                onPressed: () =>
                    Utils.push(context, (context) => const ChangePin())),
            Expanded(flex: 20, child: Container()),
            const PoweredBy(color: Color(0xfff9f8f8))
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
