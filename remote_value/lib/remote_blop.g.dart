// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remote_blop.dart';

// **************************************************************************
// BlopGenerator
// **************************************************************************

abstract class _BlopInterfaceRemoteValueBlop<T> {
  Stream<RemoteModel<T>> _reload();
}

mixin _$RemoteValueBlop<T> on Blop<BlopEvent<RemoteModel<T>>, RemoteModel<T>>
    implements _BlopInterfaceRemoteValueBlop<T> {
// annotated element: _reload generator: Stream<stateType>
  Future<RemoteModel<T>> reload() async {
    return executeMethod(
      () => _reload(),
      '_reload',
    );
  }
}
