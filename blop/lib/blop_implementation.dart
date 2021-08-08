import 'package:bloc/bloc.dart';

import 'blop_event.dart';
import 'completer_strategy/blop_complete_strategy.dart';
import 'method_execution_exception.dart';

abstract class Blop<Event extends BlopEvent<State>, State>
    extends Bloc<Event, State> {
  final MethodCompleterStrategy completerStrategy;
  Blop(
    State initialState, {
    MethodCompleterStrategy? completerStrategy,
  })  : completerStrategy =
            completerStrategy ?? MethodCompleterStrategy.doNothing(),
        super(initialState);

  @override
  Stream<State> mapEventToState(Event event) {
    return event.execute();
  }

  Future<State> executeMethod(
    Stream<State> Function() processFn,
    String processName,
  ) async {
    final event = BlopEvent(processFn, processName);
    final completeFuture = completerStrategy.waitComplete(event);

    // register first and after that fire event
    add(event as Event);

    await completeFuture;

    return state;
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (error is MethodExecutionException) {
      error.complete();
    }
    super.onError(error, stackTrace);
  }

  @override
  Future<void> close() async {
    await completerStrategy.close(runtimeType);
    return super.close();
  }
}

abstract class SimpleBlop<State> extends Blop<BlopEvent<State>, State> {
  SimpleBlop(State initialState, {MethodCompleterStrategy? completerStrategy})
      : super(
          initialState,
          completerStrategy: completerStrategy,
        );
}
