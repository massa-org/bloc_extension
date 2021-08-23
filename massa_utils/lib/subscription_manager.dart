import 'dart:async';

import 'package:bloc/bloc.dart';

/// Listen stream and call update on each event
/// must call closeManager on dispose or close
mixin StreamSubscriptionManager {
  final List<StreamSubscription> _sub = [];

  void listenStreams(Iterable<Stream> streams, void Function() update) {
    _sub.addAll(streams.map((e) => e.listen((_) => update())));
  }

  Future<void> closeManager() async {
    await Future.wait(_sub.map((e) => e.cancel()));
  }
}

/// Listen stream or bloc and call update on each event
/// must call closeManager on dispose or close
mixin BlocSubscriptionManager {
  final List<StreamSubscription> _sub = [];

  /// listen stream and call update but can't get access to event value :[
  void listenStreams(Iterable<Stream> streams, void Function() update) {
    _sub.addAll(streams.map((e) => e.listen((_) => update())));
  }

  /// listen blocs and call update
  /// can add multiple listeners and can be called multiple times with different arguments
  void listenBlocs(Iterable<BlocBase> cubits, void Function() update) {
    listenStreams(cubits.map((e) => e.stream), update);
  }

  // Cancel all subscriptions
  Future<void> closeManager() async {
    await Future.wait(_sub.map((e) => e.cancel()));
  }
}
