import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/card/card_box.dart';
import '../components/common/powerd_by.dart';
import '../components/input/input.dart';
import '../model/agent_response.dart';
import '../model/permission_response.dart';
import '../utils/alert.dart';
import '../utils/pref_constants.dart';
import '/api/api.dart' as api;

class Permission extends StatefulWidget {
  final List<Receipt>? receipt;

  final List<Payment>? payment;

  final List<Opening>? opening;

  final List<PassbookOtp>? passbookOTP;

  final Summary selectedSummary;

  const Permission(
      {super.key,
      required this.receipt,
      required this.payment,
      required this.opening,
      required this.passbookOTP,
      required this.selectedSummary});

  @override
  State<Permission> createState() => _PermissionState();
}

class _PermissionState extends State<Permission> {
  List<Receipt>? receipt;

  List<Payment>? payment;

  List<Opening>? opening;

  List<PassbookOtp>? passbookOTP;

  @override
  void initState() {
    super.initState();
    receipt = widget.receipt;
    payment = widget.payment;
    opening = widget.opening;
    passbookOTP = widget.passbookOTP;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Permissions",
            style: TextStyle(
                color: Color(0xff202020),
                fontFamily: "Poppins-SemiBold",
                fontSize: 18.0)),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              setPermission();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(children: [
          resultCard(),
          Expanded(child: permissionCard()),
          const PoweredBy()
        ]),
      ),
    );
  }

  resultCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: CardBox(
        height: 80,
        body: Column(children: [
          CardBoxItem1(
              name: widget.selectedSummary.agentName ?? '',
              dob: widget.selectedSummary.lastTxnDate != null
                  ? DateFormat('dd-MMM-yyyy').format(DateFormat("dd-MM-yyyy")
                      .parse(widget.selectedSummary.lastTxnDate!
                          .replaceAll('/', '-')))
                  : '',
              status: widget.selectedSummary.status ?? '',
              agentId: widget.selectedSummary.agentID ?? '',
              onChanged: null,
              dobIcon: true),
          // item3(account, null)
        ]),
      ),
    );
  }

  permissionCard() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: SingleChildScrollView(
          child: Column(children: [
        permissionTitle('RECEIPT'),
        ...permissionList(widget.receipt!, statusReceipt, Icons.receipt, 1,
            controller1, node1),
        permissionTitle('PAYMENT'),
        ...permissionList(widget.payment!, statusPayment, Icons.payment, 2,
            controller2, node2),
        permissionTitle('ACCOUNT OPENING'),
        ...permissionList(
            widget.opening!, statusOpening, Icons.open_in_new, 3, null, null),
        permissionTitle('PASSBOOK OTP AUTHENTICATION'),
        ...permissionList(
            widget.passbookOTP!, statusOtp, Icons.password, 4, null, null),
      ])),
    );
  }

  permissionTitle(String title) {
    return Text(title,
        style: const TextStyle(
            color: Color(0xff202020),
            fontFamily: "Poppins-SemiBold",
            fontSize: 14));
  }

  List<bool> statusReceipt = [];
  List<bool> statusPayment = [];
  List<bool> statusOpening = [];
  List<bool> statusOtp = [];
  List<TextEditingController> controller1 = [];
  List<TextEditingController> controller2 = [];
  List<FocusNode> node1 = [];
  List<FocusNode> node2 = [];

  permissionList(items, status, icon, order, controller, node) {
    List<Widget> list = [];
    for (var i = 0; i < items.length; i++) {
      if (controller != null) {
        controller.add(TextEditingController(
            text: items?[i]?.maxAmount?.toString() ?? ''));
        node.add(FocusNode());
      }
      if (order != 4) {
        status.add(items?[i]?.allow == 'N' ? false : true);
      } else {
        status.add(items?[i]?.otp == 'N' ? false : true);
      }
      list.add(SizedBox(
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon),
            const SizedBox(width: 20),
            Expanded(
                flex: 10,
                child: Text(items?[i].acType ?? '',
                    style: const TextStyle(
                        color: Color(0xff5b5959),
                        fontFamily: "Poppins-Regular",
                        fontSize: 14))),
            if ((order == 1 || order == 2) && status[i])
              Expanded(
                flex: 15,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: InputPrimary(
                      controller: controller[i],
                      focusNode: node[i],
                      labelText: 'Max Amount',
                      keyboardType: TextInputType.phone),
                ),
              ),
            const SizedBox(width: 20),
            Switch(
                value: status[i],
                onChanged: (bool newValue) {
                  setState(() {
                    status[i] = newValue;
                  });
                  var acType = items?[i].acType;
                  if (order == 1) {
                    for (var i = 0; i < receipt!.length; i++) {
                      if (receipt?[i].acType == acType) {
                        receipt?[i] = Receipt(
                            acType: acType,
                            maxAmount: receipt?[i].maxAmount,
                            allow: newValue ? 'Y' : 'N');
                      }
                    }
                  } else if (order == 2) {
                    for (var i = 0; i < payment!.length; i++) {
                      if (payment?[i].acType == acType) {
                        payment?[i] = Payment(
                            acType: acType,
                            maxAmount: payment?[i].maxAmount,
                            allow: newValue ? 'Y' : 'N');
                      }
                    }
                  } else if (order == 3) {
                    for (var i = 0; i < opening!.length; i++) {
                      if (opening?[i].acType == acType) {
                        opening?[i] = Opening(
                            acType: opening?[i].acType,
                            allow: newValue ? 'Y' : 'N');
                      }
                    }
                  } else if (order == 4) {
                    for (var i = 0; i < passbookOTP!.length; i++) {
                      if (passbookOTP?[i].acType == acType) {
                        passbookOTP?[i] = PassbookOtp(
                            acType: acType, otp: newValue ? 'Y' : 'N');
                      }
                    }
                  }
                },
                activeColor: const Color(0xffe54f00))
          ],
        ),
      ));
    }
    return list;
  }

  setPermission() async {
    var result1 = await showDialog(
      context: context,
      builder: (context) {
        return const PermissionConfirmation();
      },
    );
    for (var i = 0; i < receipt!.length; i++) {
      num maxAmount = 0;
      try {
        maxAmount = int.parse(controller1[i].text);
      } catch (e) {
        try {
          maxAmount = double.parse(controller1[i].text);
        } catch (e) {
          print(e);
        }
        print(e);
      }
      receipt?[i] = Receipt(
          acType: receipt?[i].acType,
          maxAmount: maxAmount,
          allow: receipt?[i].allow);
    }
    for (var i = 0; i < payment!.length; i++) {
      num maxAmount = 0;
      try {
        maxAmount = int.parse(controller2[i].text);
      } catch (e) {
        try {
          maxAmount = double.parse(controller2[i].text);
        } catch (e) {
          print(e);
        }
        print(e);
      }
      payment?[i] = Payment(
          acType: payment?[i].acType,
          maxAmount: maxAmount,
          allow: payment?[i].allow);
    }
    if (result1 != null && result1 == true) {
      var response = await api.setPermissions(widget.selectedSummary.agentID,
          receipt, payment, opening, passbookOTP);
      PrefConstants.setToken(response?.tokenNo ?? '');
      Navigator.pop(context);
    }
  }
}
