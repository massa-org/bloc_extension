// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:massa_utils/massa_utils.dart';
import 'package:blop/annotations.dart';
import 'package:blop/blop.dart';
import 'package:blop/blop_event.dart';
import 'package:remote_value/remote_value.dart';

part 'remote_blop.g.dart';

/// base class to use in generics
abstract class RemoteValueBlopBase<T> implements BlocBase<RemoteModel<T>> {
  Future<RemoteModel<T>> reload();
}

@blopProcessor
abstract class RemoteValueBlop<T> extends SimpleBlop<RemoteModel<T>>
    with BlocSubscriptionManager, _$RemoteValueBlop<T>
    implements RemoteValueBlopBase<T> {
  final Cubit<FutureOr<T> Function()> loaderBloc;

  RemoteValueBlop(
    this.loaderBloc, {
    bool reloadOnLoaderChange = true,
    bool reloadOnCreate = true,
  }) : super(RemoteModel.initial()) {
    if (reloadOnLoaderChange) listenBlocs([loaderBloc], reload);
    if (reloadOnCreate) reload();
  }

  RemoteValueBlop.staticLoader(
    FutureOr<T> Function() loader, {
    bool reloadOnCreate = true,
  })  : loaderBloc = Cubits.fromValue(loader),
        super(RemoteModel.initial()) {
    if (reloadOnCreate) reload();
  }

  /// return state if it loaded or await first data | error event and return
  Future<RemoteModel<T>> get loadingFuture async {
    if (state.isLoaded) return state;
    return stream.firstWhere((e) => state.isLoaded);
  }

  @override
  Future<void> close() async {
    await closeManager();
    return super.close();
  }

  @override
  @blopProcess
  Stream<RemoteModel<T>> _reload() async* {
    yield RemoteModel.loading();
    late RemoteModel<T> ret;
    try {
      ret = RemoteModel.data(await loaderBloc.state());
    } catch (error) {
      ret = RemoteModel.error(error);
    }
    yield ret;
  }

  @override
  Stream<BlopEvent<RemoteModel<T>>> transformEvents(
    Stream<BlopEvent<RemoteModel<T>>> events,
    Stream<BlopEvent<RemoteModel<T>>> Function(
      BlopEvent<RemoteModel<T>> event,
    )
        mapper,
  ) {
    return super
        .transformEvents(events, mapper)
        .handleError((error, stackTrace) => emit(RemoteModel.error(error)));
  }

  @override
  // ignore: must_call_super
  void onError(Object error, StackTrace stackTrace) {
    if (error is MethodExecutionException) {
      error.complete();
      emit(RemoteModel.error(error.error));
    } else {
      emit(RemoteModel.error(error));
    }
  }
}
