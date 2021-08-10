import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_model.freezed.dart';

@freezed
abstract class RemoteDataModel<T> implements _$RemoteDataModel<T> {
  const RemoteDataModel._();

  const factory RemoteDataModel.initial() = _Initial;
  const factory RemoteDataModel.data(T value) = _Data;
  const factory RemoteDataModel.loading() = _Loading;
  const factory RemoteDataModel.error(dynamic error) = _Error;

  // transformers
  // transform on data and cast on other
  RemoteDataModel<E> transformData<E>(E Function(T value) transform) {
    return when(
      inital: () => RemoteDataModel.initial(),
      loading: () => RemoteDataModel.loading(),
      data: (v) => RemoteDataModel.data(transform(v)),
      error: (error) => RemoteDataModel.error(error),
    );
  }

  RemoteDataModel<E> cast<E>() {
    return when(
      inital: () => RemoteDataModel.initial(),
      loading: () => RemoteDataModel.loading(),
      data: (v) => RemoteDataModel.data(v as E),
      error: (error) => RemoteDataModel.error(error),
    );
  }

  // state check helpers
  bool get isLoaded => maybeWhen(
        orElse: () => true,
        inital: () => false,
        loading: () => false,
      );

  bool get isData => maybeWhen(orElse: () => false, data: (_) => true);
  bool get isError => maybeWhen(orElse: () => false, error: (_) => true);
  bool get isLoading => maybeWhen(orElse: () => false, loading: () => true);
  bool get isInitial => maybeWhen(orElse: () => false, inital: () => true);
}
