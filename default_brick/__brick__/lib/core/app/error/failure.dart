import 'package:equatable/equatable.dart';
import 'package:toastification/toastification.dart';
import 'package:{{name.snakeCase()}}/core/app/utils/alerts.dart';

class Failure extends Equatable implements Exception {
  final String? type;
  final String? message;

  const Failure({
    this.type,
    this.message,
  });

  factory Failure.custom({String? type, String? message}) =>
      Failure(type: type, message: message);

  void toast({ToastificationType severity = ToastificationType.error}) {
    final showColon = type != null && message != null;
    Alerts.showToast(
      severity: severity,
      message: '${type ?? ''}${showColon ? ':' : ''} ${message ?? ''}',
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [type, message];
}
