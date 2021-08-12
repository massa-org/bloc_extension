import 'dart:async';

import 'package:hive/hive.dart';

import 'persistent_blop_store.dart';

// TODO add tests for this store

/// Create box for each blopName, and store single value at 0 index with hive serialization
class HiveBlopStore<T> extends PersistentBlopStore<T> {
  late final Box<T> box;
  late FutureOr<T> Function() defaultValue;

  @override
  Future<void> init(
    FutureOr<T> Function() defaultValue,
    String blopName,
  ) async {
    this.defaultValue = defaultValue;
    box = await Hive.openBox<T>(blopName);
  }

  @override
  Future<T> load() async {
    if (box.isNotEmpty) {
      return box.getAt(0) as T;
    } else {
      final def = await defaultValue();
      await box.putAt(0, def);
      return def;
    }
  }

  @override
  Future<T> save(T newValue) async {
    await box.putAt(0, newValue);
    return newValue;
  }
}
