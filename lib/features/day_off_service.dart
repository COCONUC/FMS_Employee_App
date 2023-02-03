import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fms_employee/models/day_off_data.dart';
import 'package:fms_employee/models/day_off_register_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fms_employee/constants/backend_query.dart';

import '../constants/pref_data.dart';

class DayOffServices{

// lấy ra danh sách ngày nghỉ của staff
Future<List<DayOffData>> getDateOffListOfStaff() async {
  String? token = await const FlutterSecureStorage().read(key: 'accessToken');
  int employeeId = await PrefData.getUserId();
  try {
    http.Response response = await http.get(
      Uri.parse('$backEndUrl/employee/getAllDayOffbyEmployeeId/employeeId/$employeeId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'content-encoding': 'gzip',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<DayOffData>((json) => DayOffData.fromJson(json))
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

//Gửi yêu cầu đăng ký ngày nghỉ
Future<void> sendDayOffForm(DayOffRegisterData data) async{
  String? token = await const FlutterSecureStorage().read(key: 'accessToken');
  try{
    final response = await http.post(
        Uri.parse(
            '$backEndUrl/employee/employeeCreateFormForAbsent'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data.toJson())
    );
    if(response.statusCode == 200){
      /*print("Gửi thành công");*/
    } else{
     /* print("gửi không thành công");
      print(response.body);*/
    }
  } catch (e){
    throw Exception(e);
  }

}

}