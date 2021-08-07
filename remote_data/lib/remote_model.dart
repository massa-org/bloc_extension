import 'package:freezed_annotation/freezed_annotation.dart';

part 'remote_model.freezed.dart';

@freezed
abstract class RemoteDataModel<T> implements _$RemoteDataModel<T> {
  const RemoteDataModel._();

  const factory RemoteDataModel.inital() = _Initial;
  const factory RemoteDataModel.data(T value) = _Data;
  const factory RemoteDataModel.loading() = _Loading;
  const factory RemoteDataModel.error(dynamic error) = _Error;

  // transform on data and cast on other
  RemoteDataModel<E> transformData<E>(E Function(T value) transform) {
    return when(
      inital: () => RemoteDataModel.inital(),
      loading: () => RemoteDataModel.loading(),
      data: (v) => RemoteDataModel.data(transform(v)),
      error: (error) => RemoteDataModel.error(error),
    );
  }

  RemoteDataModel<E> cast<E>() {
    return when(
      inital: () => RemoteDataModel.inital(),
      loading: () => RemoteDataModel.loading(),
      data: (v) => RemoteDataModel.data(v as E),
      error: (error) => RemoteDataModel.error(error),
    );
  }
}
