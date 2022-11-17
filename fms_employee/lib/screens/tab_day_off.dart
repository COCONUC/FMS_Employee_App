import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/models/model_dayoff.dart';
import 'package:fms_employee/screens/notification_screen.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../constants/resizer/fetch_pixels.dart';
import '../constants/widget_utils.dart';
import '../data/data_file.dart';

class TabDayOff extends StatefulWidget {
  static const String routeName = '/tab_day_off';
  const TabDayOff({Key? key}) : super(key: key);

  @override
  State<TabDayOff> createState() => _TabDayOffState();
}

class _TabDayOffState extends State<TabDayOff> {
  bool schedule = true;
  List<ModelDayOff> scheduleList = DataFile.scheduleList;

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
              Constant.sendToScreen(NotificationScreen(), context);
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
          getVerSpace(FetchPixels.getPixelHeight(30)),
          calendar(edgeInsets),
          getVerSpace(FetchPixels.getPixelHeight(30)),
          addReminderButton(context),
          getVerSpace(FetchPixels.getPixelHeight(20)),
          buildScheduleList(edgeInsets)
        ],
      ),
    );
  }

  ListView buildScheduleList(EdgeInsets edgeInsets) {
    return ListView.builder(
      itemBuilder: (context, index) {
        ModelDayOff boolModel = scheduleList[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getPaddingWidget(edgeInsets,getCustomFont(
              boolModel.date ?? "",
              16,
              textColor,
              1,
              fontWeight: FontWeight.w400,
            )),
            getVerSpace(FetchPixels.getPixelHeight(10)),
            buildBookingListItem(
                boolModel, context, index, () {}, () {}),
            getVerSpace(FetchPixels.getPixelHeight(20)),
          ],
        );
      },
      shrinkWrap: true,
      primary: false,
      itemCount: scheduleList.length,
    );
  }


  Widget addReminderButton(BuildContext context) {
    return getButton(context, const Color(0xFFF2F4F8), "Đăng ký",
        blueColor, () {}, 18,
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
          monthViewSettings: const DateRangePickerMonthViewSettings(
            dayFormat: "EEE",
          ),
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {

          },
          selectionShape: DateRangePickerSelectionShape.circle,
          showNavigationArrow: true,
          backgroundColor: Colors.white,
          rangeSelectionColor: Colors.white,
          rangeTextStyle: TextStyle(
            color: Colors.black,
            fontSize: FetchPixels.getPixelHeight(14),
            fontWeight: FontWeight.w400,
          ),
          startRangeSelectionColor: blueColor,
          endRangeSelectionColor: blueColor,
          monthCellStyle: DateRangePickerMonthCellStyle(
              todayCellDecoration: BoxDecoration(
                  border: Border.all(color: blueColor), shape: BoxShape.circle),
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: FetchPixels.getPixelHeight(14),
                fontWeight: FontWeight.w400,
              ),
              todayTextStyle: TextStyle(
                color: blueColor,
                fontSize: FetchPixels.getPixelHeight(14),
                fontWeight: FontWeight.w400,
              )),
          selectionTextStyle: TextStyle(
            color: Colors.white,
            fontSize: FetchPixels.getPixelHeight(14),
            fontWeight: FontWeight.w400,
          ),
          selectionMode: DateRangePickerSelectionMode.range,
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

  GestureDetector buildBookingListItem(ModelDayOff modelDayOff,
      BuildContext context, int index, Function function, Function funDelete) {
    return GestureDetector(
      onTap: () {
        function();
      },
      child: Container(
        height: FetchPixels.getPixelHeight(171),
        margin: EdgeInsets.only(
            bottom: FetchPixels.getPixelHeight(20),
            left: FetchPixels.getDefaultHorSpace(context),
            right: FetchPixels.getDefaultHorSpace(context)),
        padding: EdgeInsets.symmetric(
            vertical: FetchPixels.getPixelHeight(16),
            horizontal: FetchPixels.getPixelWidth(16)),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0.0, 4.0)),
            ],
            borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(12))),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  getHorSpace(FetchPixels.getPixelWidth(16)),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 1,child: getHorSpace(0),),
                        getCustomFont(
                            "api: Ngày nghỉ bắt đầu - kết thúc", 16, Colors.black, 1,
                            fontWeight: FontWeight.w900),
                        getVerSpace(FetchPixels.getPixelHeight(12)),
                        getCustomFont(
                          "api: Lý do",
                          14,
                          textColor,
                          1,
                          fontWeight: FontWeight.w400,
                        ),
                        getVerSpace(FetchPixels.getPixelHeight(12)),
                        Expanded(flex: 1,child: getHorSpace(0),),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          funDelete();
                        },
                        child: getSvgImage("trash.svg",
                            width: FetchPixels.getPixelHeight(20),
                            height: FetchPixels.getPixelHeight(20)),
                      )
                    ],
                  )
                ],
              ),
            ),
            getVerSpace(FetchPixels.getPixelHeight(16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    getAssetImage("dot.png", FetchPixels.getPixelHeight(8),
                        FetchPixels.getPixelHeight(8)),
                    getHorSpace(FetchPixels.getPixelWidth(8)),
                    getCustomFont("api: Tiến độ giải quyết đơn", 14, textColor, 1,
                        fontWeight: FontWeight.w400),
                  ],
                ),
                Wrap(
                  children: [
                    getButton(
                        context,
                        Color(modelDayOff.bgColor!.toInt()),
                        modelDayOff.tag ?? "",
                        modelDayOff.textColor!,
                            () {},
                        16,
                        weight: FontWeight.w600,
                        borderRadius:
                        BorderRadius.circular(FetchPixels.getPixelHeight(37)),
                        insetsGeometrypadding: EdgeInsets.symmetric(
                            vertical: FetchPixels.getPixelHeight(6),
                            horizontal: FetchPixels.getPixelWidth(12)))
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

}
