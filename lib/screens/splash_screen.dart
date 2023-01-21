import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fms_employee/screens/new_login_screen.dart';

import '../constants/color_constant.dart';
import '../constants/constant.dart';
import '../constants/pref_data.dart';
import '../constants/resizer/fetch_pixels.dart';
import '../constants/widget_utils.dart';
import '../widgets/bottom_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    PrefData.isLogIn().then((value) {
      Timer(
        const Duration(seconds: 2),
            () {
          (value)
              ? Constant.sendToScreen(const NavScreen(), context)
              : Constant.sendToScreen(const NewLoginScreen(), context);
        },
      );
    });
  }

  void backClick() {
    Constant.backToPrev(context);
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: buildLogo(),
        ),
        onWillPop: () async {
          backClick();
          return false;
        });
  }

  Container buildLogo() {
    return Container(
        color: blueColor,
        child: Center(
            child: getSvgImageWithSize(
                context,
                "splash_logo.svg",
                FetchPixels.getPixelHeight(180),
                FetchPixels.getPixelHeight(180)))
    );
  }
}