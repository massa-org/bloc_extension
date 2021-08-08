import 'dart:async';

/// store abstraction used on PersistentBlop
abstract class PersistentBlopStore<T> {
  /// init call lazy only once before call load or save
  Future<void> init(FutureOr<T> Function() defaultValue, String blopName);

  Future<T> load();

  Future<T> save(T newValue);
}
