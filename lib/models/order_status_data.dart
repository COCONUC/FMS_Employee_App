
class ChangeOrderStatusData {
  int? statusId;

  ChangeOrderStatusData({this.statusId});

  ChangeOrderStatusData.fromJson(Map<String, dynamic> json) {
    if(json["statusId"] is int) {
      statusId = json["statusId"];
    }
  }

  static List<ChangeOrderStatusData> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => ChangeOrderStatusData.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["statusId"] = statusId;
    return _data;
  }
}