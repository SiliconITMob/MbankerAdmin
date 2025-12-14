import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static pushAndRemoveUntil(
      BuildContext context, String name, WidgetBuilder builder) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: builder, settings: RouteSettings(name: "/$name")),
        (Route<dynamic> route) => false);
  }

  static push(BuildContext context, WidgetBuilder builder) {
    Navigator.push(context, MaterialPageRoute(builder: builder));
  }

  static String getFormatDate(String date) {
    if (date.isEmpty) return date;
    DateTime input = DateFormat('dd/MM/yyyy').parse(date);
    return DateFormat("dd MMM yyyy").format(input);
  }

  static String formattedDateAndTime(String date) {
    DateTime input = DateFormat('dd/MM/yyyy hh:mm:ss').parse(date);
    return DateFormat("dd MMM yyyy | hh:mm a").format(input);
  }

  static String currentDateAndTime() {
    return DateFormat("dd MMM yyyy | hh:mm a").format(DateTime.now());
  }

  static String getFormatAmount(String amount) {
    try {
      if (amount.isEmpty) return amount;
      amount = amount.replaceAll("Cr", "").replaceAll("Dr", "");
      var formatter = NumberFormat("#,##0.00", "en_US");
      formatter.maximumFractionDigits = 2;
      formatter.minimumFractionDigits = 2;
      String str = formatter.format(double.parse(amount));
      return "₹ $str";
    } catch (e) {
      return "₹ $amount";
    }
  }

  static String getFormatAmountDecimal(String amount) {
    try {
      if (amount.isEmpty) return amount;
      var formatter = NumberFormat("#,##0", "en_US");
      String str = formatter.format(double.parse(amount));
      return "₹ $str";
    } catch (e) {
      return "₹ $amount";
    }
  }

  static String getAmountDecimal(String amount) {
    try {
      if (amount.isEmpty) return amount;
      var formatter = NumberFormat("#,##0", "en_US");
      String str = formatter.format(double.parse(amount));
      return str;
    } catch (e) {
      return amount;
    }
  }

  static int differenceDate(String mDate) {
    if (mDate.isEmpty) return 0;
    DateTime date = DateFormat('dd/MM/yyyy').parse(mDate);
    Duration difference = date.difference(DateTime.now());
    return difference.inDays;
  }

  static String formatAcNo(String input) {
    var result = [];
    for (int i = 0; i < input.length; i++) {
      if (i % 4 == 0 && i != 0) {
        result.add(" ");
      }

      result.add(input[i]);
    }
    return result.join();
  }
}
