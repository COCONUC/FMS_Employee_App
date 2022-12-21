import 'dart:convert';
import 'package:fms_employee/constants/backend_query.dart';
import 'package:fms_employee/models/order_data.dart';
import 'package:fms_employee/models/order_detail_data.dart';
import 'package:fms_employee/models/order_with_status_data.dart';
import 'package:fms_employee/models/report_order_data.dart';
import 'package:http/http.dart' as http;

class OrderServices {
  // lấy ra danh sách order của staff
  Future<List<OrderData>> getOrderListForStaff(employeeId) async {
    try {
      http.Response response = await http.get(
        Uri.parse('${backEndUrl}/employee/ViewAssign/employeeId/$employeeId'),
        headers: <String, String>{
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

  // lấy ra danh sách order với trạng thái phù hợp cho staff
  Future<List<OrderWithStatusData>> getInProcessOrderListForStaff(employeeId, statusId) async {
    try {
      http.Response response = await http.get(
        Uri.parse('${backEndUrl}/employee/viewOrderStatus/employeeId/$employeeId/orderWorkingStatus/$statusId'),
        headers: <String, String>{
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

  // Lấy thông tin của một đơn hàng khi ấn vào dựa theo OrderID
  Future<OrderDetailData> getOrderDetailById(orderId) async {
    final response = await http.get(
      Uri.parse(
          '$backEndUrl/employee/getorderdetailbyemployee/order/$orderId'),
      headers: <String, String>{
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

//
  Future<void> sendReportOrder(orderId, ReportOrder service) async{
    try{
      final response = await http.put(
        Uri.parse(
            '$backEndUrl/report_order_assigned/$orderId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(service.toJson())

      );
      if(response.statusCode == 200){
        print("Gửi thành công");
      } else{
        print("gửi không thành công");
        print(response.body);
      }
    } catch (e){
      throw Exception(e);
    }

  }

}
