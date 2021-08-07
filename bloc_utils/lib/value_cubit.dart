// not abstract variant of cubit, yep it's not named

import 'dart:async';

import 'package:bloc/bloc.dart';

class ValueCubit<T> extends Cubit<T> {
  ValueCubit(T initialState) : super(initialState);
}

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

class Cubits {
  static Cubit<T> fromValue<T>(T value) => ValueCubit(value);
  static Cubit<T> fromStream<T>(T initialValue, Stream<T> stream) =>
      StreamCubit(initialValue, stream);
}
