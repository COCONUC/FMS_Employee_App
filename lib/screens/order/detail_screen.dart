
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:fms_employee/constants/constant.dart';
import 'package:fms_employee/constants/pref_data.dart';
import 'package:fms_employee/constants/resizer/fetch_pixels.dart';
import 'package:fms_employee/constants/widget_utils.dart';
import 'package:fms_employee/data/data_file.dart';
import 'package:fms_employee/models/model_cart.dart';
import 'package:fms_employee/models/model_popular_service.dart';
import 'package:fms_employee/models/model_salon.dart';
import 'package:fms_employee/widgets/dialog/color_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;


class DetailScreen extends StatefulWidget {
  static const String routeName = '/detail_screen';
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  static List<ModelSalon> salonProductLists = DataFile.salonProductList;
  List<ModelPopularService> popularServiceLists = DataFile.popularServiceList;

  // SharedPreferences? selection;
  var index = 0;

  final ImagePicker imgPicker = ImagePicker();
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

  getPrefData() async {
    index = await PrefData.getDefIndex();
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    getPrefData();
    //imgRef = FirebaseFirestore.instance.collection('imageURLs');
  }

  var total = 0.00;


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
                title: "Mã Đơn Hàng",
                weight: FontWeight.w900,
                textColor: Colors.black,
                fontsize: 24,
                istext: true,
                isrightimage: true,
                rightimage: "more.svg",
                rightFunction: () {})),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        getPaddingWidget(edgeInsets, productImage(index)),
        getVerSpace(FetchPixels.getPixelHeight(20)),
        getPaddingWidget(edgeInsets, productDescription(context)),
        getVerSpace(FetchPixels.getPixelHeight(29)),
        getPaddingWidget(
            edgeInsets,
            getCustomFont("Dịch vụ:", 16, Colors.black, 1,
                fontWeight: FontWeight.w900)),
        getVerSpace(FetchPixels.getPixelHeight(15)),
        buildListView(defSpace),
        getVerSpace(FetchPixels.getPixelHeight(10)),
        getPaddingWidget(edgeInsets, totalContainer(),),
        viewCartButton(context),
        getVerSpace(FetchPixels.getPixelHeight(30))
        // packageList(context)
      ],
    );
  }

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
              packageImage(context, modelSalon),
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

  // Expanded packageList(BuildContext context) {
  //   return Expanded(
  //     child: SingleChildScrollView(
  //       physics: const BouncingScrollPhysics(),
  //       child: ConstrainedBox(
  //         constraints: const BoxConstraints(),
  //         child: Column(
  //           children: [
  //             ListView.builder(
  //               shrinkWrap: true,
  //               physics: const BouncingScrollPhysics(),
  //               padding: EdgeInsets.zero,
  //               scrollDirection: Axis.vertical,
  //               itemCount: salonProductLists.length,
  //               itemBuilder: (context, index) {
  //                 ModelSalon modelSalon = salonProductLists[index];
  //                 return Container(
  //                   margin:
  //                       EdgeInsets.only(bottom: FetchPixels.getPixelHeight(20)),
  //                   width: FetchPixels.getPixelWidth(374),
  //                   padding: EdgeInsets.only(
  //                       left: FetchPixels.getPixelWidth(16),
  //                       right: FetchPixels.getPixelWidth(16),
  //                       top: FetchPixels.getPixelHeight(16),
  //                       bottom: FetchPixels.getPixelHeight(16)),
  //                   decoration: BoxDecoration(
  //                       color: Colors.white,
  //                       boxShadow: const [
  //                         BoxShadow(
  //                             color: Colors.black12,
  //                             blurRadius: 10,
  //                             offset: Offset(0.0, 4.0)),
  //                       ],
  //                       borderRadius: BorderRadius.circular(
  //                           FetchPixels.getPixelHeight(12))),
  //                   child: Row(
  //                     children: [
  //                       packageImage(context, modelSalon),
  //                       Expanded(
  //                         child: Container(
  //                           padding: EdgeInsets.only(
  //                               left: FetchPixels.getPixelWidth(16)),
  //                           child: packageDescription(modelSalon),
  //                         ),
  //                       ),
  //                       addButton(modelSalon, context, index)
  //                     ],
  //                   ),
  //                 );
  //               },
  //             ),
  //             getVerSpace(FetchPixels.getPixelHeight(10)),
  //             totalContainer(),
  //             viewCartButton(context),
  //             getVerSpace(FetchPixels.getPixelHeight(30))
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget viewCartButton(BuildContext context) {
    return getButton(context, blueColor, "Thêm dịch vụ", Colors.white, () {
      showModalBottomSheet(
          backgroundColor: backGroundColor,
          isDismissible: false,
          isScrollControlled: true,
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(FetchPixels.getPixelHeight(40)),
            ),
          ),
          builder: (context) {
            return const ColorDialog();
          });
    }, 18,
        weight: FontWeight.w600,
        buttonHeight: FetchPixels.getPixelHeight(60),
        borderRadius: BorderRadius.circular(FetchPixels.getPixelHeight(14)),
        insetsGeometry: EdgeInsets.symmetric(
            horizontal: FetchPixels.getDefaultHorSpace(context)));
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
              getCustomFont(
                "\$$total",
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
          getButton(context, Colors.transparent, "Add", blueColor, () {
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
        getCustomFont("\$${modelSalon.price}", 16, blueColor, 1,
            fontWeight: FontWeight.w900)
      ],
    );
  }

  Column packageDescription(ModelSalon modelSalon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCustomFont(
          modelSalon.name ?? '',
          16,
          Colors.black,
          1,
          fontWeight: FontWeight.w900,
        ),
        getVerSpace(FetchPixels.getPixelHeight(4)),
        getCustomFont(modelSalon.productName ?? "", 14, textColor, 1,
            fontWeight: FontWeight.w400),
        getVerSpace(FetchPixels.getPixelHeight(6)),
        Row(
          children: [
            getSvgImage("star.svg",
                height: FetchPixels.getPixelHeight(16),
                width: FetchPixels.getPixelHeight(16)),
            getHorSpace(FetchPixels.getPixelWidth(6)),
            getCustomFont(
              modelSalon.rating ?? "",
              14,
              Colors.black,
              1,
              fontWeight: FontWeight.w400,
            )
          ],
        )
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

  late CollectionReference imgRef;
  late firebase_storage.Reference ref;
  Future uploadFile() async{
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      for(var img in imageFiles!){
        final imgPath = img.path; //Getting the path of XFile
        File file = File(imgPath);
        String url;
        Reference ref = storage.ref().child("image${DateTime.now()}");
        UploadTask uploadTask = ref.putFile(file);
        uploadTask.whenComplete(() async{
          url = await ref.getDownloadURL();
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


  Column productDescription(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        getCustomFont("Chi tiết đơn hàng", 24, Colors.black, 1,
            fontWeight: FontWeight.w900),
        getVerSpace(FetchPixels.getPixelHeight(17)),
        imageFiles != null ?
        Wrap(
          children: imageFiles!.map((imageOne) {
            return Card(
              child: Container(
                constraints: const BoxConstraints.tightFor(
                  height: 120,
                  width: 80,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(imageOne.path)),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(children: [
                  Positioned(
                    right: 0.0,
                    top: 0.0,
                    child: InkWell(
                      child: const Icon(Icons.close_sharp),
                      onTap: () {
                        imageFiles!.remove(imageOne);
                        setState(() {
                          imageFiles;
                        });
                      },
                    ),),
                ]),
              ),
            );
          }).toList(),
        ): Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                getSvgImage("star.svg",
                    width: FetchPixels.getPixelHeight(25),
                    height: FetchPixels.getPixelHeight(25)),
                getHorSpace(FetchPixels.getPixelWidth(10)),
                getCustomFont(
                  "*hình ảnh*",
                  16,
                  Colors.black,
                  1,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
            getButton(
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
            ),
            getButton(
                context, Colors.white, "Chụp ảnh hiện trạng", blueColor, ()
                  {
                    openImages();
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
            )
          ],
        ),
        getVerSpace(FetchPixels.getPixelHeight(24)),
        getMultilineCustomFont(
            "Mô tả tình trạng hư hỏng",
            16,
            Colors.black,
            fontWeight: FontWeight.w400,
            txtHeight: 1.3),
      ],
    );
  }

  Hero productImage(int index) {
    return Hero(
        tag: popularServiceLists[index],
        child: getCircularImage(context, FetchPixels.getPixelWidth(374),
            FetchPixels.getPixelHeight(225), FetchPixels.getPixelHeight(16),
            popularServiceLists[index].image ?? "",boxFit: BoxFit.cover));
        // getAssetImage(popularServiceLists[index].image ?? "",
        // FetchPixels.getPixelWidth(374), FetchPixels.getPixelHeight(225),
        // boxFit: BoxFit.fill),);
  }
}
