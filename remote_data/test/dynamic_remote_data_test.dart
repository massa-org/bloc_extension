// import 'package:remote_data/remote_data.dart';

import 'dart:async';

import 'package:bloc_utils/value_cubit.dart';
import 'package:blop/blop.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remote_data/remote_blop.dart';
import 'package:remote_data/remote_data.dart';

final dataCubit = () => ValueCubit(() => 'loaded');

class SRemote extends RemoteDataBlop<String> {
  SRemote(dynamic cubit) : super(cubit);

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (error is MethodExecutionException) {
      error.complete();
    }
  }
}

void main() {
  test('correct state switch', () async {
    final v = SRemote(dataCubit());
    expect(v.state, RemoteDataModel.initial());
    // ignore: unawaited_futures
    v.reload();

    expect(await v.stream.first, RemoteDataModel.loading());
    expect(await v.stream.first, RemoteDataModel.data('loaded'));
    // ignore: unawaited_futures
    v.reload();
    expect(await v.stream.first, RemoteDataModel.loading());
    expect(await v.stream.first, RemoteDataModel.data('loaded'));
  });

  test('loading future return value', () async {
    final v = SRemote(dataCubit());
    expect(v.state, RemoteDataModel.initial());

    expect(await v.reload(), RemoteDataModel.data('loaded'));
  });

  test('auto reload', () async {
    final v = SRemote(dataCubit());
    expect(await v.stream.first, RemoteDataModel.loading());
    expect(await v.stream.first, RemoteDataModel.data('loaded'));
  });

  test('reload on change', () async {
    final _dataCubit = dataCubit();
    final v = SRemote(_dataCubit);
    // skip initial reload
    expect(await v.stream.first, RemoteDataModel.loading());
    expect(await v.stream.first, RemoteDataModel.data('loaded'));

    _dataCubit.emit(() => 'hell');
    expect(await v.stream.first, RemoteDataModel.loading());
    expect(await v.stream.first, RemoteDataModel.data('hell'));

    _dataCubit.emit(() => 'hell2');
    expect(await v.stream.first, RemoteDataModel.loading());
    expect(await v.stream.first, RemoteDataModel.data('hell2'));
  });

  test('reload with exception', () async {
    await runZonedGuarded(
      () async {
        final _dataCubit = dataCubit();
        final v = SRemote(_dataCubit);
        // skip initial reload
        expect(await v.stream.first, RemoteDataModel.loading());
        expect(await v.stream.first, RemoteDataModel.data('loaded'));

        _dataCubit.emit(() => 'hell');
        expect(await v.stream.first, RemoteDataModel.loading());
        expect(await v.stream.first, RemoteDataModel.data('hell'));

        _dataCubit.emit(() => throw 'err');
        expect(await v.stream.first, RemoteDataModel.loading());

        await v.stream.first;
        expect(v.state, RemoteDataModel.error('err'));
        assert(true, 'Unreachable');
      },
      (e, __) => expect(e, 'err'),
    );
  });
}
