import 'dart:async';

import 'package:bloc/bloc.dart';

/// Listen stream and call update on event
/// on dispose or close must call closeManager
mixin StreamSubscriptionManager {
  final List<StreamSubscription> _sub = [];

  void listenStreams(Iterable<Stream> streams, void Function() update) {
    _sub.addAll(streams.map((e) => e.listen((_) => update())));
  }

  Future<void> closeManager() async {
    await Future.wait(_sub.map((e) => e.cancel()));
  }
}

/// Listen stream or bloc and call update on event
/// on dispose or close must call closeManager
mixin BlocSubscriptionManager {
  final List<StreamSubscription> _sub = [];

  void listenStreams(Iterable<Stream> streams, void Function() update) {
    _sub.addAll(streams.map((e) => e.listen((_) => update())));
  }

  void listenBlocs(Iterable<BlocBase> cubits, void Function() update) {
    listenStreams(cubits.map((e) => e.stream), update);
  }

  Future<void> closeManager() async {
    await Future.wait(_sub.map((e) => e.cancel()));
  }
}
