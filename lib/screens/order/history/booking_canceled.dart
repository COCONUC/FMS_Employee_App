import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fms_employee/features/order_service.dart';
import 'package:fms_employee/models/order_with_status_data.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/pref_data.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';
import 'package:fms_employee/screens/order/history/booking_detail_history.dart';


class BookingCanceled extends StatefulWidget {
  static const String routeName = '/booking_canceled';
  const BookingCanceled( {Key? key}) : super(key: key);

  @override
  State<BookingCanceled> createState() => _BookingCanceledState();
}

class _BookingCanceledState extends State<BookingCanceled> {

  @override
  void initState() {
    super.initState();
  }

  /*AccountData accountData = new AccountData();

  Future<AccountData> getAccountService() async {
    accountData = await AccountServices().getAccountDataByEmployeeId(widget.employeeId);
    return accountData;
  }*/

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return SafeArea(
      child: Container(
        child: bookingList(),
      ),
    );
  }

  List<OrderWithStatusData> bookingLists = [];

  Future<List<OrderWithStatusData>> getFutureService() async {
    bookingLists = await OrderServices().getInProcessOrderListForStaff( 1002, context);
    return bookingLists;
  }

  Widget bookingList() {
    return FutureBuilder<List<OrderWithStatusData>> (
        future: getFutureService(),
        builder: (context, snapshot){
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return snapshot.data!.isNotEmpty?
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: FetchPixels.getPixelHeight(20)),
              shrinkWrap: true,
              primary: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    /*dateHeader(snapshot.data![index], index),*/
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: FetchPixels.getPixelHeight(20),
                            left: FetchPixels.getDefaultHorSpace(context),
                            right: FetchPixels.getDefaultHorSpace(context)),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  offset: Offset(0.0, 4.0)),
                            ],
                            borderRadius:
                            BorderRadius.circular(FetchPixels.getPixelHeight(12))),
                        padding: EdgeInsets.symmetric(
                            horizontal: FetchPixels.getPixelWidth(16),
                            vertical: FetchPixels.getPixelHeight(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: getCustomFont(snapshot.data![index].address ?? "",
                                      16, Colors.black, 1,
                                      fontWeight: FontWeight.w900),
                                ),
                                getSvgImage("info.svg",
                                    color: error,
                                    width: FetchPixels.getPixelHeight(24),
                                    height: FetchPixels.getPixelHeight(24)),
                                getHorSpace(FetchPixels.getPixelWidth(6)),
                                getCustomFont(
                                  snapshot.data![index].statusName ?? "api: trạng thái đơn",
                                  13,
                                  error,
                                  1,
                                  fontWeight: FontWeight.w600,
                                )
                              ],
                            ),
                            getVerSpace(FetchPixels.getPixelHeight(6)),
                            getCustomFont("Mã đơn: ${snapshot.data![index].orderId.toString()}", 14, textColor, 1,
                                fontWeight: FontWeight.w400),
                            getVerSpace(FetchPixels.getPixelHeight(20)),
                            getDivider(dividerColor, 0, 1),
                            getVerSpace(FetchPixels.getPixelHeight(20)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Hero(
                                  tag: snapshot.data![index].customerId ?? "",
                                  child: Container(
                                    height: FetchPixels.getPixelHeight(42),
                                    width: FetchPixels.getPixelHeight(42),
                                    decoration: BoxDecoration(
                                        image: getDecorationAssetImage(
                                            context, "booking_owner1.png")),
                                  ),
                                ),
                                getHorSpace(FetchPixels.getPixelWidth(9)),
                                Expanded(
                                  flex: 1,
                                  child: getCustomFont(
                                    snapshot.data![index].customerName ?? "",
                                    16,
                                    Colors.black,
                                    1,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                getSvgImage("call_icon.svg",height:FetchPixels.getPixelHeight(42),width: FetchPixels.getPixelHeight(42) ),
                                getCustomFont(snapshot.data![index].customerPhone ?? "", 14, textColor, 1,
                                    fontWeight: FontWeight.w400),
                                // Container(
                                //   height: FetchPixels.getPixelHeight(42),
                                //   width: FetchPixels.getPixelHeight(42),
                                //   decoration: BoxDecoration(
                                //       image: getDecorationAssetImage(
                                //           context, "round_chat.png")),
                                // ),
                                getHorSpace(FetchPixels.getPixelWidth(12)),


                                // Container(
                                //   height: FetchPixels.getPixelHeight(42),
                                //   width: FetchPixels.getPixelHeight(42),
                                //   decoration: BoxDecoration(
                                //       image: getDecorationAssetImage(
                                //           context, "call_bg.png")),
                                // ),
                              ],
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        PrefData.setDefIndex(index);
                        Constant.sendToScreen(BookingDetailHistory("booking_owner1.png", snapshot.data![index].orderId!), context);
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BookingDetail("booking_owner1.png"?? "", snapshot.data![index].orderId!)
                          )
                      );*/
                      },
                    )
                  ],
                );
              },
            ): nullListView();
          }
        }
    );
  }

  Widget dateHeader(OrderWithStatusData modelBooking, int index) {
    return getPaddingWidget(
        EdgeInsets.symmetric(
            horizontal: FetchPixels.getDefaultHorSpace(context)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            index == 0
                ? getCustomFont("Đơn Hàng", 16, Colors.black, 1,
                fontWeight: FontWeight.w900)
                : Container(),
            if (index == 0)
              getCustomFont(
                /*modelBooking.createAssignAt?.substring(0,10)*/ "api: thời gian khách đặt",
                16,
                Colors.black,
                1,
                fontWeight: FontWeight.w400,
              )
            else if (/*bookingLists[index - 1].createAssignAt?.substring(0,10) == bookingLists[index].createAssignAt?.substring(0,10)*/ "api: thời gian khách đặt" == "api: thời gian khách đặt")
              Container()
            else
              getCustomFont(
                "api: thời gian khách đặt",
                14,
                textColor,
                1,
                fontWeight: FontWeight.w400,
              )
          ],
        ));
  }

  Widget nullListView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getSvgImage("booking_null.svg",
            height: FetchPixels.getPixelHeight(124),
            width: FetchPixels.getPixelHeight(84.77)),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        getCustomFont("Chưa Có Đơn Hàng !", 20, Colors.black, 1,
            fontWeight: FontWeight.w900, textAlign: TextAlign.center),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        getCustomFont(
          "Vui lòng chờ cập nhật mới từ hệ thống! ",
          16,
          Colors.black,
          2,
          fontWeight: FontWeight.w400,
        ),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        getButton(context, backGroundColor, "Tải lại dữ liệu", blueColor, () {
          setState(() {
            /*schedule = true;*/
          });
        }, 18,
            weight: FontWeight.w600,
            buttonHeight: FetchPixels.getPixelHeight(60),
            insetsGeometry: EdgeInsets.symmetric(
                horizontal: FetchPixels.getPixelWidth(98)),
            borderRadius:
            BorderRadius.circular(FetchPixels.getPixelHeight(14)),
            isBorder: true,
            borderColor: blueColor,
            borderWidth: 1.5)
      ],
    );
  }

}
