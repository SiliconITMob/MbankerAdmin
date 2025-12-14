import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/alert.dart';
import '../../utils/images.dart';

class CardInputBox extends StatelessWidget {
  final Widget body;

  const CardInputBox({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        child: Row(
          children: [
            Expanded(flex: 20, child: Container()),
            Expanded(flex: 320, child: SingleChildScrollView(child: body)),
            Expanded(flex: 20, child: Container())
          ],
        ));
  }
}

class CardBankDetails extends StatelessWidget {
  final String icon;
  final String nameEnglish;
  final String nameMalayalam;

  const CardBankDetails(
      {Key? key,
      required this.icon,
      required this.nameEnglish,
      required this.nameMalayalam})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 76,
        decoration: const BoxDecoration(
            color: Color(0xfff2ab00),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Row(
          children: [
            Expanded(flex: 16, child: Container()),
            icon != ""
                ? Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(25))),
                    child: Image.network(
                      "https://mambacloudservices.com/MBanker/Logo/$icon.png",
                    ),
                  )
                : Container(),
            Expanded(flex: 30, child: Container()),
            Expanded(
                flex: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nameEnglish,
                      style: const TextStyle(
                          color: Color(0xff000000),
                          fontFamily: "Poppins-SemiBold",
                          fontSize: 16.0),
                    ),
                    // Text("($nameMalayalam )",
                    //     style: const TextStyle(
                    //         color: Color(0xff5b5959),
                    //         fontFamily: "Poppins-Regular",
                    //         fontSize: 12.0),
                    //     textAlign: TextAlign.left)
                  ],
                ))
          ],
        ));
  }
}

class CardBox extends StatelessWidget {
  final Widget body;
  final Color color;
  final double height;
  final double width;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const CardBox({
    Key? key,
    required this.body,
    this.color = const Color(0xfff9f8f8),
    this.width = double.infinity,
    this.height = 50,
    this.borderRadius = 25,
    this.margin = const EdgeInsets.only(top: 20),
    this.padding = const EdgeInsets.all(16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
        child: body);
  }
}

typedef OnChangedCallback = void Function(bool value, String agentId);

class CardBoxItem1 extends StatefulWidget {
  final String name;
  final String dob;
  final String status;
  final String agentId;
  final OnChangedCallback? onChanged;
  final String? acType;
  final bool? dobIcon;

  const CardBoxItem1(
      {super.key,
      required this.name,
      required this.dob,
      required this.status,
      required this.agentId,
      this.onChanged,
      this.acType,
      this.dobIcon});

  @override
  State<CardBoxItem1> createState() => _CardBoxItem1State();
}

class _CardBoxItem1State extends State<CardBoxItem1> {
  bool status = false;

  @override
  void initState() {
    super.initState();
    status = widget.status == "Y";
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: 46,
        child: Stack(
          children: [
            SvgPicture.asset(
              Images.avatar,
              height: 46,
            ),
            Align(
                alignment: Alignment.topRight,
                child: Container(
                    margin: const EdgeInsets.all(3),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: status
                            ? const Color(0xff027148)
                            : const Color(0xffe42323),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)))))
          ],
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.name,
              style: const TextStyle(
                  color: Color(0xff202020),
                  fontFamily: "Poppins-SemiBold",
                  fontSize: 16.0)),
          const SizedBox(height: 2),
          Row(children: [
            if (widget.dobIcon != null)
              SvgPicture.asset(Images.calendarMonth,
                  width: 12, color: const Color(0xffe54f00)),
            if (widget.dobIcon != null) const SizedBox(width: 3),
            Text(widget.dob,
                style: const TextStyle(
                    color: Color(0xff5b5959),
                    fontFamily: "Poppins-Regular",
                    fontSize: 12.0)), // 400001234560
            if (widget.acType != null)
              Text(" | ${widget.acType}",
                  style: const TextStyle(
                      color: Color(0xff5b5959),
                      fontFamily: "Poppins-Regular",
                      fontSize: 12.0)),
          ]),
        ]),
      ),
      if (widget.onChanged != null)
        Switch(
            value: status,
            onChanged: onChanged,
            activeColor: const Color(0xffe54f00)),
    ]);
  }

  onChanged(bool value) async {
    var result = await showDialog(
      context: context,
      builder: (context) {
        return AgentConfirmation(
          isActive: value,
        );
      },
    );
    if (result != null && result == true) {
      widget.onChanged!(value, widget.agentId);
      setState(() {
        status = value;
      });
    }
  }
}

class CardBoxItem2 extends StatelessWidget {
  final String phone;
  final String acNumber;

  const CardBoxItem2({
    Key? key,
    required this.phone,
    required this.acNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      subItem1('Account Number', Images.sb, acNumber),
      const SizedBox(width: 25),
      subItem1('Phone Number', Images.callIcon, phone)
    ]);
  }

  subItem1(String title, String icon, String value) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  color: Color(0xff5b5959),
                  fontFamily: "Poppins-Regular",
                  fontSize: 12.0)),
          const SizedBox(height: 3),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            SvgPicture.asset(icon, width: 12), // 400001234560
            const SizedBox(width: 5),
            Text(value,
                style: const TextStyle(
                  color: Color(0xff202020),
                  fontFamily: "Poppins-SemiBold",
                ))
          ])
        ]);
  }
}

class CardBoxBottomBlack extends StatelessWidget {
  final List<Widget> children;
  final double height;

  const CardBoxBottomBlack({
    Key? key,
    required this.children,
    this.height = 64,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            height: height,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: Color(0xff202020),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(18),
                    bottomLeft: Radius.circular(18)))),
        Align(
            alignment: Alignment.centerRight,
            child: SvgPicture.asset(Images.shape01, height: 60)),
        SizedBox(
          height: height,
          child: Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: children,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class SearchCardItem2 extends StatelessWidget {
  final String collection;
  final String payment;
  final String inHand;

  const SearchCardItem2(
      {super.key,
      required this.collection,
      required this.payment,
      required this.inHand});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      subItem1('Collection', Images.currencyWithBox, collection),
      subItem1('Payment', Images.currencyWithBox, payment),
      subItem1('In Hand', Images.currencyWithBox, inHand)
    ]);
  }

  subItem1(String title, String icon, String value) {
    return Expanded(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    color: Color(0xff5b5959),
                    fontFamily: "Poppins-Regular",
                    fontSize: 12.0)),
            const SizedBox(height: 5),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              SvgPicture.asset(icon,
                  color: const Color(0xfff2ab00), width: 12), // 400001234560
              const SizedBox(width: 5),
              Text(value,
                  style: const TextStyle(
                    color: Color(0xff202020),
                    fontFamily: "Poppins-SemiBold",
                  ))
            ])
          ]),
    );
  }
}

class UploadFile extends StatelessWidget {
  final GestureTapCallback onCamera;
  final GestureTapCallback onGallery;

  const UploadFile(
      {super.key, required this.onCamera, required this.onGallery});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
        child: GestureDetector(
          onTap: () => onCamera(),
          child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt, color: Color(0xffc2c2c2), size: 33),
                Text("Camera",
                    style: TextStyle(
                        color: Color(0xff5b5959),
                        fontFamily: "Poppins-SemiBold",
                        fontSize: 12.0))
              ]),
        ),
      ), // Rectangle 109
      Container(
          width: 1,
          height: 80,
          decoration: const BoxDecoration(color: Color(0xffe8e8e8))),
      Expanded(
        child: GestureDetector(
          onTap: () => onGallery(),
          child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.image, color: Color(0xffc2c2c2), size: 33),
                Text("Gallery",
                    style: TextStyle(
                        color: Color(0xff5b5959),
                        fontFamily: "Poppins-SemiBold",
                        fontSize: 12.0))
              ]),
        ),
      )
    ]);
  }
}

class SelectedImage extends StatelessWidget {
  final GestureTapCallback onTap;
  final String path;

  const SelectedImage({super.key, required this.onTap, required this.path});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Image.file(
          File(path),
          fit: BoxFit.contain,
          errorBuilder:
              (BuildContext context, Object error, StackTrace? stackTrace) {
            return const Center(
                child: Text('This image type is not supported'));
          },
        ),
      ),
      SizedBox(
          width: double.infinity,
          height: 100,
          child: Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () => onTap(),
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: const BoxDecoration(
                      color: Color(0xff8f8f8f),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: const EdgeInsets.only(top: 5, right: 15),
                  child: const Icon(Icons.close, size: 10, color: Colors.white),
                ),
              )))
    ]);
  }
}
