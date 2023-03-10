import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_sample/core/states/ui_state.dart';

class LiveData<T extends UIState> with ChangeNotifier {

  T? _value;

  void setValue(T? value){
    this._value = value;
    notifyListeners();
  }

  T? getValue(){
    return this._value;
  }

}