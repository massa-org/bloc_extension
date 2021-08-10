import 'dart:async';

import 'package:blop/blop.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:remote_data/persistent_blop/persistent_blop.dart';
import 'package:remote_data/persistent_blop/store/persistent_blop_store.dart';
import 'package:remote_data/remote_data.dart';

typedef _DefaultFn<T> = FutureOr<T> Function();

class MockStore<T> extends PersistentBlopStore<T> {
  bool hasValue = false;
  bool isInit = false;
  late T val;
  late _DefaultFn<T> defaultValue;

  @override
  Future<void> init(_DefaultFn<T> defaultValue, String valueName) async {
    this.defaultValue = defaultValue;
    isInit = true;
  }

  @override
  Future<T> load() async {
    if (isInit == false) throw 'uninitialized_error';
    if (hasValue) {
      return val;
    }
    val = await defaultValue();
    hasValue = true;
    return val;
  }

  @override
  Future<T> save(newValue) async {
    if (isInit == false) throw 'uninitialized_error';
    return val = newValue;
  }
}

class PBTest extends PersistentBlop<String> {
  PBTest({String Function()? defaultValue})
      : super(
          () => Future.delayed(
            Duration(milliseconds: 50),
            defaultValue ?? () => 'initial default value',
          ),
          store: MockStore<String>(),
        );

  // need this to prevent UnhandledBlocException in debug mode
  @override
  // ignore: must_call_super
  void onError(Object error, StackTrace stackTrace) {
    if (error is MethodExecutionException) {
      error.complete();
    }
  }
}

void main() async {
  test('check correct initialization', () async {
    final pb = PBTest();

    expect(pb.state, RemoteDataModel.initial());
    expect(await pb.reload(), RemoteDataModel.data('initial default value'));
  });

  test('catch error from initialization', () async {
    final pb = PBTest(defaultValue: () => throw 'err');
    expect(pb.state, RemoteDataModel.initial());

    expect(pb.reload(), throwsA('err'));
  });

  test('catch error from initialization multiple times', () async {
    final pb = PBTest(defaultValue: () => throw 'err');
    expect(pb.state, RemoteDataModel.initial());

    expect(pb.reload(), throwsA('err'));
    expect(pb.reload(), throwsA('err'));
  });

  test('error from initialization appear in state', () async {
    final pb = PBTest(defaultValue: () => throw 'err');
    expect(pb.state, RemoteDataModel.initial());

    await pb.reload().onError((error, stackTrace) => pb.state);

    expect(pb.state, RemoteDataModel.error('err'));
  });

  test('check correct value update', () async {
    final pb = PBTest();
    expect(pb.state, RemoteDataModel.initial());
    expect(await pb.reload(), RemoteDataModel.data('initial default value'));

    expect(
      await pb.update((_) => 'new_value'),
      RemoteDataModel.data('new_value'),
    );
  });

  test('update work correct without init', () async {
    final pb = PBTest();
    expect(pb.state, RemoteDataModel.initial());

    expect(
      await pb.update((_) => 'new_value'),
      RemoteDataModel.data('new_value'),
    );
  });
  test('update catch error from init', () async {
    final pb = PBTest(defaultValue: () => throw 'err');
    expect(pb.state, RemoteDataModel.initial());

    expect(
      pb.update((_) => 'new_value'),
      throwsA('err'),
    );
    await pb.stream.first;
    expect(pb.state, RemoteDataModel.error('err'));
  });

  test('catch error from update', () async {
    final pb = PBTest();
    expect(pb.state, RemoteDataModel.initial());
    expect(await pb.reload(), RemoteDataModel.data('initial default value'));

    expect(
      pb.update((_) => throw 'error'),
      throwsA('error'),
    );
  });

  test('error from update appear in state', () async {
    final pb = PBTest();
    expect(pb.state, RemoteDataModel.initial());
    expect(await pb.reload(), RemoteDataModel.data('initial default value'));
    await pb
        .update((_) => throw 'error')
        .onError((error, stackTrace) => pb.state);

    expect(
      pb.state,
      RemoteDataModel.error('error'),
    );
  });
}
