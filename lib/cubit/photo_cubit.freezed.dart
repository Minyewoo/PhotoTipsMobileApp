// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'photo_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$PhotoStateTearOff {
  const _$PhotoStateTearOff();

// ignore: unused_element
  PhotoInitial initial() {
    return const PhotoInitial();
  }

// ignore: unused_element
  PhotoLoading loading() {
    return const PhotoLoading();
  }

// ignore: unused_element
  PhotoLoaded loaded(List<Photo> photos) {
    return PhotoLoaded(
      photos,
    );
  }

// ignore: unused_element
  PhotoError error(String message) {
    return PhotoError(
      message,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $PhotoState = _$PhotoStateTearOff();

/// @nodoc
mixin _$PhotoState {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(List<Photo> photos),
    @required TResult error(String message),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult loaded(List<Photo> photos),
    TResult error(String message),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(PhotoInitial value),
    @required TResult loading(PhotoLoading value),
    @required TResult loaded(PhotoLoaded value),
    @required TResult error(PhotoError value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(PhotoInitial value),
    TResult loading(PhotoLoading value),
    TResult loaded(PhotoLoaded value),
    TResult error(PhotoError value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $PhotoStateCopyWith<$Res> {
  factory $PhotoStateCopyWith(
          PhotoState value, $Res Function(PhotoState) then) =
      _$PhotoStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$PhotoStateCopyWithImpl<$Res> implements $PhotoStateCopyWith<$Res> {
  _$PhotoStateCopyWithImpl(this._value, this._then);

  final PhotoState _value;
  // ignore: unused_field
  final $Res Function(PhotoState) _then;
}

/// @nodoc
abstract class $PhotoInitialCopyWith<$Res> {
  factory $PhotoInitialCopyWith(
          PhotoInitial value, $Res Function(PhotoInitial) then) =
      _$PhotoInitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$PhotoInitialCopyWithImpl<$Res> extends _$PhotoStateCopyWithImpl<$Res>
    implements $PhotoInitialCopyWith<$Res> {
  _$PhotoInitialCopyWithImpl(
      PhotoInitial _value, $Res Function(PhotoInitial) _then)
      : super(_value, (v) => _then(v as PhotoInitial));

  @override
  PhotoInitial get _value => super._value as PhotoInitial;
}

/// @nodoc
class _$PhotoInitial implements PhotoInitial {
  const _$PhotoInitial();

  @override
  String toString() {
    return 'PhotoState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is PhotoInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(List<Photo> photos),
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
    TResult loaded(List<Photo> photos),
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
    @required TResult initial(PhotoInitial value),
    @required TResult loading(PhotoLoading value),
    @required TResult loaded(PhotoLoaded value),
    @required TResult error(PhotoError value),
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
    TResult initial(PhotoInitial value),
    TResult loading(PhotoLoading value),
    TResult loaded(PhotoLoaded value),
    TResult error(PhotoError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class PhotoInitial implements PhotoState {
  const factory PhotoInitial() = _$PhotoInitial;
}

/// @nodoc
abstract class $PhotoLoadingCopyWith<$Res> {
  factory $PhotoLoadingCopyWith(
          PhotoLoading value, $Res Function(PhotoLoading) then) =
      _$PhotoLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class _$PhotoLoadingCopyWithImpl<$Res> extends _$PhotoStateCopyWithImpl<$Res>
    implements $PhotoLoadingCopyWith<$Res> {
  _$PhotoLoadingCopyWithImpl(
      PhotoLoading _value, $Res Function(PhotoLoading) _then)
      : super(_value, (v) => _then(v as PhotoLoading));

  @override
  PhotoLoading get _value => super._value as PhotoLoading;
}

/// @nodoc
class _$PhotoLoading implements PhotoLoading {
  const _$PhotoLoading();

  @override
  String toString() {
    return 'PhotoState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is PhotoLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(List<Photo> photos),
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
    TResult loaded(List<Photo> photos),
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
    @required TResult initial(PhotoInitial value),
    @required TResult loading(PhotoLoading value),
    @required TResult loaded(PhotoLoaded value),
    @required TResult error(PhotoError value),
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
    TResult initial(PhotoInitial value),
    TResult loading(PhotoLoading value),
    TResult loaded(PhotoLoaded value),
    TResult error(PhotoError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class PhotoLoading implements PhotoState {
  const factory PhotoLoading() = _$PhotoLoading;
}

/// @nodoc
abstract class $PhotoLoadedCopyWith<$Res> {
  factory $PhotoLoadedCopyWith(
          PhotoLoaded value, $Res Function(PhotoLoaded) then) =
      _$PhotoLoadedCopyWithImpl<$Res>;
  $Res call({List<Photo> photos});
}

/// @nodoc
class _$PhotoLoadedCopyWithImpl<$Res> extends _$PhotoStateCopyWithImpl<$Res>
    implements $PhotoLoadedCopyWith<$Res> {
  _$PhotoLoadedCopyWithImpl(
      PhotoLoaded _value, $Res Function(PhotoLoaded) _then)
      : super(_value, (v) => _then(v as PhotoLoaded));

  @override
  PhotoLoaded get _value => super._value as PhotoLoaded;

  @override
  $Res call({
    Object photos = freezed,
  }) {
    return _then(PhotoLoaded(
      photos == freezed ? _value.photos : photos as List<Photo>,
    ));
  }
}

/// @nodoc
class _$PhotoLoaded implements PhotoLoaded {
  const _$PhotoLoaded(this.photos) : assert(photos != null);

  @override
  final List<Photo> photos;

  @override
  String toString() {
    return 'PhotoState.loaded(photos: $photos)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PhotoLoaded &&
            (identical(other.photos, photos) ||
                const DeepCollectionEquality().equals(other.photos, photos)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(photos);

  @JsonKey(ignore: true)
  @override
  $PhotoLoadedCopyWith<PhotoLoaded> get copyWith =>
      _$PhotoLoadedCopyWithImpl<PhotoLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(List<Photo> photos),
    @required TResult error(String message),
  }) {
    assert(initial != null);
    assert(loading != null);
    assert(loaded != null);
    assert(error != null);
    return loaded(photos);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult loading(),
    TResult loaded(List<Photo> photos),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded(photos);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(PhotoInitial value),
    @required TResult loading(PhotoLoading value),
    @required TResult loaded(PhotoLoaded value),
    @required TResult error(PhotoError value),
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
    TResult initial(PhotoInitial value),
    TResult loading(PhotoLoading value),
    TResult loaded(PhotoLoaded value),
    TResult error(PhotoError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class PhotoLoaded implements PhotoState {
  const factory PhotoLoaded(List<Photo> photos) = _$PhotoLoaded;

  List<Photo> get photos;
  @JsonKey(ignore: true)
  $PhotoLoadedCopyWith<PhotoLoaded> get copyWith;
}

/// @nodoc
abstract class $PhotoErrorCopyWith<$Res> {
  factory $PhotoErrorCopyWith(
          PhotoError value, $Res Function(PhotoError) then) =
      _$PhotoErrorCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$PhotoErrorCopyWithImpl<$Res> extends _$PhotoStateCopyWithImpl<$Res>
    implements $PhotoErrorCopyWith<$Res> {
  _$PhotoErrorCopyWithImpl(PhotoError _value, $Res Function(PhotoError) _then)
      : super(_value, (v) => _then(v as PhotoError));

  @override
  PhotoError get _value => super._value as PhotoError;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(PhotoError(
      message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
class _$PhotoError implements PhotoError {
  const _$PhotoError(this.message) : assert(message != null);

  @override
  final String message;

  @override
  String toString() {
    return 'PhotoState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is PhotoError &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  $PhotoErrorCopyWith<PhotoError> get copyWith =>
      _$PhotoErrorCopyWithImpl<PhotoError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult loading(),
    @required TResult loaded(List<Photo> photos),
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
    TResult loaded(List<Photo> photos),
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
    @required TResult initial(PhotoInitial value),
    @required TResult loading(PhotoLoading value),
    @required TResult loaded(PhotoLoaded value),
    @required TResult error(PhotoError value),
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
    TResult initial(PhotoInitial value),
    TResult loading(PhotoLoading value),
    TResult loaded(PhotoLoaded value),
    TResult error(PhotoError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class PhotoError implements PhotoState {
  const factory PhotoError(String message) = _$PhotoError;

  String get message;
  @JsonKey(ignore: true)
  $PhotoErrorCopyWith<PhotoError> get copyWith;
}
