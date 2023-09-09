


import 'package:flutter_clean_architecture_sample/data/ip/model/ip_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main()async{

  late Map<String,dynamic> jsonIpResponse;
  late IpModel ipModel;

  setUp((){

    jsonIpResponse = {
      'success':true,
      'ip':'192.168.1.1',
      'type':'local'
    };

    ipModel = IpModel(success: true,ip: '192.168.1.1',type: 'local');

  });


  group('test serialize and deserialize for ip model', () {

    test('fromJson Test for ip model', (){

      expect(IpModel.fromJson(jsonIpResponse), ipModel);

    });

    test('toJson Test for ip model', (){

      expect(ipModel.toJson(), jsonIpResponse);

    });

  });



}