import 'package:fms_employee/models/day_off_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fms_employee/constants/backend_query.dart';

class DayOffServices{

// lấy ra danh sách ngày nghỉ của staff
Future<List<DayOffData>> getDateOffListOfStaff(employeeId) async {
  try {
    http.Response response = await http.get(
      Uri.parse('${backEndUrl}/employee/getAllDayOffbyEmployeeId/employeeId/$employeeId'),
      headers: <String, String>{
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

}