
/*class ReportOrder {
  int? orderId;
  String? description;
  String? urlImage;
  List<ListChosenService>? listService;

  ReportOrder({this.orderId, this.description, this.urlImage, this.listService});

  ReportOrder.fromJson(Map<String, dynamic> json) {
    orderId = json["orderId"];
    description = json["description"];
    urlImage = json["urlImage"];
    listService = json["listService"] == null ? null : (json["listService"] as List).map((e) => ListChosenService.fromJson(e)).toList();
  }

  static List<ReportOrder> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ReportOrder.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["orderId"] = orderId;
    _data["description"] = description;
    _data["urlImage"] = urlImage;
    if(listService != null) {
      _data["listService"] = listService?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}*/

class ReportOrder {
  int? orderId;
  String? description;
  List<ListChosenService>? listService;
  List<ListEmployeeCreateOrderImageListDto>? listEmployeeCreateOrderImageListDto;

  ReportOrder({this.orderId, this.description, this.listService, this.listEmployeeCreateOrderImageListDto});

  ReportOrder.fromJson(Map<String, dynamic> json) {
    if(json["orderId"] is int) {
      orderId = json["orderId"];
    }
    if(json["description"] is String) {
      description = json["description"];
    }
    if(json["listService"] is List) {
      listService = json["listService"] == null ? null : (json["listService"] as List).map((e) => ListChosenService.fromJson(e)).toList();
    }
    if(json["listEmployeeCreateOrderImageListDto"] is List) {
      listEmployeeCreateOrderImageListDto = json["listEmployeeCreateOrderImageListDto"] == null ? null : (json["listEmployeeCreateOrderImageListDto"] as List).map((e) => ListEmployeeCreateOrderImageListDto.fromJson(e)).toList();
    }
  }

  static List<ReportOrder> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ReportOrder.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["orderId"] = orderId;
    _data["description"] = description;
    if(listService != null) {
      _data["listService"] = listService?.map((e) => e.toJson()).toList();
    }
    if(listEmployeeCreateOrderImageListDto != null) {
      _data["listEmployeeCreateOrderImageListDto"] = listEmployeeCreateOrderImageListDto?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class ListEmployeeCreateOrderImageListDto {
  int? orderId;
  String? imageUrl;
  bool? status;

  ListEmployeeCreateOrderImageListDto({this.orderId, this.imageUrl, this.status});

  ListEmployeeCreateOrderImageListDto.fromJson(Map<String, dynamic> json) {
    if(json["orderId"] is int) {
      orderId = json["orderId"];
    }
    if(json["imageUrl"] is String) {
      imageUrl = json["imageUrl"];
    }
    if(json["status"] is bool) {
      status = json["status"];
    }
  }

  static List<ListEmployeeCreateOrderImageListDto> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ListEmployeeCreateOrderImageListDto.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["orderId"] = orderId;
    _data["imageUrl"] = imageUrl;
    _data["status"] = status;
    return _data;
  }
}

class ListService {
  int? serviceId;
  int? quantity;

  ListService({this.serviceId, this.quantity});

  ListService.fromJson(Map<String, dynamic> json) {
    if(json["serviceId"] is int) {
      serviceId = json["serviceId"];
    }
    if(json["quantity"] is int) {
      quantity = json["quantity"];
    }
  }

  static List<ListService> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ListService.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["serviceId"] = serviceId;
    _data["quantity"] = quantity;
    return _data;
  }
}

class ListChosenService {
  int? serviceId;
  int? quantity;

  ListChosenService({this.serviceId, this.quantity});

  ListChosenService.fromJson(Map<String, dynamic> json) {
    serviceId = json["serviceId"];
    quantity = json["quantity"];
  }

  static List<ListChosenService> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ListChosenService.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["serviceId"] = serviceId;
    _data["quantity"] = quantity;
    return _data;
  }
}