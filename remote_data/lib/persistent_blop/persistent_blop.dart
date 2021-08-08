import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_utils/value_cubit.dart';
import 'package:blop/annotations.dart';
import 'package:blop/blop.dart';
import 'package:hive/hive.dart';
import 'package:remote_data/remote_blop.dart';
import 'package:remote_data/remote_model.dart';

part 'persistent_blop.g.dart';

typedef _DefaultFn<T> = FutureOr<T> Function();

abstract class PersistentStore<T> {
  Future<void> init(_DefaultFn<T> defaultValue, String valueName);

  Future<T> load();

  Future<T> save(T newValue);
}

class HiveStore<T> extends PersistentStore<T> {
  late final Box<T> box;
  late _DefaultFn<T> defaultValue;

  @override
  Future<void> init(_DefaultFn<T> defaultValue, String valueName) async {
    this.defaultValue = defaultValue;
    box = await Hive.openBox<T>(valueName);
  }

  @override
  Future<T> load() async {
    if (box.isNotEmpty) {
      return box.getAt(0) as T;
    } else {
      final def = await defaultValue();
      await box.putAt(0, def);
      return def;
    }
  }

  @override
  Future<T> save(T newValue) async {
    await box.putAt(0, newValue);
    return newValue;
  }
}

@blopProcessor
class PersistentBlop<T> extends RemoteDataBlop<T> with _$PersistentBlop<T> {
  final PersistentStore<T> _store;
  late final Cubit<FutureOr<T> Function()> _reloadCubit;
  final _DefaultFn<T> _defaultValue;
  late final String _valueName;

  static dynamic _lrc;

  var _currentReload;
  var _currentUpdate;

  PersistentBlop(
    this._defaultValue, {
    PersistentStore<T>? store,
    String? valueName,
  })  : _store = store ?? HiveStore<T>(),
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

    _currentReload = _reloadWithInit;
    _currentUpdate = _updateWithInit;
  }

  Future<RemoteDataModel<T>> _reloadWithInit() async {
    await _store.init(_defaultValue, _valueName);
    _currentUpdate = _update;
    _currentReload = super.reload;

    return super.reload();
  }

  @override
  Future<RemoteDataModel<T>> reload() async {
    return _currentReload();
  }

  @override
  @blopProcess
  Stream<RemoteDataModel<T>> __updateWithInit(
    T Function(T v) updateFn,
  ) async* {
    await _store.init(_defaultValue, _valueName);
    final data = await _store.load();
    yield RemoteDataModel.data(data);
    await stream.first;
    yield (await __update(updateFn));
    _currentUpdate = _update;
    _currentReload = super.reload;
  }

  Future<RemoteDataModel<T>> update(T Function(T v) updateFn) {
    return _currentUpdate(updateFn);
  }

  @override
  @blopProcess
  FutureOr<RemoteDataModel<T>> __update(T Function(T v) updateFn) async {
    return state.maybeWhen(
      data: (v) async {
        return RemoteDataModel.data(await _store.save(updateFn(v)));
      },
      orElse: () => state,
    );
  }
}
