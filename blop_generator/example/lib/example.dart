// ignore_for_file: unused_element
import 'dart:async';

import 'package:blop/blop.dart';

part 'example.g.dart';

@blopProcessor
class BlopTestClass extends SimpleBlop<String> with _$BlopTestClass {
  BlopTestClass(initialState) : super(initialState);

  @override
  @blopProcess
  String _optional<T>(Stream<T> v, [int num = 0, Future<int>? f]) => '';
  @override
  @blopProcess
  String _empty() => '';

  @override
  @blopProcess
  String _emptyGeneric<T>() => '';

  @override
  @blopProcess
  String _emptyGeneric2<T extends num, E>() => '';

  @override
  @blopProcess
  String _optionalOnly([int n = 2]) => '';

  @override
  @blopProcess
  String _optionalOnly2([int n = 2, int? h]) => '';

  @override
  @blopProcess
  String _namedOnly({int n = 2}) => '';

  @override
  @blopProcess
  String _namedOnly2({int n = 2, int? h}) => '';

  @override
  @blopProcess
  FutureOr<String> _named(int v, {int n = 2, int? h}) => '';

  @override
  @BlopProcess(name: 'wtf')
  Stream<String> flow(List<String> data) async* {
    for (final v in data) {
      await Future.delayed(Duration(seconds: 2));
      yield v;
    }
  }

  @override
  @blopProcess
  Stream<String> _implicitStream() async* {}

  @override
  @blopProcess
  Future<String> _implicitFuture() async {
    return 'string';
  }

  @override
  @blopProcess
  String _implicitState() => 'string';
}
