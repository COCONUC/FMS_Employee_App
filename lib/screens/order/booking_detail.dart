import 'package:flutter/material.dart';
import 'package:fms_employee/data/data_file.dart';
import 'package:fms_employee/features/order_service.dart';
import 'package:fms_employee/models/model_booking.dart';
import 'package:fms_employee/constants/pref_data.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/models/order_detail_data.dart';
import 'package:fms_employee/screens/order/booking_add_detail_screen.dart';

class BookingDetail extends StatefulWidget {
  final String img;
  final int orderId;
  const BookingDetail(this.img, this.orderId, {Key? key}) : super(key: key);

  @override
  State<BookingDetail> createState() => _BookingDetailState();
}

class _BookingDetailState extends State<BookingDetail> {

  getPrefData() async {
    index = await PrefData.getDefIndex();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPrefData();
  }

  List<ModelBooking> bookingLists = DataFile.bookingList;
  var index = 0;


  @override
  Widget build(BuildContext context) {
    ModelBooking modelBooking = bookingLists[index];

    FetchPixels(context);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          bottomNavigationBar: buttons(context),
          body: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getDefaultHorSpace(context)),
              child: buildBookingDetail(context, modelBooking),
            ),
          ),
        ),
        onWillPop: () async {
          Constant.backToPrev(context);
          return false;
        });
  }

   Widget buildBookingDetail(BuildContext context, ModelBooking modelBooking) {
    return FutureBuilder<OrderDetailData>(
      future: OrderServices().getOrderDetailById(widget.orderId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getVerSpace(FetchPixels.getPixelHeight(20)),
              gettoolbarMenu(context, "back.svg", () {
                Constant.backToPrev(context);
              },
                  title: "Mã đơn: " + snapshot.data!.orderId.toString(),
                  weight: FontWeight.w900,
                  istext: true,
                  textColor: Colors.black,
                  fontsize: 24),
              getVerSpace(FetchPixels.getPixelHeight(40)),
              Expanded(
                flex: 1,
                child: ListView(
                  shrinkWrap: true,
                  primary: true,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Hero(
                        tag: widget.img,
                        child: Container(
                          height: FetchPixels.getPixelHeight(100),
                          width: FetchPixels.getPixelHeight(100),
                          decoration: BoxDecoration(
                              image: getDecorationNetworkImage(context,'/v0/b/fms-firebase-storage.appspot.com/o/FMS_logo.png?alt=media&token=ba7e5f55-db6f-4d2c-9d53-cd3da0d952b3')
                          ),
                        ),
                      ),
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(40)),

                    getCustomFont("Tên Khách Hàng:", 16, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(6)),
                    getCustomFont(
                      snapshot.data!.customerName ?? "api: Tên khách hàng",
                      16,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.w400,
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                    getDivider(dividerColor, 0, 1),
                    getVerSpace(FetchPixels.getPixelHeight(20)),

                    getCustomFont("Số điện thoại liên hệ:", 16, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(6)),
                    getCustomFont(
                      snapshot.data!.customerPhone ?? "api: số điện thoại khách hàng",
                      16,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.w400,
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                    getDivider(dividerColor, 0, 1),
                    getVerSpace(FetchPixels.getPixelHeight(20)),

                    getCustomFont("Địa Chỉ:", 16, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(6)),
                    getCustomFont(
                      snapshot.data!.address ?? "api: Địa chỉ khách đặt",
                      16,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.w400,
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                    getDivider(dividerColor, 0, 1),
                    getVerSpace(FetchPixels.getPixelHeight(20)),

                    getCustomFont("Ngày & Giờ", 16, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(6)),
                    getCustomFont(
                      "api: Thời gian khách đặt" ?? '',
                      16,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.w400,
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                    getDivider(dividerColor, 0, 1),
                    getVerSpace(FetchPixels.getPixelHeight(20)),

                    getCustomFont("Mô tả:", 16, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(6)),
                    getCustomFont(
                      "api: Mô tả của Manager",
                      16,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.w400,
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                    getDivider(dividerColor, 0, 1),
                    getVerSpace(FetchPixels.getPixelHeight(20)),

                    getCustomFont("Nhân viên thực hiện:", 16, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(6)),
                    getCustomFont(
                      snapshot.data!.listEmployeeDto!.map((e) => e.employeeName).join(', ') ?? "api: Nhân viên thực hiện đơn hàng",
                      16,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.w400,
                    ),

                    getVerSpace(FetchPixels.getPixelHeight(20)),
                    getDivider(dividerColor, 0, 1),
                    getVerSpace(FetchPixels.getPixelHeight(20)),

                    getCustomFont("Dịch Vụ", 16, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(6)),
                    getCustomFont(
                      " " + snapshot.data!.listOrderServiceDto!.map((e) => e.serviceName).join('\n\n ') ?? "api: Danh sách dịch vụ",
                      16,
                      Colors.black,
                      10,
                      fontWeight: FontWeight.w400,
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                    getDivider(dividerColor, 0, 1),
                    getVerSpace(FetchPixels.getPixelHeight(20)),


                  ],
                ),
              )
            ],
          );
        }
      }
    );
  }

  Container buttons(BuildContext context) {
    return Container(
      color: backGroundColor,
      padding: EdgeInsets.only(
          left: FetchPixels.getPixelWidth(20),
          right: FetchPixels.getPixelWidth(20),
          bottom: FetchPixels.getPixelHeight(30)),
      child: Row(
        children: [
          Expanded(
              child: getButton(context, backGroundColor, "Trở Về", blueColor,
                  () {
            Constant.backToPrev(context);
          }, 18,
                  weight: FontWeight.w600,
                  buttonHeight: FetchPixels.getPixelHeight(60),
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(14)),
                  borderColor: blueColor,
                  isBorder: true,
                  borderWidth: 1.5)),
          getHorSpace(FetchPixels.getPixelWidth(20)),
          Expanded(
              child: getButton(context, blueColor, "Bắt Đầu", Colors.white, () {
            // addressList.removeAt(selection!.getInt("index")!);
            // setState(() {});
            /*Constant.backToPrev(context);*/
                /*Navigator.of(context).pushReplacementNamed(DetailScreen.routeName);*/
                Constant.sendToScreen(DetailScreen(widget.orderId), context);
          }, 18,
                  weight: FontWeight.w600,
                  buttonHeight: FetchPixels.getPixelHeight(60),
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(14)))),
        ],
      ),
    );
  }
}
