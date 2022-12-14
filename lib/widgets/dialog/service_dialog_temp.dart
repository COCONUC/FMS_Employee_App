
import 'package:flutter/material.dart';

import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';
import 'package:fms_employee/features/service_service.dart';
import 'package:fms_employee/models/order_detail_data.dart';
import '../../models/service_data.dart';

class ServiceDialogTemp extends StatefulWidget {

  const ServiceDialogTemp({Key? key}) : super(key: key);

  @override
  State<ServiceDialogTemp> createState() => _ServiceDialogTempState();
}

class _ServiceDialogTempState extends State<ServiceDialogTemp> {
  var total = 0.00;

  List<ServiceData> serviceLists = [];
  List<ListOrderServiceDto> listChosenService = [];

   _getFutureService() async {
    serviceLists = await ServiceServices().getServiceListForStaff();
    if(serviceLists.isNotEmpty){
      for(ServiceData e in serviceLists){
        e.quantity = 0;
      }
    setState(() {
    });}
  }
  @override
  void initState() {
    super.initState();
    _getFutureService();
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: addServicesButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: ListView(
          children: [
            Container(
              child: getPaddingWidget(
                EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      getVerSpace(FetchPixels.getPixelHeight(34)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          getCustomFont("Ch???n d???ch v??? mu???n th??m", 20, Colors.black, 1,
                              fontWeight: FontWeight.w900),
                          GestureDetector(
                              onTap: () {
                                Constant.backToPrev(context);
                              },
                              child: getSvgImage("close.svg",
                                  color: mSecondaryColor,
                                  height: FetchPixels.getPixelHeight(24),
                                  width: FetchPixels.getPixelHeight(24)))
                        ],
                      ),
                      getVerSpace(FetchPixels.getPixelHeight(20)),
                      serviceToChooseList(),

                      getVerSpace(FetchPixels.getPixelHeight(10)),
                      /*totalContainer(),*/
                      /*addServicesButton(context),*/
                      getVerSpace(FetchPixels.getPixelHeight(30))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget serviceToChooseList() {
                    return serviceLists.isEmpty? nullListView():  ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      physics: const BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.vertical,
                      itemCount: serviceLists.length,
                      itemBuilder: (context, index) {
                        ServiceData serviceData =serviceLists[index];
                        return Container(
                          margin: EdgeInsets.only(bottom: FetchPixels.getPixelHeight(20)),
                          width: FetchPixels.getPixelWidth(374),
                          padding: EdgeInsets.only(
                              left: FetchPixels.getPixelWidth(16),
                              right: FetchPixels.getPixelWidth(16),
                              top: FetchPixels.getPixelHeight(16),
                              bottom: FetchPixels.getPixelHeight(16)),
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
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.only(left: FetchPixels.getPixelWidth(16)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      getCustomFont(serviceData.serviceName ?? 'api: T??n d???ch v???', 16, Colors.black, 1,
                                        fontWeight: FontWeight.w900, ),
                                      getVerSpace(FetchPixels.getPixelHeight(4)),
                                      getCustomFont(
                                          serviceData.categoryName ?? "api: Category", 14, textColor, 1,
                                          fontWeight: FontWeight.w400),
                                      getVerSpace(FetchPixels.getPixelHeight(4)),
                                      getCustomFont(
                                          "????n v???: api: ????n v??? t??nh", 14, textColor, 1,
                                          fontWeight: FontWeight.w400),
                                      getVerSpace(FetchPixels.getPixelHeight(4)),
                                      getCustomFont(
                                          "Gi?? ti???n: ${serviceData.price}", 14, textColor, 1,
                                          fontWeight: FontWeight.w400),
                                      getVerSpace(FetchPixels.getPixelHeight(6)),
                                    ],
                                  ),
                                ),
                              ),
                             getServiceColumn(context, serviceData),
                            ],
                          ),
                        );
                      },
                    );
          }

  Column getServiceColumn(context, ServiceData serviceData){
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (serviceData.quantity == 0)
          getButton(context, Colors.transparent, "Th??m", blueColor,
                  () {
                    setState(() {
                      serviceData.quantity = serviceData.quantity! +1;
                      /*total = total + (modelColor.price! * 1);*/
                      listChosenService.add(
                      ListOrderServiceDto(
                          serviceId: serviceData.serviceId,
                          serviceName: serviceData.serviceName,
                          categoryName: serviceData.categoryName,
                          quantity: serviceData.quantity,
                          price: serviceData.price)
                      );
                    });


              }, 14,
              weight: FontWeight.w600,
              insetsGeometrypadding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelWidth(20),
                  vertical: FetchPixels.getPixelHeight(12)),
              borderColor: blueColor,
              borderWidth: 1.5,
              isBorder: true,
              borderRadius: BorderRadius.circular(
                  FetchPixels.getPixelHeight(10)))
        else
          Row(
            children: [
              GestureDetector(
                child: getSvgImage("add1.svg",
                    width: FetchPixels.getPixelHeight(30),
                    height: FetchPixels.getPixelHeight(30)),
                onTap: () {
                  serviceData.quantity = (serviceData.quantity! + 1);
                  /*total = total + (modelColor.price! * 1);*/
                  listChosenService.firstWhere((element) => element.serviceId == serviceData.serviceId).quantity = serviceData.quantity!;
                  setState(() {});
                },
              ),
              getHorSpace(FetchPixels.getPixelWidth(10)),
              getCustomFont( serviceData.quantity.toString(), 14,
                Colors.black, 1,
                fontWeight: FontWeight.w400,
              ),
              getHorSpace(FetchPixels.getPixelWidth(10)),
              GestureDetector(
                child: getSvgImage("minus.svg",
                    width: FetchPixels.getPixelHeight(30),
                    height: FetchPixels.getPixelHeight(30)),
                onTap: () {
                  serviceData.quantity = (serviceData.quantity! - 1);
                  /*total = total - (modelColor.price! * 1);*/
                  if (serviceData.quantity! > 0) {
                    listChosenService.firstWhere((element) => element.serviceId == serviceData.serviceId).quantity = serviceData.quantity!;
                  } else {
                    listChosenService.removeWhere((element) => element.serviceId == serviceData.serviceId);
                  }
                  setState(() {});
                },
              ),
            ],
          ),
        getVerSpace(FetchPixels.getPixelHeight(40)),
        /*getCustomFont("${modelColor.price} \VN??", 16, blueColor, 1,
                              fontWeight: FontWeight.w900)*/
      ],
    );
  }

  Container totalContainer() {
    return Container(
      child: total == 0.00
          ? Container()
          : Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              getCustomFont("Total", 24, Colors.black, 1,
                  fontWeight: FontWeight.w900),
              getCustomFont("\$$total", 24, Colors.black, 1,
                fontWeight: FontWeight.w900, )
            ],
          ),
          getVerSpace(FetchPixels.getPixelHeight(30)),
        ],
      ),
    );
  }

  Widget addServicesButton(BuildContext context) {
    return SizedBox(
      height: FetchPixels.getPixelHeight(50),
      width: FetchPixels.getPixelWidth(370),
      child: getButton(context, blueColor, "X??c nh???n", Colors.white, () {
        //printData();
        Navigator.pop(context, listChosenService);
        /*Constant.backToPrev(context);*/
        /*Constant.sendToNext(context, Routes.cartRoute);*/
      }, 18,
          weight: FontWeight.w600,
          buttonHeight: FetchPixels.getPixelHeight(60),
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14))),
    );
  }
  


  Widget nullListView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       /* getSvgImage("booking_null.svg",
            height: FetchPixels.getPixelHeight(124),
            width: FetchPixels.getPixelHeight(84.77)),*/
        getVerSpace(FetchPixels.getPixelHeight(30)),
        /*getCustomFont("Kh??ng t???i ???????c d???ch v???!", 20, Colors.black, 1,
            fontWeight: FontWeight.w900, textAlign: TextAlign.center)*/
      ],
    );
  }

}
