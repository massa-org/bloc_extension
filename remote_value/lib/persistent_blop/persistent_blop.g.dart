// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistent_blop.dart';

// **************************************************************************
// BlopGenerator
// **************************************************************************

abstract class _BlopInterfacePersistentValueBlop<T> {
  Stream<RemoteModel<T>> _reload();

  Stream<RemoteModel<T>> _update(
    T Function(T) updateFn,
  );
}

mixin _$PersistentValueBlop<T>
    on Blop<BlopEvent<RemoteModel<T>>, RemoteModel<T>>
    implements _BlopInterfacePersistentValueBlop<T> {
// annotated element: _reload generator: Stream<stateType>
  Future<RemoteModel<T>> reload() async {
    return executeMethod(
      () => _reload(),
      '_reload',
    );
  }

// annotated element: _update generator: Stream<stateType>
  Future<RemoteModel<T>> update(
    T Function(T) updateFn,
  ) async {
    return executeMethod(
      () => _update(updateFn),
      '_update',
    );
  }
}
