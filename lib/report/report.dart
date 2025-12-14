import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../components/card/card_box.dart';
import '../components/common/powerd_by.dart';
import '../model/report_response.dart';
import '../utils/images.dart';
import '../utils/pref_constants.dart';
import '/api/api.dart' as api;

class Report extends StatefulWidget {
  final String fromDate;
  final String toDate;
  final String acType;
  final String agentID;

  const Report(
      {super.key,
      required this.fromDate,
      required this.toDate,
      required this.acType,
      required this.agentID});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  Header? reportHeader;
  List<Widget> resultCards = [];

  get fromDate => DateFormat("dd.MM.yyyy")
      .format(DateFormat("dd/MM/yyyy").parse(widget.fromDate));

  get toDate => DateFormat("dd.MM.yyyy")
      .format(DateFormat("dd/MM/yyyy").parse(widget.toDate));

  @override
  void initState() {
    super.initState();
    getApprovalStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Report",
            style: TextStyle(
                color: Color(0xff202020),
                fontFamily: "Poppins-SemiBold",
                fontSize: 18.0)),
      ),
      body: SafeArea(
        child: Column(children: [
          card(),
          Expanded(child: SizedBox(width: double.infinity, child: body())),
          const PoweredBy()
        ]),
      ),
    );
  }

  getApprovalStatus() async {
    ReportResponse? data = await api.getReport(widget.agentID,
        widget.acType[0], widget.fromDate, widget.toDate);
    PrefConstants.setToken(data?.header?.tokenNo ?? '');
    setState(() {
      reportHeader = data?.header;
      data?.txns?.map((report) => resultCards.add(resultCard(report))).toList();
    });
  }

  card() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: CardBox(
        height: 210,
        body: Column(children: [
          item1(),
          const SizedBox(height: 16),
          item2('Opening Balance', 'Total Collection'),
          item3(reportHeader?.opening.toString(),
              reportHeader?.totalReceipt.toString()),
          const SizedBox(height: 16),
          item2('Total Payment', 'Closing Balance'),
          item3(reportHeader?.totalPayment.toString(),
              reportHeader?.closing.toString())
        ]),
      ),
    );
  }

  body() {
    return SingleChildScrollView(
      child: Column(
        children: [...resultCards, const SizedBox(height: 20)],
      ),
    );
  }

  item1() {
    return Row(children: [
      Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: const Center(
            child: Text("₹",
                style: TextStyle(
                    color: Color(0xfff2ab00),
                    fontFamily: "Poppins-SemiBold",
                    fontSize: 16.0)),
          )),
      const SizedBox(width: 14),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Collection",
            style: TextStyle(
                color: Color(0xff202020),
                fontFamily: "Poppins-SemiBold",
                fontSize: 16.0)),
        const SizedBox(height: 4),
        Row(children: [
          SvgPicture.asset(
            Images.calendarMonth,
            color: const Color(0xffe54f00),
          ), // 20.12.2022 - 20.02.2023
          const SizedBox(width: 5),
          Text(
            ' $fromDate - $toDate',
            style: const TextStyle(
                color: Color(0xff202020),
                fontFamily: "Poppins-Regular",
                fontSize: 12.0),
          )
        ]),
      ])
    ]);
  }

  item2(text1, text2) {
    return Row(children: [
      SizedBox(
        width: 140,
        child: Text(
          text1,
          style: const TextStyle(
              color: Color(0xff8f8f8f),
              fontFamily: "Poppins-Regular",
              fontSize: 12.0),
        ),
      ),
      SizedBox(
        width: 140,
        child: Text(
          text2,
          style: const TextStyle(
              color: Color(0xff8f8f8f),
              fontFamily: "Poppins-Regular",
              fontSize: 12.0),
        ),
      )
    ]);
  }

  item3(text1, text2) {
    return Row(children: [
      SizedBox(
        width: 140,
        child: Text(
          text1 != null ? '₹ $text1' : '₹ 0',
          style: const TextStyle(
              color: Color(0xff202020),
              fontFamily: "Poppins-SemiBold",
              fontSize: 18),
        ),
      ),
      SizedBox(
        width: 140,
        child: Text(
          text2 != null ? '₹ $text2' : '₹ 0',
          style: const TextStyle(
              color: Color(0xff202020),
              fontFamily: "Poppins-SemiBold",
              fontSize: 18),
        ),
      )
    ]);
  }

  resultCard(Txns? report) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: CardBox(
          height: 77,
          borderRadius: 16,
          body: Column(children: [
            item4(report?.acNo, report?.amount.toString(), report?.txnType),
            const SizedBox(height: 4),
            item5(report?.customerName, report?.txnTime)
          ])),
    );
  }

  item4(acNo, amount, txnType) {
    return Row(children: [
      Text(acNo,
          style: const TextStyle(
              color: Color(0xff202020),
              fontFamily: "Poppins-SemiBold",
              fontSize: 14.0)),
      Expanded(child: Container()),
      Text("₹ $amount",
          style: TextStyle(
              color: txnType == 'P' ? Colors.red : const Color(0xff27ac34),
              fontFamily: "Poppins-SemiBold",
              fontSize: 14.0))
    ]);
  }

  item5(name, date) {
    return Row(children: [
      Text(
        name,
        style: const TextStyle(
            color: Color(0xff5b5959),
            fontFamily: "Poppins-Regular",
            fontSize: 12.0),
      ),
      Expanded(child: Container()), // 20.02.2023 | 11:45 PM
      Text(
          DateFormat("dd.MM.yyyy | hh:mm a")
              .format(DateFormat("dd/MM/yyyy HH:mm").parse(date)),
          style: const TextStyle(
              color: Color(0xff5b5959),
              fontFamily: "Poppins-Regular",
              fontSize: 12.0),
          textAlign: TextAlign.left)
    ]);
  }
}
