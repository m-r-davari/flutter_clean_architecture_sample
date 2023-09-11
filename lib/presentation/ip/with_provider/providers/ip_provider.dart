import 'package:flutter_clean_architecture_sample/core/states/ui_state.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/entity/ip_entity.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/usecase/i_ip_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/errors/failure.dart';


class IpProvider with ChangeNotifier {

  final IIpUseCase ipUseCase;
  IpProvider({required this.ipUseCase});

  UIState<IpEntity> _ipUiState = LoadingState();

  UIState<IpEntity> get ipUiState => _ipUiState;

  set ipUiState(UIState<IpEntity> value) {
    _ipUiState = value;
    notifyListeners();
  }

  Future<dynamic> fetchIp() async{
    ipUiState = LoadingState();
    Either<Failure?,IpEntity> result = await ipUseCase.getIp();
    result.fold(
    (l) {
      ipUiState = FailureState(l?.message);
    },
    (r) {
      ipUiState = SuccessState(r);
    });
  }


}