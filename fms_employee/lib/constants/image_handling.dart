import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';

class ImagePickerHandling {

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
        /*setState(() {});*/
      }
    } catch (e) {
      throw Exception(e);
    }
  }


  Future<String> submitImage() async {

    List<MultipartFile> multipartImageList = <MultipartFile>[];
    for (XFile image in imageFiles!) {
      MultipartFile multipartFile = await MultipartFile.fromFile(image.path,
          contentType: MediaType('image', 'png'));

      multipartImageList.add(multipartFile);
    }
    FormData formData = FormData.fromMap({
      "img": multipartImageList,
    });
    return 'submitImage';
  }
}
