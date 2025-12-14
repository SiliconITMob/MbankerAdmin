import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mbankeradmin/components/common/powerd_by.dart';

import '../../utils/images.dart';
import '../card/card_box.dart';
import 'appbar.dart';

abstract class BasePageAuth extends StatefulWidget {
  final AuthType authType;

  const BasePageAuth({Key? key, required this.authType}) : super(key: key);
}

enum AuthType { signIn, signUp }

abstract class BaseAuthState<Page extends BasePageAuth> extends State<Page> {
  Widget body();

  final _emptyNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor:const Color(0xfff9f8f8) ,
        title: SvgPicture.asset(
          Images.logo02,
          height: 33,
        ),
      ),
      backgroundColor:const Color(0xfff9f8f8) ,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(_emptyNode);
          },
          child: Column(
            children: [
              Expanded(
                  flex: widget.authType == AuthType.signUp ? 20 : 75,
                  child: Container()),
              Expanded(
                  flex: widget.authType == AuthType.signUp ? 300 : 200,
                  child: SvgPicture.asset(
                    Images.welcome01,
                  )),
              Expanded(
                  flex: widget.authType == AuthType.signUp ? 20 : 50,
                  child: Container()),
              Expanded(
                  flex: widget.authType == AuthType.signUp ? 500 : 400,
                  child: CardInputBox(
                    body: body(),
                  )),
              Expanded(
                  flex: 20,
                  child: Container(
                    color: Colors.white,
                  )),
              const PoweredBy(color: Color(0xfff9f8f8))
            ],
          ),
        ),
      ),
    );
  }
}

class PageCommon extends StatelessWidget {
  final String header;
  final Widget body;

  const PageCommon({Key? key, required this.header, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(children: [
          Expanded(
              child: Row(children: [
            const SizedBox(width: 20),
            Expanded(child: body),
            const SizedBox(width: 20)
          ])),
          const PoweredBy(color: Colors.white)
        ])),
        appBar: AppBar(
            title: AppbarTitleCommon(header: header),
            elevation: 0,
            backgroundColor: Colors.white));
  }
}
