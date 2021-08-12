// import 'package:remote_data/remote_data.dart';

import 'dart:async';

import 'package:bloc_utils/value_cubit.dart';
import 'package:blop/blop.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remote_value/remote_value.dart';

final dataCubit = () => ValueCubit(() => 'loaded');

class SRemote extends RemoteValueBlop<String> {
  SRemote(dynamic cubit) : super(cubit);

  @override
  // ignore: must_call_super
  void onError(Object error, StackTrace stackTrace) {
    if (error is MethodExecutionException) {
      error.complete();
    }
  }
}

void main() {
  test('correct state switch', () async {
    final v = SRemote(dataCubit());
    expect(v.state, RemoteValue.initial());
    // ignore: unawaited_futures
    v.reload();

    expect(await v.stream.first, RemoteValue.loading());
    expect(await v.stream.first, RemoteValue.data('loaded'));
    // ignore: unawaited_futures
    v.reload();
    expect(await v.stream.first, RemoteValue.loading());
    expect(await v.stream.first, RemoteValue.data('loaded'));
  });

  test('loading future return value', () async {
    final v = SRemote(dataCubit());
    expect(v.state, RemoteValue.initial());

    expect(await v.reload(), RemoteValue.data('loaded'));
  });

  test('auto reload', () async {
    final v = SRemote(dataCubit());
    expect(await v.stream.first, RemoteValue.loading());
    expect(await v.stream.first, RemoteValue.data('loaded'));
  });

  test('reload on change', () async {
    final _dataCubit = dataCubit();
    final v = SRemote(_dataCubit);
    // skip initial reload
    expect(await v.stream.first, RemoteValue.loading());
    expect(await v.stream.first, RemoteValue.data('loaded'));

    _dataCubit.emit(() => 'hell');
    expect(await v.stream.first, RemoteValue.loading());
    expect(await v.stream.first, RemoteValue.data('hell'));

    _dataCubit.emit(() => 'hell2');
    expect(await v.stream.first, RemoteValue.loading());
    expect(await v.stream.first, RemoteValue.data('hell2'));
  });

  test('reload with exception', () async {
    await runZonedGuarded(
      () async {
        final _dataCubit = dataCubit();
        final v = SRemote(_dataCubit);
        // skip initial reload
        expect(await v.stream.first, RemoteValue.loading());
        expect(await v.stream.first, RemoteValue.data('loaded'));

        _dataCubit.emit(() => 'hell');
        expect(await v.stream.first, RemoteValue.loading());
        expect(await v.stream.first, RemoteValue.data('hell'));

        _dataCubit.emit(() => throw 'err');
        expect(await v.stream.first, RemoteValue.loading());

        await v.stream.first;
        expect(v.state, RemoteValue.error('err'));
        assert(true, 'Unreachable');
      },
      (e, __) => expect(e, 'err'),
    );
  });
}
