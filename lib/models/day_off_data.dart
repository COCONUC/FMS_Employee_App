
class DayOffData {
  int? id;
  int? employeeId;
  String? reason;
  String? dayOff;
  int? status;

  DayOffData({this.id, this.employeeId, this.reason, this.dayOff, this.status});

  DayOffData.fromJson(Map<String, dynamic> json) {
    if(json["id"] is int) {
      id = json["id"];
    }
    if(json["employeeId"] is int) {
      employeeId = json["employeeId"];
    }
    if(json["reason"] is String) {
      reason = json["reason"];
    }
    if(json["dayOff"] is String) {
      dayOff = json["dayOff"];
    }
    if(json["status"] is int) {
      status = json["status"];
    }
  }

  static List<DayOffData> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => DayOffData.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["employeeId"] = employeeId;
    _data["reason"] = reason;
    _data["dayOff"] = dayOff;
    _data["status"] = status;
    return _data;
  }
}