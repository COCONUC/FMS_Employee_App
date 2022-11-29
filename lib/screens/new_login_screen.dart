import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/pref_data.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';
import 'package:fms_employee/widgets/bottom_bar.dart';


class NewLoginScreen extends StatefulWidget {
  static const String routeName = '/new-login-screen';
  const NewLoginScreen({Key? key}) : super(key: key);

  @override
  State<NewLoginScreen> createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {

  final _signInFormKey = GlobalKey<FormState>();

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPass = true;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          body: SafeArea(
            child: Container(
              padding:
              EdgeInsets.symmetric(horizontal: FetchPixels.getDefaultHorSpace(context)),
              alignment: Alignment.topCenter,
              child: buildWidgetList(context),
            ),
          ),
        ),
        onWillPop: () async {
          finishView();
          return false;
        });
  }

  ListView buildWidgetList(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      primary: true,
      children: [
        getVerSpace(FetchPixels.getPixelHeight(70)),
        getCustomFont("Login", 24, Colors.black, 1,
          fontWeight: FontWeight.w900, ),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        getCustomFont("Glad to meet you again! ", 16, Colors.black, 1,
          fontWeight: FontWeight.w400, ),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        getDefaultTextFiledWithLabel(
          context,
          "Số điện thoại",
          phoneController,
          Colors.grey,
          function: () {},
          height: FetchPixels.getPixelHeight(60),
          isEnable: false,
          withprefix: true,
          image: "message.svg",
        ),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        getDefaultTextFiledWithLabel(
            context, "Mật khẩu", passwordController, Colors.grey,
            function: () {},
            height: FetchPixels.getPixelHeight(60),
            isEnable: false,
            withprefix: true,
            image: "lock.svg",
            isPass: isPass,
            withSufix: true,
            suffiximage: "eye.svg", imagefunction: () {
          setState(() {
            isPass = !isPass;
          });
        }),
        getVerSpace(FetchPixels.getPixelHeight(19)),
        Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () {
                /*Constant.sendToNext(context, Routes.forgotRoute);*/
              },
              child: getCustomFont("Forgot Password?", 16, blueColor, 1,
                fontWeight: FontWeight.w900, ),
            )),
        getVerSpace(FetchPixels.getPixelHeight(49)),
        getButton(context, blueColor, "Login", Colors.white, () {
          PrefData.setLogIn(true);
          /*Constant.sendToNext(context, Routes.homeScreenRoute);*/
          if (_signInFormKey.currentState!.validate()) {
            signInUser();
          }
        }, 18,
            weight: FontWeight.w600,
            buttonHeight: FetchPixels.getPixelHeight(60),
            borderRadius:
            BorderRadius.circular(FetchPixels.getPixelHeight(15))),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getCustomFont("Don’t have an account?", 14, Colors.black, 1,
              fontWeight: FontWeight.w400, ),
            GestureDetector(
              onTap: () {
                /*Constant.sendToNext(context, Routes.signupRoute);*/
              },
              child: getCustomFont(" Sign Up", 16, blueColor, 1,
                fontWeight: FontWeight.w900, ),
            )
          ],
        ),
        getVerSpace(FetchPixels.getPixelHeight(50)),
        getDivider(dividerColor, FetchPixels.getPixelHeight(1), 1),
        getVerSpace(FetchPixels.getPixelHeight(50)),
        getButton(
          context,
          Colors.white,
          "Login with Google",
          Colors.black,
              () {},
          18,
          weight: FontWeight.w600,
          isIcon: true,
          image: "google.svg",
          buttonHeight: FetchPixels.getPixelHeight(60),
          borderRadius:
          BorderRadius.circular(FetchPixels.getPixelHeight(15)),
          boxShadow: [
            const BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0.0, 4.0)),
          ],
        ),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        getButton(context, Colors.white, "Login with Facebook",
            Colors.black, () {}, 18,
            weight: FontWeight.w600,
            isIcon: true,
            image: "facebook.svg",
            buttonHeight: FetchPixels.getPixelHeight(60),
            borderRadius:
            BorderRadius.circular(FetchPixels.getPixelHeight(15)),
            boxShadow: [
              const BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0.0, 4.0)),
            ]),
      ],
    );
  }

  String resultText = "";

  void signInUser() {
    if(phoneController.text == '0938995710' ){
      resultText == 'OK';
      print('OK');
      Navigator.of(context).pushReplacementNamed(NavScreen.routeName);
    }
  }

  void finishView() {
    Constant.closeApp();
  }

}
