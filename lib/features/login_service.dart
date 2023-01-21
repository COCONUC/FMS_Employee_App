import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fms_employee/constants/backend_query.dart';
import 'package:fms_employee/constants/pref_data.dart';
import 'package:fms_employee/models/auth_data.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class LoginServices {

  Future<http.Response> loginCustomer(String username, String password) async {
    final response = await http.post(
        Uri.parse('$backEndUrl/api/account/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "username": username,
          "password": password
        })
    );
    if (response.statusCode == 200) {
      PrefData.setLogIn(true);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('userAuth', response.body.toString());
      PrefData.setUserId(AuthModel.fromJson(jsonDecode(response.body.toString())).userLoginBasicInformationDto!.userId!);
      const FlutterSecureStorage().write(key: 'accessToken', value: AuthModel
          .fromJson(jsonDecode(response.body.toString()))
          .accessToken);
      const FlutterSecureStorage().write(key: 'refreshToken', value: AuthModel
          .fromJson(jsonDecode(response.body.toString()))
          .refreshToken);
      return response;
    } else {
      return response;
    }
  }

  Future<bool> logoutCustomer(int accountId) async {
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    final response = await http.put(
      Uri.parse('$backEndUrl/api/account/logout/accountId/$accountId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      PrefData.setLogIn(false);
      const FlutterSecureStorage().deleteAll();
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      return true;
    } else {
      throw Exception('Lấy dữ liệu thất bại');
    }
  }

}
