
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
    if(json["serviceId"] is int) {
      serviceId = json["serviceId"];
    }
    if(json["serviceName"] is String) {
      serviceName = json["serviceName"];
    }
    if(json["serviceDescription"] is String) {
      serviceDescription = json["serviceDescription"];
    }
    if(json["price"] is String) {
      price = json["price"];
    }
    if(json["type"] is String) {
      type = json["type"];
    }
    if(json["createAt"] is String) {
      createAt = json["createAt"];
    }
    if(json["updateAt"] is String) {
      updateAt = json["updateAt"];
    }
    if(json["status"] is bool) {
      status = json["status"];
    }
    if(json["categoryName"] is String) {
      categoryName = json["categoryName"];
    }
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