import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../components/card/card_box.dart';
import '../utils/pref_constants.dart';
import '/api/api.dart' as api;
import '../components/button/button.dart';
import '../components/input/input.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Password Reset",
            style: TextStyle(
                color: Color(0xff202020),
                fontFamily: "Poppins-SemiBold",
                fontSize: 18.0)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: CardBox(
            height: 300,
            body: Column(
              children: [
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
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(child: Container()),
                    SizedBox(
                      width: 200,
                      child: ButtonPrimary(
                          padding: 0,
                          text: 'Change Pin',
                          bg: const Color(0xfff76b1c),
                          onPressed: isValidPin() ? changePin : null),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
    if (context.mounted && response?.rc == '0') {
      EasyLoading.showSuccess('Password updated');
      Future.delayed(const Duration(seconds: 3)).then((value) {
        Navigator.pop(context);
      });
    } else {
      EasyLoading.showError('Please check current pin');
    }
  }
}
