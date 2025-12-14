import 'package:shared_preferences/shared_preferences.dart';

class PrefConstants {
  static SharedPreferences? _instance;
  static String? tokenNo;

  static Future<SharedPreferences> getInstance() async {
    _instance ??= await SharedPreferences.getInstance();
    return _instance!;
  }

  static String getTokenNo() {
    return tokenNo ?? '';
  }

  static setToken(String? token) {
    if (token != null && token.isNotEmpty) tokenNo = token;
  }

  static String isRegister = 'isRegister';
  static String isPasswordUpdate = 'isPasswordUpdate';
  static String rc = "rc";
  static String cbsUrl = "cbsUrl";
  static String bankCode = "bankCode";
  static String bankName = "bankName";
  static String userName = "userName";
  static String mobile = "mobile";
  static String customerID = "customerID";
  static String userID = "userID";
}
