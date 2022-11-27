
class ServiceData {
  int? serviceId;
  String? serviceName;
  String? serviceDescription;
  String? price;
  String? type;
  String? createAt;
  String? updateAt;
  bool? status;
  String? categoryName;

  ServiceData({this.serviceId, this.serviceName, this.serviceDescription, this.price, this.type, this.createAt, this.updateAt, this.status, this.categoryName});

  ServiceData.fromJson(Map<String, dynamic> json) {
    serviceId = json["serviceId"];
    serviceName = json["serviceName"];
    serviceDescription = json["serviceDescription"];
    price = json["price"];
    type = json["type"];
    createAt = json["createAt"];
    updateAt = json["updateAt"];
    status = json["status"];
    categoryName = json["categoryName"];
  }

  static List<ServiceData> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ServiceData.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["serviceId"] = serviceId;
    _data["serviceName"] = serviceName;
    _data["serviceDescription"] = serviceDescription;
    _data["price"] = price;
    _data["type"] = type;
    _data["createAt"] = createAt;
    _data["updateAt"] = updateAt;
    _data["status"] = status;
    _data["categoryName"] = categoryName;
    return _data;
  }
}