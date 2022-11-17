import 'dart:convert';
import 'package:fms_employee/constants/backend_querry.dart';
import 'package:http/http.dart' as http;
import 'package:fms_employee/models/account_data.dart';

class AccountServices {
  // Lấy thông tin của một employee dựa vào employeeId
  Future<AccountData> getAccountDataByEmployeeId(employeeId) async {
    final response = await http.get(
      Uri.parse(
          '$backEndUrl/$employeeId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final parsed = AccountData.fromJson(json.decode(response.body));
      return parsed;
    } else {
      throw ('Dữ liệu lỗi');
    }
  }
}
