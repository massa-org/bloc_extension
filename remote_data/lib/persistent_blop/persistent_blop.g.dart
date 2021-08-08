// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'persistent_blop.dart';

// **************************************************************************
// BlopGenerator
// **************************************************************************

abstract class _BlopInterfacePersistentBlop<T> {
  Stream<RemoteDataModel<T>> __updateWithInit(
    T Function(T) updateFn,
  );

  FutureOr<RemoteDataModel<T>> __update(
    T Function(T) updateFn,
  );
}

mixin _$PersistentBlop<T>
    on Blop<BlopEvent<RemoteDataModel<T>>, RemoteDataModel<T>>
    implements _BlopInterfacePersistentBlop<T> {
// annotated element: __updateWithInit generator: Stream<stateType>
  Future<RemoteDataModel<T>> _updateWithInit(
    T Function(T) updateFn,
  ) async {
    return executeMethod(
      () => __updateWithInit(updateFn),
      '__updateWithInit',
    );
  }

// annotated element: __update generator: FutureOr<stateType>
  Future<RemoteDataModel<T>> _update(
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
