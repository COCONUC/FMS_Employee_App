/*
import 'package:dio/dio.dart';

class ImageServices {

  Future sendImages(orderId) async{
    Dio dio = Dio();
    final response = await dio.post(
      'https://computer-services-api.herokuapp.com/order/upload-img/${orderId}', //your url here
      data: formData,
      options: Options(
          contentType: 'application/form-data',
          headers: {"token": "Bearer ${widget.token}"},
          validateStatus: (status) {
            return status! <= 500;
          }),
    );
  }

}
*/
