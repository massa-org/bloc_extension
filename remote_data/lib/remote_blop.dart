import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_utils/bloc_utils.dart';
import 'package:blop/annotations.dart';
import 'package:blop/blop.dart';
import 'package:blop/blop_event.dart';

import 'remote_model.dart';

part 'remote_blop.g.dart';

@blopProcessor
abstract class RemoteDataBlop<T> extends SimpleBlop<RemoteDataModel<T>>
    with BlocSubscriptionManager, _$RemoteDataBlop<T> {
  final Cubit<FutureOr<T> Function()> loaderBloc;

  RemoteDataBlop(
    this.loaderBloc, {
    bool reloadOnLoaderChange = true,
    bool reloadOnCreate = true,
  }) : super(RemoteDataModel.inital()) {
    if (reloadOnLoaderChange) listenBlocs([loaderBloc], reload);
    if (reloadOnCreate) reload();
  }

  RemoteDataBlop.staticLoader(
    FutureOr<T> Function() loader, {
    bool reloadOnCreate = true,
  })  : loaderBloc = Cubits.fromValue(loader),
        super(RemoteDataModel.inital()) {
    if (reloadOnCreate) reload();
  }

  @override
  Future<void> close() async {
    await closeManager();
    return super.close();
  }

  @override
  @blopProcess
  Stream<RemoteDataModel<T>> _reload() async* {
    yield RemoteDataModel.loading();

    yield RemoteDataModel.data(await loaderBloc.state());
  }

  // supress all errors and convert it to RemoteDataModel.error
  @override
  Stream<RemoteDataModel<T>> mapEventToState(
    BlopEvent<RemoteDataModel<T>> event,
  ) async* {
    try {
      final str = super.mapEventToState(event);
      await for (final state in str) {
        yield state;
      }
    } on MethodExecutionException catch (error) {
      yield RemoteDataModel.error(error.error);
      rethrow;
    } catch (error) {
      yield RemoteDataModel.error(error);
      rethrow;
    }
  }
}
