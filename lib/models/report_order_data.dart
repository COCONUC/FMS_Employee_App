
class ReportOrder {
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