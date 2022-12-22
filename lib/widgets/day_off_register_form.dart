import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';
import 'package:fms_employee/features/account_service.dart';
import 'package:fms_employee/models/account_data.dart';


class DayOffRegisterScreen extends StatefulWidget {
  final int employeeId;
  final String date;
  const DayOffRegisterScreen(this.employeeId, this.date, {Key? key}) : super(key: key);

  @override
  State<DayOffRegisterScreen> createState() => _DayOffRegisterScreenState();
}

class _DayOffRegisterScreenState extends State<DayOffRegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  AccountData accountData = new AccountData();

  Future<AccountData> getAccountService() async {
    accountData = await AccountServices().getAccountDataByEmployeeId(widget.employeeId);
    return accountData;
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          bottomNavigationBar: addAddressButton(context),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: FetchPixels.getDefaultHorSpace(context)),
              child: Column(
                children: [
                  getVerSpace(FetchPixels.getPixelHeight(20)),
                  buildToolbar(context),
                  getVerSpace(FetchPixels.getPixelHeight(30)),
                  buildExpand(context)
                ],
              ),
            ),
          ),
        ),
        onWillPop: () async {
          Constant.backToPrev(context);
          return false;
        });
  }

  Widget buildExpand(BuildContext context) {
    return FutureBuilder<AccountData>(
        future: getAccountService(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center();
      } else {
        return Expanded(
          flex: 1,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            primary: true,
            children: [
              getDefaultTextFiledWithLabel(
                  context, snapshot.data!.employeeName ?? "Name",
                  nameController,
                  Colors.grey,
                  function: () {},
                  height: FetchPixels.getPixelHeight(60),
                  withprefix: true,
                  image: "profile.svg",
                  isEnable: false,
                  minLines: true),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getDefaultTextFiledWithLabel(
                  context, widget.date ?? "Ngày đăng ký",
                  nameController,
                  Colors.grey,
                  function: () {},
                  height: FetchPixels.getPixelHeight(60),
                  withprefix: true,
                  image: "profile.svg",
                  isEnable: false,
                  minLines: true),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getDefaultTextFiledWithLabel(
                  context, "Lý do", addressController, Colors.grey,
                  function: () {},
                  isEnable: false,
                  withprefix: false,
                  minLines: true,
                  height: FetchPixels.getPixelHeight(120),
                  alignment: Alignment.topLeft),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getDefaultTextFiledWithLabel(
                  context, snapshot.data!.email ?? "Email", pinCodeController, Colors.grey,
                  function: () {},
                  isEnable: false,
                  withprefix: false,
                  minLines: true,
                  height: FetchPixels.getPixelHeight(60)),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getDefaultTextFiledWithLabel(
                  context, snapshot.data!.employeePhoneNumber ?? "Số điện thoại", phoneController, Colors.grey,
                  function: () {},
                  height: FetchPixels.getPixelHeight(60),
                  withprefix: true,
                  image: "call.svg",
                  isEnable: false,
                  minLines: true),
            ],
          ),
        );
      }
    }
    );
  }

  Widget buildToolbar(BuildContext context) {
    return gettoolbarMenu(context, "back.svg", () {
      Constant.backToPrev(context);
    },
        istext: true,
        title: "Đơn Đăng Ký Ngày Nghỉ",
        weight: FontWeight.w900,
        fontsize: 24,
        textColor: Colors.black);
  }

  Container addAddressButton(BuildContext context) {
    return Container(
      color: backGroundColor,
      padding: EdgeInsets.only(
          left: FetchPixels.getPixelWidth(20),
          right: FetchPixels.getPixelWidth(20),
          bottom: FetchPixels.getPixelHeight(30)),
      child: getButton(context, blueColor, "Gửi Đơn", Colors.white, () {
        Constant.backToPrev(context);
      }, 18,
          weight: FontWeight.w600,
          buttonHeight: FetchPixels.getPixelHeight(60),
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
    );
  }
}
