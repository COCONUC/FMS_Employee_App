import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/pref_data.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';
import 'package:fms_employee/screens/login_screen.dart';
import 'package:fms_employee/screens/profile/my_profile_screen.dart';


class TabProfile extends StatefulWidget {
  static const String routeName = '/tab_profile';
  const TabProfile({Key? key}) : super(key: key);

  @override
  State<TabProfile> createState() => _TabProfileState();
}

class _TabProfileState extends State<TabProfile> {
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: FetchPixels.getDefaultHorSpace(context)),
        child: Column(
          children: [
            getVerSpace(FetchPixels.getPixelHeight(20)),
            buildHeader(),
            getVerSpace(FetchPixels.getPixelHeight(40)),
            buildExpand(context),
            buildButtonLogout(context),
          ],
        ),
      ),
    );
  }

  Widget buildButtonLogout(BuildContext context) {
    return getButton(context, blueColor, "Đăng xuất", Colors.white, () {
      PrefData.setLogIn(false);
      /*Constant.sendToNext(context, Routes.homeRoute);*/
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    }, 18,
        weight: FontWeight.w600,
        buttonHeight: FetchPixels.getPixelHeight(60),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14)));
  }

  Expanded buildExpand(BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView(
        children: [
          Container(
            height: FetchPixels.getPixelHeight(100),
            width: FetchPixels.getPixelHeight(100),
            decoration: BoxDecoration(
                image: getDecorationAssetImage(context, "profile.png")),
          ),
          getVerSpace(FetchPixels.getPixelHeight(44)),
          getButtonWithIcon(context, Colors.white, "Thông tin cá nhân", Colors.black,
              () {
            /*Constant.sendToNext(context, Routes.myProfileScreenRoute);*/
                Navigator.of(context).pushNamed(MyProfileScreen.routeName);
          }, 16,
              weight: FontWeight.w400,
              buttonHeight: FetchPixels.getPixelHeight(60),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              prefixIcon: true,
              prefixImage: "user.svg",
              sufixIcon: true,
              suffixImage: "arrow_right.svg"),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          /*getButtonWithIcon(
              context, Colors.white, "Privacy Policy", Colors.black, () {
            Constant.sendToNext(context, Routes.privacyRoute);
          }, 16,
              weight: FontWeight.w400,
              buttonHeight: FetchPixels.getPixelHeight(60),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              prefixIcon: true,
              prefixImage: "privacy.svg",
              sufixIcon: true,
              suffixImage: "arrow_right.svg"),*/
          getVerSpace(FetchPixels.getPixelHeight(20)),
          /*getButtonWithIcon(context, Colors.white, "Terms of Use", Colors.black,
              () {
            Constant.sendToNext(context, Routes.termOfUseRoute);
          }, 16,
              weight: FontWeight.w400,
              buttonHeight: FetchPixels.getPixelHeight(60),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              prefixIcon: true,
              prefixImage: "termuse.svg",
              sufixIcon: true,
              suffixImage: "arrow_right.svg"),*/
          getVerSpace(FetchPixels.getPixelHeight(20)),
          /*getButtonWithIcon(context, Colors.white, "Support", Colors.black, () {
            Constant.sendToNext(context, Routes.supportRoute);
          }, 16,
              weight: FontWeight.w400,
              buttonHeight: FetchPixels.getPixelHeight(60),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              prefixIcon: true,
              prefixImage: "headphone.svg",
              sufixIcon: true,
              suffixImage: "arrow_right.svg"),*/
          getVerSpace(FetchPixels.getPixelHeight(20)),
          getButtonWithIcon(context, Colors.white, "Báo cáo sự cố", Colors.black, () {
            /*Constant.sendToNext(context, Routes.reportRoute);*/
          }, 16,
              weight: FontWeight.w400,
              buttonHeight: FetchPixels.getPixelHeight(60),
              borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(12)),
              boxShadow: [
                const BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0.0, 4.0)),
              ],
              prefixIcon: true,
              prefixImage: "documnet.svg",
              sufixIcon: true,
              suffixImage: "arrow_right.svg"),
          getVerSpace(FetchPixels.getPixelHeight(40)),
        ],
      ),
    );
  }

  Align buildHeader() {
    return Align(
        alignment: Alignment.topCenter,
        child: getCustomFont("Tài khoản", 24, Colors.black, 1,
            fontWeight: FontWeight.w900));
  }
}
