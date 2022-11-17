import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/pref_data.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';
import 'package:fms_employee/data/data_file.dart';
import 'package:fms_employee/models/model_cart.dart';
import 'package:fms_employee/models/model_salon.dart';
import 'package:fms_employee/models/order_detail_data.dart';
import 'package:fms_employee/widgets/dialog/service_dialog.dart';
import 'package:flutter/material.dart';
import '../../features/order_service.dart';


class DetailScreen extends StatefulWidget {
  static const String routeName = '/detail_report_screen';
  final int orderId;
  const DetailScreen(this.orderId, {Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  static List<ModelSalon> salonProductLists = DataFile.salonProductList;
  /*List<ModelPopularService> popularServiceLists = DataFile.popularServiceList;*/

  // SharedPreferences? selection;
  var index = 0;

  final TextEditingController descriptionController = TextEditingController();

  getPrefData() async {
    index = await PrefData.getDefIndex();
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    getPrefData();
  }

  var total = 0.00;

  OrderDetailData serviceLists = new OrderDetailData();

  Future<OrderDetailData> getOrderDetailService() async {
    serviceLists = await OrderServices().getOrderDetailById(widget.orderId);
    return serviceLists;
  }


  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    double defSpace = FetchPixels.getDefaultHorSpace(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: defSpace);
    return WillPopScope(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backGroundColor,
          body: SafeArea(
            child: buildPage(edgeInsets, context, index, defSpace),
          ),
        ),
        onWillPop: () async {
          Constant.backToPrev(context);
          return false;
        });
  }

  ListView buildPage(EdgeInsets edgeInsets, BuildContext context, int index,
      double defSpace) {
    return ListView(
      primary: true,
      shrinkWrap: true,
      children: [
        getVerSpace(FetchPixels.getPixelHeight(20)),
        getPaddingWidget(
            edgeInsets,
            gettoolbarMenu(context, "back.svg", () {
              Constant.backToPrev(context);
            },
                title: "Mã đơn: " + widget.orderId.toString() ?? "api: Mã đơn",
                weight: FontWeight.w900,
                textColor: Colors.black,
                fontsize: 24,
                istext: true,
                isrightimage: true,
                rightimage: "more.svg",
                rightFunction: () {})),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        /*getPaddingWidget(edgeInsets, productImage(index)),*/
        getVerSpace(FetchPixels.getPixelHeight(20)),
        getPaddingWidget(edgeInsets, productDescription(context)),
        getVerSpace(FetchPixels.getPixelHeight(29)),
        getPaddingWidget(
            edgeInsets,
            getCustomFont("Dịch vụ: ${buildListView(defSpace).semanticChildCount}", 16, Colors.black, 1,
                fontWeight: FontWeight.w900)),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        viewCartButton(context),
        getVerSpace(FetchPixels.getPixelHeight(15)),
        buildListView(defSpace),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        getPaddingWidget(edgeInsets, totalContainer(),),
        sendOrderButton(context),
        getVerSpace(FetchPixels.getPixelHeight(30))
        // packageList(context)
      ],
    );
  }

  Column productDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCustomFont("Chi tiết đơn hàng", 24, Colors.black, 1,
            fontWeight: FontWeight.w900),
        getVerSpace(FetchPixels.getPixelHeight(17)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                getSvgImage("trash.svg",
                    width: FetchPixels.getPixelHeight(25),
                    height: FetchPixels.getPixelHeight(25)),
                getHorSpace(FetchPixels.getPixelWidth(10)),
                getCustomFont(
                  "*api thợ chụp hình ảnh*",
                  16,
                  Colors.black,
                  1,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            getButton(
                context, Colors.white, "Chụp ảnh", blueColor, () {}, 14,
                weight: FontWeight.w400,
                boxShadow: [
                  const BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0.0, 4.0)),
                ],
                borderRadius:
                BorderRadius.circular(FetchPixels.getPixelHeight(20)),
                buttonHeight: FetchPixels.getPixelHeight(40),
                insetsGeometrypadding: EdgeInsets.symmetric(
                    horizontal: FetchPixels.getPixelWidth(18)))
          ],
        ),
        getVerSpace(FetchPixels.getPixelHeight(24)),
        getMultilineCustomFont(
            "Mô Tả Tình Trạng: ",
            16,
            Colors.black,
            fontWeight: FontWeight.bold,
            txtHeight: 1.3),
        getVerSpace(FetchPixels.getPixelHeight(16)),
        TextFormField(decoration:
          const InputDecoration(hintText:"api thợ nhập vào mô tả"),
        ),
        getVerSpace(FetchPixels.getPixelHeight(4)),
      ],
    );
  }

  // List dịch vụ được employee chọn
  ListView buildListView(double defSpace) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      primary: false,
      itemCount: salonProductLists.length,
      itemBuilder: (context, index) {
        ModelSalon modelSalon = salonProductLists[index];
        return Container(
          margin: EdgeInsets.only(
              bottom: FetchPixels.getPixelHeight(20),
              left: defSpace,
              right: defSpace),
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
              borderRadius: BorderRadius.circular(
                  FetchPixels.getPixelHeight(12))),
          child: Row(
            children: [
              /*packageImage(context, modelSalon),*/
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(
                      left: FetchPixels.getPixelWidth(16)),
                  child: packageDescription(modelSalon),
                ),
              ),
              addButton(modelSalon, context, index)
            ],
          ),
        );
      },
    );
  }

  Widget packageDescription(ModelSalon modelSalon) {
    return FutureBuilder<OrderDetailData>(
      future: getOrderDetailService(),
    builder: (context, snapshot){
    if (!snapshot.hasData) {
    return const Center();
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          getCustomFont(
            'api: service name',
            16,
            Colors.black,
            1,
            fontWeight: FontWeight.w900,
          ),
          getVerSpace(FetchPixels.getPixelHeight(4)),
          getCustomFont('api: category', 14, textColor, 1,
              fontWeight: FontWeight.w400),
          getVerSpace(FetchPixels.getPixelHeight(6)),
          Row(
            children: [
              /*getSvgImage("star.svg",
                height: FetchPixels.getPixelHeight(16),
                width: FetchPixels.getPixelHeight(16)),*/
              getCustomFont(
                "Đơn vị:",
                14,
                Colors.black,
                1,
                fontWeight: FontWeight.w400,
              ),
              getHorSpace(FetchPixels.getPixelWidth(6)),
              getCustomFont(
                "api: đơn vị tính",
                14,
                Colors.black,
                1,
                fontWeight: FontWeight.w400,
              )
            ],
          ),
          getVerSpace(FetchPixels.getPixelHeight(6)),
          getCustomFont('Giá tiền: api: category', 14, textColor, 1,
              fontWeight: FontWeight.w400),
        ],
      );
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
              getCustomFont("Tổng cộng", 24, Colors.black, 1,
                  fontWeight: FontWeight.w900),
              getCustomFont(
                /*"$total VNĐ"*/ "api: Tổng giá tiền",
                24,
                Colors.black,
                1,
                fontWeight: FontWeight.w900,
              )
            ],
          ),
          getVerSpace(FetchPixels.getPixelHeight(30)),
        ],
      ),
    );
  }

  Column addButton(ModelSalon modelSalon, BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (modelSalon.quantity == 0)
          getButton(context, Colors.transparent, "Số lượng", blueColor, () {
            modelSalon.quantity = (modelSalon.quantity! + 1);
            total = total + (modelSalon.price! * 1);
            DataFile.cartList[index.toString()] = ModelCart(
                modelSalon.image,
                modelSalon.name,
                modelSalon.productName,
                modelSalon.rating,
                modelSalon.price,
                modelSalon.quantity);

            setState(() {});
          }, 14,
              weight: FontWeight.w600,
              insetsGeometrypadding: EdgeInsets.symmetric(
                  horizontal: FetchPixels.getPixelWidth(20),
                  vertical: FetchPixels.getPixelHeight(12)),
              borderColor: blueColor,
              borderWidth: 1.5,
              isBorder: true,
              borderRadius:
              BorderRadius.circular(FetchPixels.getPixelHeight(10)))
        else
          Row(
            children: [
              GestureDetector(
                child: getSvgImage("add1.svg",
                    width: FetchPixels.getPixelHeight(30),
                    height: FetchPixels.getPixelHeight(30)),
                onTap: () {
                  modelSalon.quantity = (modelSalon.quantity! + 1);
                  total = total + (modelSalon.price! * 1);

                  DataFile.cartList[index.toString()]!.quantity =
                      modelSalon.quantity;

                  setState(() {});
                },
              ),
              getHorSpace(FetchPixels.getPixelWidth(10)),
              getCustomFont(
                modelSalon.quantity.toString(),
                14,
                Colors.black,
                1,
                fontWeight: FontWeight.w400,
              ),
              getHorSpace(FetchPixels.getPixelWidth(10)),
              GestureDetector(
                child: getSvgImage("minus.svg",
                    width: FetchPixels.getPixelHeight(30),
                    height: FetchPixels.getPixelHeight(30)),
                onTap: () {
                  modelSalon.quantity = (modelSalon.quantity! - 1);
                  total = total - (modelSalon.price! * 1);

                  // print(
                  //     "cartList12===${cartLists.length}===${cartLists[index.toString()]!.quantity}");

                  if (modelSalon.quantity! > 0) {
                    DataFile.cartList[index.toString()]!.quantity =
                        modelSalon.quantity;
                  } else {
                    DataFile.cartList.remove(index.toString());
                  }

                  setState(() {});
                },
              ),
            ],
          ),
        getVerSpace(FetchPixels.getPixelHeight(40)),
        getCustomFont(" Thành tiền: ${modelSalon.price} \VNĐ", 16, blueColor, 1,
            fontWeight: FontWeight.w900)
      ],
    );
  }


  Container packageImage(BuildContext context, ModelSalon modelSalon) {
    return Container(
      height: FetchPixels.getPixelHeight(104),
      width: FetchPixels.getPixelHeight(104),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(10)),
          color: listColor,
          image: getDecorationAssetImage(context, modelSalon.image ?? "")),
    );
  }

  Widget viewCartButton(BuildContext context) {
    return getButton(context, Colors.white, "Thêm dịch vụ", Colors.blue, () {
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
            return const ServiceDialog();
          });
    }, 18,
        weight: FontWeight.w600,
        buttonHeight: FetchPixels.getPixelHeight(40),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14)),
        boxShadow: [
          const BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0.0, 4.0)),
        ],
        insetsGeometry: EdgeInsets.symmetric(
            horizontal: FetchPixels.getDefaultHorSpace(context)));
  }

  Widget sendOrderButton(BuildContext context) {
    return getButton(context, blueColor, "Gửi cho quản lý", Colors.white, () {
      showModalBottomSheet(
          backgroundColor: backGroundColor,
          isDismissible: false,
          isScrollControlled: true,
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(FetchPixels.getPixelHeight(40))
            ),
          ),
          builder: (context) {
            return const ServiceDialog();
          });
    }, 18,
        weight: FontWeight.w600,
        buttonHeight: FetchPixels.getPixelHeight(60),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14)),
        insetsGeometry: EdgeInsets.symmetric(
            horizontal: FetchPixels.getDefaultHorSpace(context)));
  }

  /*Hero productImage(int index) {
    return Hero(
        tag: popularServiceLists[index],
        child: getCircularImage(context, FetchPixels.getPixelWidth(374),
            FetchPixels.getPixelHeight(225), FetchPixels.getPixelHeight(16),
            popularServiceLists[index].image ?? "",boxFit: BoxFit.cover));
        // getAssetImage(popularServiceLists[index].image ?? "",
        // FetchPixels.getPixelWidth(374), FetchPixels.getPixelHeight(225),
        // boxFit: BoxFit.fill),);
  }*/
}
