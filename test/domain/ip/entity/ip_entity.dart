


import 'package:flutter_clean_architecture_sample/data/ip/model/ip_model.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/entity/ip_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  final ipTempModel = IpModel(success: true,ip: '192.168.1.1',type: 'local');

  group('test ip entity fromModel/toModel', () {

    test('test ip entity from model', () {
      final ipEntity = IpEntity.fromModel(ipTempModel);
      expect(ipEntity.success, true);
      expect(ipEntity.type, 'local');
      expect(ipEntity.ip, '192.168.1.1');
    });


    test('test ip entity to model', () {
      final ipEntity = IpEntity(success: true,ip: '192.168.1.1',type: 'local');
      final ipModel = ipEntity.toModel();
      expect(ipModel.success, true);
      expect(ipModel.ip, '192.168.1.1');
      expect(ipModel.type, 'local');
    });

  });

}