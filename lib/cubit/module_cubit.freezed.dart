// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'module_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$ModuleStateTearOff {
  const _$ModuleStateTearOff();

// ignore: unused_element
  ModuleInitial initial() {
    return const ModuleInitial();
  }

// ignore: unused_element
  ModuleLoading loading() {
    return const ModuleLoading();
  }

// ignore: unused_element
  ModuleLoaded loaded(List<Module> modules) {
    return ModuleLoaded(
      modules,
    );
  }

// ignore: unused_element
  ModuleError error(String message) {
    return ModuleError(
      message,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $ModuleState = _$ModuleStateTearOff();

/// @nodoc
mixin _$ModuleState {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(List<Module> modules),
    @required TResult error(String message),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult loaded(List<Module> modules),
    TResult error(String message),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(ModuleInitial value),
    @required TResult loading(ModuleLoading value),
    @required TResult loaded(ModuleLoaded value),
    @required TResult error(ModuleError value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(ModuleInitial value),
    TResult loading(ModuleLoading value),
    TResult loaded(ModuleLoaded value),
    TResult error(ModuleError value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $ModuleStateCopyWith<$Res> {
  factory $ModuleStateCopyWith(
          ModuleState value, $Res Function(ModuleState) then) =
      _$ModuleStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ModuleStateCopyWithImpl<$Res> implements $ModuleStateCopyWith<$Res> {
  _$ModuleStateCopyWithImpl(this._value, this._then);

  final ModuleState _value;
  // ignore: unused_field
  final $Res Function(ModuleState) _then;
}

/// @nodoc
abstract class $ModuleInitialCopyWith<$Res> {
  factory $ModuleInitialCopyWith(
          ModuleInitial value, $Res Function(ModuleInitial) then) =
      _$ModuleInitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$ModuleInitialCopyWithImpl<$Res> extends _$ModuleStateCopyWithImpl<$Res>
    implements $ModuleInitialCopyWith<$Res> {
  _$ModuleInitialCopyWithImpl(
      ModuleInitial _value, $Res Function(ModuleInitial) _then)
      : super(_value, (v) => _then(v as ModuleInitial));

  @override
  ModuleInitial get _value => super._value as ModuleInitial;
}

/// @nodoc
class _$ModuleInitial implements ModuleInitial {
  const _$ModuleInitial();

  @override
  String toString() {
    return 'ModuleState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is ModuleInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(List<Module> modules),
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
    TResult loaded(List<Module> modules),
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
    @required TResult initial(ModuleInitial value),
    @required TResult loading(ModuleLoading value),
    @required TResult loaded(ModuleLoaded value),
    @required TResult error(ModuleError value),
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
    TResult initial(ModuleInitial value),
    TResult loading(ModuleLoading value),
    TResult loaded(ModuleLoaded value),
    TResult error(ModuleError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class ModuleInitial implements ModuleState {
  const factory ModuleInitial() = _$ModuleInitial;
}

/// @nodoc
abstract class $ModuleLoadingCopyWith<$Res> {
  factory $ModuleLoadingCopyWith(
          ModuleLoading value, $Res Function(ModuleLoading) then) =
      _$ModuleLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$ModuleLoadingCopyWithImpl<$Res> extends _$ModuleStateCopyWithImpl<$Res>
    implements $ModuleLoadingCopyWith<$Res> {
  _$ModuleLoadingCopyWithImpl(
      ModuleLoading _value, $Res Function(ModuleLoading) _then)
      : super(_value, (v) => _then(v as ModuleLoading));

  @override
  ModuleLoading get _value => super._value as ModuleLoading;
}

/// @nodoc
class _$ModuleLoading implements ModuleLoading {
  const _$ModuleLoading();

  @override
  String toString() {
    return 'ModuleState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is ModuleLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(List<Module> modules),
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
    TResult loaded(List<Module> modules),
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
    @required TResult initial(ModuleInitial value),
    @required TResult loading(ModuleLoading value),
    @required TResult loaded(ModuleLoaded value),
    @required TResult error(ModuleError value),
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
    TResult initial(ModuleInitial value),
    TResult loading(ModuleLoading value),
    TResult loaded(ModuleLoaded value),
    TResult error(ModuleError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class ModuleLoading implements ModuleState {
  const factory ModuleLoading() = _$ModuleLoading;
}

/// @nodoc
abstract class $ModuleLoadedCopyWith<$Res> {
  factory $ModuleLoadedCopyWith(
          ModuleLoaded value, $Res Function(ModuleLoaded) then) =
      _$ModuleLoadedCopyWithImpl<$Res>;
  $Res call({List<Module> modules});
}

/// @nodoc
class _$ModuleLoadedCopyWithImpl<$Res> extends _$ModuleStateCopyWithImpl<$Res>
    implements $ModuleLoadedCopyWith<$Res> {
  _$ModuleLoadedCopyWithImpl(
      ModuleLoaded _value, $Res Function(ModuleLoaded) _then)
      : super(_value, (v) => _then(v as ModuleLoaded));

  @override
  ModuleLoaded get _value => super._value as ModuleLoaded;

  @override
  $Res call({
    Object modules = freezed,
  }) {
    return _then(ModuleLoaded(
      modules == freezed ? _value.modules : modules as List<Module>,
    ));
  }
}

/// @nodoc
class _$ModuleLoaded implements ModuleLoaded {
  const _$ModuleLoaded(this.modules) : assert(modules != null);

  @override
  final List<Module> modules;

  @override
  String toString() {
    return 'ModuleState.loaded(modules: $modules)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ModuleLoaded &&
            (identical(other.modules, modules) ||
                const DeepCollectionEquality().equals(other.modules, modules)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(modules);

  @JsonKey(ignore: true)
  @override
  $ModuleLoadedCopyWith<ModuleLoaded> get copyWith =>
      _$ModuleLoadedCopyWithImpl<ModuleLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(List<Module> modules),
    @required TResult error(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    return loaded(modules);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult loaded(List<Module> modules),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded(modules);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(ModuleInitial value),
    @required TResult loading(ModuleLoading value),
    @required TResult loaded(ModuleLoaded value),
    @required TResult error(ModuleError value),
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
    TResult initial(ModuleInitial value),
    TResult loading(ModuleLoading value),
    TResult loaded(ModuleLoaded value),
    TResult error(ModuleError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class ModuleLoaded implements ModuleState {
  const factory ModuleLoaded(List<Module> modules) = _$ModuleLoaded;

  List<Module> get modules;
  @JsonKey(ignore: true)
  $ModuleLoadedCopyWith<ModuleLoaded> get copyWith;
}

/// @nodoc
abstract class $ModuleErrorCopyWith<$Res> {
  factory $ModuleErrorCopyWith(
          ModuleError value, $Res Function(ModuleError) then) =
      _$ModuleErrorCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$ModuleErrorCopyWithImpl<$Res> extends _$ModuleStateCopyWithImpl<$Res>
    implements $ModuleErrorCopyWith<$Res> {
  _$ModuleErrorCopyWithImpl(
      ModuleError _value, $Res Function(ModuleError) _then)
      : super(_value, (v) => _then(v as ModuleError));

  @override
  ModuleError get _value => super._value as ModuleError;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(ModuleError(
      message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
class _$ModuleError implements ModuleError {
  const _$ModuleError(this.message) : assert(message != null);

  @override
  final String message;

  @override
  String toString() {
    return 'ModuleState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is ModuleError &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  $ModuleErrorCopyWith<ModuleError> get copyWith =>
      _$ModuleErrorCopyWithImpl<ModuleError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(List<Module> modules),
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
    TResult loaded(List<Module> modules),
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
    @required TResult initial(ModuleInitial value),
    @required TResult loading(ModuleLoading value),
    @required TResult loaded(ModuleLoaded value),
    @required TResult error(ModuleError value),
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
    TResult initial(ModuleInitial value),
    TResult loading(ModuleLoading value),
    TResult loaded(ModuleLoaded value),
    TResult error(ModuleError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ModuleError implements ModuleState {
  const factory ModuleError(String message) = _$ModuleError;

  String get message;
  @JsonKey(ignore: true)
  $ModuleErrorCopyWith<ModuleError> get copyWith;
}
