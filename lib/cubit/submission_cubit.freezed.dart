// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'submission_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$SubmissionStateTearOff {
  const _$SubmissionStateTearOff();

// ignore: unused_element
  SubmissionInitial initial() {
    return const SubmissionInitial();
  }

// ignore: unused_element
  SubmissionLoading loading() {
    return const SubmissionLoading();
  }

// ignore: unused_element
  SubmissionLoaded loaded(List<Submission> submissions) {
    return SubmissionLoaded(
      submissions,
    );
  }

// ignore: unused_element
  SubmissionError error(String message) {
    return SubmissionError(
      message,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $SubmissionState = _$SubmissionStateTearOff();

/// @nodoc
mixin _$SubmissionState {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(List<Submission> submissions),
    @required TResult error(String message),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult loaded(List<Submission> submissions),
    TResult error(String message),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(SubmissionInitial value),
    @required TResult loading(SubmissionLoading value),
    @required TResult loaded(SubmissionLoaded value),
    @required TResult error(SubmissionError value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(SubmissionInitial value),
    TResult loading(SubmissionLoading value),
    TResult loaded(SubmissionLoaded value),
    TResult error(SubmissionError value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $SubmissionStateCopyWith<$Res> {
  factory $SubmissionStateCopyWith(
          SubmissionState value, $Res Function(SubmissionState) then) =
      _$SubmissionStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$SubmissionStateCopyWithImpl<$Res>
    implements $SubmissionStateCopyWith<$Res> {
  _$SubmissionStateCopyWithImpl(this._value, this._then);

  final SubmissionState _value;
  // ignore: unused_field
  final $Res Function(SubmissionState) _then;
}

/// @nodoc
abstract class $SubmissionInitialCopyWith<$Res> {
  factory $SubmissionInitialCopyWith(
          SubmissionInitial value, $Res Function(SubmissionInitial) then) =
      _$SubmissionInitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$SubmissionInitialCopyWithImpl<$Res>
    extends _$SubmissionStateCopyWithImpl<$Res>
    implements $SubmissionInitialCopyWith<$Res> {
  _$SubmissionInitialCopyWithImpl(
      SubmissionInitial _value, $Res Function(SubmissionInitial) _then)
      : super(_value, (v) => _then(v as SubmissionInitial));

  @override
  SubmissionInitial get _value => super._value as SubmissionInitial;
}

/// @nodoc
class _$SubmissionInitial implements SubmissionInitial {
  const _$SubmissionInitial();

  @override
  String toString() {
    return 'SubmissionState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is SubmissionInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(List<Submission> submissions),
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
    TResult loaded(List<Submission> submissions),
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
    @required TResult initial(SubmissionInitial value),
    @required TResult loading(SubmissionLoading value),
    @required TResult loaded(SubmissionLoaded value),
    @required TResult error(SubmissionError value),
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
    TResult initial(SubmissionInitial value),
    TResult loading(SubmissionLoading value),
    TResult loaded(SubmissionLoaded value),
    TResult error(SubmissionError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class SubmissionInitial implements SubmissionState {
  const factory SubmissionInitial() = _$SubmissionInitial;
}

/// @nodoc
abstract class $SubmissionLoadingCopyWith<$Res> {
  factory $SubmissionLoadingCopyWith(
          SubmissionLoading value, $Res Function(SubmissionLoading) then) =
      _$SubmissionLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$SubmissionLoadingCopyWithImpl<$Res>
    extends _$SubmissionStateCopyWithImpl<$Res>
    implements $SubmissionLoadingCopyWith<$Res> {
  _$SubmissionLoadingCopyWithImpl(
      SubmissionLoading _value, $Res Function(SubmissionLoading) _then)
      : super(_value, (v) => _then(v as SubmissionLoading));

  @override
  SubmissionLoading get _value => super._value as SubmissionLoading;
}

/// @nodoc
class _$SubmissionLoading implements SubmissionLoading {
  const _$SubmissionLoading();

  @override
  String toString() {
    return 'SubmissionState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is SubmissionLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(List<Submission> submissions),
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
    TResult loaded(List<Submission> submissions),
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
    @required TResult initial(SubmissionInitial value),
    @required TResult loading(SubmissionLoading value),
    @required TResult loaded(SubmissionLoaded value),
    @required TResult error(SubmissionError value),
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
    TResult initial(SubmissionInitial value),
    TResult loading(SubmissionLoading value),
    TResult loaded(SubmissionLoaded value),
    TResult error(SubmissionError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class SubmissionLoading implements SubmissionState {
  const factory SubmissionLoading() = _$SubmissionLoading;
}

/// @nodoc
abstract class $SubmissionLoadedCopyWith<$Res> {
  factory $SubmissionLoadedCopyWith(
          SubmissionLoaded value, $Res Function(SubmissionLoaded) then) =
      _$SubmissionLoadedCopyWithImpl<$Res>;
  $Res call({List<Submission> submissions});
}

/// @nodoc
class _$SubmissionLoadedCopyWithImpl<$Res>
    extends _$SubmissionStateCopyWithImpl<$Res>
    implements $SubmissionLoadedCopyWith<$Res> {
  _$SubmissionLoadedCopyWithImpl(
      SubmissionLoaded _value, $Res Function(SubmissionLoaded) _then)
      : super(_value, (v) => _then(v as SubmissionLoaded));

  @override
  SubmissionLoaded get _value => super._value as SubmissionLoaded;

  @override
  $Res call({
    Object submissions = freezed,
  }) {
    return _then(SubmissionLoaded(
      submissions == freezed
          ? _value.submissions
          : submissions as List<Submission>,
    ));
  }
}

/// @nodoc
class _$SubmissionLoaded implements SubmissionLoaded {
  const _$SubmissionLoaded(this.submissions) : assert(submissions != null);

  @override
  final List<Submission> submissions;

  @override
  String toString() {
    return 'SubmissionState.loaded(submissions: $submissions)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SubmissionLoaded &&
            (identical(other.submissions, submissions) ||
                const DeepCollectionEquality()
                    .equals(other.submissions, submissions)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(submissions);

  @JsonKey(ignore: true)
  @override
  $SubmissionLoadedCopyWith<SubmissionLoaded> get copyWith =>
      _$SubmissionLoadedCopyWithImpl<SubmissionLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(List<Submission> submissions),
    @required TResult error(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    return loaded(submissions);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult loaded(List<Submission> submissions),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded(submissions);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(SubmissionInitial value),
    @required TResult loading(SubmissionLoading value),
    @required TResult loaded(SubmissionLoaded value),
    @required TResult error(SubmissionError value),
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
    TResult initial(SubmissionInitial value),
    TResult loading(SubmissionLoading value),
    TResult loaded(SubmissionLoaded value),
    TResult error(SubmissionError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class SubmissionLoaded implements SubmissionState {
  const factory SubmissionLoaded(List<Submission> submissions) =
      _$SubmissionLoaded;

  List<Submission> get submissions;
  @JsonKey(ignore: true)
  $SubmissionLoadedCopyWith<SubmissionLoaded> get copyWith;
}

/// @nodoc
abstract class $SubmissionErrorCopyWith<$Res> {
  factory $SubmissionErrorCopyWith(
          SubmissionError value, $Res Function(SubmissionError) then) =
      _$SubmissionErrorCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$SubmissionErrorCopyWithImpl<$Res>
    extends _$SubmissionStateCopyWithImpl<$Res>
    implements $SubmissionErrorCopyWith<$Res> {
  _$SubmissionErrorCopyWithImpl(
      SubmissionError _value, $Res Function(SubmissionError) _then)
      : super(_value, (v) => _then(v as SubmissionError));

  @override
  SubmissionError get _value => super._value as SubmissionError;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(SubmissionError(
      message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
class _$SubmissionError implements SubmissionError {
  const _$SubmissionError(this.message) : assert(message != null);

  @override
  final String message;

  @override
  String toString() {
    return 'SubmissionState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is SubmissionError &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  $SubmissionErrorCopyWith<SubmissionError> get copyWith =>
      _$SubmissionErrorCopyWithImpl<SubmissionError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(List<Submission> submissions),
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
    TResult loaded(List<Submission> submissions),
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
    @required TResult initial(SubmissionInitial value),
    @required TResult loading(SubmissionLoading value),
    @required TResult loaded(SubmissionLoaded value),
    @required TResult error(SubmissionError value),
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
    TResult initial(SubmissionInitial value),
    TResult loading(SubmissionLoading value),
    TResult loaded(SubmissionLoaded value),
    TResult error(SubmissionError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SubmissionError implements SubmissionState {
  const factory SubmissionError(String message) = _$SubmissionError;

  String get message;
  @JsonKey(ignore: true)
  $SubmissionErrorCopyWith<SubmissionError> get copyWith;
}
