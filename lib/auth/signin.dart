import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/card/card_box.dart';
import '../components/common/base_page.dart';
import '../utils/pref_constants.dart';
import '/api/api.dart' as api;

import '../components/button/button.dart';
import '../components/input/input.dart';
import '../home/home.dart';
import '../utils/utils.dart';

class SignIn extends BasePageAuth {
  const SignIn({Key? key}) : super(key: key, authType: AuthType.signIn);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends BaseAuthState<SignIn> {
  final TextEditingController _pinController = TextEditingController(text: '');
  final _pinNode = FocusNode();
  final _emptyNode = FocusNode();
  String? current;

  onPressed() async {
    var response = await api.login(current);
    PrefConstants.setToken(response?.tokenNo ?? '');
    
    if (context.mounted) {
      switch (response?.rc) {
        case '0':
          // Success
          Utils.pushAndRemoveUntil(context, 'home', (context) => const Home());
          break;
        case '1':
          // Invalid User ID
          EasyLoading.showError('Invalid User ID. Please check your credentials.');
          break;
        case '2':
          // Invalid PIN
          EasyLoading.showError('Invalid PIN. Please check your PIN and try again.');
          break;
        case '3':
          // Maximum Login Attempts Exceeded
          EasyLoading.showError('Maximum login attempts exceeded. Please try again later.');
          break;
        case '4':
          // Agent Deactivated
          EasyLoading.showError('Your account has been deactivated. Please contact support.');
          break;
        case '5':
          // Server Error
          EasyLoading.showError('Server error occurred. Please try again later.');
          break;
        default:
          // Unknown error or null response
          EasyLoading.showError('Login failed. Please try again.');
          break;
      }
    }
  }
  String? bankName;
  String? bankCode;

  @override
  initState() {
    super.initState();
    setBankName();
  }

  setBankName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bankName = prefs.getString(PrefConstants.bankName);
      bankCode = prefs.getString(PrefConstants.bankCode);
    });
  }


  @override
  Widget body() {
    return Column(
      children: [
        const Text("Sign In",
            style: TextStyle(
                color: Color(0xff202020),
                fontFamily: "Poppins-SemiBold",
                fontSize: 16.0)),
        const SizedBox(height: 25),
        CardBankDetails(
            icon: bankCode??'',
            nameEnglish: bankName??'',
            nameMalayalam:bankName??''),
        const SizedBox(height: 25),
        InputPrimary(
            obscureText: true,
            maxLines: 1,
            controller: _pinController,
            focusNode: _pinNode,
            labelText: 'Pin',
            onChanged: (value) => setState(() => current = value),
            maxLength: 6,
            keyboardType: TextInputType.phone,
            secondNode: _emptyNode),
        const SizedBox(height: 10),
        ButtonPrimary(
            text: 'Log In',
            bg: const Color(0xfff76b1c),
            onPressed: current?.length == 6 ? onPressed : null),
      ],
    );
  }
}
