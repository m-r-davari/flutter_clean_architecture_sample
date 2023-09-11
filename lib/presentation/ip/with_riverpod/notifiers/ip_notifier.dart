import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_sample/core/states/ui_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/errors/failure.dart';
import '../../../../domain/ip/entity/ip_entity.dart';
import '../../../../domain/ip/usecase/i_ip_usecase.dart';


class IpNotifier extends Notifier<UIState>{

  final IIpUseCase ipUseCase;
  IpNotifier({required this.ipUseCase});

  @override
  UIState build() {
    return LoadingState();
  }

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



