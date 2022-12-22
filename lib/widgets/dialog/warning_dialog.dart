import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';

class WarningDialog extends StatefulWidget {
  const WarningDialog({Key? key}) : super(key: key);

  @override
  State<WarningDialog> createState() => _WarningDialogState();
}

class _WarningDialogState extends State<WarningDialog> {
  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return WillPopScope(
      onWillPop: _onWillPop,
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(FetchPixels.getPixelHeight(20))),
        backgroundColor: backGroundColor,
        content: Builder(
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                getVerSpace(FetchPixels.getPixelHeight(20)),
               /* getSvgImage("confirm.svg",
                    width: FetchPixels.getPixelHeight(71.37),
                    height: FetchPixels.getPixelHeight(99.92)),*/
                getVerSpace(FetchPixels.getPixelHeight(40)),
                /*getCustomFont("Booking Confirmed", 22, Colors.black, 1,
                  fontWeight: FontWeight.w900, ),*/
                getVerSpace(FetchPixels.getPixelHeight(10)),
                getMultilineCustomFont(
                    "Vui lòng chọn ngày muốn đăng ký nghỉ!",
                    16,
                    Colors.black,

                    fontWeight: FontWeight.w400,
                    txtHeight:1.3,
                    textAlign: TextAlign.center),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                getButton(context, blueColor, "Quay lại", Colors.white, () {
                  Constant.backToPrev(context);
                }, 18,
                    weight: FontWeight.w600,
                    buttonHeight: FetchPixels.getPixelHeight(60),
                    borderRadius:
                    BorderRadius.circular(FetchPixels.getPixelHeight(14))),
                getVerSpace(FetchPixels.getPixelHeight(10)),
              ],
            );
          },
        ),
      ),
    );
  }
}
