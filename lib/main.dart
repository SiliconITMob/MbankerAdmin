import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mbankeradmin/utils/images.dart';
import 'package:mbankeradmin/utils/palette.dart';
import 'package:mbankeradmin/utils/pref_constants.dart';
import 'package:mbankeradmin/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/change_pin.dart';
import 'auth/registration.dart';
import 'auth/signin.dart';
import 'components/button/button.dart';
import 'components/common/powerd_by.dart';

void main() {
  runApp(const MBanker());
}

class MBanker extends StatelessWidget {
  const MBanker({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      theme: ThemeData(
        primarySwatch: Palette.customMaterial,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: Colors.black),
        ),
      ),
      home: const Welcome(),
    );
  }
}

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<Welcome> {
  onPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userID = prefs.getString(PrefConstants.userID) ?? '';
    var isPasswordUpdate =
        prefs.getBool(PrefConstants.isPasswordUpdate) ?? false;
    if (userID == "") {
      Utils.push(context, (context) => const Registration());
    } else if (!isPasswordUpdate) {
      Utils.push(context, (context) => const ChangePin());
    } else {
      Utils.push(context, (context) => const SignIn());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: SvgPicture.asset(
          Images.logo02,
          height: 33,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 10, child: Container()),
            Expanded(
                flex: 300,
                child: SvgPicture.asset(
                  Images.welcome01,
                )),
            const Text(
              "M Banker Administration",
              style: TextStyle(
                  color: Color(0xff202020),
                  fontFamily: "Poppins-SemiBold",
                  fontSize: 22.0),
            ),
            Expanded(flex: 15, child: Container()),
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                  "Users can monitor agents' transactions and deny or allow agents to perform transactions.",
                  style: TextStyle(
                      color: Color(0xff5b5959),
                      fontFamily: "Poppins-Regular",
                      fontSize: 14.0),
                  textAlign: TextAlign.center),
            ),
            Expanded(flex: 135, child: Container()),
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
                onPressed: onPressed),
            Expanded(flex: 20, child: Container()),
            const PoweredBy(color: Colors.white)
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
