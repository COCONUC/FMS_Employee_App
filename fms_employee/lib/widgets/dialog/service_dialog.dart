import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';
import 'package:fms_employee/data/data_file.dart';
import 'package:fms_employee/features/service_service.dart';
import 'package:fms_employee/models/model_color.dart';
import '../../models/model_cart.dart';
import '../../models/service_data.dart';

class ServiceDialog extends StatefulWidget {

  const ServiceDialog({Key? key}) : super(key: key);

  @override
  State<ServiceDialog> createState() => _ServiceDialogState();
}

class _ServiceDialogState extends State<ServiceDialog> {
  var total = 0.00;
  static List<ModelColor> hairColorLists = DataFile.hairColorList;

  List<ServiceData> serviceLists = [];

  Future<List<ServiceData>> getFutureService() async {
    serviceLists = await ServiceServices().getServiceListForStaff();
    return serviceLists;
  }

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    return Wrap(
      children: [
        Container(
          child: getPaddingWidget(
            EdgeInsets.symmetric(horizontal: FetchPixels.getPixelWidth(20)),
            Column(
              children: [
                getVerSpace(FetchPixels.getPixelHeight(34)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    getCustomFont("Chọn dịch vụ muốn thêm", 20, Colors.black, 1,
                         fontWeight: FontWeight.w900),
                    GestureDetector(
                        onTap: () {
                          Constant.backToPrev(context);
                        },
                        child: getSvgImage("close.svg",
                            height: FetchPixels.getPixelHeight(24),
                            width: FetchPixels.getPixelHeight(24)))
                  ],
                ),
                getVerSpace(FetchPixels.getPixelHeight(20)),
                serviceToChooseList(),
                getVerSpace(FetchPixels.getPixelHeight(10)),
                totalContainer(),
                addServicesButton(context),
                getVerSpace(FetchPixels.getPixelHeight(30))
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget serviceToChooseList() {
    return FutureBuilder<List<ServiceData>>(
      future: getFutureService(),
      builder: (context, snapshot){
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return snapshot.data!.isNotEmpty?
    ListView.builder(
      shrinkWrap: true,
      primary: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        ModelColor modelColor = hairColorLists[index];
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
                      getCustomFont(snapshot.data![index].serviceName ?? 'api: Tên dịch vụ', 16, Colors.black, 1,
                          fontWeight: FontWeight.w900, ),
                      getVerSpace(FetchPixels.getPixelHeight(4)),
                      getCustomFont(
                          snapshot.data![index].category ?? "api: Category", 14, textColor, 1,
                           fontWeight: FontWeight.w400),
                      getVerSpace(FetchPixels.getPixelHeight(4)),
                      getCustomFont(
                          "Đơn vị: api: đơn vị tính", 14, textColor, 1,
                          fontWeight: FontWeight.w400),
                      getVerSpace(FetchPixels.getPixelHeight(4)),
                      getCustomFont(
                          "Giá tiền: ${snapshot.data![index].price}", 14, textColor, 1,
                          fontWeight: FontWeight.w400),
                      getVerSpace(FetchPixels.getPixelHeight(6)),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (modelColor.quantity == 0)
                    getButton(context, Colors.transparent, "Thêm", blueColor,
                        () {
                      modelColor.quantity = (modelColor.quantity! + 1);
                      total = total + (modelColor.price! * 1);
                      DataFile.cartList[index.toString()] = ModelCart(
                          modelColor.image,
                          modelColor.name,
                          modelColor.productName,
                          modelColor.rating,
                          modelColor.price,
                          modelColor.quantity);

                      setState(() {});
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
                            modelColor.quantity = (modelColor.quantity! + 1);
                            total = total + (modelColor.price! * 1);
                            DataFile.cartList[index.toString()]!.quantity =
                                modelColor.quantity;
                            setState(() {});
                          },
                        ),
                        getHorSpace(FetchPixels.getPixelWidth(10)),
                        getCustomFont(modelColor.quantity.toString(), 14,
                            Colors.black, 1,
                            fontWeight: FontWeight.w400,
                            ),
                        getHorSpace(FetchPixels.getPixelWidth(10)),
                        GestureDetector(
                          child: getSvgImage("minus.svg",
                              width: FetchPixels.getPixelHeight(30),
                              height: FetchPixels.getPixelHeight(30)),
                          onTap: () {
                            modelColor.quantity = (modelColor.quantity! - 1);
                            total = total - (modelColor.price! * 1);
                            if (modelColor.quantity! > 0) {
                              DataFile.cartList[index.toString()]!.quantity =
                                  modelColor.quantity;
                            } else {
                              DataFile.cartList.remove(index.toString());
                            }
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  getVerSpace(FetchPixels.getPixelHeight(40)),
                  getCustomFont("${modelColor.price} \VNĐ", 16, blueColor, 1,
                       fontWeight: FontWeight.w900)
                ],
              )
            ],
          ),
        );
      },
    ): nullListView();
  }
}
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
    return getButton(context, blueColor, "Xác nhận", Colors.white, () {
      Constant.backToPrev(context);
      /*Constant.sendToNext(context, Routes.cartRoute);*/
    }, 18,
        weight: FontWeight.w600,
        buttonHeight: FetchPixels.getPixelHeight(60),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14)));
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
        getCustomFont("Không load được dịch vụ!", 20, Colors.black, 1,
            fontWeight: FontWeight.w900, textAlign: TextAlign.center)
      ],
    );
  }

}
