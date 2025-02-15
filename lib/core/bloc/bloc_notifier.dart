import 'package:freezed_annotation/freezed_annotation.dart';

part 'bloc_notifier.freezed.dart';

@Freezed(equal: false)
class BlocNotifier with _$BlocNotifier {
  factory BlocNotifier.success({
    required String message,
    String? action,
    @Default(false) bool isFailure,
  }) = _NotifySuccess;

  factory BlocNotifier.failed({
    required String message,
    @Default(true) bool isFailure,
  }) = _NotifyFailed;
}
