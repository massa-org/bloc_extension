// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// BlopGenerator
// **************************************************************************

abstract class _BlopInterfaceBlopTestClass {
  String _optional<T>(
    Stream<T> v, [
    int num = 0,
    Future<int>? f,
  ]);

  String _empty();

  String _emptyGeneric<T>();

  String _emptyGeneric2<T extends num, E>();

  String _optionalOnly([
    int n = 2,
  ]);

  String _optionalOnly2([
    int n = 2,
    int? h,
  ]);

  String _namedOnly({
    int n = 2,
  });

  String _namedOnly2({
    int n = 2,
    int? h,
  });

  FutureOr<String> _named(
    int v, {
    int n = 2,
    int? h,
  });

  Stream<String> flow(
    List<String> data,
  );

  Stream<String> _implicitStream();

  Future<String> _implicitFuture();

  String _implicitState();
}

mixin _$BlopTestClass on Blop<BlopEvent<String>, String>
    implements _BlopInterfaceBlopTestClass {
// annotated element: _optional generator: stateType
  Future<String> optional<T>(
    Stream<T> v, [
    int num = 0,
    Future<int>? f,
  ]) async {
    return executeMethod(
      () => Future.value(_optional(v, num, f)).asStream(),
      '_optional',
    );
  }

// annotated element: _empty generator: stateType
  Future<String> empty() async {
    return executeMethod(
      () => Future.value(_empty()).asStream(),
      '_empty',
    );
  }

// annotated element: _emptyGeneric generator: stateType
  Future<String> emptyGeneric<T>() async {
    return executeMethod(
      () => Future.value(_emptyGeneric()).asStream(),
      '_emptyGeneric',
    );
  }

// annotated element: _emptyGeneric2 generator: stateType
  Future<String> emptyGeneric2<T extends num, E>() async {
    return executeMethod(
      () => Future.value(_emptyGeneric2()).asStream(),
      '_emptyGeneric2',
    );
  }

// annotated element: _optionalOnly generator: stateType
  Future<String> optionalOnly([
    int n = 2,
  ]) async {
    return executeMethod(
      () => Future.value(_optionalOnly(n)).asStream(),
      '_optionalOnly',
    );
  }

// annotated element: _optionalOnly2 generator: stateType
  Future<String> optionalOnly2([
    int n = 2,
    int? h,
  ]) async {
    return executeMethod(
      () => Future.value(_optionalOnly2(n, h)).asStream(),
      '_optionalOnly2',
    );
  }

// annotated element: _namedOnly generator: stateType
  Future<String> namedOnly({
    int n = 2,
  }) async {
    return executeMethod(
      () => Future.value(_namedOnly(n: n)).asStream(),
      '_namedOnly',
    );
  }

// annotated element: _namedOnly2 generator: stateType
  Future<String> namedOnly2({
    int n = 2,
    int? h,
  }) async {
    return executeMethod(
      () => Future.value(_namedOnly2(n: n, h: h)).asStream(),
      '_namedOnly2',
    );
  }

// annotated element: _named generator: FutureOr<stateType>
  Future<String> named(
    int v, {
    int n = 2,
    int? h,
  }) async {
    return executeMethod(
      () async* {
        yield (await _named(v, n: n, h: h));
      },
      '_named',
    );
  }

// annotated element: flow generator: Stream<stateType>
  Future<String> wtf(
    List<String> data,
  ) async {
    return executeMethod(
      () => flow(data),
      'flow',
    );
  }

// annotated element: _implicitStream generator: Stream<stateType>
  Future<String> implicitStream() async {
    return executeMethod(
      () => _implicitStream(),
      '_implicitStream',
    );
  }

// annotated element: _implicitFuture generator: Future<stateType>
  Future<String> implicitFuture() async {
    return executeMethod(
      () => _implicitFuture().asStream(),
      '_implicitFuture',
    );
  }

// annotated element: _implicitState generator: stateType
  Future<String> implicitState() async {
    return executeMethod(
      () => Future.value(_implicitState()).asStream(),
      '_implicitState',
    );
  }
}
