import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../components/button/button.dart';
import 'images.dart';

class AgentConfirmation extends StatelessWidget {
  final bool isActive;

  const AgentConfirmation({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: 260,
        width: double.infinity,
        child: Column(children: [
          const SizedBox(height: 21),
          Row(children: [
            Expanded(child: Container()),
            Text(
              isActive ? "Activate Agent" : 'Deactivate Agent',
              style: const TextStyle(
                  color: Color(0xff202020),
                  fontFamily: "Poppins-SemiBold",
                  fontSize: 14.0),
            ),
            Expanded(child: Container()),
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close)),
            // Send for Approval
          ]), // Make sure all information entered are correct.
          const SizedBox(height: 12),
          SvgPicture.asset(
            isActive ? Images.icActivate : Images.icDeactivate,
          ),
          const SizedBox(height: 12),
          Text(
              isActive
                  ? "Are you sure you want to activate this agent?"
                  : 'Are you sure you want to deactivate this agent?',
              style: const TextStyle(
                  color: Color(0xff202020),
                  fontFamily: "Poppins-Regular",
                  fontSize: 16.0),
              textAlign: TextAlign.center),
          const SizedBox(height: 13),
          Buttons(buttonText2: isActive ? 'Activate' : 'Deactivate'),
        ]),
      ),
    );
  }
}

class PermissionConfirmation extends StatelessWidget {
  const PermissionConfirmation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: 260,
        width: double.infinity,
        child: Column(children: [
          const SizedBox(height: 21),
          Row(children: [
            Expanded(child: Container()),
            const Text(
              'Set Permissions',
              style: TextStyle(
                  color: Color(0xff202020),
                  fontFamily: "Poppins-SemiBold",
                  fontSize: 16),
            ),
            Expanded(child: Container()),
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close)),
            // Send for Approval
          ]), // Make sure all information entered are correct.
          const SizedBox(height: 12),
          SvgPicture.asset(
            Images.icActivate,
          ),
          const SizedBox(height: 12),
          const Text("Are you sure you want to set this permissions?",
              style: TextStyle(
                  color: Color(0xff202020),
                  fontFamily: "Poppins-Regular",
                  fontSize: 16.0),
              textAlign: TextAlign.center),
          const SizedBox(height: 13),
          const Buttons(buttonText2: 'Yes'),
        ]),
      ),
    );
  }
}

class Permissions extends StatefulWidget {
  final List<String>? permissionsReceipt;
  final List<String>? permissionsPayment;

  const Permissions(
      {super.key, this.permissionsReceipt, this.permissionsPayment});

  @override
  State<Permissions> createState() => _PermissionsState();
}

class _PermissionsState extends State<Permissions> {
  List<String> userCheckedPayment = [];
  List<String> userCheckedReceipt = [];

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: 580,
        width: double.infinity,
        child: Column(children: [
          const SizedBox(height: 21),
          const Text(
            'Set permissions',
            style: TextStyle(
                color: Color(0xff202020),
                fontFamily: "Poppins-SemiBold",
                fontSize: 16),
          ),
          const SizedBox(height: 21),
          const SizedBox(
            width: double.infinity,
            child: Text(
              'Receipt',
              style: TextStyle(
                  color: Color(0xff202020),
                  fontFamily: "Poppins-SemiBold",
                  fontSize: 16),
            ),
          ),
          SizedBox(
            height: 220,
            child: ListView(
                children: widget.permissionsReceipt!.map((String key) {
              return CheckboxListTile(
                activeColor: const Color(0xffe54f00),
                title: Text(key),
                value: userCheckedReceipt.contains(key),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      setState(() {
                        userCheckedReceipt.add(key);
                      });
                    } else {
                      setState(() {
                        userCheckedReceipt.remove(key);
                      });
                    }
                  });
                },
              );
            }).toList()),
          ),
          const SizedBox(height: 10),
          const SizedBox(
            width: double.infinity,
            child: Text(
              'Payment',
              style: TextStyle(
                  color: Color(0xff202020),
                  fontFamily: "Poppins-SemiBold",
                  fontSize: 16),
            ),
          ),
          SizedBox(
            height: 160,
            child: ListView(
                children: widget.permissionsPayment!.map((String key) {
              return CheckboxListTile(
                activeColor: const Color(0xffe54f00),
                title: Text(key),
                value: userCheckedPayment.contains(key),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      setState(() {
                        userCheckedPayment.add(key);
                      });
                    } else {
                      setState(() {
                        userCheckedPayment.remove(key);
                      });
                    }
                  });
                },
              );
            }).toList()),
          ),
          Row(children: [
            Expanded(
              child: ButtonSecondary(
                  curved: true,
                  padding: 0,
                  text: 'Cancel',
                  onPressed: () => Navigator.pop(context)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ButtonPrimary(
                  padding: 0,
                  curved: true,
                  text: 'Ok',
                  onPressed: () => Navigator.pop(context, {
                        "userCheckedPayment": userCheckedPayment,
                        "userCheckedReceipt": userCheckedReceipt
                      })),
            )
          ]),
          const SizedBox(height: 21),
        ]),
      ),
    );
  }
}

class Logout extends StatelessWidget {
  const Logout({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        height: 180,
        width: double.infinity,
        child: Column(children: [
          const SizedBox(height: 21),
          Row(children: [
            Expanded(child: Container()),
            // Send for Approval
            const Text(
              "Logout",
              style: TextStyle(
                  color: Color(0xff202020),
                  fontFamily: "Poppins-SemiBold",
                  fontSize: 14.0),
            ),
            Expanded(child: Container()),
            GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(Icons.close)),
            // Send for Approval
          ]), // Make sure all information entered are correct.
          const SizedBox(height: 22),
          const Text("Are you sure you want to logout?",
              style: TextStyle(
                  color: Color(0xff202020),
                  fontFamily: "Poppins-Regular",
                  fontSize: 16.0),
              textAlign: TextAlign.center),
          const SizedBox(height: 20),
          const Buttons(buttonText2: 'Logout'),
        ]),
      ),
    );
  }
}

class Buttons extends StatelessWidget {
  final String buttonText1;
  final String buttonText2;

  const Buttons(
      {super.key, this.buttonText1 = 'Cancel', this.buttonText2 = 'Send'});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: ButtonSecondary(
            curved: true,
            padding: 0,
            text: buttonText1,
            onPressed: () => Navigator.pop(context)),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: ButtonPrimary(
            padding: 0,
            curved: true,
            text: buttonText2,
            onPressed: () => Navigator.pop(context, true)),
      )
    ]);
  }
}
