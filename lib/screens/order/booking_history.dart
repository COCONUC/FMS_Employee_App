import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';
import 'package:fms_employee/screens/order/booking_active.dart';
import 'package:fms_employee/screens/order/booking_canceled.dart';
import 'package:fms_employee/screens/order/booking_completed.dart';

class BookingHistory extends StatefulWidget {
  final int employeeId;
  const BookingHistory(this.employeeId, {Key? key}) : super(key: key);

  @override
  State<BookingHistory> createState() => _BookingHistoryState();
}

class _BookingHistoryState extends State<BookingHistory> with SingleTickerProviderStateMixin {
  final PageController _controller = PageController(
    initialPage: 0,
  );

  late TabController tabController;
  var position = 0;

  List<String> tabsList = ["Hoàn thành", "Đã hủy"];

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
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
          getVerSpace(FetchPixels.getPixelHeight(40)),
          getPaddingWidget(
            EdgeInsets.symmetric(
                horizontal: FetchPixels.getDefaultHorSpace(context)),
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
          /*getVerSpace(FetchPixels.getPixelHeight(10)),*/
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
          BookingCompleted(widget.employeeId),
          BookingCanceled(widget.employeeId),
        ],
        onPageChanged: (value) {
          tabController.animateTo(value);
          position = value;
          setState(() {});
        },
      ),
    );
  }



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
      ),
    );
  }

}
