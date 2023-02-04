import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fms_employee/constants/color_constant.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ShowImage extends StatefulWidget {
  const ShowImage({Key? key,required this.id, /*required this.token,*/ this.imgURL}) : super(key: key);
  /*final String? token;*/
  final int? id;
  final List<String>? imgURL;

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {

  final ImagePicker imgPicker = ImagePicker();
  List<XFile>? imageFiles;
  bool isLoading = false;

  openImages() async {
    try {
      var pickedFiles =
      await imgPicker.pickMultiImage(maxWidth: 1024, maxHeight: 1024);
      //you can use ImageCourse.camera for Camera capture
      if (pickedFiles != null) {
        if (imageFiles == null) {
          imageFiles = pickedFiles;
        } else {
          imageFiles!.addAll(pickedFiles);
        }
        setState(() {});
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /*Future<String> submitImage() async {
    setState(() {
      isLoading = true;
    });
    List<MultipartFile> multipartImageList = <MultipartFile>[];
    for (XFile image in imageFiles!) {
      MultipartFile multipartFile = await   MultipartFile.fromFile(image.path,contentType: MediaType('image','png'));

      multipartImageList.add(multipartFile);
    }
    FormData formData = FormData.fromMap({
      "img": multipartImageList,

    });

    Dio dio = Dio();
    final response = await dio.post(
      'https://computer-services-api.herokuapp.com/order/upload-img/${widget.id}', //your url here
      data: formData,
      options: Options(
          contentType: 'application/form-data',
          headers: {"token": "Bearer ${widget.token}"},
          validateStatus: (status) {
            return status! <= 500;
          }),
    );
    setState(() {
      isLoading = true;
    });
    if(response.statusCode ==200){
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.SUCCES,
        title: 'Lưu thành công',
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
          Navigator.pop(context);
        },
      ).show();
    }else {
      AwesomeDialog(
        context: context,
        animType: AnimType.SCALE,
        dialogType: DialogType.ERROR,
        title: 'Lỗi',
        dismissOnTouchOutside: false,
        btnOkOnPress: () {
        },
      ).show();
    }
    return "SENT";
  }*/


  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      opacity: 0.5,
      color: Colors.black12.withOpacity(0.3),
      progressIndicator: const CircularProgressIndicator(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            elevation: 0.0,
            backgroundColor: blueColor,
            title: const Text(
              "Ảnh hiện trạng",
              style: TextStyle(
                fontSize: 23,
              ),
            ),
            centerTitle: true,
          ),
        ),
        body: Container(
          color: backGroundColor,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text("Ảnh đã lưu:"),
              const Divider(),
              widget.imgURL != [] ? Wrap(
                children: widget.imgURL!.map((imageOne) {
                  return Card(
                    child: FullScreenWidget(
                      child: Container(
                        constraints: const BoxConstraints.tightFor(
                          height: 150,
                          width: 150,
                        ),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(imageOne),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ) : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
