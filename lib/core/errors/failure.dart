
abstract class Failure {
  String get message;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Failure && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}