import 'package:flutter/material.dart';
import 'package:fms_employee/features/order_service.dart';
import 'package:fms_employee/models/order_data.dart';
import 'package:fms_employee/screens/booking/booking_new.dart';
import 'package:fms_employee/screens/notification_screen.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';
import '../features/account_service.dart';
import '../models/account_data.dart';

class TabBooking extends StatefulWidget {
  static const String routeName = '/tab_booking';

  const TabBooking({Key? key}) : super(key: key);

  @override
  State<TabBooking> createState() => _TabBookingState();
}

class _TabBookingState extends State<TabBooking> with SingleTickerProviderStateMixin {

  final PageController _controller = PageController(
    initialPage: 0,
  );

  late TabController tabController;
  var position = 0;

  List<String> tabsList = ["Đơn mới"];

  @override
  void initState() {
    tabController = TabController(length: 1, vsync: this);
    super.initState();
  }

  AccountData accountData = AccountData();

  Future<AccountData> getAccountService() async {
    accountData = await AccountServices().getAccountDataByEmployeeId();
    return accountData;
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return SafeArea(
      child: Column(
        children: [
          getVerSpace(FetchPixels.getPixelHeight(16)),
          buildTopRow(context),
          getVerSpace(FetchPixels.getPixelHeight(16)),
          tabBar(),
          Expanded(
            flex: 1,
            /*child: BookingActive(widget.employeeId),*/
            child: PageView(
              physics: const BouncingScrollPhysics(),
              controller: _controller,
              scrollDirection: Axis.horizontal,
              children: /*const*/ [
                BookingActive(),
              ],
              onPageChanged: (value) {
                tabController.animateTo(value);
                position = value;
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildTopRow(BuildContext context) {
    return FutureBuilder<AccountData>(
        future: getAccountService(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) {
        return const Center();
      } else {
        return getPaddingWidget(
          EdgeInsets.symmetric(
              horizontal: FetchPixels.getDefaultHorSpace(context)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: FetchPixels.getPixelHeight(46),
                width: FetchPixels.getPixelHeight(46),
                decoration: BoxDecoration(
                    image: getDecorationAssetImage(context, snapshot.data!.imageUrl ?? "booking4.png")),
              ),
              getHorSpace(FetchPixels.getPixelWidth(12)),
              Expanded(
                flex: 1,
                child: getCustomFont(snapshot.data!.employeeName ?? "api: Tên Nhân Viên", 16, Colors.black, 1,
                    fontWeight: FontWeight.w400),
              ),
              InkWell(
                  child: getSvgImage("notification.svg",
                  height: FetchPixels.getPixelHeight(24),
                  width: FetchPixels.getPixelHeight(24)),
                onTap: () => {Constant.sendToScreen(NotificationScreen(), context)},
              ),
            ],
          ),
        );
      }
    }
    );
  }

  Widget nullListView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getSvgImage("booking_null.svg",
            height: FetchPixels.getPixelHeight(124),
            width: FetchPixels.getPixelHeight(84.77)),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        getCustomFont("Chưa Có Đơn!", 20, Colors.black, 1,
            fontWeight: FontWeight.w900, textAlign: TextAlign.center)
      ],
    );
  }

  List<OrderData> bookingLists = [];

  Future<List<OrderData>> getFutureService() async {
    bookingLists = await OrderServices().getOrderListForStaff();
    return bookingLists;
  }

  Widget dateHeader(OrderData modelBooking, int index) {
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
                /*modelBooking.createAssignAt?.substring(0,10)*/ "api: thời gian khách đặt" ?? "",
                16,
                Colors.black,
                1,
                fontWeight: FontWeight.w400,
              )
            else if (/*bookingLists[index - 1].createAssignAt?.substring(0,10) == bookingLists[index].createAssignAt?.substring(0,10)*/ "api: thời gian khách đặt" == "api: thời gian khách đặt")
              Container()
            else
              getCustomFont(
                "api: thời gian khách đặt" ?? "",
                14,
                textColor,
                1,
                fontWeight: FontWeight.w400,
              )
          ],
        ));
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
