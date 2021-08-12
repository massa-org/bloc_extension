import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_model.freezed.dart';

@freezed
abstract class RemoteValue<T> implements _$RemoteValue<T> {
  const RemoteValue._();

  const factory RemoteValue.initial() = _Initial;
  const factory RemoteValue.data(T value) = _Data;
  const factory RemoteValue.loading() = _Loading;
  const factory RemoteValue.error(dynamic error) = _Error;

  // transformers
  // transform on data and cast on other
  RemoteValue<E> transformData<E>(E Function(T value) transform) {
    return when(
      initial: () => RemoteValue.initial(),
      loading: () => RemoteValue.loading(),
      data: (v) => RemoteValue.data(transform(v)),
      error: (error) => RemoteValue.error(error),
    );
  }

  RemoteValue<E> cast<E>() {
    return when(
      initial: () => RemoteValue.initial(),
      loading: () => RemoteValue.loading(),
      data: (v) => RemoteValue.data(v as E),
      error: (error) => RemoteValue.error(error),
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
