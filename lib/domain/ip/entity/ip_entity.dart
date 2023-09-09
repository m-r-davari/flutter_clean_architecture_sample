import 'package:flutter_clean_architecture_sample/data/ip/model/ip_model.dart';

class IpEntity {
  final String ip;
  final String? type;
  final bool? success;

  IpEntity({required this.ip, required this.type ,required this.success});

  factory IpEntity.fromModel(IpModel model)=>IpEntity(
    ip : model.ip ?? '00.00.00.00',
    type : model.type,
    success : model.success,
  );

  IpModel toModel()=> IpModel(
    ip : this.ip,
    type : this.type,
    success : this.success,
  );


  IpEntity copyWith ({String? ip, String? type, bool? success})=> IpEntity(
      ip: ip ?? this.ip,
      type: type ?? this.type,
      success: success ?? this.success
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IpEntity && runtimeType == other.runtimeType && ip == other.ip && type == other.type && success == other.success;

  @override
  int get hashCode => ip.hashCode ^ type.hashCode ^ success.hashCode;
}