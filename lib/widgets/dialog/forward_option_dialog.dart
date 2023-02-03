import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';
import 'package:fms_employee/models/order_detail_data.dart';

class ForwardOptionDialog extends StatefulWidget {
  final String title;
  final String message;
  const ForwardOptionDialog(this.title, this.message, {Key? key}) : super(key: key);

  @override
  State<ForwardOptionDialog> createState() => _ForwardOptionDialogState();
}

class _ForwardOptionDialogState extends State<ForwardOptionDialog> {
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
                /*getVerSpace(FetchPixels.getPixelHeight(20)),*/
                /* getSvgImage("confirm.svg",
                    width: FetchPixels.getPixelHeight(71.37),
                    height: FetchPixels.getPixelHeight(99.92)),*/
                getVerSpace(FetchPixels.getPixelHeight(20)),
                getCustomFont(widget.title, 22, Colors.black, 1,
                  fontWeight: FontWeight.w900, ),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                getMultilineCustomFont(
                    widget.message,
                    16,
                    Colors.black,

                    fontWeight: FontWeight.w400,
                    txtHeight:1.3,
                    textAlign: TextAlign.center),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getButton(context, backGroundColor, "Quay lại", blueColor, () {
                      Constant.backToPrevAfterDelete(context, false);
                    }, 18,
                        weight: FontWeight.w600,
                        buttonHeight: FetchPixels.getPixelHeight(60),
                        buttonWidth: FetchPixels.getPixelWidth(120),
                        isBorder: true,
                        borderWidth: 1.5,
                        borderColor: blueColor,
                        borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(14))),
                    getHorSpace(FetchPixels.getPixelWidth(20)),
                    getButton(context, blueColor, "Xác nhận", Colors.white, () {
                      Constant.backToPrevAfterDelete(context, true);
                    }, 18,
                        weight: FontWeight.w600,
                        buttonHeight: FetchPixels.getPixelHeight(60),
                        buttonWidth: FetchPixels.getPixelWidth(120),
                        borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(14))),
                  ],
                ),
                getVerSpace(FetchPixels.getPixelHeight(10)),
              ],
            );
          },
        ),
      ),
    );
  }
}
