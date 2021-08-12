import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:massa_utils/massa_utils.dart';
import 'package:blop/annotations.dart';
import 'package:blop/blop.dart';
import 'package:blop/blop_event.dart';
import 'package:remote_value/remote_value.dart';

part 'remote_blop.g.dart';

@blopProcessor
abstract class RemoteValueBlop<T> extends SimpleBlop<RemoteValue<T>>
    with BlocSubscriptionManager, _$RemoteValueBlop<T> {
  final Cubit<FutureOr<T> Function()> loaderBloc;

  RemoteValueBlop(
    this.loaderBloc, {
    bool reloadOnLoaderChange = true,
    bool reloadOnCreate = true,
  }) : super(RemoteValue.initial()) {
    if (reloadOnLoaderChange) listenBlocs([loaderBloc], reload);
    if (reloadOnCreate) reload();
  }

  RemoteValueBlop.staticLoader(
    FutureOr<T> Function() loader, {
    bool reloadOnCreate = true,
  })  : loaderBloc = Cubits.fromValue(loader),
        super(RemoteValue.initial()) {
    if (reloadOnCreate) reload();
  }

  /// return state if it loaded or await first data | error event and return
  Future<RemoteValue<T>> get loadingFuture async {
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
  Stream<RemoteValue<T>> _reload() async* {
    yield RemoteValue.loading();

    yield RemoteValue.data(await loaderBloc.state());
  }

  // supress all errors and convert it to RemoteDataModel.error
  @override
  Stream<RemoteValue<T>> mapEventToState(
    BlopEvent<RemoteValue<T>> event,
  ) async* {
    try {
      final str = super.mapEventToState(event);
      await for (final state in str) {
        yield state;
      }
    } on MethodExecutionException catch (error) {
      yield RemoteValue.error(error.error);
      rethrow;
    } catch (error) {
      yield RemoteValue.error(error);
      rethrow;
    }
  }
}
