
class OrderData {
  int? orderId;
  int? customerId;
  int? workingStatusId;
  String? statusName;
  String? address;
  String? customerPhone;
  String? customerName;

  OrderData({this.orderId, this.customerId, this.workingStatusId, this.statusName, this.address, this.customerPhone, this.customerName});

  OrderData.fromJson(Map<String, dynamic> json) {
    orderId = json["orderId"];
    customerId = json["customerId"];
    workingStatusId = json["workingStatusId"];
    statusName = json["statusName"];
    address = json["address"];
    customerPhone = json["customerPhone"];
    customerName = json["customerName"];
  }

  static List<OrderData> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => OrderData.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["orderId"] = orderId;
    _data["customerId"] = customerId;
    _data["workingStatusId"] = workingStatusId;
    _data["statusName"] = statusName;
    _data["address"] = address;
    _data["customerPhone"] = customerPhone;
    _data["customerName"] = customerName;
    return _data;
  }
}