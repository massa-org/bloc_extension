library blop;

import 'dart:async';

import 'package:bloc/bloc.dart';

import 'complete_reason.dart';

class _CancelCubit extends Cubit<CompleteReason> {
  _CancelCubit(CompleteReason initialState) : super(initialState);
}

class BlopEvent<T> {
  static int _id = 0;

  final int id = ++_id;
  final _completer = Completer<CompleteReason>();

  final Stream<T> Function() _processFn;

  BlopEvent(this._processFn);

  Stream<T> _process() async* {
    try {
      await for (final item in _processFn()) {
        yield item;
      }
      _completer.complete(CompleteReason.done(id));
    } catch (error) {
      _completer.completeError(error);
    }
  }

  @override
  String toString() {
    return 'BlopEvent<$T>($id)';
  }
}

abstract class Blop<Event extends BlopEvent<State>, State>
    extends Bloc<Event, State> {
  Blop(State initialState) : super(initialState);

  final Map<String, _CancelCubit> _cancelCubits =
      {}; // contains only Proccess count cubits

  @override
  Stream<State> mapEventToState(Event event) {
    return event._process();
  }

  Future<State> addProcess(
    Stream<State> Function() processFn,
    String proccessName,
  ) async {
    final event = BlopEvent(processFn);

    final cancelCubit = _cancelCubits.putIfAbsent(
      proccessName,
      () => _CancelCubit(CompleteReason.done(event.id)),
    );

    final _blocker = Completer();

    // listen event complete
    event._completer.future.onError(
      // map error to error event
      (error, stackTrace) {
        return CompleteReason.error(event.id, error!);
      },
    ).then(
      (e) {
        //then call event to cancel other process
        e.maybeWhen(
          done: (id) {
            if (!_blocker.isCompleted) _blocker.complete();
            cancelCubit.emit(CompleteReason.cancel(event.id));
          },
          error: (id, error) {
            if (!_blocker.isCompleted) _blocker.completeError(error);
            cancelCubit.emit(CompleteReason.cancelWithError(event.id, error));
          },
          orElse: () {},
        );
      },
    );

    // listen cancel event
    final cSub = cancelCubit.stream.listen((cevent) {
      // prevent earlier started process from drop later process
      if (cevent.id > event.id && !_blocker.isCompleted) {
        cevent.maybeWhen(
          cancelWithError: (id, error) => _blocker.completeError(error),
          orElse: () => _blocker.complete(),
        );
      }
    });

    // register first and after that fire event
    add(event as Event);

    await _blocker.future;

    cSub.cancel();

    return state;
  }

  @override
  Future<void> close() {
    _cancelCubits.forEach((key, value) => value.close());
    return super.close();
  }
}

abstract class SimpleBlop<State> extends Blop<BlopEvent<State>, State> {
  SimpleBlop(State initialState) : super(initialState);
}
