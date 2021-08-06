import 'package:freezed_annotation/freezed_annotation.dart';

part 'complete_reason.freezed.dart';

@freezed
abstract class CompleteReason implements _$CompleteReason {
  const CompleteReason._();

  const factory CompleteReason.cancel(int id) = _Cancel;
  const factory CompleteReason.done(int id) = _Done;

  const factory CompleteReason.error(int id,error) = _Error;
  const factory CompleteReason.cancelWithError(int id,error) = _CancelError;
}
