import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';

class FailureDialog extends StatefulWidget {
  final String title;
  final String description;
  const FailureDialog({Key? key,required this.title, required this.description}) : super(key: key);

  @override
  State<FailureDialog> createState() => _FailureDialogState();
}

class _FailureDialogState extends State<FailureDialog> {
  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(20))),
      backgroundColor: backGroundColor,
      content: Builder(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getVerSpace(FetchPixels.getPixelHeight(20)),
              getSvgImage("info.svg"),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              getCustomFont(widget.title, 22, Colors.black, 1,
                  fontWeight: FontWeight.w900),
              getVerSpace(FetchPixels.getPixelHeight(10)),
              getMultilineCustomFont(
                  widget.description,
                  16,
                  Colors.black,
                  fontWeight: FontWeight.w400,

                  textAlign: TextAlign.center,
                  txtHeight:1.3),
              getVerSpace(FetchPixels.getPixelHeight(30)),
              getButton(context, blueColor, "Ok", Colors.white, () {
                Constant.backToPrev(context);
              }, 18,
                  weight: FontWeight.w600,
                  buttonHeight: FetchPixels.getPixelHeight(60),
                  borderRadius:
                  BorderRadius.circular(FetchPixels.getPixelHeight(15))),
              getVerSpace(FetchPixels.getPixelHeight(20)),
            ],
          );
        },
      ),
    );
  }
}
