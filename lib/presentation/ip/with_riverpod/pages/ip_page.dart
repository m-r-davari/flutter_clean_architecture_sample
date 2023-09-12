import 'package:flutter_clean_architecture_sample/core/states/ui_state.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/entity/ip_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_sample/presentation/ip/with_riverpod/notifiers/ip_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/injector.dart';
import '../../../../domain/ip/usecase/i_ip_usecase.dart';



class IpPage extends StatelessWidget {
  const IpPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('IP Page'),
        ),
        body: IpPageBodyContent(),
      ),
    );
  }

}

//todo : must change type
var _ipProvider = NotifierProvider<IpNotifier, UIState>((){
  IpNotifier ipNotifier = IpNotifier(ipUseCase: injector<IIpUseCase>());
  Future.delayed(Duration.zero,(){
    ipNotifier.fetchIp();
  });
  return ipNotifier;
});

class IpPageBodyContent extends ConsumerWidget {

  @visibleForTesting
  set ipProvider(value) {
    _ipProvider = value;
  }

  IpPageBodyContent({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final state = ref.watch(_ipProvider);
    print('----> state is $state');
    return Center(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(100),
        decoration: BoxDecoration(
            color: const Color(0xffEDEDED),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: Colors.grey.withOpacity(0.3),width: 0.5),
            boxShadow: const [
              BoxShadow(color: Colors.black12,blurRadius: 20,spreadRadius: 5)
            ]
        ),
        child: _handleState(ref, state),
    ));
  }

  Widget _handleState(WidgetRef ref,UIState state){
    if(state is LoadingState){
      return const SizedBox(width: 40,height: 40,child: CircularProgressIndicator());
    }
    else if(state is SuccessState){
      IpEntity data = (state as SuccessState).data;
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,mainAxisSize: MainAxisSize.min,
        children: [
          Text('IP : ${data.ip}',style: const TextStyle(fontSize: 16),),
          const SizedBox(height: 24,),
          Text('Type : ${data.type}',style: const TextStyle(fontSize: 16),),
          const SizedBox(height: 24,),
          Text('Result : ${data.success}',style: const TextStyle(fontSize: 16),)
        ],
      );
    }
    else if(state is FailureState){
      String message = (state as FailureState).message;
      return Column(
        mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: (){
              ref.watch(_ipProvider.notifier).fetchIp();
            },
            icon: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 16,),
          Text(message)
        ],
      );
    }
    else{
      return Container();
    }
  }

}



