import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/features/day_off_service.dart';
import 'package:fms_employee/models/day_off_data.dart';
import 'package:fms_employee/screens/notification_screen.dart';
import 'package:fms_employee/widgets/day_off_register_form.dart';
import 'package:fms_employee/widgets/dialog/warning_dialog.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../constants/resizer/fetch_pixels.dart';
import '../constants/widget_utils.dart';

class TabDayOff extends StatefulWidget {
  static const String routeName = '/tab_day_off';
  const TabDayOff({Key? key}) : super(key: key);

  @override
  State<TabDayOff> createState() => _TabDayOffState();
}

class _TabDayOffState extends State<TabDayOff> {
  bool schedule = true;
  String date = " ";

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(
        horizontal: FetchPixels.getDefaultHorSpace(context));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backGroundColor,
      body: Column(
        children: [
          getVerSpace(FetchPixels.getPixelHeight(50)),
          buildSearchBar(edgeInsets, context),
          /* schedule == true ? Container() : nullScheduleView(context),*/
          schedule == true
              ? buildScheduleWidget(edgeInsets, context)
              : Container()
        ],
      ),
    );
  }

  Widget buildSearchBar(EdgeInsets edgeInsets, BuildContext context) {
    return getPaddingWidget(
        edgeInsets,
        withoutleftIconToolbar(context,
            isrightimage: true,
            title: "Đăng ký ngày nghỉ",
            weight: FontWeight.w900,
            textColor: Colors.black,
            fontsize: 24,
            istext: true,
            rightimage: "notification.svg", rightFunction: () {
          /*Constant.sendToNext(context, Routes.notificationRoutes);*/
          Constant.sendToScreen(const NotificationScreen(), context);
          /*Navigator.of(context).pushReplacementNamed(NotificationScreen.routeName);*/
        }));
  }

  Expanded buildScheduleWidget(EdgeInsets edgeInsets, BuildContext context) {
    return Expanded(
      flex: 1,
      child: ListView(
        primary: true,
        shrinkWrap: true,
        children: [
          /*getVerSpace(FetchPixels.getPixelHeight(10)),*/
          calendar(edgeInsets),
          getVerSpace(FetchPixels.getPixelHeight(30)),
          registerButton(context),
          getVerSpace(FetchPixels.getPixelHeight(30)),
          Center(child: getCustomFont("Đơn Đã Gửi", 21, Colors.black, 1),),
          getVerSpace(FetchPixels.getPixelHeight(5)),
          Padding(padding: const EdgeInsets.only(left: 20, right: 20),
            child: getDivider(dividerColor, 0, 1),
          ),

          getVerSpace(FetchPixels.getPixelHeight(10)),
          buildScheduleList(edgeInsets)
        ],
      ),
    );
  }

  ListView buildScheduleList(EdgeInsets edgeInsets) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dayOffPendingList(),
          ],
        );
      },
      shrinkWrap: true,
      primary: false,
      itemCount: dayOffList.length + 1,
    );
  }

  Widget registerButton(BuildContext context) {
    return getButton(
        context, mBlueColor, "Đăng ký", Colors.white, () {
      if (date != " "){
      showModalBottomSheet(
          backgroundColor: Colors.white,
          isDismissible: false,
          isScrollControlled: true,
          context: context,
          constraints: BoxConstraints(maxHeight: FetchPixels.getPixelHeight(700)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(FetchPixels.getPixelHeight(40)),
            ),
          ),
          builder: (context) {
            return DayOffRegisterScreen(date);
          });}
      else{
        showDialog(
            barrierDismissible: false,
            builder: (context) {
              return const WarningDialog("Chưa chọn ngày", "Vui lòng chọn ngày muốn đăng ký nghỉ!");
            },
            context: context);
      }
    }, 18,
        weight: FontWeight.w600,
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14)),
        buttonHeight: FetchPixels.getPixelHeight(60),
        insetsGeometry:
            EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(95)));
  }

  Container calendar(EdgeInsets edgeInsets) {
    return Container(
      height: FetchPixels.getPixelHeight(363),
      margin: edgeInsets,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0.0, 4.0)),
          ],
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(20))),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(20)),
        child: SfDateRangePicker(
          enablePastDates: false,
          minDate: DateTime.now().add(const Duration(days: 2)),

         /* selectableDayPredicate: (DateTime dateTime){
            if (dateTime == DateTime(2023, 2, 24)) {
              return false;
            }
            return true;
          },*/

          monthViewSettings: const DateRangePickerMonthViewSettings(
            dayFormat: "EEE",
            firstDayOfWeek: 1,
          ),
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            date = DateFormat('yyyy-MM-dd').format(args.value);
          },
          selectionShape: DateRangePickerSelectionShape.circle,
          showNavigationArrow: true,
          backgroundColor: Colors.white,
          selectionColor: mBlueColor,
          rangeTextStyle: TextStyle(
            color: Colors.black,
            fontSize: FetchPixels.getPixelHeight(14),
            fontWeight: FontWeight.w400,
          ),
          monthCellStyle: DateRangePickerMonthCellStyle(
              todayCellDecoration: BoxDecoration(
                  border: Border.all(color: mSecondaryColor),
                  shape: BoxShape.circle),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: FetchPixels.getPixelHeight(14),
                fontWeight: FontWeight.w400,
              ),
              todayTextStyle: TextStyle(
                color: mBlueColor,
                fontSize: FetchPixels.getPixelHeight(14),
                fontWeight: FontWeight.w400,
              )),
          selectionTextStyle: TextStyle(
            color: Colors.white,
            fontSize: FetchPixels.getPixelHeight(14),
            fontWeight: FontWeight.w400,
          ),
          selectionMode: DateRangePickerSelectionMode.single,
          initialDisplayDate: DateTime.now(),
          headerStyle: DateRangePickerHeaderStyle(
              textAlign: TextAlign.start,
              textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: FetchPixels.getPixelHeight(16))),
        ),
      ),
    );
  }

  List<DayOffData> dayOffList = [];

  Future<List<DayOffData>> getFutureService() async {
    dayOffList = await DayOffServices().getDateOffListOfStaff();
    return dayOffList.reversed.toList().sublist(0, 4);
  }

  Widget dayOffPendingList() {
    return FutureBuilder<List<DayOffData>>(
        future: getFutureService(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return snapshot.data!.isNotEmpty
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding:
                        EdgeInsets.only(top: FetchPixels.getPixelHeight(10)),
                    shrinkWrap: true,
                    primary: true,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          /*dateHeader(snapshot.data![index], index),*/
                          getVerSpace(FetchPixels.getPixelHeight(5)),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(
                                  bottom: FetchPixels.getPixelHeight(20),
                                  left: FetchPixels.getDefaultHorSpace(context),
                                  right:
                                      FetchPixels.getDefaultHorSpace(context)),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 10,
                                        offset: Offset(0.0, 4.0)),
                                  ],
                                  borderRadius: BorderRadius.circular(
                                      FetchPixels.getPixelHeight(12))),
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
                                        child: getCustomFont(
                                            "Ngày đăng ký nghỉ:  ${DateFormat('dd-MM-yyyy').format(DateTime.parse(snapshot.data![index].dayOff!.substring(0, 10)))}",
                                            16,
                                            Colors.black,
                                            1,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      getHorSpace(FetchPixels.getPixelWidth(6)),
                                      /* getCustomFont(
                                  snapshot.data![index].statusName ?? "api: trạng thái đơn",
                                  13,
                                  success,
                                  1,
                                  fontWeight: FontWeight.w600,
                                )*/
                                    ],
                                  ),
                                  getVerSpace(FetchPixels.getPixelHeight(10)),
                                  getDivider(dividerColor, 0, 1),
                                  getVerSpace(FetchPixels.getPixelHeight(10)),
                                  getCustomFont(
                                      "Lý do: ${snapshot.data![index].reason}",
                                      14,
                                      Colors.black,
                                      1,
                                      fontWeight: FontWeight.w400),
                                  getVerSpace(FetchPixels.getPixelHeight(20)),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                       SizedBox(
                                         height:
                                             FetchPixels.getPixelHeight(42),
                                         width: FetchPixels.getPixelHeight(42),
                                         /*decoration: BoxDecoration(
                                       image: getDecorationAssetImage(
                                           context, "booking_owner1.png" ?? "")),*/
                                       ),
                                      getHorSpace(FetchPixels.getPixelWidth(9)),
                                      Expanded(
                                        flex: 1,
                                        child: getCustomFont(
                                          " ",
                                          16,
                                          Colors.black,
                                          1,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      /*getCustomFont(snapshot.data![index].status.toString() ?? "", 14, textColor, 1,
                                    fontWeight: FontWeight.w400),*/

                                      if (snapshot.data![index].status == 3)
                                        Wrap(
                                          children: [
                                            getButton(
                                                context,
                                                const Color(0xFFEEFCF0),
                                                "Đã duyệt",
                                                success,
                                                () {},
                                                16,
                                                weight: FontWeight.w600,
                                                borderRadius: BorderRadius
                                                    .circular(FetchPixels
                                                        .getPixelHeight(37)),
                                                insetsGeometrypadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: FetchPixels
                                                            .getPixelHeight(6),
                                                        horizontal: FetchPixels
                                                            .getPixelWidth(12)))
                                          ],
                                        )
                                      else if(snapshot.data![index].status == 4)
                                        Wrap(
                                          children: [
                                            getButton(
                                                context,
                                                error,
                                                "Từ chối",
                                                Colors.white,
                                                () {},
                                                16,
                                                weight: FontWeight.w600,
                                                borderRadius: BorderRadius
                                                    .circular(FetchPixels
                                                        .getPixelHeight(37)),
                                                insetsGeometrypadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: FetchPixels
                                                            .getPixelHeight(6),
                                                        horizontal: FetchPixels
                                                            .getPixelWidth(12)))
                                          ],
                                        )
                                      else if(snapshot.data![index].status == 1)
                                          Wrap(
                                            children: [
                                              getButton(
                                                  context,
                                                  Colors.yellow.shade700,
                                                  "Chờ duyệt",
                                                  Colors.white,
                                                      () {},
                                                  16,
                                                  weight: FontWeight.w600,
                                                  borderRadius: BorderRadius
                                                      .circular(FetchPixels
                                                      .getPixelHeight(37)),
                                                  insetsGeometrypadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: FetchPixels
                                                          .getPixelHeight(6),
                                                      horizontal: FetchPixels
                                                          .getPixelWidth(12)))
                                            ],
                                          )
                                      else
                                          Wrap(
                                            children: [
                                              getButton(
                                                  context,
                                                  Colors.yellow.shade700,
                                                  "Chờ duyệt",
                                                  Colors.white,
                                                      () {},
                                                  16,
                                                  weight: FontWeight.w600,
                                                  borderRadius: BorderRadius
                                                      .circular(FetchPixels
                                                      .getPixelHeight(37)),
                                                  insetsGeometrypadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: FetchPixels
                                                          .getPixelHeight(6),
                                                      horizontal: FetchPixels
                                                          .getPixelWidth(12)))
                                            ],
                                          ),
                                      getHorSpace(FetchPixels.getPixelWidth(12)),

                                    ],
                                  )
                                ],
                              ),
                            ),
                            onTap: () {},
                          )
                        ],
                      );
                    },
                  )
                : nullListView();
          }
        });
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
        getCustomFont("Không Có Đơn Đăng Ký !", 20, Colors.black, 1,
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
      ],
    );
  }
}
