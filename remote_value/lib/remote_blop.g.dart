// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_blop.dart';

// **************************************************************************
// BlopGenerator
// **************************************************************************

abstract class _BlopInterfaceRemoteValueBlop<T> {
  Stream<RemoteValue<T>> _reload();
}

mixin _$RemoteValueBlop<T> on Blop<BlopEvent<RemoteValue<T>>, RemoteValue<T>>
    implements _BlopInterfaceRemoteValueBlop<T> {
// annotated element: _reload generator: Stream<stateType>
  Future<RemoteValue<T>> reload() async {
    return executeMethod(
      () => _reload(),
      '_reload',
    );
  }
}
