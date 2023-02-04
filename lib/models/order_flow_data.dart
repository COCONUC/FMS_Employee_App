
class OrderFlowData {
  int? orderId;
  String? totalPrice;
  int? customerId;
  int? workingStatusId;
  String? statusName;
  String? address;
  String? customerPhone;
  String? customerName;
  String? implementationDate;
  String? implementationTime;

  OrderFlowData({this.orderId, this.totalPrice, this.customerId, this.workingStatusId, this.statusName, this.address, this.customerPhone, this.customerName, this.implementationDate, this.implementationTime});

  OrderFlowData.fromJson(Map<String, dynamic> json) {
    if(json["orderId"] is int) {
      orderId = json["orderId"];
    }
    if(json["totalPrice"] is String) {
      totalPrice = json["totalPrice"];
    }
    if(json["customerId"] is int) {
      customerId = json["customerId"];
    }
    if(json["workingStatusId"] is int) {
      workingStatusId = json["workingStatusId"];
    }
    if(json["statusName"] is String) {
      statusName = json["statusName"];
    }
    if(json["address"] is String) {
      address = json["address"];
    }
    if(json["customerPhone"] is String) {
      customerPhone = json["customerPhone"];
    }
    if(json["customerName"] is String) {
      customerName = json["customerName"];
    }
    if(json["implementationDate"] is String) {
      implementationDate = json["implementationDate"];
    }
    if(json["implementationTime"] is String) {
      implementationTime = json["implementationTime"];
    }
  }

  static List<OrderFlowData> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => OrderFlowData.fromJson(map)).toList();
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
    _data["implementationDate"] = implementationDate;
    _data["implementationTime"] = implementationTime;
    return _data;
  }
}