import 'package:easy_localization/easy_localization.dart';
import 'package:{{name.snakeCase()}}/core/app/error/failure.dart';
import 'package:{{name.snakeCase()}}/core/app/localization/locale_keys.dart';

class UnknownFailure extends Failure {
  static String get _defaultType => LocaleKeys.errors_remote_error.tr();
  static String get _defaultMessage => LocaleKeys.errors_remote_unknown.tr();

  UnknownFailure() : super(type: _defaultType, message: _defaultMessage);
}

class AppFailure extends Failure {
  const new({super.type, super.message});
}

class NetworkFailure extends Failure {
  const new({super.type, super.message});
}

class FirebaseFailure extends Failure {
  const new({super.type, super.message});
}
