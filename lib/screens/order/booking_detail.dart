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
import 'package:fms_employee/widgets/image_screen.dart';

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
  late List<String> listImages = [];

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
      future: futureDetailData(),
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
                  title: "M?? ????n: " + snapshot.data!.orderId.toString(),
                  weight: FontWeight.w900,
                  istext: true,
                  textColor: Colors.black,
                  fontsize: 24,
                  isrightimage: true,
                  rightimage: "more.svg",
                  rightFunction: () {}),
              getVerSpace(FetchPixels.getPixelHeight(10)),
              Center(
                child:   getCustomFont(
                  snapshot.data!.statusName! ?? "api: tr???ng th??i ????n h??ng",
                  16,
                  success,
                  1,
                  fontWeight: FontWeight.w600,
                )
              ),
              getVerSpace(FetchPixels.getPixelHeight(40)),
              Expanded(
                flex: 1,
                child: ListView(
                  shrinkWrap: true,
                  primary: true,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                        child: Container(
                          height: FetchPixels.getPixelHeight(100),
                          width: FetchPixels.getPixelHeight(100),
                          decoration: BoxDecoration(
                              image: getDecorationNetworkImage(context,'/v0/b/fms-firebase-storage.appspot.com/o/image2022-12-03%2017%3A45%3A20.601076?alt=media&token=77724f45-bb52-44ee-9c0e-ae7de8d5ffe7')
                          ),
                        ),
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(40)),

                    getCustomFont("T??n Kh??ch H??ng:", 16, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    getCustomFont(
                      snapshot.data!.customerName ?? "api: T??n kh??ch h??ng",
                      16,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.w400,
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(5)),
                    getDivider(dividerColor, 0, 1),
                    getVerSpace(FetchPixels.getPixelHeight(20)),

                    getCustomFont("S??? ??i???n tho???i li??n h???:", 16, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    getCustomFont(
                      snapshot.data!.customerPhone ?? "api: s??? ??i???n tho???i kh??ch h??ng",
                      16,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.w400,
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(5)),
                    getDivider(dividerColor, 0, 1),
                    getVerSpace(FetchPixels.getPixelHeight(20)),

                    getCustomFont("?????a Ch???:", 16, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    getCustomFont(
                      snapshot.data!.address ?? "api: ?????a ch??? kh??ch ?????t",
                      16,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.w400,
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(5)),
                    getDivider(dividerColor, 0, 1),
                    getVerSpace(FetchPixels.getPixelHeight(20)),

                    getCustomFont("Ng??y & Gi???", 16, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    getCustomFont(
                      "api: Th???i gian kh??ch ?????t" ?? '',
                      16,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.w400,
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(5)),
                    getDivider(dividerColor, 0, 1),
                    getVerSpace(FetchPixels.getPixelHeight(20)),

                    getCustomFont("M?? t???:", 16, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    getCustomFont(
                      snapshot.data!.description ?? "api: M?? t??? c???a Manager",
                      16,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.w400,
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(5)),
                    getDivider(dividerColor, 0, 1),
                    getVerSpace(FetchPixels.getPixelHeight(20)),

                    getCustomFont("???nh hi???n tr???ng:", 16, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    /*getCustomFont(
                      snapshot.data!.description ?? "api: M?? t??? c???a Manager",
                      16,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.w400,
                    ),*/
                    InkWell(
                      child: const Icon(
                        Icons.image,
                        color: Colors.orange,
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ImageScreen(id: widget.orderId, imgURL: listImages)));
                      },
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(5)),
                    getDivider(dividerColor, 0, 1),
                    getVerSpace(FetchPixels.getPixelHeight(20)),

                    getCustomFont("Nh??n vi??n th???c hi???n:", 16, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    getCustomFont(
                      snapshot.data!.listEmployeeDto!.map((e) => e.employeeName).join(', ') ?? "api: Nh??n vi??n th???c hi???n ????n h??ng",
                      16,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.w400,
                    ),

                    getVerSpace(FetchPixels.getPixelHeight(5)),
                    getDivider(dividerColor, 0, 1),
                    getVerSpace(FetchPixels.getPixelHeight(20)),

                    getCustomFont("Th???i gian l??m vi???c d??? ki???n:", 16, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    getCustomFont(
                      snapshot.data!.estimateTimeFinish ?? "api: th???i gian l??m vi???c d??? ki???n",
                      16,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.w400,
                    ),

                    getVerSpace(FetchPixels.getPixelHeight(5)),
                    getDivider(dividerColor, 0, 1),
                    getVerSpace(FetchPixels.getPixelHeight(20)),

                    getCustomFont("D???ch V???", 16, textColor, 1,
                        fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    getCustomFont(
                      " " + snapshot.data!.listOrderServiceDto!.map((e) => e.serviceName! + "\t\t\t\t\t\t\t\t\t\t\t\t\t" + e.price.toString() + " VN??"+ " S??? l?????ng: " + e.quantity.toString()).join('\n\n ') ?? "api: Danh s??ch d???ch v???",
                      16,
                      Colors.black,
                      100,
                      fontWeight: FontWeight.w400,
                    ),
                    getVerSpace(FetchPixels.getPixelHeight(5)),
                    getDivider(dividerColor, 0, 1),
                    getVerSpace(FetchPixels.getPixelHeight(20)),
                    getCustomFont("T???ng C???ng", 16, textColor, 1, fontWeight: FontWeight.w400),
                    getVerSpace(FetchPixels.getPixelHeight(10)),
                    getCustomFont(
                      snapshot.data!.totalPrice ?? "api: T???ng gi?? ti???n ????n h??ng",
                      20,
                      Colors.black,
                      1,
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.right,
                    ),
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
              child: getButton(context, backGroundColor, "Tr??? V???", blueColor,
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
              child: getButton(context, blueColor, "Kh???o S??t", Colors.white, () {
            // addressList.removeAt(selection!.getInt("index")!);
            // setState(() {});
            /*Constant.backToPrev(context);*/
                /*Navigator.of(context).pushReplacementNamed(DetailScreen.routeName);*/
                if (detailData != null) {
                  Constant.sendToScreen(
                      DetailEditingScreen(widget.orderId, detailData, '/v0/b/fms-firebase-storage.appspot.com/o/image2022-12-03%2017%3A45%3A20.601076?alt=media&token=77724f45-bb52-44ee-9c0e-ae7de8d5ffe7'), context);
                }
          }, 18,
                  weight: FontWeight.w600,
                  buttonHeight: FetchPixels.getPixelHeight(60),
                  borderRadius:
                      BorderRadius.circular(FetchPixels.getPixelHeight(14)))),
        ],
      ),
    );
  }

  late OrderDetailData detailData;

  Future<OrderDetailData> futureDetailData() async{
    detailData = await OrderServices().getOrderDetailById(widget.orderId);
    return detailData;
  }

}
