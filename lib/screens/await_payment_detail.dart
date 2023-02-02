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
import 'package:fms_employee/widgets/bottom_bar.dart';
import 'package:intl/intl.dart';
import 'package:fms_employee/widgets/show_image.dart';

class AwaitPaymentDetail extends StatefulWidget {
  final String img;
  final int orderId;
  const AwaitPaymentDetail(this.img, this.orderId, {Key? key}) : super(key: key);

  @override
  State<AwaitPaymentDetail> createState() => _AwaitPaymentDetailState();
}

class _AwaitPaymentDetailState extends State<AwaitPaymentDetail> {

  List<String> imgPath = ['https://firebasestorage.googleapis.com/v0/b/fms-firebase-storage.appspot.com/o/image2022-12-03%2017%3A45%3A20.601076?alt=media&token=77724f45-bb52-44ee-9c0e-ae7de8d5ffe7'
    ,'https://firebasestorage.googleapis.com/v0/b/fms-firebase-storage.appspot.com/o/image2022-12-03%2017%3A45%3A20.601076?alt=media&token=77724f45-bb52-44ee-9c0e-ae7de8d5ffe7'
    ,'https://firebasestorage.googleapis.com/v0/b/fms-firebase-storage.appspot.com/o/image2022-12-03%2017%3A45%3A20.601076?alt=media&token=77724f45-bb52-44ee-9c0e-ae7de8d5ffe7'];

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
                    title: "Mã đơn: ${snapshot.data!.orderId}",
                    weight: FontWeight.w900,
                    istext: true,
                    textColor: Colors.black,
                    fontsize: 24,
                    isrightimage: false,
                    rightimage: "more.svg",
                    rightFunction: () {}),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                Center(
                    child:   getCustomFont(
                      snapshot.data!.statusName! ?? "api: trạng thái đơn hàng",
                      16,
                      success,
                      1,
                      fontWeight: FontWeight.w600,
                    )
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                Center(
                    child:   getCustomFont(
                      "Thông tin chi tiết",
                      20,
                      textColor,
                      1,
                      fontWeight: FontWeight.w800,
                    )
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                Expanded(
                  flex: 1,
                  child: ListView(
                    shrinkWrap: true,
                    primary: true,
                    children: [
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      getCustomFont("Tên Khách Hàng:", 16, textColor, 1,
                          fontWeight: FontWeight.w400),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      getCustomFont(
                        snapshot.data!.customerName ?? "api: Tên khách hàng",
                        16,
                        Colors.black,
                        1,
                        fontWeight: FontWeight.w400,
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      getDivider(dividerColor, 0, 1),
                      getVerSpace(FetchPixels.getPixelHeight(20)),

                      getCustomFont("Số điện thoại liên hệ:", 16, textColor, 1,
                          fontWeight: FontWeight.w400),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      getCustomFont(
                        snapshot.data!.customerPhone ?? "api: số điện thoại khách hàng",
                        16,
                        Colors.black,
                        1,
                        fontWeight: FontWeight.w400,
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      getDivider(dividerColor, 0, 1),
                      getVerSpace(FetchPixels.getPixelHeight(20)),

                      getCustomFont("Địa Chỉ:", 16, textColor, 1,
                          fontWeight: FontWeight.w400),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      getCustomFont(
                        snapshot.data!.address ?? "api: Địa chỉ khách đặt",
                        16,
                        Colors.black,
                        1,
                        fontWeight: FontWeight.w400,
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      getDivider(dividerColor, 0, 1),
                      getVerSpace(FetchPixels.getPixelHeight(20)),

                      getCustomFont("Giờ & Ngày thực hiện công việc:", 16, textColor, 1,
                          fontWeight: FontWeight.w400),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      getCustomFont(
                        "${snapshot.data!.listOrderServiceDto!.first.implementationTime}  Ngày: ${DateFormat('dd-MM-yyyy').format(DateTime.parse(snapshot.data!.listOrderServiceDto!.first.implementationDate.toString()))}" ?? 'api: Thời gian khách đặt',
                        16,
                        Colors.black,
                        1,
                        fontWeight: FontWeight.w400,
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      getDivider(dividerColor, 0, 1),
                      getVerSpace(FetchPixels.getPixelHeight(20)),

                      getCustomFont("Mô tả:", 16, textColor, 1,
                          fontWeight: FontWeight.w400),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      if(snapshot.data!.description!.isNotEmpty)
                        getCustomFont(
                          snapshot.data!.description ?? "Không có mô tả",
                          16,
                          Colors.black,
                          1,
                          fontWeight: FontWeight.w400,
                        )
                      else
                        getCustomFont(
                          "Không có mô tả",
                          16,
                          Colors.black,
                          1,
                          fontWeight: FontWeight.w400,
                        ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      getDivider(dividerColor, 0, 1),
                      getVerSpace(FetchPixels.getPixelHeight(20)),

                      getCustomFont("Ảnh hiện trạng:", 16, textColor, 1,
                          fontWeight: FontWeight.w400),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      InkWell(
                        child: const Icon(
                          Icons.image,
                          color: Colors.orange,
                        ),
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ShowImage(id: widget.orderId, imgURL: imgPath)));
                        },
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      getDivider(dividerColor, 0, 1),
                      getVerSpace(FetchPixels.getPixelHeight(20)),

                      getCustomFont("Nhân viên thực hiện:", 16, textColor, 1,
                          fontWeight: FontWeight.w400),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      getCustomFont(
                        snapshot.data!.listEmployeeDto!.map((e) => e.employeeName).join(', ') ?? "api: Nhân viên thực hiện đơn hàng",
                        16,
                        Colors.black,
                        1,
                        fontWeight: FontWeight.w400,
                      ),

                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      getDivider(dividerColor, 0, 1),
                      getVerSpace(FetchPixels.getPixelHeight(20)),

                      getCustomFont("Thời gian làm việc dự kiến:", 16, textColor, 1,
                          fontWeight: FontWeight.w400),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      getCustomFont(
                        "${totalTime(snapshot.data!.listOrderServiceDto!).toString()} slot(s)" ?? "api: thời gian làm việc dự kiến",
                        16,
                        Colors.black,
                        1,
                        fontWeight: FontWeight.w400,
                      ),

                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      getDivider(dividerColor, 0, 1),
                      getVerSpace(FetchPixels.getPixelHeight(20)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              getCustomFont("Tên Dịch Vụ", 16, textColor, 1,
                                  fontWeight: FontWeight.w400),
                            ],
                          ),
                          Column(
                            children: [
                              getCustomFont("\t\t\t\t\t\t\t\t\t\t\t\t\t\t" + "Số lượng", 16, textColor, 1,
                                  fontWeight: FontWeight.w400),
                            ],
                          ),
                          Column(
                            children: [
                              getCustomFont("Đơn giá (VNĐ)", 16, textColor, 1,
                                  fontWeight: FontWeight.w400),
                            ],
                          ),
                        ],
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              getCustomFont(
                                snapshot.data!.listOrderServiceDto!.map((e) => e.serviceName!).join('\n').toString() ?? "api: Danh sách dịch vụ",
                                16,
                                Colors.black,
                                100,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              getCustomFont(
                                snapshot.data!.listOrderServiceDto!.map((e) => e.quantity!).join('\n').toString()?? "api: Danh sách dịch vụ",
                                16,
                                Colors.black,
                                100,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              /*Text(snapshot.data!.listOrderServiceDto!.map((e) => e.quantity!).join('\n').toString()),*/
                              getCustomFont(
                                snapshot.data!.listOrderServiceDto!.map((e) => e.price!).join('\n').toString()?? "api: Danh sách dịch vụ",
                                16,
                                Colors.black,
                                100,
                                fontWeight: FontWeight.w400,
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ],
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(5)),
                      getDivider(dividerColor, 0, 1),
                      getVerSpace(FetchPixels.getPixelHeight(20)),
                      getCustomFont("Tổng Cộng", 16, textColor, 1, fontWeight: FontWeight.w400),
                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      getCustomFont(
                        "${totalPrice(snapshot.data!.listOrderServiceDto!).toInt()} VNĐ" ?? "Tổng giá tiền đơn hàng",
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

  double totalPrice(List<ListOrderServiceDto> services){
    double total = 0.0;
    for(var e in services){
      total = total + (double.parse(e.price!)* e.quantity!);
    }
    return total;
  }

  double totalTime(List<ListOrderServiceDto> time){
    double total = 0.0;
    for(var e in time){
      if(e.estimateTimeFinish != null) {
        total = total + (double.parse(e.estimateTimeFinish!.toString().substring(0, 1)));
      }
      if(e.estimateTimeFinish == null) {
        double slot = 1;
        total = total + 1;
      }
    }
    return total;
  }

  Widget buttons(BuildContext context) {
    return FutureBuilder<OrderDetailData>(
        future: OrderServices().getOrderDetailById(widget.orderId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container(
              color: backGroundColor,
              padding: EdgeInsets.only(
                  left: FetchPixels.getPixelWidth(20),
                  right: FetchPixels.getPixelWidth(20),
                  bottom: FetchPixels.getPixelHeight(30)),
              child: Row(
                children: [
                  Expanded(
                      child: getButton(
                          context, backGroundColor, "Sửa Đơn", blueColor,
                              () {
                            if (snapshot.data! != null) {
                              Constant.sendToScreen(
                                  DetailEditingScreen(widget.orderId, snapshot
                                      .data!,
                                      '/v0/b/fms-firebase-storage.appspot.com/o/image2022-12-03%2017%3A45%3A20.601076?alt=media&token=77724f45-bb52-44ee-9c0e-ae7de8d5ffe7'),
                                  context);
                            }
                          }, 16,
                          weight: FontWeight.w600,
                          buttonHeight: FetchPixels.getPixelHeight(60),
                          borderRadius:
                          BorderRadius.circular(FetchPixels.getPixelHeight(14)),
                          borderColor: blueColor,
                          isBorder: true,
                          borderWidth: 1.5)),
                  getHorSpace(FetchPixels.getPixelWidth(20)),
                  Expanded(
                      child: getButton(
                          context, blueColor, "Hoàn Tất Đơn",
                          Colors.white, () {
                        // addressList.removeAt(selection!.getInt("index")!);
                        // setState(() {});
                        /*Constant.backToPrev(context);*/
                        /*Navigator.of(context).pushReplacementNamed(DetailScreen.routeName);*/
                        /*Constant.sendToScreen(DetailScreen(widget.orderId), context);*/
                        Constant.sendToScreen(NavScreen(), context);
                      }, 16,
                          weight: FontWeight.w600,
                          buttonHeight: FetchPixels.getPixelHeight(60),
                          borderRadius:
                          BorderRadius.circular(
                              FetchPixels.getPixelHeight(14)))),
                ],
              ),
            );
          }
        }
    );
  }
}
