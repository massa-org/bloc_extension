// import 'package:remote_data/remote_data.dart';

import 'dart:async';

import 'package:blop/blop.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remote_data/remote_blop.dart';
import 'package:remote_data/remote_model.dart';

class SRemote extends RemoteDataBlop<String> {
  SRemote([FutureOr<String> Function()? load])
      : super.staticLoader(
          () => Future.delayed(
            Duration(milliseconds: 10),
            load ?? () => 'loaded',
          ),
          reloadOnCreate: false,
        );

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (error is MethodExecutionException) {
      error.complete();
    }
  }
}

void main() {
  test('correct state switch', () async {
    final v = SRemote();
    expect(v.state, RemoteDataModel.inital());
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
    final v = SRemote();
    expect(v.state, RemoteDataModel.inital());

    expect(await v.reload(), RemoteDataModel.data('loaded'));
  });

  test('correct error behavior', () async {
    final v = SRemote(() => throw 'error');
    expect(v.state, RemoteDataModel.inital());
    expect(v.reload(), throwsA('error'));
    expect(await v.stream.first, RemoteDataModel.loading());
    expect(await v.stream.first, RemoteDataModel.error('error'));
  });
}
