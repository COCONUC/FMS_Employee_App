import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';
import 'package:fms_employee/screens/notification_screen.dart';
import 'package:fms_employee/screens/tab_booking.dart';

class BookingHistory extends StatefulWidget {
  final int employeeId;
  const BookingHistory(this.employeeId, {Key? key}) : super(key: key);

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory>
    with SingleTickerProviderStateMixin {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  late TabController tabController;
  var position = 0;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backGroundColor,
      body: Column(
        children: [
          getVerSpace(FetchPixels.getPixelHeight(30)),
          getPaddingWidget(
            EdgeInsets.symmetric(
                horizontal: FetchPixels.getDefaultHorSpace(context)),
            /*withoutleftIconToolbar(context,
                isrightimage: true,
                title: "Bookings",
                weight: FontWeight.w900,
                textColor: Colors.black,
                fontsize: 24,
                istext: true,
                rightimage: "notification.svg", rightFunction: () {
                  *//*Constant.sendToNext(context, Routes.notificationRoutes);*//*
                }),*/
              gettoolbarMenu(context, "back.svg", () {
                Constant.backToPrev(context);
              },
                  istext: true,
                  title: "Lịch Sử Đơn Hàng",
                  weight: FontWeight.w900,
                  fontsize: 24,
                  textColor: Colors.black),
          ),
          /*InkWell(
            child: getSvgImage("notification.svg",
                height: FetchPixels.getPixelHeight(24),
                width: FetchPixels.getPixelHeight(24)),
            onTap: () => {Constant.sendToScreen(NotificationScreen(), context)},
          ),*/
          getVerSpace(FetchPixels.getPixelHeight(30)),
          tabBar(),
          getVerSpace(FetchPixels.getPixelHeight(10)),
          pageViewer()
        ],
      ),
    );
  }

  Expanded pageViewer() {
    return Expanded(
      child: PageView(
        physics: const BouncingScrollPhysics(),
        controller: _controller,
        scrollDirection: Axis.horizontal,
        children: /*const*/ [
          /*AllBookingScreen(),
          ActiveBookingScreen(),
          CompleteBookingScreen(),
          CancelBookingScreen()*/
          TabBooking(widget.employeeId),
          TabBooking(widget.employeeId),
          TabBooking(widget.employeeId),
        ],
        onPageChanged: (value) {
          tabController.animateTo(value);
          position = value;
          setState(() {});
        },
      ),
    );
  }

  List<String> tabsList = ["Tất cả", "Hoàn thành", "Đã hủy"];

  Widget tabBar() {
    return getPaddingWidget(
      EdgeInsets.symmetric(horizontal: FetchPixels.getDefaultHorSpace(context)),
      TabBar(
        indicatorColor: Colors.transparent,
        physics: const BouncingScrollPhysics(),
        controller: tabController,
        labelPadding: EdgeInsets.zero,
        onTap: (index) {
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
          position = index;
          setState(() {});
        },
        tabs: List.generate(tabsList.length, (index) {
          return Tab(
            child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    getCustomFont(tabsList[index], 16,
                        position == index ? blueColor : Colors.black, 1,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.visible),
                    getVerSpace(FetchPixels.getPixelHeight(7)),
                    Container(
                      height: FetchPixels.getPixelHeight(2),
                      color: position == index
                          ? blueColor
                          : const Color(0xFFE5E8F1),
                    )
                  ],
                )),
          );
        }),
        // Tab(
        //   child: Container(
        //       alignment: Alignment.center,
        //       child: Column(
        //         children: [
        //           getCustomFont(
        //               "All", 16, position == 0 ? blueColor : Colors.black, 1,
        //               fontWeight: FontWeight.w400,
        //               overflow: TextOverflow.visible),
        //           getVerSpace(FetchPixels.getPixelHeight(7)),
        //           Container(
        //             height: FetchPixels.getPixelHeight(2),
        //             color:
        //                 position == 0 ? blueColor : const Color(0xFFE5E8F1),
        //           )
        //         ],
        //       )),
        // ),
        // Tab(
        //   child: Container(
        //       alignment: Alignment.center,
        //       child: Column(
        //         children: [
        //           getCustomFont("Active", 16,
        //               position == 1 ? blueColor : Colors.black, 1,
        //
        //               fontWeight: FontWeight.w400,
        //               overflow: TextOverflow.visible),
        //           getVerSpace(FetchPixels.getPixelHeight(7)),
        //           Container(
        //             height: FetchPixels.getPixelHeight(2),
        //             color:
        //                 position == 1 ? blueColor : const Color(0xFFE5E8F1),
        //           )
        //         ],
        //       )),
        // ),
        // Tab(
        //   child: Container(
        //       alignment: Alignment.center,
        //       child: Column(
        //         children: [
        //           getCustomFont("Completed", 16,
        //               position == 2 ? blueColor : Colors.black, 1,
        //
        //               fontWeight: FontWeight.w400,
        //               overflow: TextOverflow.visible),
        //           getVerSpace(FetchPixels.getPixelHeight(7)),
        //           Container(
        //             height: FetchPixels.getPixelHeight(2),
        //             color:
        //                 position == 2 ? blueColor : const Color(0xFFE5E8F1),
        //           )
        //         ],
        //       )),
        // ),
        // Tab(
        //   child: Container(
        //       alignment: Alignment.center,
        //       child: Column(
        //         children: [
        //           getCustomFont("Cancelled", 16,
        //               position == 3 ? blueColor : Colors.black, 1,
        //
        //               fontWeight: FontWeight.w400,
        //               overflow: TextOverflow.visible),
        //           getVerSpace(FetchPixels.getPixelHeight(7)),
        //           Container(
        //             height: FetchPixels.getPixelHeight(2),
        //             color:
        //                 position == 3 ? blueColor : const Color(0xFFE5E8F1),
        //           )
        //         ],
        //       )),
        // )
      ),
    );
  }
}
