import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/pref_data.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';
import 'package:fms_employee/features/account_service.dart';
import 'package:fms_employee/features/day_off_service.dart';
import 'package:fms_employee/models/account_data.dart';
import 'package:fms_employee/models/day_off_register_data.dart';
import 'package:fms_employee/widgets/dialog/confirm_dialog.dart';
import 'package:fms_employee/widgets/dialog/warning_dialog.dart';
import 'package:intl/intl.dart';


class DayOffRegisterScreen extends StatefulWidget {
  final String date;
  const DayOffRegisterScreen( this.date, {Key? key}) : super(key: key);

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

  final DayOffRegisterData _dayOffRegisterData = DayOffRegisterData(status: 1);

  AccountData accountData = AccountData();

  Future<AccountData> getAccountService() async {
    accountData = await AccountServices().getAccountDataByEmployeeId();
    return accountData;
  }
  @override
  void initState() {
    // TODO: implement initState
    PrefData.getUserId().then((value) =>     accountData.employeeId = value
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
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
                  context, "${snapshot.data!.employeeName}" ?? "Name",
                  nameController,
                  Colors.black,
                  function: () {},
                  height: FetchPixels.getPixelHeight(60),
                  withprefix: true,
                  image: "user.svg",
                  isEnable: true,
                  minLines: true),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getDefaultTextFiledWithLabel(
                  context, "Ngày đăng ký nghỉ: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.date))}",
                  nameController,
                  Colors.black,
                  function: () {},
                  height: FetchPixels.getPixelHeight(60),
                  withprefix: true,
                  image: "calender.svg",
                  isEnable: true,
                  minLines: true),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getDefaultTextFiledWithLabel(
                  context, "Nhập lý do xin nghỉ", reasonController, Colors.black,
                  function: () {},
                  isEnable: false,
                  withprefix: false,
                  minLines: true,
                  height: FetchPixels.getPixelHeight(120),
                  alignment: Alignment.topLeft),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getDefaultTextFiledWithLabel(
                  context, "Email: ${snapshot.data!.email}" ?? "Email", pinCodeController, Colors.black,
                  function: () {},
                  isEnable: true,
                  withprefix: false,
                  image: 'mail.png',
                  minLines: true,
                  height: FetchPixels.getPixelHeight(60)),
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getDefaultTextFiledWithLabel(
                  context, snapshot.data!.employeePhoneNumber ?? "Số điện thoại", phoneController, Colors.black,
                  function: () {},
                  height: FetchPixels.getPixelHeight(60),
                  withprefix: true,
                  image: "call.svg",
                  isEnable: true,
                  minLines: true),

              getVerSpace(FetchPixels.getPixelHeight(20)),

              addAddressButton(context, snapshot.data!.employeeId!),
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

  Container addAddressButton(BuildContext context, int employeeId) {
    return Container(
      color: backGroundColor,
      padding: EdgeInsets.only(
          left: FetchPixels.getPixelWidth(4),
          right: FetchPixels.getPixelWidth(4),
          top: FetchPixels.getPixelHeight(60)),
      child: getButton(context, blueColor, "Gửi Đơn", Colors.white, () {
        if(reasonController.text.isNotEmpty){
    showDialog(
    barrierDismissible: false,
    builder: (context) {
      _dayOffRegisterData.employeeId = employeeId;
      _dayOffRegisterData.dayOff = widget.date;
      _dayOffRegisterData.reason = reasonController.text;
      _dayOffRegisterData.status = 1;
      DayOffServices().sendDayOffForm(_dayOffRegisterData);
    return const ConfirmDialog("Gửi đơn thành công", "Vui lòng đợi xét duyệt");
    },
    context: context);
    }else{
          showDialog(
              barrierDismissible: false,
              builder: (context) {
                return const WarningDialog("Chưa nhập lý do", "Vui lòng ghi rõ lý do xin nghỉ!");
              },
              context: context);
        }
      }, 18,
          weight: FontWeight.w600,
          buttonHeight: FetchPixels.getPixelHeight(60),
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
    );
  }
}
