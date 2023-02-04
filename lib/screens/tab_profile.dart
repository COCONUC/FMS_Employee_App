import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/pref_data.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';
import 'package:fms_employee/features/account_service.dart';
import 'package:fms_employee/models/account_data.dart';
import 'package:fms_employee/screens/new_login_screen.dart';
import 'package:fms_employee/screens/booking/history/booking_history.dart';
import 'package:fms_employee/screens/profile/my_profile_screen.dart';
import 'package:fms_employee/widgets/dialog/option_dialog.dart';


class TabProfile extends StatefulWidget {
  static const String routeName = '/tab_profile';

  const TabProfile( {Key? key}) : super(key: key);

  @override
  State<TabProfile> createState() => _TabProfileState();
}

class _TabProfileState extends State<TabProfile> {

  AccountData accountData = AccountData();

  Future<AccountData> getFutureService() async {
    accountData = await AccountServices().getAccountDataByEmployeeId();
    return accountData;
  }
  
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
            getVerSpace(FetchPixels.getPixelHeight(10)),
          ],
        ),
      ),
    );
  }

  Widget buildButtonLogout(BuildContext context) {
    return getButton(context, blueColor, "Đăng xuất", Colors.white, () {
      PrefData.setLogIn(false);
      /*Constant.sendToNext(context, Routes.homeRoute);*/
      showDialog(
          barrierDismissible: false,
          builder: (context) {
            return const OptionDialog(" ", "Đăng xuất khỏi thiết bị?");
          },
          context: context).then((value) {
        if(value == true){
          Navigator.of(context).pushReplacementNamed(NewLoginScreen.routeName);
        }
      });
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
                image: getDecorationAssetImage(context, "booking4.png")),
          ),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          FutureBuilder<AccountData>(future: getFutureService(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
             return const Center(child: CircularProgressIndicator());
            } else {
            return Center(child: getCustomFont(accountData.employeeName.toString() ?? " ", 20, Colors.black, 1),);
              }
            }
          ),

          getVerSpace(FetchPixels.getPixelHeight(30)),
          getButtonWithIcon(context, Colors.white, "Thông tin cá nhân", Colors.black,
              () {
            /*Constant.sendToNext(context, Routes.myProfileScreenRoute);*/
                /*Navigator.of(context).pushNamed(MyProfileScreen.routeName);*/
                Constant.sendToScreen(const MyProfileScreen(), context);
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
          getButtonWithIcon(context, Colors.white, "Lịch sử đơn hàng", Colors.black,
                  () {
                /*Constant.sendToNext(context, Routes.myProfileScreenRoute);*/
                /*Navigator.of(context).pushNamed(MyProfileScreen.routeName);*/
                    Constant.sendToScreen(const BookingHistory(), context);
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
          /*getButtonWithIcon(context, Colors.white, "Báo cáo sự cố", Colors.black, () {
            *//*Constant.sendToNext(context, Routes.reportRoute);*//*
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
              prefixImage: "documnet.svg",
              sufixIcon: true,
              suffixImage: "arrow_right.svg"),*/
          getVerSpace(FetchPixels.getPixelHeight(40)),
        ],
      ),
    );
  }

  Align buildHeader() {
    return Align(
        alignment: Alignment.topCenter,
        child: getCustomFont("Tài Khoản", 24, Colors.black, 1,
            fontWeight: FontWeight.w900));

  }
}
