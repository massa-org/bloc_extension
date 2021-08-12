import 'package:bloc/bloc.dart';
import 'package:blop/blop.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rxdart/rxdart.dart';

class TestBlop extends SimpleBlop<String> {
  TestBlop() : super('');

  Future<String> returnValue(String value) {
    return executeMethod(
      () async* {
        yield value;
      },
      'returnValue',
    );
  }

  Future<String> returnLast(String value) {
    return executeMethod(
      () async* {
        yield value + '_some_random_shit';
        yield value;
      },
      'returnLast',
    );
  }

  Future<String> throwValue(String value) {
    return executeMethod(
      () async* {
        yield value + '_some_random_shit';

        throw value;
      },
      'throwValue',
    );
  }

  Future<String> multipleValue(String value) {
    return executeMethod(
      () async* {
        yield value + '_some_random_shit';

        await Future.delayed(Duration(milliseconds: 100));

        yield value;
      },
      'multipleValue',
    );
  }

  Future<String> multipleValueThrow(String value) {
    return executeMethod(
      () async* {
        yield value + '_some_random_shit';

        await Future.delayed(Duration(milliseconds: 100));

        yield value + 'as';
        throw value;
      },
      'multipleValueThrow',
    );
  }

  @override
  // ignore: must_call_super
  void onError(Object error, StackTrace stackTrace) {
    if (error is MethodExecutionException) error.complete();
    // super.onError(error, stackTrace);
  }
}

class DebounceBlop extends SimpleBlop<String> {
  DebounceBlop()
      : super(
          '',
          completerStrategy: MethodCompleterStrategy.completeOlderSameType(),
        );

  Future<String> multipleValue(String value) {
    return executeMethod(
      () async* {
        yield value + '_some_random_shit';

        await Future.delayed(Duration(milliseconds: 200));

        yield value;
      },
      'multipleValue',
    );
  }

  Future<String> multipleValueThrow(String value) {
    return executeMethod(
      () async* {
        yield value + '_some_random_shit';

        await Future.delayed(Duration(milliseconds: 200));

        yield value + 'as';
        throw value;
      },
      'multipleValueThrow',
    );
  }

  @override
  Stream<Transition<BlopEvent<String>, String>> transformEvents(
    Stream<BlopEvent<String>> events,
    TransitionFunction<BlopEvent<String>, String> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(Duration(milliseconds: 100)),
      transitionFn,
    );
  }

  @override
  // ignore: must_call_super
  void onError(Object error, StackTrace stackTrace) {
    if (error is MethodExecutionException) error.complete();
    // super.onError(error, stackTrace);
  }
}

void main() {
  test('process returns value', () async {
    final testBlop = TestBlop();
    expect(await testBlop.returnValue('actual_value'), 'actual_value');
  });
  test('process returns last yielded value', () async {
    final testBlop = TestBlop();
    expect(await testBlop.returnLast('actual_value'), 'actual_value');
  });

  test('process throw value', () async {
    final testBlop = TestBlop();
    expect(() => testBlop.throwValue('actual_value'), throwsA('actual_value'));
  });

  test('earlier runned process does\'t cancel next with value', () async {
    final testBlop = TestBlop();
    final data = await Future.wait([
      testBlop.multipleValue('actual_value'),
      testBlop.multipleValue('actual_val'),
    ]);
    expect(data, ['actual_value', 'actual_val']);
  });

  test('earlier runned process does\'t cancel next with error', () async {
    final testBlop = TestBlop();
    final futures = [
      testBlop.multipleValueThrow('actual_value'),
      testBlop.multipleValue('actual_val'),
    ];
    expect(futures[0], throwsA('actual_value'));
    expect(await futures[1], 'actual_val');
  });

  test('multiple throw', () async {
    final testBlop = TestBlop();
    final futures = [
      testBlop.multipleValueThrow('actual_value'),
      testBlop.multipleValueThrow('actual_val'),
    ];
    expect(futures[0], throwsA('actual_value'));
    expect(futures[1], throwsA('actual_val'));
  });

  test('process cancel earlier droped process with value', () async {
    final testBlop = DebounceBlop();
    final data = await Future.wait([
      testBlop.multipleValue('actual_value'),
      testBlop.multipleValue('actual_val'),
    ]);
    expect(data, ['actual_val', 'actual_val']);
  });

  test('process cancel earlier droped process with error', () async {
    final testBlop = DebounceBlop();
    final futures = [
      testBlop.multipleValueThrow('actual_value'),
      testBlop.multipleValueThrow('actual_val'),
    ];
    expect(futures[0], throwsA('actual_val'));
    expect(futures[1], throwsA('actual_val'));
  });
}
