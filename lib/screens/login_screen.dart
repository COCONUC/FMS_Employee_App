import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/features/login_service.dart';
import 'package:fms_employee/widgets/bottom_bar.dart';
import 'package:fms_employee/widgets/custom_button.dart';
import 'package:fms_employee/widgets/custom_text_field.dart';
import 'package:fms_employee/widgets/dialog/failure_dialog.dart';

/*enum Auth {
  signin,
  signup,
}*/

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login-screen';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();

  String resultText = "";

  final TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPassController = TextEditingController();

  bool isPass = true;
  bool isValidated = false;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }


  void signUpUser() {
   /* authService.signUpUser(
      context: context,
      username: phoneController.text,
      password: passwordController.text,
    );*/
  }

  void signInUser() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ListTile(
                  tileColor: mBackgroundColor,
                  title: Text(
                    'Đăng nhập1',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ),

                  Container(
                    padding: const EdgeInsets.all(8),
                    color: mBackgroundColor,
                    child: Form(
                      key: _signInFormKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: phoneController,
                            hintText: 'Số điện thoại',
                            secure: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextField(
                            controller: passwordController,
                            hintText: 'Mật khẩu',
                            secure: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                            text: 'Đăng nhập',
                            onTap: () {
                             /* if (_signInFormKey.currentState!.validate()) {
                                signInUser();
                              }*/
                              /*Navigator.of(context).pushReplacementNamed(NavScreen.routeName);
                              Constant.sendToScreen(NavScreen(), context);*/

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
                                  Constant.sendToScreen(const NavScreen(0), context);
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
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          InkWell(
                           child:  Text(
                            'Quên mật khẩu ?',
                          ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}