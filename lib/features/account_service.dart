import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fms_employee/constants/backend_query.dart';
import 'package:fms_employee/constants/pref_data.dart';
import 'package:http/http.dart' as http;
import 'package:fms_employee/models/account_data.dart';

class AccountServices {
  // Lấy thông tin của một employee dựa vào employeeId
  Future<AccountData> getAccountDataByEmployeeId() async {
    int employeeId = await PrefData.getUserId();
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    final response = await http.get(
      Uri.parse(
          '$backEndUrl/$employeeId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
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
