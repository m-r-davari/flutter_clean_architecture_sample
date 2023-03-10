abstract class UIState<T> {}


class InitialState<T> extends UIState<T>{}


class LoadingState<T> extends UIState<T>{}


class SuccessState<T> extends UIState<T> {
  T data;
  SuccessState(this.data);
}


class FailureState<T> extends UIState<T> {
  final String? _message;
  FailureState(this._message);

  String get message => _message ?? 'UI State Error';
}