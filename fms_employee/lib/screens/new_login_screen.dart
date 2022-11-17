import 'package:flutter/material.dart';
import '../constants/color_constant.dart';
import '../constants/constant.dart';
import '../constants/pref_data.dart';
import '../constants/resizer/fetch_pixels.dart';
import '../constants/widget_utils.dart';


class NewLoginScreen extends StatefulWidget {
  static const String routeName = "/";
  const NewLoginScreen({Key? key}) : super(key: key);

  @override
  State<NewLoginScreen> createState() => _NewLoginScreenState();
}

class _NewLoginScreenState extends State<NewLoginScreen> {
  void finishView() {
    Constant.closeApp();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValueNotifier valueNotifier = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getDefaultHorSpace(context)),
              alignment: Alignment.topCenter,
              child: buildLoginWidget(context),
            ),
          ),
        ),
        onWillPop: () async {
          finishView();
          return false;
        });
  }

  ListView buildLoginWidget(BuildContext context) {
    return ListView(
      primary: true,
      shrinkWrap: true,
      children: [
        getVerSpace(FetchPixels.getPixelHeight(70)),
        getCustomFont("Login", 24, Colors.black, 1,
            fontWeight: FontWeight.w900, textAlign: TextAlign.center),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        getCustomFont("Glad to meet you again! ", 16, Colors.black, 1,
            fontWeight: FontWeight.w400, textAlign: TextAlign.center),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        emailField(context),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        passField(),
        getVerSpace(FetchPixels.getPixelHeight(19)),
        forgotPass(context),
        getVerSpace(FetchPixels.getPixelHeight(49)),
        loginBtn(context),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        dontAcc(context),
        getVerSpace(FetchPixels.getPixelHeight(50)),
        getDivider(dividerColor, FetchPixels.getPixelHeight(1), 1),
        getVerSpace(FetchPixels.getPixelHeight(50)),
        btnGoogle(context),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        btnFacebook(context),
      ],
    );
  }

  Align forgotPass(BuildContext context) {
    return Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () {
            /*Constant.sendToNext(context, Routes.forgotRoute);*/
          },
          child: getCustomFont(
            "Forgot Password?",
            16,
            blueColor,
            1,
            fontWeight: FontWeight.w900,
          ),
        ));
  }

  Widget btnFacebook(BuildContext context) {
    return getButton(
        context, Colors.white, "Login with Facebook", Colors.black, () {}, 18,
        weight: FontWeight.w600,
        isIcon: true,
        image: "facebook.svg",
        buttonHeight: FetchPixels.getPixelHeight(60),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(15)),
        boxShadow: [
          const BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
        ]);
  }

  Widget btnGoogle(BuildContext context) {
    return getButton(
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
      borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(15)),
      boxShadow: [
        const BoxShadow(
            color: Colors.black12, blurRadius: 10, offset: Offset(0.0, 4.0)),
      ],
    );
  }

  Row dontAcc(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getCustomFont(
          "Don’t have an account?",
          14,
          Colors.black,
          1,
          fontWeight: FontWeight.w400,
        ),
        GestureDetector(
          onTap: () {
            /*Constant.sendToNext(context, Routes.signupRoute);*/
          },
          child: getCustomFont(
            " Sign Up",
            16,
            blueColor,
            1,
            fontWeight: FontWeight.w900,
          ),
        )
      ],
    );
  }

  Widget loginBtn(BuildContext context) {
    return getButton(context, blueColor, "Login", Colors.white, () {
      PrefData.setLogIn(true);
      /*Constant.sendToNext(context, Routes.homeScreenRoute);*/
    }, 18,
        weight: FontWeight.w600,
        buttonHeight: FetchPixels.getPixelHeight(60),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(15)));
  }

  ValueListenableBuilder<dynamic> passField() {
    return ValueListenableBuilder(
      builder: (context, value, child) {
        return getDefaultTextFiledWithLabel(
            context, "Password", passwordController, Colors.grey,
            function: () {},
            height: FetchPixels.getPixelHeight(60),
            isEnable: false,
            withprefix: true,
            image: "lock.svg",
            isPass: valueNotifier.value,
            withSufix: true,
            suffiximage: "eye.svg", imagefunction: () {
          valueNotifier.value = !valueNotifier.value;
        });
      },
      valueListenable: valueNotifier,
    );
  }

  Widget emailField(BuildContext context) {
    return getDefaultTextFiledWithLabel(
      context,
      "Email",
      emailController,
      Colors.grey,
      function: () {},
      height: FetchPixels.getPixelHeight(60),
      isEnable: false,
      withprefix: true,
      image: "message.svg",
      imageWidth: FetchPixels.getPixelWidth(19),
      imageHeight: FetchPixels.getPixelHeight(17.66),
    );
  }
}
