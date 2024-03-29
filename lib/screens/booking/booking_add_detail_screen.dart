import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';
import 'package:fms_employee/models/model_salon.dart';
import 'package:fms_employee/models/order_detail_data.dart';
import 'package:fms_employee/models/report_order_data.dart';
import 'package:fms_employee/screens/booking/detail/manager_order.dart';
import 'package:fms_employee/widgets/dialog/delete_dialog.dart';
import 'package:fms_employee/widgets/dialog/service_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fms_employee/widgets/dialog/service_dialog_temp.dart';
import 'package:fms_employee/widgets/show_image.dart';
import '../../features/order_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class DetailEditingScreen extends StatefulWidget {
  static const String routeName = '/detail_editing_screen';
  final int orderId;
  final OrderDetailData _data;
  final String img;
  const DetailEditingScreen(this.orderId, this._data, this.img, {Key? key}) : super(key: key);

  @override
  State<DetailEditingScreen> createState() => _DetailEditingScreenState();
}

class _DetailEditingScreenState extends State<DetailEditingScreen> {
  // SharedPreferences? selection;
  //var index = 0;

  List<String> imgPath = ['https://firebasestorage.googleapis.com/v0/b/fms-firebase-storage.appspot.com/o/image2022-12-03%2017%3A45%3A20.601076?alt=media&token=77724f45-bb52-44ee-9c0e-ae7de8d5ffe7'
    ,'https://firebasestorage.googleapis.com/v0/b/fms-firebase-storage.appspot.com/o/damaged-furniture.jpg?alt=media&token=6b1f1b31-8d04-4826-a2d4-49f655a3422d'
    ,'https://firebasestorage.googleapis.com/v0/b/fms-firebase-storage.appspot.com/o/istockphoto-898281526-612x612.jpg?alt=media&token=7c4ca68a-56cb-4033-95ea-a1c01209a1a5'];

  final oCcy = new NumberFormat("#,###", "vi_VI");

  final TextEditingController descriptionController = TextEditingController();

  final ImagePicker imgPicker = ImagePicker();

  late List<String> listImages = [];

  List<XFile>? imageFiles;
  bool isLoading = false;

  openImages() async {
    try {
      var pickedFiles =
      await imgPicker.pickMultiImage(maxWidth: 1024, maxHeight: 1024);
      //you can use ImageCourse.camera for Camera capture
      if (imageFiles == null) {
        imageFiles = pickedFiles;
      } else {
        imageFiles!.addAll(pickedFiles);
      }
      setState(() {});
    } catch (e) {
      throw Exception(e);
    }
  }

  List<String> firebaseURLs =[];
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;

  Future uploadFile() async{
    await FirebaseAuth.instance.signInAnonymously();
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      for(var img in imageFiles!){
        final imgPath = img.path; //Getting the path of XFile
        File file = File(imgPath);
        String url;
        Reference ref = storage.ref().child("image${DateTime.now()}");
        UploadTask uploadTask = ref.putFile(file);
        uploadTask.whenComplete(() async{
          firebaseURLs.add(await ref.getDownloadURL());
        }).catchError((onError) {
          print(onError);
        });
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.${e.message}");
      }
    }
  }

  getPrefData() async {
    //index = await PrefData.getDefIndex();
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    getPrefData();
    reportOrder.orderId = widget.orderId;
    data = widget._data;
  }

  OrderDetailData data =  OrderDetailData();

  var total = 0.00;

  @override
  Widget build(BuildContext context) {
    FetchPixels(context);
    double defSpace = FetchPixels.getDefaultHorSpace(context);
    EdgeInsets edgeInsets = EdgeInsets.symmetric(horizontal: defSpace);
    return WillPopScope(
        child: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);

            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: backGroundColor,
            floatingActionButton: floatingSendOrderButton(context),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            body: SafeArea(
              child: buildPage(edgeInsets, context, 0, defSpace),
            ),
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
                title: "Mã đơn: ${widget.orderId}",
                weight: FontWeight.w900,
                textColor: Colors.black,
                fontsize: 24,
                istext: true,
                isrightimage: false,
                rightimage: "more.svg",
                rightFunction: () {})),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        Center(
          child: getCustomFont("Đang khảo sát", 16, success, 1, fontWeight: FontWeight.w600)
        ),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        /*getPaddingWidget(edgeInsets, productImage(index)),*/
        getVerSpace(FetchPixels.getPixelHeight(20)),
        getPaddingWidget(edgeInsets, productDescription(context)),
        getVerSpace(FetchPixels.getPixelHeight(29)),
        /*getPaddingWidget(
            edgeInsets,
            getCustomFont("Dịch vụ: ${buildListView(defSpace).semanticChildCount}", 16, Colors.black, 1,
                fontWeight: FontWeight.w900)),*/
        getPaddingWidget(
            edgeInsets,
            getCustomFont("Dịch vụ: ", 16, Colors.black, 1,
                fontWeight: FontWeight.w900)),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        /*addServiceButton(context),*/
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
            ),
            onPressed:  getNewService,
            child: const Text("Cập nhật dịch vụ", style: TextStyle(
              color: Colors.blue,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),),
          ),
        ),
        getVerSpace(FetchPixels.getPixelHeight(15)),
        buildListView(defSpace),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        getPaddingWidget(edgeInsets, totalContainer(),),
        getVerSpace(FetchPixels.getPixelHeight(60))
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
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getCustomFont("Ảnh hiện trạng:", 16, Colors.black, 1),
            /*getButton(
                context, Colors.white, "Lưu ảnh", blueColor, ()
            {
              uploadFile();
            },
                14,
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
                    horizontal: FetchPixels.getPixelWidth(18))
            ),*/
            getButton(
                context, Colors.white, "Thêm ảnh", blueColor, () {
              openImages();
            }, 14,
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
                    ]
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: TextButton(onPressed: () =>  Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ShowImage(id: widget.orderId, imgURL: imgPath))),
                child: getCustomFont(
                  "Nhấn vào link để xem ảnh",
                  18,
                  Colors.blueAccent,
                  1,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            /*getVerSpace(FetchPixels.getPixelHeight(12)),*/
            Row(
              children: [
                getHorSpace(FetchPixels.getPixelWidth(10)),
                   Container(
                   /* height: FetchPixels.getPixelHeight(100),
                    width: FetchPixels.getPixelHeight(100),*/
                     padding: const EdgeInsets.all(20),
                   /* decoration: BoxDecoration(
                        image: getDecorationNetworkImage(context,'/v0/b/fms-firebase-storage.appspot.com/o/image2022-12-03%2017%3A45%3A20.601076?alt=media&token=77724f45-bb52-44ee-9c0e-ae7de8d5ffe7')
                    ),*/
                     child: Row(
                         children: [
                     const Divider(),
                     listImages != [] ? Wrap(
                       children: listImages.map((imageOne) {
                         return Card(
                           child: Container(
                             constraints: const BoxConstraints.tightFor(
                               height: 100,
                               width: 100,
                             ),
                             decoration: BoxDecoration(
                               image: DecorationImage(
                                 image: NetworkImage(imageOne),
                                 fit: BoxFit.cover,
                               ),
                             ),
                             child: Stack(children: [
                               Positioned(
                                   right: 0.0,
                                   top: 0.0,
                                   child: InkWell(
                                     child: const Icon(Icons.close),
                                     onTap: () {
                                       listImages.remove(imageOne);
                                       setState(() {
                                         imageFiles;
                                       });
                                     },
                                   ))
                             ]),
                           ),
                         );
                       }).toList(),
                     ) : Container(),
    ]
    ),
                  ),

              ],
            )
          ],
        ),
        /*getVerSpace(FetchPixels.getPixelHeight(10)),*/
        getMultilineCustomFont(
            "Mô Tả Tình Trạng: ",
            16,
            Colors.black,
            fontWeight: FontWeight.bold,
            txtHeight: 1.3),
        TextFormField(decoration:
          const InputDecoration(hintText:"Mô tả ngắn gọn tình trạng hư hỏng", hintStyle: TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
          controller: descriptionController,
        ),
      ],
    );
  }

  OrderDetailData serviceLists = OrderDetailData();



  // List dịch vụ được employee chọn
  Widget buildListView(double defSpace) {
      return data.listOrderServiceDto!.isNotEmpty?
      ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        primary: false,
        itemCount: data.listOrderServiceDto!.length,
        itemBuilder: (context, index) {
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
                    child: packageDescription(index),
                  ),
                ),
              ],
            ),
          );
        },
      ) : nullServiceView();
    }


  Widget packageDescription(index) {
      return  Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: FetchPixels.getPixelWidth(150),
                child: getCustomFont(
                data.listOrderServiceDto![index].serviceName ?? ' ',
                16,
                Colors.black,
                2,
                fontWeight: FontWeight.w900,
              ),),
          getVerSpace(FetchPixels.getPixelHeight(4)),
          getCustomFont( data.listOrderServiceDto![index].categoryName ?? ' ', 14, textColor, 1,
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
                textColor,
                1,
                fontWeight: FontWeight.w400,
              ),
              getHorSpace(FetchPixels.getPixelWidth(6)),
              getCustomFont(
                " ",
                14,
                textColor,
                1,
                fontWeight: FontWeight.w400,
              )
            ],
          ),
          getVerSpace(FetchPixels.getPixelHeight(6)),
          getCustomFont("Số lượng: ${data.listOrderServiceDto![index].quantity}" , 14, Colors.black, 1,
              fontWeight: FontWeight.w400),
          getVerSpace(FetchPixels.getPixelHeight(6)),
          getCustomFont("${oCcy.format(int.parse(data.listOrderServiceDto![index].price!))} vnđ", 14, Colors.black, 1,
              fontWeight: FontWeight.w400),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          barrierDismissible: false,
                          builder: (context) {
                            return DeleteDialog("Xóa dịch vụ này?", " ", widget.orderId, data.listOrderServiceDto![index]);
                          },
                          context: context).then((value) {
                            if(value == true){
                              data.listOrderServiceDto!.removeAt(index);
                              setState(() {
                              });
                            }
                            else{
                              //show dialog
                            }
                          });
                    },
                    child: getSvgImage("trash.svg",color: Colors.deepOrange,
                        width: FetchPixels.getPixelHeight(25),
                        height: FetchPixels.getPixelHeight(25)),
                  )
                ],
              ),
              getVerSpace(FetchPixels.getPixelHeight(70)),
              getCustomFont("Thành tiền: ${oCcy.format(data.listOrderServiceDto![index].quantity! * int.parse(data.listOrderServiceDto![index].price!))} VNĐ", 14, blueColor, 1,
                  fontWeight: FontWeight.w900)
            ],
          ),
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

  final ReportOrder reportOrder = ReportOrder(statusId: 2,listEmployeeCreateOrderImageListDto: [], listService: []);

  void getNewService() async {
    List<ListOrderServiceDto> result = await Navigator.push(context, MaterialPageRoute(builder: (_) => ServiceDialogTemp(data!.listOrderServiceDto)));
    if(result != null){
       for(var element in result){
         // kiem tra xem service da ton tai trong list chua?
         // neu ton tai thi chi thay doi quantity, khong thi add vao _reportOrder va data
         if(!data.listOrderServiceDto!.any((e) => e.serviceId == element.serviceId)) {

           data.listOrderServiceDto?.add(
              element
           );


         }
         else{
           data.listOrderServiceDto!.firstWhere((e) => e.serviceId == element.serviceId).quantity = element.quantity;
         }
       }

       setState(() {

       });

      }
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

  Widget floatingSendOrderButton(BuildContext context){
    return SizedBox(
      height: FetchPixels.getPixelHeight(50),
      width: FetchPixels.getPixelWidth(370),
      child: FloatingActionButton(
        backgroundColor: mBlueColor,
        shape: const RoundedRectangleBorder(),
        onPressed: () {
          reportOrder.description = descriptionController.text;
          reportOrder.orderId = widget.orderId;
          reportOrder.statusId = 2;
          reportOrder.listEmployeeCreateOrderImageListDto?.add(
              ListEmployeeCreateOrderImageListDto(
                  orderId: widget.orderId,
                imageUrl: widget.img ?? 'url',
                  status: true
              )
          );
          for(var e in data!.listOrderServiceDto!){
            reportOrder.listService?.add(ListService(serviceId: e.serviceId, quantity: e.quantity));
          }
          OrderServices().sendReportOrder(widget.orderId, reportOrder).whenComplete(() => Constant.sendToScreen(ManagerOrderDetail(widget.img, widget.orderId), context));
        },
        child: const Text("Xác nhận", style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          /* fontWeight: FontWeight.w600,*/
        ),),
      ),
    );
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

  Widget nullServiceView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        getSvgImage("booking_null.svg",
            height: FetchPixels.getPixelHeight(110),
            width: FetchPixels.getPixelHeight(84)),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        getCustomFont("Chưa Có Dịch Vụ Được Chọn.", 18, Colors.black, 1,
            fontWeight: FontWeight.w900, textAlign: TextAlign.center),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        getCustomFont(
          "Vui lòng chọn dịch vụ sau khi khảo sát !",
          14,
          Colors.black,
          2,
          fontWeight: FontWeight.w400,
        ),
        getVerSpace(FetchPixels.getPixelHeight(30)),
        /*getButton(context, backGroundColor, "Tải lại dữ liệu", blueColor, () {
          setState(() {
            *//*schedule = true;*//*
          });
        }, 18,
            weight: FontWeight.w600,
            buttonHeight: FetchPixels.getPixelHeight(60),
            insetsGeometry: EdgeInsets.symmetric(
                horizontal: FetchPixels.getPixelWidth(98)),
            borderRadius:
            BorderRadius.circular(FetchPixels.getPixelHeight(14)),
            isBorder: true,
            borderColor: blueColor,
            borderWidth: 1.5)*/
      ],
    );
  }

}
