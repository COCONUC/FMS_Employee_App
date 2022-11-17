
class AccountData {
  int? employeeId;
  int? accountId;
  int? specialtyId;
  String? employeeName;
  String? email;
  String? employeePhoneNumber;
  dynamic imageUrl;
  bool? workingStatus;
  bool? status;
  dynamic account;
  dynamic specialty;
  List<dynamic>? assigns;
  List<dynamic>? employeeDayOffs;

  AccountData({this.employeeId, this.accountId, this.specialtyId, this.employeeName, this.email, this.employeePhoneNumber, this.imageUrl, this.workingStatus, this.status, this.account, this.specialty, this.assigns, this.employeeDayOffs});

  AccountData.fromJson(Map<String, dynamic> json) {
    employeeId = json["employeeId"];
    accountId = json["accountId"];
    specialtyId = json["specialtyId"];
    employeeName = json["employeeName"];
    email = json["email"];
    employeePhoneNumber = json["employeePhoneNumber"];
    imageUrl = json["imageUrl"];
    workingStatus = json["workingStatus"];
    status = json["status"];
    account = json["account"];
    specialty = json["specialty"];
    assigns = json["assigns"] ?? [];
    employeeDayOffs = json["employeeDayOffs"] ?? [];
  }

  static List<AccountData> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => AccountData.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["employeeId"] = employeeId;
    _data["accountId"] = accountId;
    _data["specialtyId"] = specialtyId;
    _data["employeeName"] = employeeName;
    _data["email"] = email;
    _data["employeePhoneNumber"] = employeePhoneNumber;
    _data["imageUrl"] = imageUrl;
    _data["workingStatus"] = workingStatus;
    _data["status"] = status;
    _data["account"] = account;
    _data["specialty"] = specialty;
    if(assigns != null) {
      _data["assigns"] = assigns;
    }
    if(employeeDayOffs != null) {
      _data["employeeDayOffs"] = employeeDayOffs;
    }
    return _data;
  }
}