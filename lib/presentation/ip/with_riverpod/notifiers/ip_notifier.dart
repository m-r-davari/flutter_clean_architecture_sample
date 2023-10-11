import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture_sample/core/di/injector.dart';
import 'package:flutter_clean_architecture_sample/core/states/ui_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/failure.dart';
import '../../../../domain/ip/entity/ip_entity.dart';
import '../../../../domain/ip/usecase/i_ip_usecase.dart';


final ipProvider = StateNotifierProvider.autoDispose<IpNotifier,UIState>((ref) {
  final notifier = IpNotifier(ipUseCase: injector<IIpUseCase>());
  notifier.fetchIp();
  return notifier;
});

class IpNotifier extends StateNotifier<UIState>{

  final IIpUseCase ipUseCase;
  IpNotifier({required this.ipUseCase}) : super(LoadingState());

  Future<dynamic> fetchIp() async{
    state = LoadingState();
    Either<Failure?,IpEntity> result = await ipUseCase.getIp();
    result.fold(
            (l) {
          state = FailureState(l?.message);
        },
            (r) {
          state = SuccessState(r);
        });
  }




}



