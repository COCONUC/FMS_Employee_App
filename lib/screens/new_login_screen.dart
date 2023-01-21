
import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';
import 'package:fms_employee/features/login_service.dart';
import 'package:fms_employee/widgets/bottom_bar.dart';
import 'package:fms_employee/widgets/dialog/failure_dialog.dart';
import 'package:loading_overlay/loading_overlay.dart';

class NewLoginScreen extends StatefulWidget {
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
  bool isPass = true;
  bool isValidated = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: LoadingOverlay(
          isLoading: isLoading,
          opacity: 0.5,
          color: Colors.black12.withOpacity(0.2),
          progressIndicator: const CircularProgressIndicator(),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: backGroundColor,
            body: SafeArea(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: FetchPixels.getDefaultHorSpace(context)),
                alignment: Alignment.topCenter,
                child: buildWidgetList(context),
              ),
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
        getVerSpace(FetchPixels.getPixelHeight(700)),
        getCustomFont(
          "Đăng nhập",
          24,
          Colors.black,
          1,
          fontWeight: FontWeight.w900,
        ),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        getCustomFont(
          "Chào mừng bạn! ",
          16,
          Colors.black,
          1,
          fontWeight: FontWeight.w400,
        ),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        getDefaultTextFiledWithLabelForLogin(
          context,
          "Số điện thoại",
          isValidated,
          emailController,
          Colors.grey,
          minLines: true,
          function: () {},
          height: FetchPixels.getPixelHeight(60),
          isEnable: false,
          withprefix: true,
          image: "call.svg",
        ),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        getDefaultTextFiledWithLabelForLogin(
            context, "Mật khẩu", isValidated, passwordController, Colors.grey,
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
              child: getCustomFont(
                "Quên mật khẩu?",
                16,
                blueColor,
                1,
                fontWeight: FontWeight.w900,
              ),
            )),
        getVerSpace(FetchPixels.getPixelHeight(49)),
        getButton(context, blueColor, "Đăng nhập", Colors.white, () {
          FocusScope.of(context).requestFocus(FocusNode());
          setState(() {
            isLoading = true;
          });
          LoginServices()
              .loginCustomer(emailController.text, passwordController.text)
              .then((value) {
            setState(() {
              isLoading = false;
            });
            if(value.statusCode==200){
              /*Constant.sendToNext(context, Routes.homeScreenRoute);*/
              Constant.sendToScreen(const NavScreen(), context);
            }else{
              showDialog(
                barrierDismissible: true,
                context: context,
                builder: (context) {
                  return FailureDialog(title: 'Đăng nhập thất bại', description: value.body.toString());
                },);
            }
          }
          );
        }, 18,
            weight: FontWeight.w600,
            buttonHeight: FetchPixels.getPixelHeight(60),
            borderRadius:
            BorderRadius.circular(FetchPixels.getPixelHeight(15))),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getCustomFont(
              "Chưa có tài khoản?",
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
                " Đăng ký",
                16,
                blueColor,
                1,
                fontWeight: FontWeight.w900,
              ),
            )
          ],
        ),
        getVerSpace(FetchPixels.getPixelHeight(50)),
        //getDivider(dividerColor, FetchPixels.getPixelHeight(1), 1),
      ],
    );
  }
}
