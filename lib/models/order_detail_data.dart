
class OrderDetailData {
  int? orderId;
  int? customerId;
  int? workingStatusId;
  String? address;
  String? totalPrice;
  String? createAt;
  dynamic updateAt;
  String? description;
  bool? status;
  dynamic customer;
  dynamic workingStatus;
  List<dynamic>? assigns;
  List<dynamic>? orderServices;

  OrderDetailData({this.orderId, this.customerId, this.workingStatusId, this.address, this.totalPrice, this.createAt, this.updateAt, this.description, this.status, this.customer, this.workingStatus, this.assigns, this.orderServices});

  OrderDetailData.fromJson(Map<String, dynamic> json) {
    orderId = json["orderId"];
    customerId = json["customerId"];
    workingStatusId = json["workingStatusId"];
    address = json["address"];
    totalPrice = json["totalPrice"];
    createAt = json["createAt"];
    updateAt = json["updateAt"];
    description = json["description"];
    status = json["status"];
    customer = json["customer"];
    workingStatus = json["workingStatus"];
    assigns = json["assigns"] ?? [];
    orderServices = json["orderServices"] ?? [];
  }

  static List<OrderDetailData> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => OrderDetailData.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["orderId"] = orderId;
    _data["customerId"] = customerId;
    _data["workingStatusId"] = workingStatusId;
    _data["address"] = address;
    _data["totalPrice"] = totalPrice;
    _data["createAt"] = createAt;
    _data["updateAt"] = updateAt;
    _data["description"] = description;
    _data["status"] = status;
    _data["customer"] = customer;
    _data["workingStatus"] = workingStatus;
    if(assigns != null) {
      _data["assigns"] = assigns;
    }
    if(orderServices != null) {
      _data["orderServices"] = orderServices;
    }
    return _data;
  }
}