import 'dart:convert';
import 'package:fms_employee/models/service_data.dart';
import 'package:http/http.dart' as http;
import '../constants/backend_querry.dart';

class ServiceServices {

  // lấy ra danh sách dịch vụ
  Future<List<ServiceData>> getServiceListForStaff() async {
    try {
      http.Response response = await http.get(
        Uri.parse('${backEndUrl}/getAllService'),
        headers: <String, String>{
          'content-encoding': 'gzip',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed
            .map<ServiceData>((json) => ServiceData.fromJson(json))
            .toList();
      } else {
        /*AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.WARNING,
          title: 'Hết phiên đăng nhập',
          desc: 'Vui lòng đăng nhập lại',
          dismissOnTouchOutside: false,
          btnOkOnPress: () { AuthService().logOut(context);},
        ).show();*/
        throw Exception('Lấy dữ liệu thất bại');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

}
