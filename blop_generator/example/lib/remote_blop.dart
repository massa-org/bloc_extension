import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blop/annotations.dart';
import 'package:blop/blop.dart';
import 'package:massa_utils/massa_utils.dart';

import 'remote_model.dart';

part 'remote_blop.g.dart';

@blopProcessor
abstract class RemoteDataBlop<T> extends SimpleBlop<RemoteDataModel<T>>
    with BlocSubscriptionManager, _$RemoteDataBlop<T> {
  final Duration reloadDebounceDuration;
  final Cubit<FutureOr<T> Function()> loaderBloc;
  final bool reloadOnLoaderChange;

  RemoteDataBlop(
    this.loaderBloc, {
    this.reloadDebounceDuration = const Duration(milliseconds: 250),
    this.reloadOnLoaderChange = false,
  }) : super(RemoteDataModel.inital()) {
    if (reloadOnLoaderChange) listenBlocs([loaderBloc], reload);
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

  @override
  Stream<BlopEvent<RemoteDataModel<T>>> transformEvents(
    Stream<BlopEvent<RemoteDataModel<T>>> events,
    Stream<BlopEvent<RemoteDataModel<T>>> Function(
      BlopEvent<RemoteDataModel<T>> event,
    )
        mapper,
  ) {
    return super.transformEvents(events, mapper);
  }
}
