import 'package:flutter_clean_architecture_sample/core/states/livedata.dart';
import 'package:flutter_clean_architecture_sample/core/states/ui_state.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/entity/ip_entity.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/usecase/ip_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../core/errors/failure.dart';

class IpProvider with ChangeNotifier {

  final IpUseCase ipUseCase;
  IpProvider({required this.ipUseCase});

  LiveData<UIState<IpEntity>> ipUiState = LiveData<UIState<IpEntity>>();


  Future<dynamic> fetchIp() async{
    ipUiState.setValue(LoadingState());
    Either<Failure?,IpEntity> result = await ipUseCase.getIp();
    result.fold(
    (l) {
      print('---------ffffffffff--------- ${l?.message}');
      ipUiState.setValue(FailureState(l?.message));
    },
    (r) {
      print('---------rrrrrrrrrrrr---------');
      ipUiState.setValue(SuccessState(r));
    });
  }


}