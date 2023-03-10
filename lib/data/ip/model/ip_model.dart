class IpModel {
  bool? success;
  String? ip;
  String? type;

  IpModel({this.success, this.ip, this.type});

  IpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    ip = json['ip'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['ip'] = this.ip;
    data['type'] = this.type;
    return data;
  }
}