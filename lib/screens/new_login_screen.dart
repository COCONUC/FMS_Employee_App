import 'package:flutter/material.dart';
import 'package:fms_employee/widgets/bottom_bar.dart';
import '../../../constants/color_constant.dart';
import '../../../constants/constant.dart';
import '../../../constants/pref_data.dart';
import '../../../constants/resizer/fetch_pixels.dart';
import '../../../constants/widget_utils.dart';

class NewLoginScreen extends StatefulWidget {
  static const String routeName = '/new-login-screen';
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
        getCustomFont("Đăng Nhập", 24, Colors.black, 1,
            fontWeight: FontWeight.w900, textAlign: TextAlign.center),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        getCustomFont("Welcome! ", 16, Colors.black, 1,
            fontWeight: FontWeight.w400, textAlign: TextAlign.center),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        emailField(context),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        passField(),
        getVerSpace(FetchPixels.getPixelHeight(19)),
        forgotPass(context),
        getVerSpace(FetchPixels.getPixelHeight(49)),
        loginBtn(context),
       /* getVerSpace(FetchPixels.getPixelHeight(30)),*/
        /*dontAcc(context),*/
        /*getVerSpace(FetchPixels.getPixelHeight(50)),*/
        /*getDivider(dividerColor, FetchPixels.getPixelHeight(1), 1),*/
       /* getVerSpace(FetchPixels.getPixelHeight(50)),*/
        /*btnGoogle(context),*/
        /*getVerSpace(FetchPixels.getPixelHeight(20)),*/
        /*btnFacebook(context),*/
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
            "Quên mật khẩu?",
            16,
            blueColor,
            1,
            fontWeight: FontWeight.w900,
          ),
        ));
  }


  Widget loginBtn(BuildContext context) {
    return getButton(context, blueColor, "Đăng Nhập", Colors.white, () {
      PrefData.setLogIn(true);
      /*Constant.sendToNext(context, Routes.homeScreenRoute);*/
      Navigator.of(context).pushReplacementNamed(NavScreen.routeName);
    }, 18,
        weight: FontWeight.w600,
        buttonHeight: FetchPixels.getPixelHeight(60),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(15)));
  }

  ValueListenableBuilder<dynamic> passField() {
    return ValueListenableBuilder(
      builder: (context, value, child) {
        return getDefaultTextFiledWithLabel(
            context, "Mật Khẩu", passwordController, Colors.grey,
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
      "Số điện thoại",
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
