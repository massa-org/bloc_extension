import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blop/complete_reason.dart';

import '../blop_closed_exception.dart';
import '../blop_event.dart';

part '_cancel_cubit.dart';
part '_complete_all.dart';
part '_complete_same_type.dart';

abstract class MethodCompleterStrategy {
  Future<void> waitComplete(BlopEvent event);
  Future<void> close([Type? blopType]);

  factory MethodCompleterStrategy.completeOlderSameType() =>
      _TypeBasedCompleterStrategy();
  factory MethodCompleterStrategy.completeOlder() => _OlderCompleteStrategy();
  factory MethodCompleterStrategy.doNothing() => _DoNothing();
}

class _DoNothing implements MethodCompleterStrategy {
  @override
  Future<void> close([Type? blopType]) async {}

  @override
  Future<void> waitComplete(BlopEvent event) async {
    final completer = Completer();

    // ignore: unawaited_futures
    event.completeFuture.then(
      (value) => value.maybeWhen(
        error: (id, error, stackTrace) =>
            completer.completeError(error, stackTrace),
        cancelWithError: (id, error, stackTrace) =>
            completer.completeError(error, stackTrace),
        orElse: () => completer.complete(),
      ),
    );

    return completer.future;
  }
}
