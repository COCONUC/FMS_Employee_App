
class ServiceData {
  int? serviceId;
  int? categoryId;
  String? serviceName;
  String? serviceDescription;
  int? type;
  String? price;
  String? createAt;
  String? updateAt;
  bool? status;
  String? category;
  List<dynamic>? orderServices;
  List<dynamic>? serviceDetails;

  ServiceData({this.serviceId, this.categoryId, this.serviceName, this.serviceDescription, this.type, this.price, this.createAt, this.updateAt, this.status, this.category, this.orderServices, this.serviceDetails});

  ServiceData.fromJson(Map<String, dynamic> json) {
    serviceId = json["serviceId"];
    categoryId = json["categoryId"];
    serviceName = json["serviceName"];
    serviceDescription = json["serviceDescription"];
    type = json["type"];
    price = json["price"];
    createAt = json["createAt"];
    updateAt = json["updateAt"];
    status = json["status"];
    category = json["category"];
    orderServices = json["orderServices"] ?? [];
    serviceDetails = json["serviceDetails"] ?? [];
  }

  static List<ServiceData> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ServiceData.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["serviceId"] = serviceId;
    _data["categoryId"] = categoryId;
    _data["serviceName"] = serviceName;
    _data["serviceDescription"] = serviceDescription;
    _data["type"] = type;
    _data["price"] = price;
    _data["createAt"] = createAt;
    _data["updateAt"] = updateAt;
    _data["status"] = status;
    _data["category"] = category;
    if(orderServices != null) {
      _data["orderServices"] = orderServices;
    }
    if(serviceDetails != null) {
      _data["serviceDetails"] = serviceDetails;
    }
    return _data;
  }
}