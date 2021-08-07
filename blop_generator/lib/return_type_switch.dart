import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:source_gen/source_gen.dart';

T returnTypeSwitch<T>(
  DartType stateType,
  MethodElement element, {
  T Function()? same,
  T Function()? stream,
  T Function()? future,
  T Function()? futureOr,
  required T Function() orElse,
}) {
  final returnType = element.returnType;
  if (TypeChecker.fromStatic(stateType).isExactlyType(returnType)) {
    return (same ?? orElse)();
  }

  if (TypeChecker.fromRuntime(Stream).isExactlyType(returnType)) {
    return (stream ?? orElse)();
  }

  if (returnType.isDartAsyncFuture) {
    return (future ?? orElse)();
  }

  if (returnType.isDartAsyncFutureOr) {
    return (futureOr ?? orElse)();
  }

  if (element.isAsynchronous) {
    if (element.isGenerator) {
      return (stream ?? orElse)();
    }
    return (futureOr ?? orElse)();
  }
  return (same ?? orElse)();
}
