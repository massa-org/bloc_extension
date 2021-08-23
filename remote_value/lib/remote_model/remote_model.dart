import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_model.freezed.dart';

@freezed
abstract class RemoteModel<T> implements _$RemoteModel<T> {
  const RemoteModel._();

  const factory RemoteModel.initial() = _Initial;
  const factory RemoteModel.data(T value) = _Data;
  const factory RemoteModel.loading() = _Loading;
  const factory RemoteModel.error(dynamic error) = _Error;

  // transformers
  // transform on data and cast on other
  RemoteModel<E> transformData<E>(E Function(T value) transform) {
    return when(
      initial: () => RemoteModel.initial(),
      loading: () => RemoteModel.loading(),
      data: (v) => RemoteModel.data(transform(v)),
      error: (error) => RemoteModel.error(error),
    );
  }

  RemoteModel<E> cast<E>() {
    return when(
      initial: () => RemoteModel.initial(),
      loading: () => RemoteModel.loading(),
      data: (v) => RemoteModel.data(v as E),
      error: (error) => RemoteModel.error(error),
    );
  }

  // state check helpers
  bool get isLoaded => maybeWhen(
        orElse: () => true,
        initial: () => false,
        loading: () => false,
      );

  bool get isData => maybeWhen(orElse: () => false, data: (_) => true);
  bool get isError => maybeWhen(orElse: () => false, error: (_) => true);
  bool get isLoading => maybeWhen(orElse: () => false, loading: () => true);
  bool get isInitial => maybeWhen(orElse: () => false, initial: () => true);
}
