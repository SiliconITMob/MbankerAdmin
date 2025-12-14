import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:mbankeradmin/home/tab3.dart';
import 'package:mbankeradmin/model/agent_response.dart';
import 'package:mbankeradmin/model/permission_response.dart';
import '../components/card/card_box.dart';
import '../permission/permission.dart';
import '../utils/alert.dart';
import '../utils/pref_constants.dart';
import '../utils/utils.dart';
import '/api/api.dart' as api;

class Tab2 extends StatefulWidget {
  final ValueChanged<int> onTap;

  const Tab2({super.key, required this.onTap});

  @override
  State<Tab2> createState() => _Tab2State();
}

class _Tab2State extends State<Tab2> {
  List<Widget> resultCards = [];

  List<Summary>? summaryList;

  List<Receipt>? receipt;

  List<Payment>? payment;

  List<Opening>? opening;

  List<PassbookOtp>? passbookOTP;

  @override
  void initState() {
    super.initState();
    getAgentSummary();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text("Agents",
                style: TextStyle(
                    color: Color(0xff202020),
                    fontFamily: "Poppins-SemiBold",
                    fontSize: 16.0)),
            if (resultCards.isEmpty)
              Center(
                  child: Column(
                children: [
                  const SizedBox(height: 20),
                  noResult(),
                ],
              )),
            ...resultCards,
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  getAgentSummary() async {
    var data = await api.getAgentSummary();
    summaryList = data?.summary;
    setState(() {
      PrefConstants.setToken(data?.header?.tokenNo ?? '');
      summaryList
          ?.map((summary) => resultCards.add(resultCard(summary)))
          .toList();
    });
  }

  resultCard(Summary summary) {
    return InkWell(
      onTap: () => onSelect(summary),
      child: CardBox(
        height: summary.status == 'Y' ? 203 : 158,
        body: Column(children: [
          CardBoxItem1(
              name: summary.agentName ?? '',
              dob: summary.lastTxnDate != null
                  ? DateFormat('dd-MMM-yyyy').format(DateFormat("dd-MM-yyyy")
                      .parse(summary.lastTxnDate!.replaceAll('/', '-')))
                  : '',
              status: summary.status ?? '',
              agentId: summary.agentID ?? '',
              onChanged: onChanged,
              dobIcon: true),
          const SizedBox(height: 12),
          SearchCardItem2(
            collection: summary.collection?.toString() ?? '',
            payment: summary.payment.toString(),
            inHand: summary.cashInHand.toString(),
          ),
          if (summary.status == 'Y')
            Row(children: [
              GestureDetector(
                onTap: () => permissionClick(summary.agentID ?? ''),
                child: const CardBox(
                  padding: EdgeInsets.all(0),
                  width: 45,
                  height: 45,
                  body: Center(
                      child: Icon(Icons.manage_accounts, color: Colors.white)),
                  color: Color(0xffe54f00),
                  borderRadius: 10,
                ),
              ),
            ])
        ]),
      ),
    );
  }

  onChanged(value, agentId) async {
    var data = await api.updateAgentStatus(agentId, value ? "Y" : 'N');
    PrefConstants.setToken(data?.tokenNo ?? '');
    if (value) permissionClick(agentId);
    resultCards.clear();
    setState(() {
      summaryList?.map((summary) {
        if (summary.agentID == agentId) {
          var newSummary = summary.copyWith(
              status: value ? "Y" : 'N',
              agentID: summary.agentID,
              agentName: summary.agentName,
              cashInHand: summary.cashInHand,
              collection: summary.collection,
              lastTxnDate: summary.lastTxnDate,
              payment: summary.payment);
          resultCards.add(resultCard(newSummary));
        } else {
          resultCards.add(resultCard(summary));
        }
      }).toList();
    });
  }

  noResult() {
    return const Text("No Agents Found",
        style: TextStyle(
            color: Color(0xff202020),
            fontFamily: "Poppins-SemiBold",
            fontSize: 16.0));
  }

  onSelect(Summary summary) {
    selectedSummary = summary;
    widget.onTap(2);
  }

  permissionClick(agentId) async {
    var response = await api.getPermissionParams(agentId);
    PrefConstants.setToken(response?.header?.tokenNo ?? '');
    setState(() {
      receipt = response?.receipt;
      payment = response?.payment;
      opening = response?.opening;
      passbookOTP = response?.passbookOTP;
    });

    for (int i = 0; i < summaryList!.length; i++) {
      if (summaryList![i].agentID == agentId) {
        Utils.push(
            context,
            (context) => Permission(
                receipt: receipt,
                payment: payment,
                opening: opening,
                passbookOTP: passbookOTP,
                selectedSummary: summaryList![i]));
        return;
      }
    }

    // var result = await showDialog(
    //   context: context,
    //   builder: (context) {
    //     return Permissions(
    //       permissionsReceipt: receipt,
    //       permissionsPayment: payment,
    //     );
    //   },
    // );
    // if (result != null) {
    //   var result1 = await showDialog(
    //     context: context,
    //     builder: (context) {
    //       return const PermissionConfirmation();
    //     },
    //   );
    //   if (result1 != null && result1 == true) {
    //     var response = await api.setPermissions(agentId,
    //         result['userCheckedReceipt'], result['userCheckedPayment']);
    //     PrefConstants.setToken(response?.tokenNo ?? '');
    //   }
    // }
  }
}
