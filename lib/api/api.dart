import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../home/home.dart';
import '../model/agent_response.dart';
import '../model/permission_response.dart';
import '../model/register_response.dart';
import '../model/report_response.dart';
import '../model/summary_response.dart';
import '../model/token_response.dart';
import '../utils/pref_constants.dart';
import 'constants.dart';

const baseUrl = "https://mambacloudservices.com/MBanker/MBankerAdminSignUp.php";
DateTime? startTime;

printResponse(object) {
  if (kDebugMode) {
    print(object);
  }
}

Future<RegisterResponse?> register(bankCode, userID, mobileNo) async {
  var map = <String, String>{};
  map[Constants.bankCode] = bankCode;
  map[Constants.userID] = userID;
  map[Constants.mobileNo] = mobileNo;
  map[Constants.osType] =
      Platform.isAndroid ? Constants.android : Constants.ios;
  final response =
      await callApi(url: baseUrl, map: map, requestID: Constants.signUp);
  return response != null ? RegisterResponse.fromJson(response) : null;
}

Future<TokenResponse?> login(pin) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var map = <String, String>{};
  map[Constants.userID] = prefs.getString(PrefConstants.userID) ?? '';
  map[Constants.mobileNo] = prefs.getString(PrefConstants.mobile) ?? '';
  map[Constants.pin] = await getPin(pin);
  final response = await callApi(map: map, requestID: Constants.login);
  return response != null ? TokenResponse.fromJson(response) : null;
}

Future<TokenResponse?> changePin(oldPin, newPin) async {
  var map = <String, String>{};
  map[Constants.oldPIN] = await getPin(oldPin);
  map[Constants.newPIN] = await getPin(newPin);
  final response = await callApi(map: map, requestID: Constants.changePIN);
  return response != null ? TokenResponse.fromJson(response) : null;
}

Future<SummaryResponse?> getSummary() async {
  final response = await callApi(requestID: Constants.getSummary);
  return response != null ? SummaryResponse.fromJson(response) : null;
}

Future<TokenResponse?> logout() async {
  final response = await callApi(requestID: Constants.logOut);
  return response != null ? TokenResponse.fromJson(response) : null;
}

Future<TokenResponse?> txnValidateOTP(accountNo, otp) async {
  var map = <String, String>{};
  map[Constants.acNo] = accountNo;
  map[Constants.otp] = otp;
  final response = await callApi(map: map, requestID: Constants.txnValidateOTP);
  return response != null ? TokenResponse.fromJson(response) : null;
}

Future<TokenResponse?> updateAgentStatus(agentID, status) async {
  var map = <String, String>{};
  map[Constants.agentID] = agentID;
  map[Constants.status] = status;
  final response =
      await callApi(map: map, requestID: Constants.updateAgentStatus);
  return response != null ? TokenResponse.fromJson(response) : null;
}

Future<AgentResponse?> getAgentSummary() async {
  final response = await callApi(requestID: Constants.getAgentSummary);
  return response != null ? AgentResponse.fromJson(response) : null;
}

Future<ReportResponse?> getReport(agentID, reportType, dateFrom, dateTo) async {
  var map = <String, String>{};
  map[Constants.agentID] = agentID;
  map[Constants.reportType] = reportType;
  map[Constants.dateFrom] = dateFrom;
  map[Constants.dateTo] = dateTo;
  final response = await callApi(map: map, requestID: Constants.getReport);
  return response != null ? ReportResponse.fromJson(response) : null;
}

Future<TokenResponse?> setPermissions(
    agentID, receipt, payment, opening, passbookOTP) async {
  var map = <String, String>{};
  map[Constants.agentID] = agentID;
  var rowData = <String, List<Object>>{};
  rowData[Constants.receipt] = receipt;
  rowData[Constants.payment] = payment;
  rowData[Constants.opening] = opening;
  rowData[Constants.passbookOTP] = passbookOTP;
  final response = await callApi(
      map: map,
      requestID: Constants.setPermissions,
      rowData: rowData,
      isPost: true);
  return response != null ? TokenResponse.fromJson(response) : null;
}

Future<PermissionResponse?> getPermissionParams(agentID) async {
  var map = <String, String>{};
  map[Constants.agentID] = agentID;
  final response = await callApi(requestID: Constants.getPermissionParams,map: map);
  return response != null ? PermissionResponse.fromJson(response) : null;
}

var client = http.Client();
int count = 1;

Future<dynamic> callApi(
    {url, map, requestID, isString, isPost, rowData}) async {
  if (startTime != null) {
    final difference = DateTime.now().difference(startTime!).inMinutes;
    if (difference >= 300) {
      startTime = DateTime.now();
      logoutApp.add(false);
      return null;
    }
  }
  startTime = DateTime.now();
  SharedPreferences prefs = await PrefConstants.getInstance();
  map ??= <String, String>{};
  url ??= prefs.getString(PrefConstants.cbsUrl);
  url ??= 'https://siliconapis.com/MBanker/MBankerRequestHandler.php';
  map[Constants.requestID] = requestID;
  map[Constants.userID] =
      map[Constants.userID] ?? prefs.getString(PrefConstants.userID) ?? '';
  if (requestID != Constants.login &&
      requestID != Constants.signUp &&
      requestID != Constants.changePIN) {
    map[Constants.tokenNo] = await getPin(PrefConstants.getTokenNo());
  }
  if (count != 1) {
    return null;
  }
  count++;
  http.Response response;
  try {
    if (isPost != null) {
      if (rowData != null) {
        HttpClient httpClient = HttpClient();
        try {
          HttpClientRequest request = await httpClient
              .postUrl(Uri.parse(url).replace(queryParameters: map));
          request.headers.set('content-type', 'application/json');
          request.add(utf8.encode(json.encode(rowData)));
          HttpClientResponse response1 = await request.close().timeout(const Duration(seconds: 20));
          String reply = await response1.transform(utf8.decoder).join();
          printResponse(reply);
          if (reply.isNotEmpty && response1.statusCode == 200) {
            httpClient.close();
            return json.decode(reply);
          }
          // Fallback to form post when JSON channel doesn't return success
          response = await client
              .post(Uri.parse(url).replace(queryParameters: map))
              .timeout(const Duration(seconds: 20));
        } on SocketException catch (e) {
          printResponse('SocketException: $e');
          return null;
        } on TimeoutException catch (e) {
          printResponse('TimeoutException: $e');
          return null;
        } on HttpException catch (e) {
          printResponse('HttpException: $e');
          return null;
        } catch (e) {
          printResponse('Unknown exception: $e');
          return null;
        } finally {
          httpClient.close();
        }
      } else {
        response = await client
            .post(Uri.parse(url), body: map)
            .timeout(const Duration(seconds: 20));
      }
    } else {
      response = await client
          .get(Uri.parse(url).replace(queryParameters: map))
          .timeout(const Duration(seconds: 20));
    }
    printResponse(map);
    printResponse(response.statusCode);
    final resp = response.body;
    printResponse(resp);
    if (resp.isNotEmpty && response.statusCode == 200) {
    if (resp == "Invalid Request" || resp == 'Authentication Error') {
      logoutApp.add(false);
      return null;
    }
    if (isString != null) {
      return resp;
    }
    return json.decode(resp);
    } else {
      // Do not force logout on transient/non-200 responses; allow retry after reconnection
      return null;
    }
  } on SocketException catch (e) {
    printResponse('SocketException: $e');
    return null;
  } on TimeoutException catch (e) {
    printResponse('TimeoutException: $e');
    return null;
  } on HttpException catch (e) {
    printResponse('HttpException: $e');
    return null;
  } catch (e) {
    printResponse('Unknown exception: $e');
    return null;
  } finally {
    count--;
  }
}

Future<String> getPin(pin) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String id = prefs.getString(PrefConstants.userID) ?? '';
  if (pin == '' || id == '') return pin;
  var fullPin = id.substring(id.length - 3) + pin + id.substring(0, 3);
  return sha1.convert(utf8.encode(fullPin)).toString().toUpperCase();
}
