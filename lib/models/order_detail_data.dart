
class OrderDetailData {
  int? orderServiceId;
  int? orderId;
  int? serviceId;
  dynamic serviceName;
  dynamic estimateTimeFinish;
  String? address;
  String? customerPhone;
  String? customerName;
  String? totalPrice;
  dynamic price;
  String? statusName;
  List<ListOrderServiceDto>? listOrderServiceDto;
  List<ListEmployeeDto>? listEmployeeDto;

  OrderDetailData({this.orderServiceId, this.orderId, this.serviceId, this.serviceName, this.estimateTimeFinish, this.address, this.customerPhone, this.customerName, this.totalPrice, this.price, this.statusName, this.listOrderServiceDto, this.listEmployeeDto});

  OrderDetailData.fromJson(Map<String, dynamic> json) {
    orderServiceId = json["orderServiceId"];
    orderId = json["orderId"];
    serviceId = json["serviceId"];
    serviceName = json["serviceName"];
    estimateTimeFinish = json["estimateTimeFinish"];
    address = json["address"];
    customerPhone = json["customerPhone"];
    customerName = json["customerName"];
    totalPrice = json["totalPrice"];
    price = json["price"];
    statusName = json["statusName"];
    listOrderServiceDto = json["listOrderServiceDto"] == null ? null : (json["listOrderServiceDto"] as List).map((e) => ListOrderServiceDto.fromJson(e)).toList();
    listEmployeeDto = json["listEmployeeDto"] == null ? null : (json["listEmployeeDto"] as List).map((e) => ListEmployeeDto.fromJson(e)).toList();
  }

  static List<OrderDetailData> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => OrderDetailData.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["orderServiceId"] = orderServiceId;
    _data["orderId"] = orderId;
    _data["serviceId"] = serviceId;
    _data["serviceName"] = serviceName;
    _data["estimateTimeFinish"] = estimateTimeFinish;
    _data["address"] = address;
    _data["customerPhone"] = customerPhone;
    _data["customerName"] = customerName;
    _data["totalPrice"] = totalPrice;
    _data["price"] = price;
    _data["statusName"] = statusName;
    if(listOrderServiceDto != null) {
      _data["listOrderServiceDto"] = listOrderServiceDto?.map((e) => e.toJson()).toList();
    }
    if(listEmployeeDto != null) {
      _data["listEmployeeDto"] = listEmployeeDto?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class ListEmployeeDto {
  dynamic imageUrl;
  int? accountId;
  int? specialtyId;
  String? employeeName;
  String? email;
  String? employeePhoneNumber;
  bool? status;

  ListEmployeeDto({this.imageUrl, this.accountId, this.specialtyId, this.employeeName, this.email, this.employeePhoneNumber, this.status});

  ListEmployeeDto.fromJson(Map<String, dynamic> json) {
    imageUrl = json["imageUrl"];
    accountId = json["accountId"];
    specialtyId = json["specialtyId"];
    employeeName = json["employeeName"];
    email = json["email"];
    employeePhoneNumber = json["employeePhoneNumber"];
    status = json["status"];
  }

  static List<ListEmployeeDto> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ListEmployeeDto.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["imageUrl"] = imageUrl;
    _data["accountId"] = accountId;
    _data["specialtyId"] = specialtyId;
    _data["employeeName"] = employeeName;
    _data["email"] = email;
    _data["employeePhoneNumber"] = employeePhoneNumber;
    _data["status"] = status;
    return _data;
  }
}

class ListOrderServiceDto {
  int? orderServiceId;
  int? orderId;
  int? serviceId;
  String? serviceName;
  String? price;
  String? estimateTimeFinish;

  ListOrderServiceDto({this.orderServiceId, this.orderId, this.serviceId, this.serviceName, this.price, this.estimateTimeFinish});

  ListOrderServiceDto.fromJson(Map<String, dynamic> json) {
    orderServiceId = json["orderServiceId"];
    orderId = json["orderId"];
    serviceId = json["serviceId"];
    serviceName = json["serviceName"];
    price = json["price"];
    estimateTimeFinish = json["estimateTimeFinish"];
  }

  static List<ListOrderServiceDto> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ListOrderServiceDto.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["orderServiceId"] = orderServiceId;
    _data["orderId"] = orderId;
    _data["serviceId"] = serviceId;
    _data["serviceName"] = serviceName;
    _data["price"] = price;
    _data["estimateTimeFinish"] = estimateTimeFinish;
    return _data;
  }
}