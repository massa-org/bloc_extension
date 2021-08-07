import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_utils/bloc_utils.dart';
import 'package:blop/annotations.dart';
import 'package:blop/blop.dart';

import 'remote_model.dart';

part 'remote_blop.g.dart';

@blopProcessor
abstract class RemoteDataBlop<T> extends SimpleBlop<RemoteDataModel<T>>
    with BlocSubscriptionManager, _$RemoteDataBlop<T> {
  final Cubit<FutureOr<T> Function()> loaderBloc;
  final bool reloadOnLoaderChange;

  RemoteDataBlop(
    this.loaderBloc, {
    this.reloadOnLoaderChange = true,
    bool reloadOnCreate = true,
  }) : super(RemoteDataModel.inital()) {
    if (reloadOnLoaderChange) listenBlocs([loaderBloc], reload);
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
    try {
      yield RemoteDataModel.loading();

      yield RemoteDataModel.data(await loaderBloc.state());
    } catch (error) {
      yield RemoteDataModel.error(error);
      rethrow;
    }
  }
}
