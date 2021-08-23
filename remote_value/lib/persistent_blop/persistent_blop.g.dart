// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistent_blop.dart';

// **************************************************************************
// BlopGenerator
// **************************************************************************

abstract class _BlopInterfacePersistentValueBlop<T> {
  Stream<RemoteModel<T>> __updateWithInit(
    T Function(T) updateFn,
  );

  FutureOr<RemoteModel<T>> __update(
    T Function(T) updateFn,
  );
}

mixin _$PersistentValueBlop<T>
    on Blop<BlopEvent<RemoteModel<T>>, RemoteModel<T>>
    implements _BlopInterfacePersistentValueBlop<T> {
// annotated element: __updateWithInit generator: Stream<stateType>
  Future<RemoteModel<T>> _updateWithInit(
    T Function(T) updateFn,
  ) async {
    return executeMethod(
      () => __updateWithInit(updateFn),
      '__updateWithInit',
    );
  }

// annotated element: __update generator: FutureOr<stateType>
  Future<RemoteModel<T>> _update(
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
