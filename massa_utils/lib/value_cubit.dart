import 'dart:async';

import 'package:bloc/bloc.dart';

/// not abstract variant of cubit, yep it's not create new class
class ValueCubit<T> extends Cubit<T> {
  ValueCubit(T initialState) : super(initialState);
}

/// listen data events and emit it
class StreamCubit<T> extends Cubit<T> {
  late final StreamSubscription _sub;

  StreamCubit(T initialValue, Stream<T> stream) : super(initialValue) {
    _sub = stream.listen((event) => emit(event));
  }

  @override
  Future<void> close() {
    _sub.cancel();
    return super.close();
  }
}

/// simple cubit creation helpers, useful for testing
class Cubits {
  static Cubit<T> fromValue<T>(T value) => ValueCubit(value);
  static Cubit<T> fromStream<T>(T initialValue, Stream<T> stream) =>
      StreamCubit(initialValue, stream);
  static Cubit<T> fromFuture<T>(T initialValue, Future<T> future) =>
      StreamCubit(initialValue, future.asStream());
}
