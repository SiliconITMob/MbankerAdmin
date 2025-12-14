import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mbankeradmin/auth/signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/card/card_box.dart';
import '../components/common/base_page.dart';
import '../utils/pref_constants.dart';
import '/api/api.dart' as api;
import '../components/button/button.dart';
import '../components/input/input.dart';
import '../utils/utils.dart';

class ChangePin extends BasePageAuth {
  const ChangePin({Key? key}) : super(key: key, authType: AuthType.signUp);

  @override
  State<ChangePin> createState() => _ChangePinState();
}

class _ChangePinState extends BaseAuthState<ChangePin> {
  final TextEditingController _pinCurrentController =
      TextEditingController(text: '');
  final TextEditingController _pinNewController =
      TextEditingController(text: '');
  final TextEditingController _pinConfirmController =
      TextEditingController(text: '');
  final _pinCurrentNode = FocusNode();
  final _pinNewNode = FocusNode();
  final _pinConfirmNode = FocusNode();
  final _emptyNode = FocusNode();
  String? current;
  String? newPin;
  String? confirmPin;

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
        const Text("CHANGE SIGN IN PIN",
            style: TextStyle(
                color: Color(0xff202020),
                fontFamily: "Poppins-SemiBold",
                fontSize: 16.0)),
        const SizedBox(height: 15),
        CardBankDetails(
            icon: bankCode ?? '',
            nameEnglish: bankName ?? '',
            nameMalayalam: bankName ?? ''),
        const SizedBox(height: 10),
        InputPrimary(
            maxLines: 1,
            obscureText: true,
            controller: _pinCurrentController,
            focusNode: _pinCurrentNode,
            labelText: 'Current Pin',
            onChanged: (value) => setState(() => current = value),
            maxLength: 6,
            keyboardType: TextInputType.phone,
            secondNode: _pinNewNode),
        InputPrimary(
            maxLines: 1,
            obscureText: true,
            controller: _pinNewController,
            focusNode: _pinNewNode,
            labelText: 'New Pin',
            maxLength: 6,
            onChanged: (value) => setState(() => newPin = value),
            keyboardType: TextInputType.phone,
            secondNode: _pinConfirmNode),
        InputPrimary(
            controller: _pinConfirmController,
            obscureText: true,
            focusNode: _pinConfirmNode,
            labelText: 'Confirm New Pin',
            onChanged: (value) => setState(() => confirmPin = value),
            maxLines: 1,
            maxLength: 6,
            keyboardType: TextInputType.phone,
            secondNode: _emptyNode),
        ButtonPrimary(
            text: 'Change Pin',
            bg: const Color(0xfff76b1c),
            onPressed: isValidPin() ? changePin : null),
      ],
    );
  }

  isValidPin() {
    return current?.length == 6 &&
        newPin?.length == 6 &&
        confirmPin?.length == 6 &&
        newPin == confirmPin &&
        newPin != current;
  }

  changePin() async {
    var response = await api.changePin(current, newPin);
    PrefConstants.setToken(response?.tokenNo ?? '');
    
    if (context.mounted) {
      switch (response?.rc) {
        case '0':
          // Success
          EasyLoading.showSuccess('Password updated successfully');
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(PrefConstants.isPasswordUpdate, true);
          Future.delayed(const Duration(seconds: 3)).then((value) {
            Utils.pushAndRemoveUntil(
                context, 'signIn', (context) => const SignIn());
          });
          break;
        case '1':
          // Invalid Old PIN
          EasyLoading.showError('Invalid current PIN. Please check and try again.');
          break;
        case '2':
          // Server Error
          EasyLoading.showError('Server error occurred. Please try again later.');
          break;
        case '3':
          // Previously used PINs not allowed
          EasyLoading.showError('This PIN has been used before. Please choose a different PIN.');
          break;
        default:
          // Unknown error or null response
          EasyLoading.showError('An error occurred. Please try again.');
          break;
      }
    }
  }
}
