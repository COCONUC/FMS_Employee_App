


class OrderDetailData {
  int? orderServiceId;
  int? orderId;
  int? serviceId;
  dynamic serviceName;
  dynamic categoryName;
  dynamic estimateTimeFinish;
  String? address;
  String? description;
  String? customerPhone;
  String? customerName;
  String? totalPrice;
  dynamic price;
  String? statusName;
  List<ListOrderServiceDto>? listOrderServiceDto;
  List<ListEmployeeDto>? listEmployeeDto;

  OrderDetailData({this.orderServiceId, this.orderId, this.serviceId, this.serviceName, this.categoryName, this.estimateTimeFinish, this.address, this.description, this.customerPhone, this.customerName, this.totalPrice, this.price, this.statusName, this.listOrderServiceDto, this.listEmployeeDto});

  OrderDetailData.fromJson(Map<String, dynamic> json) {
    if(json["orderServiceId"] is int) {
      orderServiceId = json["orderServiceId"];
    }
    if(json["orderId"] is int) {
      orderId = json["orderId"];
    }
    if(json["serviceId"] is int) {
      serviceId = json["serviceId"];
    }
    serviceName = json["serviceName"];
    categoryName = json["categoryName"];
    estimateTimeFinish = json["estimateTimeFinish"];
    if(json["address"] is String) {
      address = json["address"];
    }
    if(json["description"] is String) {
      description = json["description"];
    }
    if(json["customerPhone"] is String) {
      customerPhone = json["customerPhone"];
    }
    if(json["customerName"] is String) {
      customerName = json["customerName"];
    }
    if(json["totalPrice"] is String) {
      totalPrice = json["totalPrice"];
    }
    price = json["price"];
    if(json["statusName"] is String) {
      statusName = json["statusName"];
    }
    if(json["listOrderServiceDto"] is List) {
      listOrderServiceDto = json["listOrderServiceDto"] == null ? null : (json["listOrderServiceDto"] as List).map((e) => ListOrderServiceDto.fromJson(e)).toList();
    }
    if(json["listEmployeeDto"] is List) {
      listEmployeeDto = json["listEmployeeDto"] == null ? null : (json["listEmployeeDto"] as List).map((e) => ListEmployeeDto.fromJson(e)).toList();
    }
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
    _data["categoryName"] = categoryName;
    _data["estimateTimeFinish"] = estimateTimeFinish;
    _data["address"] = address;
    _data["description"] = description;
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
  String? employeeName;
  String? email;
  String? employeePhoneNumber;
  bool? status;

  ListEmployeeDto({this.imageUrl, this.accountId, this.employeeName, this.email, this.employeePhoneNumber, this.status});

  ListEmployeeDto.fromJson(Map<String, dynamic> json) {
    imageUrl = json["imageUrl"];
    if(json["accountId"] is int) {
      accountId = json["accountId"];
    }
    if(json["employeeName"] is String) {
      employeeName = json["employeeName"];
    }
    if(json["email"] is String) {
      email = json["email"];
    }
    if(json["employeePhoneNumber"] is String) {
      employeePhoneNumber = json["employeePhoneNumber"];
    }
    if(json["status"] is bool) {
      status = json["status"];
    }
  }

  static List<ListEmployeeDto> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ListEmployeeDto.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["imageUrl"] = imageUrl;
    _data["accountId"] = accountId;
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
  String? categoryName;
  int? quantity;
  String? estimateTimeFinish;
  String? implementationDate;
  String? implementationTime;

  ListOrderServiceDto({this.orderServiceId, this.orderId, this.serviceId, this.serviceName, this.price, this.categoryName, this.quantity, this.estimateTimeFinish, this.implementationDate, this.implementationTime});

  ListOrderServiceDto.fromJson(Map<String, dynamic> json) {
    if(json["orderServiceId"] is int) {
      orderServiceId = json["orderServiceId"];
    }
    if(json["orderId"] is int) {
      orderId = json["orderId"];
    }
    if(json["serviceId"] is int) {
      serviceId = json["serviceId"];
    }
    if(json["serviceName"] is String) {
      serviceName = json["serviceName"];
    }
    if(json["price"] is String) {
      price = json["price"];
    }
    if(json["categoryName"] is String) {
      categoryName = json["categoryName"];
    }
    if(json["quantity"] is int) {
      quantity = json["quantity"];
    }
    if(json["estimateTimeFinish"] is String) {
      estimateTimeFinish = json["estimateTimeFinish"];
    }
    if(json["implementationDate"] is String) {
      implementationDate = json["implementationDate"];
    }
    if(json["implementationTime"] is String) {
      implementationTime = json["implementationTime"];
    }
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
    _data["categoryName"] = categoryName;
    _data["quantity"] = quantity;
    _data["estimateTimeFinish"] = estimateTimeFinish;
    _data["implementationDate"] = implementationDate;
    _data["implementationTime"] = implementationTime;
    return _data;
  }
}

class ChosenService {
  int quantity;
  ListOrderServiceDto service;
  ChosenService({required this.quantity, required this.service});
}