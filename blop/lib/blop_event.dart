import 'dart:async';

import 'package:blop/complete_reason.dart';

import 'method_execution_exception.dart';

class BlopEvent<T> {
  static int _id = 0;

  final int id = _id = ++_id;

  final _completer = Completer<CompleteReason>();

  final String type;
  final Stream<T> Function() _processFn;

  Future<CompleteReason> get completeFuture => _completer.future;

  BlopEvent(this._processFn, this.type);

  Stream<T> execute() async* {
    try {
      await for (final item in _processFn()) {
        yield item;
      }
      _completer.complete(CompleteReason.done(id));
    } catch (error) {
      throw MethodExecutionException(
        error,
        () => _completer.complete(CompleteReason.error(id, error)),
      );
    }
  }

  @override
  String toString() {
    return 'BlopEvent<$T>($id,$type)';
  }
}
