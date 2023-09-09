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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IpModel && runtimeType == other.runtimeType && success == other.success && ip == other.ip && type == other.type;

  @override
  int get hashCode => success.hashCode ^ ip.hashCode ^ type.hashCode;
}