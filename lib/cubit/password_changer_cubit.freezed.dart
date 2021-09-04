// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'password_changer_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$PasswordChangerStateTearOff {
  const _$PasswordChangerStateTearOff();

// ignore: unused_element
  PasswordChangerInitial initial() {
    return const PasswordChangerInitial();
  }

// ignore: unused_element
  PasswordChangerLoading loading() {
    return const PasswordChangerLoading();
  }

// ignore: unused_element
  PasswordChangerLoaded loaded() {
    return const PasswordChangerLoaded();
  }

// ignore: unused_element
  PasswordChangerError error(String message) {
    return PasswordChangerError(
      message,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $PasswordChangerState = _$PasswordChangerStateTearOff();

/// @nodoc
mixin _$PasswordChangerState {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(),
    @required TResult error(String message),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult loaded(),
    TResult error(String message),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(PasswordChangerInitial value),
    @required TResult loading(PasswordChangerLoading value),
    @required TResult loaded(PasswordChangerLoaded value),
    @required TResult error(PasswordChangerError value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(PasswordChangerInitial value),
    TResult loading(PasswordChangerLoading value),
    TResult loaded(PasswordChangerLoaded value),
    TResult error(PasswordChangerError value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $PasswordChangerStateCopyWith<$Res> {
  factory $PasswordChangerStateCopyWith(PasswordChangerState value,
          $Res Function(PasswordChangerState) then) =
      _$PasswordChangerStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$PasswordChangerStateCopyWithImpl<$Res>
    implements $PasswordChangerStateCopyWith<$Res> {
  _$PasswordChangerStateCopyWithImpl(this._value, this._then);

  final PasswordChangerState _value;
  // ignore: unused_field
  final $Res Function(PasswordChangerState) _then;
}

/// @nodoc
abstract class $PasswordChangerInitialCopyWith<$Res> {
  factory $PasswordChangerInitialCopyWith(PasswordChangerInitial value,
          $Res Function(PasswordChangerInitial) then) =
      _$PasswordChangerInitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$PasswordChangerInitialCopyWithImpl<$Res>
    extends _$PasswordChangerStateCopyWithImpl<$Res>
    implements $PasswordChangerInitialCopyWith<$Res> {
  _$PasswordChangerInitialCopyWithImpl(PasswordChangerInitial _value,
      $Res Function(PasswordChangerInitial) _then)
      : super(_value, (v) => _then(v as PasswordChangerInitial));

  @override
  PasswordChangerInitial get _value => super._value as PasswordChangerInitial;
}

/// @nodoc
class _$PasswordChangerInitial implements PasswordChangerInitial {
  const _$PasswordChangerInitial();

  @override
  String toString() {
    return 'PasswordChangerState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is PasswordChangerInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(),
    @required TResult error(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult loaded(),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(PasswordChangerInitial value),
    @required TResult loading(PasswordChangerLoading value),
    @required TResult loaded(PasswordChangerLoaded value),
    @required TResult error(PasswordChangerError value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(PasswordChangerInitial value),
    TResult loading(PasswordChangerLoading value),
    TResult loaded(PasswordChangerLoaded value),
    TResult error(PasswordChangerError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class PasswordChangerInitial implements PasswordChangerState {
  const factory PasswordChangerInitial() = _$PasswordChangerInitial;
}

/// @nodoc
abstract class $PasswordChangerLoadingCopyWith<$Res> {
  factory $PasswordChangerLoadingCopyWith(PasswordChangerLoading value,
          $Res Function(PasswordChangerLoading) then) =
      _$PasswordChangerLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$PasswordChangerLoadingCopyWithImpl<$Res>
    extends _$PasswordChangerStateCopyWithImpl<$Res>
    implements $PasswordChangerLoadingCopyWith<$Res> {
  _$PasswordChangerLoadingCopyWithImpl(PasswordChangerLoading _value,
      $Res Function(PasswordChangerLoading) _then)
      : super(_value, (v) => _then(v as PasswordChangerLoading));

  @override
  PasswordChangerLoading get _value => super._value as PasswordChangerLoading;
}

/// @nodoc
class _$PasswordChangerLoading implements PasswordChangerLoading {
  const _$PasswordChangerLoading();

  @override
  String toString() {
    return 'PasswordChangerState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is PasswordChangerLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(),
    @required TResult error(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult loaded(),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(PasswordChangerInitial value),
    @required TResult loading(PasswordChangerLoading value),
    @required TResult loaded(PasswordChangerLoaded value),
    @required TResult error(PasswordChangerError value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(PasswordChangerInitial value),
    TResult loading(PasswordChangerLoading value),
    TResult loaded(PasswordChangerLoaded value),
    TResult error(PasswordChangerError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class PasswordChangerLoading implements PasswordChangerState {
  const factory PasswordChangerLoading() = _$PasswordChangerLoading;
}

/// @nodoc
abstract class $PasswordChangerLoadedCopyWith<$Res> {
  factory $PasswordChangerLoadedCopyWith(PasswordChangerLoaded value,
          $Res Function(PasswordChangerLoaded) then) =
      _$PasswordChangerLoadedCopyWithImpl<$Res>;
}

/// @nodoc
class _$PasswordChangerLoadedCopyWithImpl<$Res>
    extends _$PasswordChangerStateCopyWithImpl<$Res>
    implements $PasswordChangerLoadedCopyWith<$Res> {
  _$PasswordChangerLoadedCopyWithImpl(
      PasswordChangerLoaded _value, $Res Function(PasswordChangerLoaded) _then)
      : super(_value, (v) => _then(v as PasswordChangerLoaded));

  @override
  PasswordChangerLoaded get _value => super._value as PasswordChangerLoaded;
}

/// @nodoc
class _$PasswordChangerLoaded implements PasswordChangerLoaded {
  const _$PasswordChangerLoaded();

  @override
  String toString() {
    return 'PasswordChangerState.loaded()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is PasswordChangerLoaded);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(),
    @required TResult error(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    return loaded();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult loaded(),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(PasswordChangerInitial value),
    @required TResult loading(PasswordChangerLoading value),
    @required TResult loaded(PasswordChangerLoaded value),
    @required TResult error(PasswordChangerError value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(PasswordChangerInitial value),
    TResult loading(PasswordChangerLoading value),
    TResult loaded(PasswordChangerLoaded value),
    TResult error(PasswordChangerError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class PasswordChangerLoaded implements PasswordChangerState {
  const factory PasswordChangerLoaded() = _$PasswordChangerLoaded;
}

/// @nodoc
abstract class $PasswordChangerErrorCopyWith<$Res> {
  factory $PasswordChangerErrorCopyWith(PasswordChangerError value,
          $Res Function(PasswordChangerError) then) =
      _$PasswordChangerErrorCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$PasswordChangerErrorCopyWithImpl<$Res>
    extends _$PasswordChangerStateCopyWithImpl<$Res>
    implements $PasswordChangerErrorCopyWith<$Res> {
  _$PasswordChangerErrorCopyWithImpl(
      PasswordChangerError _value, $Res Function(PasswordChangerError) _then)
      : super(_value, (v) => _then(v as PasswordChangerError));

  @override
  PasswordChangerError get _value => super._value as PasswordChangerError;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(PasswordChangerError(
      message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
class _$PasswordChangerError implements PasswordChangerError {
  const _$PasswordChangerError(this.message) : assert(message != null);

  @override
  final String message;

  @override
  String toString() {
    return 'PasswordChangerState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PasswordChangerError &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  $PasswordChangerErrorCopyWith<PasswordChangerError> get copyWith =>
      _$PasswordChangerErrorCopyWithImpl<PasswordChangerError>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(),
    @required TResult error(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult loaded(),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(PasswordChangerInitial value),
    @required TResult loading(PasswordChangerLoading value),
    @required TResult loaded(PasswordChangerLoaded value),
    @required TResult error(PasswordChangerError value),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(PasswordChangerInitial value),
    TResult loading(PasswordChangerLoading value),
    TResult loaded(PasswordChangerLoaded value),
    TResult error(PasswordChangerError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PasswordChangerError implements PasswordChangerState {
  const factory PasswordChangerError(String message) = _$PasswordChangerError;

  String get message;
  @JsonKey(ignore: true)
  $PasswordChangerErrorCopyWith<PasswordChangerError> get copyWith;
}
