
class OrderWithStatusData {
  int? orderId;
  String? totalPrice;
  int? customerId;
  int? workingStatusId;
  String? statusName;
  String? address;
  String? customerPhone;
  String? customerName;

  OrderWithStatusData({this.orderId, this.totalPrice, this.customerId, this.workingStatusId, this.statusName, this.address, this.customerPhone, this.customerName});

  OrderWithStatusData.fromJson(Map<String, dynamic> json) {
    orderId = json["orderId"];
    totalPrice = json["totalPrice"];
    customerId = json["customerId"];
    workingStatusId = json["workingStatusId"];
    statusName = json["statusName"];
    address = json["address"];
    customerPhone = json["customerPhone"];
    customerName = json["customerName"];
  }

  static List<OrderWithStatusData> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => OrderWithStatusData.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["orderId"] = orderId;
    _data["totalPrice"] = totalPrice;
    _data["customerId"] = customerId;
    _data["workingStatusId"] = workingStatusId;
    _data["statusName"] = statusName;
    _data["address"] = address;
    _data["customerPhone"] = customerPhone;
    _data["customerName"] = customerName;
    return _data;
  }
}