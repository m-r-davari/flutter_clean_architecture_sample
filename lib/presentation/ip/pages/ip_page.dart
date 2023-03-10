import 'package:flutter_clean_architecture_sample/core/di/injector.dart';
import 'package:flutter_clean_architecture_sample/core/states/livedata.dart';
import 'package:flutter_clean_architecture_sample/core/states/ui_state.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/entity/ip_entity.dart';
import 'package:flutter_clean_architecture_sample/domain/ip/usecase/ip_usecase.dart';
import 'package:flutter_clean_architecture_sample/presentation/ip/providers/ip_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IpPage extends StatelessWidget {

  IpPage({Key? key}) : super(key: key);
  final IpProvider _ipProvider = IpProvider(ipUseCase: injector<IpUseCase>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IP Page'),
      ),
      body: ChangeNotifierProvider<LiveData<UIState<IpEntity>>>(
        create: (ctx){
          _ipProvider.fetchIp();
          return _ipProvider.ipUiState;
        },
        child: _bodyWidget(),
      ),
    );
  }


  Widget _bodyWidget(){
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
        child: Consumer<LiveData<UIState<IpEntity>>>(
          builder: (ctx,data,_){
            var state = data.getValue();
            print('---ssss----- $state');
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
                      _ipProvider.fetchIp();
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

          },
        ),
      ),
    );
  }


}
