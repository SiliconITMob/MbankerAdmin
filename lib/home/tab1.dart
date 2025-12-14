import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/images.dart';
import '../utils/pref_constants.dart';
import '/api/api.dart' as api;
import '../components/card/card_box.dart';

class Tab1 extends StatefulWidget {
  const Tab1({Key? key}) : super(key: key);

  @override
  State<Tab1> createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> {
  String? cash = '';
  String? agentCount;
  String? ddCollection;
  String? sbCollection;
  String? loanCollection;
  String? rdCollection;
  String? chittyCollection;
  String? totalCollection;
  String? totalPayment;

  @override
  void initState() {
    super.initState();
    getSummary();
    setBankName();
  }

  String? bankName;
  String? bankCode;
  String? uname;

  setBankName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bankName = prefs.getString(PrefConstants.bankName);
      bankCode = prefs.getString(PrefConstants.bankCode);
      uname = prefs.getString(PrefConstants.userName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),
          Row(
            children: [Expanded(child: welcome()), currentDate()],
          ),
          const SizedBox(height: 15),
          CardBankDetails(
              icon: bankCode ?? '',
              nameEnglish: bankName ?? '',
              nameMalayalam: bankName ?? ''),
          const SizedBox(height: 20),
          payReceive("Collections"),
          const SizedBox(height: 14),
          cashInHand(),
          const SizedBox(height: 14),
          ...getCollections(),
          const SizedBox(height: 120),
        ],
      ),
    );
  }

  welcome() {
    return RichText(
        text: TextSpan(children: [
      const TextSpan(
          style: TextStyle(
              color: Color(0xff000000),
              fontFamily: "Poppins-Regular",
              fontSize: 12.0),
          text: "Welcome,\n"),
      TextSpan(
          style: const TextStyle(
              color: Color(0xff000000),
              fontFamily: "Poppins-Bold",
              fontSize: 18.0),
          text: uname ?? '')
    ]));
  }

  currentDate() {
    return Container(
      width: 130,
      height: 27,
      decoration: const BoxDecoration(
          color: Color(0xff202020),
          borderRadius: BorderRadius.all(Radius.circular(7))),
      child: Row(children: [
        const SizedBox(width: 9),
        SvgPicture.asset(Images.calendarMonth, width: 12),
        const SizedBox(width: 9),
        Text(DateFormat('dd-MMM-yyyy').format(DateTime.now()),
            style: const TextStyle(
                color: Color(0xffffffff),
                fontFamily: "Poppins-SemiBold",
                fontSize: 11))
      ]),
    );
  }

  payReceive(title) {
    return Text(title,
        style: const TextStyle(
            color: Color(0xff333333),
            fontFamily: "Poppins-SemiBold",
            fontSize: 16.0));
  }

  cashInHand() {
    return Stack(
      children: [
        Container(
            height: 190,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color(0xffE54F00),
                borderRadius: BorderRadius.all(Radius.circular(18)))),
        Align(
            alignment: Alignment.centerRight,
            child: SvgPicture.asset(Images.shape01, height: 60)),
        Column(children: [
          SizedBox(
            height: 87,
            child: Row(
              children: [
                const SizedBox(width: 16),
                Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(14))),
                    child: Center(
                        child: SvgPicture.asset(
                      Images.currencyWithBox,
                      width: 20,
                      height: 20,
                    ))),
                const SizedBox(width: 14),
                item1("Total Collections", totalCollection ?? '', true)
              ],
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 16),
              item1("Daily Deposit", ddCollection ?? '', false),
              const SizedBox(width: 16),
              item1("SB", sbCollection ?? '', false),
              const SizedBox(width: 16),
              item1("Loans", loanCollection ?? '', false),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const SizedBox(width: 16),
              item1("Chitty", chittyCollection ?? '', false),
              const SizedBox(width: 16),
              item1("RD", rdCollection ?? '', false),
              const SizedBox(width: 16),
              item1("", '', false),
            ],
          )
        ])
      ],
    );
  }

  collectionItems(String title1, String icon1, String amount1, String title2,
      String icon2, String amount2) {
    return Row(children: [
      collectionItem(title1, icon1, amount1),
      const SizedBox(width: 14),
      title2.isEmpty
          ? Expanded(child: Container())
          : collectionItem(title2, icon2, amount2),
    ]);
  }

  collectionItem(String title, String icon, String amount) {
    return Expanded(
      child: Container(
          padding: const EdgeInsets.only(left: 14),
          height: 150,
          width: double.infinity,
          decoration: const BoxDecoration(
              color: Color(0xfff9f8f8),
              borderRadius: BorderRadius.all(Radius.circular(14))),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    height: 50,
                    width: 50,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Center(child: SvgPicture.asset(icon, width: 20))),
                const SizedBox(height: 15), // Daily Deposit
                Text(title,
                    style: const TextStyle(
                        color: Color(0xff5b5959),
                        fontFamily: "Poppins-Regular",
                        fontSize: 12.0)), // ₹ 22,400
                const SizedBox(height: 6), // Daily Deposit
                Text(amount,
                    style: const TextStyle(
                        color: Color(0xff202020),
                        fontFamily: "Poppins-SemiBold",
                        fontSize: 18.0))
              ])),
    );
  }

  getCollections() {
    return [
      collectionItems(
          'Agents',
          Images.icAgent,
          agentCount?.padLeft(2, "0") ?? '',
          'Payment',
          Images.icPayment,
          totalPayment == null ? '' : '₹ $totalPayment'),
      const SizedBox(height: 14)
    ];
  }

  getSummary() async {
    var response = await api.getSummary();
    PrefConstants.setToken(response?.tokenNo ?? '');
    setState(() {
      agentCount = response?.agentCount?.toString();
      chittyCollection = response?.chittyCollection?.toString();
      ddCollection = response?.dDCollection?.toString();
      loanCollection = response?.loanCollection?.toString();
      rdCollection = response?.rDCollection?.toString();
      sbCollection = response?.sBCollection?.toString();
      totalCollection = response?.totalCollection?.toString();
      totalPayment = response?.totalPayment?.toString();
    });
  }

  item1(String text1, String text2, bool total) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text1,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins-Regular",
                  fontSize: total ? 12 : 10)), // ₹ 72,000
          Text(text2 == '' ? '' : "₹ $text2",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Poppins-SemiBold",
                  fontSize: total ? 22 : 16))
        ],
      ),
    );
  }
}
