import 'dart:async';

import 'package:bloc/bloc.dart';

mixin StreamSubscriptionManager {
  List<StreamSubscription> _sub = [];

  void listenStreams(Iterable<Stream> cubits, void Function() update) {
    _sub = cubits.map((e) => e.listen((_) => update())).toList();
  }

  Future<void> closeManager() async {
    await Future.wait(_sub.map((e) => e.cancel()));
  }
}

mixin BlocSubscriptionManager {
  List<StreamSubscription> _sub = [];

  void listenStreams(Iterable<Stream> cubits, void Function() update) {
    _sub = cubits.map((e) => e.listen((_) => update())).toList();
  }

  void listenBlocs(Iterable<BlocBase> cubits, void Function() update) {
    listenStreams(cubits.map((e) => e.stream), update);
  }

  Future<void> closeManager() async {
    await Future.wait(_sub.map((e) => e.cancel()));
  }
}
