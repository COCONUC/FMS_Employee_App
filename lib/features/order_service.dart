import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fms_employee/constants/backend_query.dart';
import 'package:fms_employee/models/order_data.dart';
import 'package:fms_employee/models/order_detail_data.dart';
import 'package:fms_employee/models/order_flow_data.dart';
import 'package:fms_employee/models/order_status_data.dart';
import 'package:fms_employee/models/order_with_status_data.dart';
import 'package:fms_employee/models/report_order_data.dart';
import 'package:fms_employee/screens/new_login_screen.dart';
import 'package:http/http.dart' as http;
import '../constants/pref_data.dart';

class OrderServices {
  // lấy ra danh sách order của staff
  Future<List<OrderData>> getOrderListForStaff() async {
    int employeeId = await PrefData.getUserId();
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    try {
      http.Response response = await http.get(
        Uri.parse('${backEndUrl}/employee/ViewAssign/employeeId/$employeeId'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'content-encoding': 'gzip',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed
            .map<OrderData>((json) => OrderData.fromJson(json))
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

  // lấy ra danh sách order của staff với các trạng thái Đang khảo sát, Chờ quản lý xác nhận, Chờ khách hàng xác nhận, Khách hàng đã duyệt
  Future<List<OrderFlowData>> getOrderFlowListForStaff() async {
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    int employeeId = await PrefData.getUserId();
    try {
      http.Response response = await http.get(
        Uri.parse('${backEndUrl}/employee/viewFourOrderStatus/employeeId/$employeeId'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'content-encoding': 'gzip',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed
            .map<OrderFlowData>((json) => OrderFlowData.fromJson(json))
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

  // lấy ra danh sách order với trạng thái phù hợp cho staff
  Future<List<OrderWithStatusData>> getInProcessOrderListForStaff(statusId, context) async {
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    int employeeId = await PrefData.getUserId();
    try {
      http.Response response = await http.get(
        Uri.parse('${backEndUrl}/employee/viewOrderStatus/employeeId/$employeeId/orderWorkingStatus/$statusId'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'content-encoding': 'gzip',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200) {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        return parsed
            .map<OrderWithStatusData>((json) => OrderWithStatusData.fromJson(json))
            .toList();
      } else {
        AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.WARNING,
          title: 'Hết phiên đăng nhập',
          desc: 'Vui lòng đăng nhập lại',
          dismissOnTouchOutside: false,
          /*btnOkOnPress: () { AuthService().logOut(context);},*/
          btnOkOnPress: () { Navigator.of(context).pushReplacementNamed(NewLoginScreen.routeName);},
        ).show();
        throw Exception('Lấy dữ liệu thất bại');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  // Lấy thông tin của một đơn hàng khi ấn vào dựa theo OrderID
  Future<OrderDetailData> getOrderDetailById(orderId) async {
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    final response = await http.get(
      Uri.parse(
          '$backEndUrl/employee/getorderdetailbyemployee/order/$orderId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final parsed = OrderDetailData.fromJson(json.decode(response.body));
      return parsed;
    } else {
      throw('Dữ liệu lỗi');
    }
  }

//Gửi đơn khảo sát lên cho quản lý
  Future<void> sendReportOrder(orderId, ReportOrder service) async{
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    try{
      final response = await http.put(
        Uri.parse(
            '$backEndUrl/report_order_assigned/$orderId'),
        headers: <String, String>{
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(service.toJson())

      );
      if(response.statusCode == 200){

      } else{

      }
    } catch (e){
      throw Exception(e);
    }
  }

  //Thay đổi trạng thái đơn hàng dựa theo Id của đơn để thay đổi statusId
  Future<void> changeOrderStatus(orderId, ChangeOrderStatusData statusId) async{
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    try{
      final response = await http.put(
          Uri.parse(
              '$backEndUrl/employee/update_order_status_by_id/$orderId'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(statusId.toJson())
      );
      print(response.statusCode);
      print(response.body);
      if(response.statusCode == 200){

      } else{

      }
    } catch (e){
      throw Exception(e);
    }
  }

  //Xóa dịch vụ trong đơn khảo sát
  Future<bool> deleteServiceInOrder(orderId, orderServiceId) async{
    String? token = await const FlutterSecureStorage().read(key: 'accessToken');
    final response = await http.delete(
      Uri.parse('$backEndUrl/employee/deleteServiceInOrder/$orderId/orderServiceId/$orderServiceId'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
        'Content-Type': 'text/plain; charset=UTF-8',
      },
    );
    if(response.statusCode == 200){
     return true;
    }else{
      return false;
    }
  }

}
