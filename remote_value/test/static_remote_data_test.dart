// import 'package:remote_data/remote_data.dart';

import 'dart:async';

import 'package:blop/blop.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remote_value/remote_value.dart';

class SRemote extends RemoteValueBlop<String> {
  SRemote([FutureOr<String> Function()? load])
      : super.staticLoader(
          () => Future.delayed(
            Duration(milliseconds: 10),
            load ?? () => 'loaded',
          ),
          reloadOnCreate: false,
        );

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
    final v = SRemote();
    expect(v.state, RemoteModel.initial());
    // ignore: unawaited_futures
    v.reload();

    expect(await v.stream.first, RemoteModel.loading());
    expect(await v.stream.first, RemoteModel.data('loaded'));
    // ignore: unawaited_futures
    v.reload();
    expect(await v.stream.first, RemoteModel.loading());
    expect(await v.stream.first, RemoteModel.data('loaded'));
  });

  test('loading future return value', () async {
    final v = SRemote();
    expect(v.state, RemoteModel.initial());

    expect(await v.reload(), RemoteModel.data('loaded'));
  });

  test('correct error behavior', () async {
    final v = SRemote(() => throw 'error');
    expect(v.state, RemoteModel.initial());
    final f = v.reload();

    expect(await v.stream.first, RemoteModel.loading());
    expect(await v.stream.first, RemoteModel.error('error'));
    expect(await f, RemoteModel.error('error'));
  });
}
