import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/button/button.dart';
import '../model/agent_response.dart';
import '../components/card/card_box.dart';
import '../components/input/input.dart';
import '../components/radio/radio.dart';
import '../report/report.dart';
import '../utils/images.dart';
import '../utils/pref_constants.dart';
import '../utils/utils.dart';
import '/api/api.dart' as api;

class Tab3 extends StatefulWidget {
  final ValueChanged<int> onTap;

  const Tab3({super.key, required this.onTap});

  @override
  State<Tab3> createState() => _Tab3State();
}

Summary? selectedSummary;

class _Tab3State extends State<Tab3> {
  var cashScrollType = 'All';

  final TextEditingController _fromDateController =
      TextEditingController(text: DateFormat("dd/MM/yyyy").format(DateTime.now()));
  final TextEditingController _toDateController =
      TextEditingController(text: DateFormat("dd/MM/yyyy").format(DateTime.now()));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text("Report",
                style: TextStyle(
                    color: Color(0xff202020),
                    fontFamily: "Poppins-SemiBold",
                    fontSize: 16.0)),
            if (selectedSummary != null) resultCard(),
            if (selectedSummary != null) const SizedBox(height: 10),
            searchCard(),
          ],
        ),
      ),
    );
  }

  searchCard() {
    return CardBox(
      height: selectedSummary == null ? 395 : 305,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (selectedSummary == null)
          const Text("Select Agent",
              style: TextStyle(
                  color: Color(0xffd79c0e),
                  fontFamily: "Poppins-Regular",
                  fontSize: 12.0),
              textAlign: TextAlign.center),
        if (selectedSummary == null)
          GestureDetector(
            onTap: () => widget.onTap(1),
            child: InputPrimary(
                svgIconRight: Images.searchRight,
                controller: TextEditingController(text: ''),
                enabled: false,
                focusNode: FocusNode(),
                labelText: 'Select',
                svgIconOnTap: () => widget.onTap(1),
                keyboardType: TextInputType.text,
                secondNode: FocusNode()),
          ),
        if (selectedSummary == null) const SizedBox(height: 14),
        const Text("Account Type",
            style: TextStyle(
                color: Color(0xffd79c0e),
                fontFamily: "Poppins-Regular",
                fontSize: 12.0),
            textAlign: TextAlign.center),
        const SizedBox(height: 14),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RadioButton(
            value: 'All',
            groupValue: cashScrollType,
            onChanged: (value) {
              setState(() {
                cashScrollType = value.toString();
              });
            },
          ),
          RadioButtonText(
            value: 'All',
            groupValue: cashScrollType,
          ),
          const SizedBox(width: 12),
          RadioButton(
            value: 'Daily Deposit',
            groupValue: cashScrollType,
            onChanged: (value) {
              setState(() {
                cashScrollType = value.toString();
              });
            },
          ),
          RadioButtonText(
            value: 'Daily Deposit',
            groupValue: cashScrollType,
          ),
          const SizedBox(width: 12),
          RadioButton(
            value: 'SB',
            groupValue: cashScrollType,
            onChanged: (value) {
              setState(() {
                cashScrollType = value.toString();
              });
            },
          ),
          RadioButtonText(
            value: 'SB',
            groupValue: cashScrollType,
          ),
        ]),
        const SizedBox(height: 14),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RadioButton(
            value: 'Loans',
            groupValue: cashScrollType,
            onChanged: (value) {
              setState(() {
                cashScrollType = value.toString();
              });
            },
          ),
          RadioButtonText(
            value: 'Loans',
            groupValue: cashScrollType,
          ),
          const SizedBox(width: 12),
          RadioButton(
            value: 'Chitty',
            groupValue: cashScrollType,
            onChanged: (value) {
              setState(() {
                cashScrollType = value.toString();
              });
            },
          ),
          RadioButtonText(
            value: 'Chitty',
            groupValue: cashScrollType,
          ),
          const SizedBox(width: 12),
          RadioButton(
            value: 'RD',
            groupValue: cashScrollType,
            onChanged: (value) {
              setState(() {
                cashScrollType = value.toString();
              });
            },
          ),
          RadioButtonText(
            value: 'RD',
            groupValue: cashScrollType,
          ),
        ]),
        const SizedBox(height: 14),
        const Text("Date Range",
            style: TextStyle(
                color: Color(0xffd79c0e),
                fontFamily: "Poppins-Regular",
                fontSize: 12.0),
            textAlign: TextAlign.center),
        Row(children: [
          fromDate(),
          const SizedBox(width: 16),
          toDate(),
        ]),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: Container()),
            SizedBox(
              width: 160,
              child: ButtonPrimary(
                  padding: 0,
                  text: 'Show Report',
                  bg: const Color(0xfff76b1c),
                  onPressed: _fromDateController.text != '' &&
                          _toDateController.text != '' &&
                          selectedSummary != null
                      ? onPressed
                      : null),
            ),
          ],
        )
      ]),
    );
  }

  onPressed() {
    Utils.push(
        context,
        (context) => Report(
            fromDate: _fromDateController.text,
            toDate: _toDateController.text,
            acType: cashScrollType,
            agentID: selectedSummary!.agentID!));
  }

  fromDate() {
    return Expanded(
      child: GestureDetector(
        onTap: () => {onPickDate(_fromDateController)},
        child: InputPrimary(
            enabled: false,
            svgIconRight: Images.calendarMonth,
            svgIconOnTap: () => {onPickDate(_fromDateController)},
            controller: _fromDateController,
            labelText: 'From Date',
            keyboardType: TextInputType.datetime),
      ),
    );
  }

  toDate() {
    return Expanded(
      child: GestureDetector(
        onTap: () => {onPickDate(_toDateController)},
        child: InputPrimary(
            enabled: false,
            svgIconRight: Images.calendarMonth,
            svgIconOnTap: () => {onPickDate(_toDateController)},
            controller: _toDateController,
            labelText: 'To Date',
            keyboardType: TextInputType.datetime),
      ),
    );
  }

  resultCard() {
    return CardBox(
      height: 140,
      body: Column(children: [
        CardBoxItem1(
            name: selectedSummary?.agentName ?? '',
            dob: selectedSummary?.lastTxnDate != null
                ? DateFormat('dd-MMM-yyyy').format(DateFormat("dd-MM-yyyy")
                    .parse(selectedSummary!.lastTxnDate!.replaceAll('/', '-')))
                : '',
            status: selectedSummary?.status ?? '',
            agentId: selectedSummary?.agentID ?? '',
            onChanged: null,
            dobIcon: true),
        const SizedBox(height: 12),
        SearchCardItem2(
          collection: selectedSummary?.collection?.toString() ?? '',
          payment: selectedSummary!.payment.toString(),
          inHand: selectedSummary!.cashInHand.toString(),
        ),
        // item3(account, null)
      ]),
    );
  }

  onPickDate(dateController) async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2005, 8),
        lastDate: DateTime(2030));
    if (picked != null) {
      setState(() {
        dateController.text = DateFormat("dd/MM/yyyy").format(picked);
      });
    }
  }

}
