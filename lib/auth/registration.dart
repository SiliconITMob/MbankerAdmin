import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:mbankeradmin/auth/register_success.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/common/base_page.dart';
import '../utils/pref_constants.dart';
import '/api/api.dart' as api;
import '../components/button/button.dart';
import '../components/input/input.dart';
import '../utils/utils.dart';

class Registration extends BasePageAuth {
  const Registration({Key? key}) : super(key: key, authType: AuthType.signUp);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends BaseAuthState<Registration> {
  late TextEditingController _bankController;
  late TextEditingController _agentIdController;
  late TextEditingController _mobileNoController;
  final _bankNode = FocusNode();
  final _agentIdNode = FocusNode();
  final _mobileNoNode = FocusNode();
  final _emptyNode = FocusNode();
  String? agent;
  String? mobile;
  String? bank;

  @override
  void initState() {
    super.initState();
    _bankController = TextEditingController(text: '');
    _agentIdController = TextEditingController(text: '');
    _mobileNoController = TextEditingController(text: '');
    // _bankController = TextEditingController(text: 'A002');
    // _agentIdController = TextEditingController(text: 'S001');
    // _mobileNoController = TextEditingController(text: '8547581833');
    agent = _agentIdController.text;
    mobile = _mobileNoController.text;
    bank = _bankController.text;
  }

  @override
  Widget body() {
    return Column(
      children: [
        const Text("SIGN UP",
            style: TextStyle(
                color: Color(0xff202020),
                fontFamily: "Poppins-SemiBold",
                fontSize: 16.0)),
        const SizedBox(height: 15),
        InputPrimary(
            textCapitalization: TextCapitalization.characters,
            controller: _bankController,
            onChanged: (value) => setState(() => bank = value),
            maxLength: 10,
            isDigit: true,
            focusNode: _bankNode,
            labelText: 'Bank Code',
            keyboardType: TextInputType.text,
            secondNode: _agentIdNode),
        InputPrimary(
            controller: _agentIdController,
            focusNode: _agentIdNode,
            labelText: 'Employee ID',
            onChanged: (value) => setState(() => agent = value),
            maxLength: 12,
            keyboardType: TextInputType.text,
            secondNode: _mobileNoNode),
        InputPrimary(
            controller: _mobileNoController,
            focusNode: _mobileNoNode,
            onChanged: (value) => setState(() => mobile = value),
            labelText: 'Mobile No',
            maxLength: 12,
            keyboardType: TextInputType.phone,
            secondNode: _emptyNode),
        ButtonPrimary(
            text: 'Sign Up',
            bg: const Color(0xfff76b1c),
            onPressed: isValid() ? onPressed : null),
      ],
    );
  }

  onPressed() async {
    EasyLoading.show(status: 'loading...');
    var response = await api.register(bank, agent, mobile);
    EasyLoading.dismiss();
    PrefConstants.setToken(response?.tokenNo ?? '');
    if (context.mounted && response?.rc == '0') {
      EasyLoading.showSuccess('Register success');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(PrefConstants.bankName, response?.bname ?? '');
      prefs.setString(PrefConstants.cbsUrl, response?.cbsurl ?? '');
      prefs.setString(PrefConstants.userName, response?.uname ?? '');
      prefs.setString(PrefConstants.userID, agent ?? '');
      prefs.setString(PrefConstants.mobile, mobile ?? '');
      prefs.setString(PrefConstants.bankCode, bank ?? '');
      prefs.setBool(PrefConstants.isPasswordUpdate, false);
      Future.delayed(const Duration(seconds: 3)).then((value) {
        Utils.push(
            context,
            (context) => RegisterSuccess(
                bname: response?.bname ?? '', uname: response?.uname ?? ''));
      });
    } else if (response != null) {
      var arrayMessages = [
        '',
        'Invalid Bank Code',
        'Invalid User  ID',
        'Invalid Mobile No',
        'Sign Up blocked',
        'Server Error'
      ];
      EasyLoading.showError(arrayMessages[int.parse(response.rc.toString())]);
    }
  }

  isValid() {
    return agent != null &&
        mobile != null &&
        bank != null &&
        agent!.length > 3 &&
        mobile!.length > 6 &&
        bank!.length > 3;
  }
}
