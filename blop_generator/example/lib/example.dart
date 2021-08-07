import 'dart:async';

import 'package:blop/annotations.dart';
import 'package:blop/blop.dart';

part 'example.g.dart';

@blopProcessor
class BlopTestClass extends SimpleBlop<String> with _$BlopTestClass {
  BlopTestClass(initialState) : super(initialState);

  @blopProcess
  String _optional<T>(Stream<T> v, [int num = 0, Future<int>? f]) => '';
  @blopProcess
  String _empty() => '';

  @blopProcess
  String _emptyGeneric<T>() => '';

  @blopProcess
  String _emptyGeneric2<T extends num, E>() => '';

  @blopProcess
  String _optionalOnly([int n = 2]) => '';

  @blopProcess
  String _optionalOnly2([int n = 2, int? h]) => '';

  @blopProcess
  String _namedOnly({int n = 2}) => '';

  @blopProcess
  String _namedOnly2({int n = 2, int? h}) => '';

  @blopProcess
  FutureOr<String> _named(int v, {int n = 2, int? h}) => '';

  @BlopProcess(name: 'wtf')
  Stream<String> flow(List<String> data) async* {
    for (final v in data) {
      await Future.delayed(Duration(seconds: 2));
      yield v;
    }
  }

  @blopProcess
  _implicitStream() async* {}

  @blopProcess
  _implicitFuture() async {
    return 'string';
  }

  @blopProcess
  _implicitState() => 'string';
}
