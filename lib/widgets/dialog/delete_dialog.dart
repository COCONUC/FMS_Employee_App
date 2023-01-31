import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';
import 'package:fms_employee/models/order_detail_data.dart';

class DeleteDialog extends StatefulWidget {
  final String title;
  final String message;
  final ListOrderServiceDto services;
  const DeleteDialog(this.title, this.message, this.services, {Key? key}) : super(key: key);

  @override
  State<DeleteDialog> createState() => _DeleteDialogState();
}

class _DeleteDialogState extends State<DeleteDialog> {
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

                    fontWeight: FontWeight.w500,
                    txtHeight:1.3,
                    textAlign: TextAlign.center),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                getMultilineCustomFont(
                    widget.services.serviceName.toString(),
                    16,
                    Colors.black,
                    fontWeight: FontWeight.w400,
                    txtHeight:1.3,
                    textAlign: TextAlign.center),
                getVerSpace(FetchPixels.getPixelHeight(30)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getButton(context, blueColor, "Quay lại", Colors.white, () {
                      Constant.backToPrev(context);
                    }, 18,
                        weight: FontWeight.w600,
                        buttonHeight: FetchPixels.getPixelHeight(60),
                        buttonWidth: FetchPixels.getPixelWidth(100),
                        borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(14))),
                    getHorSpace(FetchPixels.getPixelWidth(20)),
                    getButton(context, blueColor, "Xóa", Colors.white, () {
                      print(widget.services.orderServiceId);
                      if(widget.services.orderServiceId != null){
                        // xoa API trong day
                        Constant.backToPrevAfterDelete(context, false);
                      }else{
                        Constant.backToPrevAfterDelete(context, true);
                      }
                    }, 18,
                        weight: FontWeight.w600,
                        buttonHeight: FetchPixels.getPixelHeight(60),
                        buttonWidth: FetchPixels.getPixelWidth(100),
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
