
class DayOffRegisterData {
  int? employeeId;
  String? reason;
  String? dayOff;
  bool? status;

  DayOffRegisterData({this.employeeId, this.reason, this.dayOff, this.status});

  DayOffRegisterData.fromJson(Map<String, dynamic> json) {
    if(json["employeeId"] is int) {
      employeeId = json["employeeId"];
    }
    if(json["reason"] is String) {
      reason = json["reason"];
    }
    if(json["dayOff"] is String) {
      dayOff = json["dayOff"];
    }
    if(json["status"] is bool) {
      status = json["status"];
    }
  }

  static List<DayOffRegisterData> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => DayOffRegisterData.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["employeeId"] = employeeId;
    _data["reason"] = reason;
    _data["dayOff"] = dayOff;
    _data["status"] = status;
    return _data;
  }
}