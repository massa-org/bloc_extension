import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:massa_utils/massa_utils.dart';
import 'package:blop/annotations.dart';
import 'package:blop/blop.dart';
import 'package:remote_value/persistent_blop/store/persistent_blop_store.dart';
import 'package:remote_value/remote_value.dart';

import 'store/hive_blop_store.dart';

part 'persistent_blop.g.dart';

@blopProcessor
class PersistentValueBlop<T> extends RemoteValueBlop<T>
    with _$PersistentValueBlop<T> {
  final PersistentBlopStore<T> _store;
  late final Cubit<FutureOr<T> Function()> _reloadCubit;
  final FutureOr<T> Function() _defaultValue;

  late final String _valueName;

  static dynamic _lrc;
  bool _storeIsInit = false;

  PersistentValueBlop(
    this._defaultValue, {
    PersistentBlopStore<T>? store,
    String? valueName,
    bool reloadOnCreate = true,
  })  : _store = store ?? HiveBlopStore<T>(),
        super(
          _lrc = Cubits.fromValue<FutureOr<T> Function()>(
            () => null as dynamic,
          ),
          reloadOnCreate: false,
          reloadOnLoaderChange: false,
        ) {
    _valueName = valueName ?? runtimeType.toString();
    // HACK all this shitty code only for pass store.load to super constructor, hate this shit
    _reloadCubit = _lrc;
    _lrc = null;
    _reloadCubit.emit(_store.load);

    if (reloadOnCreate) reload();
  }

  @override
  @blopProcess
  Stream<RemoteModel<T>> _reload() async* {
    if (_storeIsInit == false) {
      await _store.init(_defaultValue, _valueName);
      _storeIsInit = true;
    }
    yield RemoteModel.loading();
    yield RemoteModel.data(await loaderBloc.state());
  }

  @override
  @blopProcess
  Stream<RemoteModel<T>> _update(T Function(T v) updateFn) async* {
    if (_storeIsInit == false) yield* _reload();

    yield await state.maybeWhen(
      data: (v) async {
        return RemoteModel.data(await _store.save(updateFn(v)));
      },
      orElse: () => state,
    );
  }
}
