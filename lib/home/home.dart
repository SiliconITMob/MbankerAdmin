import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mbankeradmin/home/tab1.dart';
import 'package:mbankeradmin/home/tab2.dart';
import 'package:mbankeradmin/home/tab3.dart';
import 'package:url_launcher/url_launcher.dart';
import '../auth/edit_profile.dart';
import '../auth/signin.dart';
import '../components/common/powerd_by.dart';
import '../utils/alert.dart';
import '../utils/pref_constants.dart';
import '/api/api.dart' as api;

import '../utils/images.dart';
import '../utils/utils.dart';

StreamController<bool> logoutApp = StreamController<bool>.broadcast();

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var streamSubscription;

  String? contactNo;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    getBankContactNo();
    var stream = logoutApp.stream;
    streamSubscription = stream.listen((value) {
      print('LOGOUT REQUEST');
      streamSubscription.cancel();
      Utils.pushAndRemoveUntil(context, "login", (context) => const SignIn());
    });
    setState(() {
      _widgetOptions = <Widget>[
        const Tab1(),
        Tab2(onTap: _onItemTapped),
        Tab3(onTap: _onItemTapped),
      ];
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        logout();
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leadingWidth: 210,
            actions: [
              GestureDetector(
                onTap: () => logout(),
                child: SvgPicture.asset(
                  Images.logout,
                  height: 38,
                ),
              ),
              const SizedBox(width: 20),
            ],
            leading: Row(
              children: [
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () => editProfile(),
                  child: SvgPicture.asset(
                    Images.avatar,
                    height: 38,
                  ),
                ),
                const SizedBox(width: 12),
                SvgPicture.asset(
                  Images.logo02,
                  height: 33,
                )
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                  child: Row(children: [
                const SizedBox(width: 20),
                Expanded(child: _widgetOptions.elementAt(_selectedIndex)),
                const SizedBox(width: 20),
              ])),
              const PoweredBy()
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Images.icAgent,
                  color: const Color(0xff5B5959),
                ),
                activeIcon: SvgPicture.asset(
                  Images.icAgent,
                  color: const Color(0xffF2AB00),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  Images.labProfile,
                  color: const Color(0xff5B5959),
                ),
                activeIcon: SvgPicture.asset(
                  Images.labProfile,
                  color: const Color(0xffF2AB00),
                ),
                label: '',
              )
            ],
            currentIndex: _selectedIndex,
            unselectedItemColor: const Color(0xff5B5959),
            selectedItemColor: const Color(0xffF2AB00),
            onTap: _onItemTapped,
          )),
    );
  }

  getBankContactNo() async {
    // var bankContactNo = await api.getBankContactNo();
    // PrefConstants.setToken(bankContactNo?.tokenNo ?? '');
    // contactNo = bankContactNo?.contactNo;
  }

  logout() async {
    var result = await showDialog(
      context: context,
      builder: (context) {
        return const Logout();
      },
    );
    if (result != null && result == true) {
      var logout = await api.logout();
      PrefConstants.setToken(logout?.tokenNo ?? '');
      if (context.mounted) {
        Utils.pushAndRemoveUntil(context, "login", (context) => const SignIn());
      }
    }
  }

  openDialPad() async {
    Uri url = Uri(scheme: "tel", path: contactNo);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      if (kDebugMode) {
        print("Can't open dial pad.$contactNo");
      }
    }
  }

  editProfile() {
    Utils.push(context, (context) => const EditProfile());
  }
}
