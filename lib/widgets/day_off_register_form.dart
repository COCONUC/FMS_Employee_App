import 'package:flutter/material.dart';
import 'package:fms_employee/constants/assets.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';
import 'package:fms_employee/features/account_service.dart';
import 'package:fms_employee/features/day_off_service.dart';
import 'package:fms_employee/models/account_data.dart';
import 'package:fms_employee/models/day_off_register_data.dart';
import 'package:fms_employee/screens/tab_day_off.dart';
import 'package:fms_employee/widgets/dialog/confirm_dialog.dart';
import 'package:intl/intl.dart';


class DayOffRegisterScreen extends StatefulWidget {
  final int employeeId;
  final String date;
  const DayOffRegisterScreen(this.employeeId, this.date, {Key? key}) : super(key: key);

  @override
  State<DayOffRegisterScreen> createState() => _DayOffRegisterScreenState();
}

class _DayOffRegisterScreenState extends State<DayOffRegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final DayOffRegisterData _dayOffRegisterData = DayOffRegisterData();

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
                  isEnable: true,
                  minLines: true),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getDefaultTextFiledWithLabel(
                  context, "Ng??y ????ng k?? ngh???: ${widget.date}" ?? "Ng??y ????ng k??",
                  nameController,
                  Colors.grey,
                  function: () {},
                  height: FetchPixels.getPixelHeight(60),
                  withprefix: true,
                  image: "profile.svg",
                  isEnable: true,
                  minLines: true),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getDefaultTextFiledWithLabel(
                  context, "L?? do", reasonController, Colors.grey,
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
                  isEnable: true,
                  withprefix: false,
                  minLines: true,
                  height: FetchPixels.getPixelHeight(60)),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getDefaultTextFiledWithLabel(
                  context, snapshot.data!.employeePhoneNumber ?? "S??? ??i???n tho???i", phoneController, Colors.grey,
                  function: () {},
                  height: FetchPixels.getPixelHeight(60),
                  withprefix: true,
                  image: "call.svg",
                  isEnable: true,
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
        title: "????n ????ng K?? Ng??y Ngh???",
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
      child: getButton(context, blueColor, "G???i ????n", Colors.white, () {
        _dayOffRegisterData.employeeId = widget.employeeId;
        _dayOffRegisterData.dayOff = widget.date;
        _dayOffRegisterData.reason = reasonController.text;
        _dayOffRegisterData.status = false;
        DayOffServices().sendDayOffForm(_dayOffRegisterData);
        showDialog(
            barrierDismissible: false,
            builder: (context) {
              return const ConfirmDialog("check_complete.sgv", "G???i ????n th??nh c??ng", "Vui l??ng ?????i x??t duy???t");
            },
            context: context);
      }, 18,
          weight: FontWeight.w600,
          buttonHeight: FetchPixels.getPixelHeight(60),
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
    );
  }
}
