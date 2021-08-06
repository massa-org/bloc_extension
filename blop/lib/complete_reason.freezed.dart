// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'complete_reason.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$CompleteReasonTearOff {
  const _$CompleteReasonTearOff();

  _Cancel cancel(int id) {
    return _Cancel(
      id,
    );
  }

  _Done done(int id) {
    return _Done(
      id,
    );
  }

  _Error error(int id, dynamic error) {
    return _Error(
      id,
      error,
    );
  }

  _CancelError cancelWithError(int id, dynamic error) {
    return _CancelError(
      id,
      error,
    );
  }
}

/// @nodoc
const $CompleteReason = _$CompleteReasonTearOff();

/// @nodoc
mixin _$CompleteReason {
  int get id => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id) cancel,
    required TResult Function(int id) done,
    required TResult Function(int id, dynamic error) error,
    required TResult Function(int id, dynamic error) cancelWithError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id)? cancel,
    TResult Function(int id)? done,
    TResult Function(int id, dynamic error)? error,
    TResult Function(int id, dynamic error)? cancelWithError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Cancel value) cancel,
    required TResult Function(_Done value) done,
    required TResult Function(_Error value) error,
    required TResult Function(_CancelError value) cancelWithError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Cancel value)? cancel,
    TResult Function(_Done value)? done,
    TResult Function(_Error value)? error,
    TResult Function(_CancelError value)? cancelWithError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CompleteReasonCopyWith<CompleteReason> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CompleteReasonCopyWith<$Res> {
  factory $CompleteReasonCopyWith(
          CompleteReason value, $Res Function(CompleteReason) then) =
      _$CompleteReasonCopyWithImpl<$Res>;
  $Res call({int id});
}

/// @nodoc
class _$CompleteReasonCopyWithImpl<$Res>
    implements $CompleteReasonCopyWith<$Res> {
  _$CompleteReasonCopyWithImpl(this._value, this._then);

  final CompleteReason _value;
  // ignore: unused_field
  final $Res Function(CompleteReason) _then;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$CancelCopyWith<$Res> implements $CompleteReasonCopyWith<$Res> {
  factory _$CancelCopyWith(_Cancel value, $Res Function(_Cancel) then) =
      __$CancelCopyWithImpl<$Res>;
  @override
  $Res call({int id});
}

/// @nodoc
class __$CancelCopyWithImpl<$Res> extends _$CompleteReasonCopyWithImpl<$Res>
    implements _$CancelCopyWith<$Res> {
  __$CancelCopyWithImpl(_Cancel _value, $Res Function(_Cancel) _then)
      : super(_value, (v) => _then(v as _Cancel));

  @override
  _Cancel get _value => super._value as _Cancel;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_Cancel(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Cancel extends _Cancel {
  const _$_Cancel(this.id) : super._();

  @override
  final int id;

  @override
  String toString() {
    return 'CompleteReason.cancel(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Cancel &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(id);

  @JsonKey(ignore: true)
  @override
  _$CancelCopyWith<_Cancel> get copyWith =>
      __$CancelCopyWithImpl<_Cancel>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id) cancel,
    required TResult Function(int id) done,
    required TResult Function(int id, dynamic error) error,
    required TResult Function(int id, dynamic error) cancelWithError,
  }) {
    return cancel(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id)? cancel,
    TResult Function(int id)? done,
    TResult Function(int id, dynamic error)? error,
    TResult Function(int id, dynamic error)? cancelWithError,
    required TResult orElse(),
  }) {
    if (cancel != null) {
      return cancel(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Cancel value) cancel,
    required TResult Function(_Done value) done,
    required TResult Function(_Error value) error,
    required TResult Function(_CancelError value) cancelWithError,
  }) {
    return cancel(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Cancel value)? cancel,
    TResult Function(_Done value)? done,
    TResult Function(_Error value)? error,
    TResult Function(_CancelError value)? cancelWithError,
    required TResult orElse(),
  }) {
    if (cancel != null) {
      return cancel(this);
    }
    return orElse();
  }
}

abstract class _Cancel extends CompleteReason {
  const factory _Cancel(int id) = _$_Cancel;
  const _Cancel._() : super._();

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CancelCopyWith<_Cancel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$DoneCopyWith<$Res> implements $CompleteReasonCopyWith<$Res> {
  factory _$DoneCopyWith(_Done value, $Res Function(_Done) then) =
      __$DoneCopyWithImpl<$Res>;
  @override
  $Res call({int id});
}

/// @nodoc
class __$DoneCopyWithImpl<$Res> extends _$CompleteReasonCopyWithImpl<$Res>
    implements _$DoneCopyWith<$Res> {
  __$DoneCopyWithImpl(_Done _value, $Res Function(_Done) _then)
      : super(_value, (v) => _then(v as _Done));

  @override
  _Done get _value => super._value as _Done;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_Done(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_Done extends _Done {
  const _$_Done(this.id) : super._();

  @override
  final int id;

  @override
  String toString() {
    return 'CompleteReason.done(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Done &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(id);

  @JsonKey(ignore: true)
  @override
  _$DoneCopyWith<_Done> get copyWith =>
      __$DoneCopyWithImpl<_Done>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id) cancel,
    required TResult Function(int id) done,
    required TResult Function(int id, dynamic error) error,
    required TResult Function(int id, dynamic error) cancelWithError,
  }) {
    return done(id);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id)? cancel,
    TResult Function(int id)? done,
    TResult Function(int id, dynamic error)? error,
    TResult Function(int id, dynamic error)? cancelWithError,
    required TResult orElse(),
  }) {
    if (done != null) {
      return done(id);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Cancel value) cancel,
    required TResult Function(_Done value) done,
    required TResult Function(_Error value) error,
    required TResult Function(_CancelError value) cancelWithError,
  }) {
    return done(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Cancel value)? cancel,
    TResult Function(_Done value)? done,
    TResult Function(_Error value)? error,
    TResult Function(_CancelError value)? cancelWithError,
    required TResult orElse(),
  }) {
    if (done != null) {
      return done(this);
    }
    return orElse();
  }
}

abstract class _Done extends CompleteReason {
  const factory _Done(int id) = _$_Done;
  const _Done._() : super._();

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$DoneCopyWith<_Done> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ErrorCopyWith<$Res> implements $CompleteReasonCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) then) =
      __$ErrorCopyWithImpl<$Res>;
  @override
  $Res call({int id, dynamic error});
}

/// @nodoc
class __$ErrorCopyWithImpl<$Res> extends _$CompleteReasonCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(_Error _value, $Res Function(_Error) _then)
      : super(_value, (v) => _then(v as _Error));

  @override
  _Error get _value => super._value as _Error;

  @override
  $Res call({
    Object? id = freezed,
    Object? error = freezed,
  }) {
    return _then(_Error(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      error == freezed ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$_Error extends _Error {
  const _$_Error(this.id, this.error) : super._();

  @override
  final int id;
  @override
  final dynamic error;

  @override
  String toString() {
    return 'CompleteReason.error(id: $id, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Error &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  _$ErrorCopyWith<_Error> get copyWith =>
      __$ErrorCopyWithImpl<_Error>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id) cancel,
    required TResult Function(int id) done,
    required TResult Function(int id, dynamic error) error,
    required TResult Function(int id, dynamic error) cancelWithError,
  }) {
    return error(id, this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id)? cancel,
    TResult Function(int id)? done,
    TResult Function(int id, dynamic error)? error,
    TResult Function(int id, dynamic error)? cancelWithError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(id, this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Cancel value) cancel,
    required TResult Function(_Done value) done,
    required TResult Function(_Error value) error,
    required TResult Function(_CancelError value) cancelWithError,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Cancel value)? cancel,
    TResult Function(_Done value)? done,
    TResult Function(_Error value)? error,
    TResult Function(_CancelError value)? cancelWithError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error extends CompleteReason {
  const factory _Error(int id, dynamic error) = _$_Error;
  const _Error._() : super._();

  @override
  int get id => throw _privateConstructorUsedError;
  dynamic get error => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ErrorCopyWith<_Error> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$CancelErrorCopyWith<$Res>
    implements $CompleteReasonCopyWith<$Res> {
  factory _$CancelErrorCopyWith(
          _CancelError value, $Res Function(_CancelError) then) =
      __$CancelErrorCopyWithImpl<$Res>;
  @override
  $Res call({int id, dynamic error});
}

/// @nodoc
class __$CancelErrorCopyWithImpl<$Res>
    extends _$CompleteReasonCopyWithImpl<$Res>
    implements _$CancelErrorCopyWith<$Res> {
  __$CancelErrorCopyWithImpl(
      _CancelError _value, $Res Function(_CancelError) _then)
      : super(_value, (v) => _then(v as _CancelError));

  @override
  _CancelError get _value => super._value as _CancelError;

  @override
  $Res call({
    Object? id = freezed,
    Object? error = freezed,
  }) {
    return _then(_CancelError(
      id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      error == freezed ? _value.error : error,
    ));
  }
}

/// @nodoc

class _$_CancelError extends _CancelError {
  const _$_CancelError(this.id, this.error) : super._();

  @override
  final int id;
  @override
  final dynamic error;

  @override
  String toString() {
    return 'CompleteReason.cancelWithError(id: $id, error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CancelError &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  _$CancelErrorCopyWith<_CancelError> get copyWith =>
      __$CancelErrorCopyWithImpl<_CancelError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(int id) cancel,
    required TResult Function(int id) done,
    required TResult Function(int id, dynamic error) error,
    required TResult Function(int id, dynamic error) cancelWithError,
  }) {
    return cancelWithError(id, this.error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(int id)? cancel,
    TResult Function(int id)? done,
    TResult Function(int id, dynamic error)? error,
    TResult Function(int id, dynamic error)? cancelWithError,
    required TResult orElse(),
  }) {
    if (cancelWithError != null) {
      return cancelWithError(id, this.error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Cancel value) cancel,
    required TResult Function(_Done value) done,
    required TResult Function(_Error value) error,
    required TResult Function(_CancelError value) cancelWithError,
  }) {
    return cancelWithError(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Cancel value)? cancel,
    TResult Function(_Done value)? done,
    TResult Function(_Error value)? error,
    TResult Function(_CancelError value)? cancelWithError,
    required TResult orElse(),
  }) {
    if (cancelWithError != null) {
      return cancelWithError(this);
    }
    return orElse();
  }
}

abstract class _CancelError extends CompleteReason {
  const factory _CancelError(int id, dynamic error) = _$_CancelError;
  const _CancelError._() : super._();

  @override
  int get id => throw _privateConstructorUsedError;
  dynamic get error => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$CancelErrorCopyWith<_CancelError> get copyWith =>
      throw _privateConstructorUsedError;
}
