// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistent_blop.dart';

// **************************************************************************
// BlopGenerator
// **************************************************************************

abstract class _BlopInterfacePersistentValueBlop<T> {
  Stream<RemoteValue<T>> __updateWithInit(
    T Function(T) updateFn,
  );

  FutureOr<RemoteValue<T>> __update(
    T Function(T) updateFn,
  );
}

mixin _$PersistentValueBlop<T>
    on Blop<BlopEvent<RemoteValue<T>>, RemoteValue<T>>
    implements _BlopInterfacePersistentValueBlop<T> {
// annotated element: __updateWithInit generator: Stream<stateType>
  Future<RemoteValue<T>> _updateWithInit(
    T Function(T) updateFn,
  ) async {
    return executeMethod(
      () => __updateWithInit(updateFn),
      '__updateWithInit',
    );
  }

// annotated element: __update generator: FutureOr<stateType>
  Future<RemoteValue<T>> _update(
    T Function(T) updateFn,
  ) async {
    return executeMethod(
      () async* {
        yield (await __update(updateFn));
      },
      '__update',
    );
  }
}
