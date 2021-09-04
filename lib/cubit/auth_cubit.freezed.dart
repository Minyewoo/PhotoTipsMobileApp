// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'auth_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$AuthStateTearOff {
  const _$AuthStateTearOff();

// ignore: unused_element
  AuthInitial initial() {
    return const AuthInitial();
  }

// ignore: unused_element
  AuthSigningUp signingUp() {
    return const AuthSigningUp();
  }

// ignore: unused_element
  AuthSignedUp signedUp() {
    return const AuthSignedUp();
  }

// ignore: unused_element
  AuthSigningIn signingIn() {
    return const AuthSigningIn();
  }

// ignore: unused_element
  AuthSignedIn signedIn(String token) {
    return AuthSignedIn(
      token,
    );
  }

// ignore: unused_element
  AuthError error(String message) {
    return AuthError(
      message,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $AuthState = _$AuthStateTearOff();

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult signingUp(),
    @required TResult signedUp(),
    @required TResult signingIn(),
    @required TResult signedIn(String token),
    @required TResult error(String message),
  });
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult signingUp(),
    TResult signedUp(),
    TResult signingIn(),
    TResult signedIn(String token),
    TResult error(String message),
    @required TResult orElse(),
  });
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(AuthInitial value),
    @required TResult signingUp(AuthSigningUp value),
    @required TResult signedUp(AuthSignedUp value),
    @required TResult signingIn(AuthSigningIn value),
    @required TResult signedIn(AuthSignedIn value),
    @required TResult error(AuthError value),
  });
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(AuthInitial value),
    TResult signingUp(AuthSigningUp value),
    TResult signedUp(AuthSignedUp value),
    TResult signingIn(AuthSigningIn value),
    TResult signedIn(AuthSignedIn value),
    TResult error(AuthError value),
    @required TResult orElse(),
  });
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  final AuthState _value;
  // ignore: unused_field
  final $Res Function(AuthState) _then;
}

/// @nodoc
abstract class $AuthInitialCopyWith<$Res> {
  factory $AuthInitialCopyWith(
          AuthInitial value, $Res Function(AuthInitial) then) =
      _$AuthInitialCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthInitialCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $AuthInitialCopyWith<$Res> {
  _$AuthInitialCopyWithImpl(
      AuthInitial _value, $Res Function(AuthInitial) _then)
      : super(_value, (v) => _then(v as AuthInitial));

  @override
  AuthInitial get _value => super._value as AuthInitial;
}

/// @nodoc
class _$AuthInitial implements AuthInitial {
  const _$AuthInitial();

  @override
  String toString() {
    return 'AuthState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is AuthInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult signingUp(),
    @required TResult signedUp(),
    @required TResult signingIn(),
    @required TResult signedIn(String token),
    @required TResult error(String message),
  }) {
    assert(initial != null);
    assert(signingUp != null);
    assert(signedUp != null);
    assert(signingIn != null);
    assert(signedIn != null);
    assert(error != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult signingUp(),
    TResult signedUp(),
    TResult signingIn(),
    TResult signedIn(String token),
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
    @required TResult initial(AuthInitial value),
    @required TResult signingUp(AuthSigningUp value),
    @required TResult signedUp(AuthSignedUp value),
    @required TResult signingIn(AuthSigningIn value),
    @required TResult signedIn(AuthSignedIn value),
    @required TResult error(AuthError value),
  }) {
    assert(initial != null);
    assert(signingUp != null);
    assert(signedUp != null);
    assert(signingIn != null);
    assert(signedIn != null);
    assert(error != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(AuthInitial value),
    TResult signingUp(AuthSigningUp value),
    TResult signedUp(AuthSignedUp value),
    TResult signingIn(AuthSigningIn value),
    TResult signedIn(AuthSignedIn value),
    TResult error(AuthError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AuthInitial implements AuthState {
  const factory AuthInitial() = _$AuthInitial;
}

/// @nodoc
abstract class $AuthSigningUpCopyWith<$Res> {
  factory $AuthSigningUpCopyWith(
          AuthSigningUp value, $Res Function(AuthSigningUp) then) =
      _$AuthSigningUpCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthSigningUpCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $AuthSigningUpCopyWith<$Res> {
  _$AuthSigningUpCopyWithImpl(
      AuthSigningUp _value, $Res Function(AuthSigningUp) _then)
      : super(_value, (v) => _then(v as AuthSigningUp));

  @override
  AuthSigningUp get _value => super._value as AuthSigningUp;
}

/// @nodoc
class _$AuthSigningUp implements AuthSigningUp {
  const _$AuthSigningUp();

  @override
  String toString() {
    return 'AuthState.signingUp()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is AuthSigningUp);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult signingUp(),
    @required TResult signedUp(),
    @required TResult signingIn(),
    @required TResult signedIn(String token),
    @required TResult error(String message),
  }) {
    assert(initial != null);
    assert(signingUp != null);
    assert(signedUp != null);
    assert(signingIn != null);
    assert(signedIn != null);
    assert(error != null);
    return signingUp();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult signingUp(),
    TResult signedUp(),
    TResult signingIn(),
    TResult signedIn(String token),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (signingUp != null) {
      return signingUp();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(AuthInitial value),
    @required TResult signingUp(AuthSigningUp value),
    @required TResult signedUp(AuthSignedUp value),
    @required TResult signingIn(AuthSigningIn value),
    @required TResult signedIn(AuthSignedIn value),
    @required TResult error(AuthError value),
  }) {
    assert(initial != null);
    assert(signingUp != null);
    assert(signedUp != null);
    assert(signingIn != null);
    assert(signedIn != null);
    assert(error != null);
    return signingUp(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(AuthInitial value),
    TResult signingUp(AuthSigningUp value),
    TResult signedUp(AuthSignedUp value),
    TResult signingIn(AuthSigningIn value),
    TResult signedIn(AuthSignedIn value),
    TResult error(AuthError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (signingUp != null) {
      return signingUp(this);
    }
    return orElse();
  }
}

abstract class AuthSigningUp implements AuthState {
  const factory AuthSigningUp() = _$AuthSigningUp;
}

/// @nodoc
abstract class $AuthSignedUpCopyWith<$Res> {
  factory $AuthSignedUpCopyWith(
          AuthSignedUp value, $Res Function(AuthSignedUp) then) =
      _$AuthSignedUpCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthSignedUpCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $AuthSignedUpCopyWith<$Res> {
  _$AuthSignedUpCopyWithImpl(
      AuthSignedUp _value, $Res Function(AuthSignedUp) _then)
      : super(_value, (v) => _then(v as AuthSignedUp));

  @override
  AuthSignedUp get _value => super._value as AuthSignedUp;
}

/// @nodoc
class _$AuthSignedUp implements AuthSignedUp {
  const _$AuthSignedUp();

  @override
  String toString() {
    return 'AuthState.signedUp()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is AuthSignedUp);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult signingUp(),
    @required TResult signedUp(),
    @required TResult signingIn(),
    @required TResult signedIn(String token),
    @required TResult error(String message),
  }) {
    assert(initial != null);
    assert(signingUp != null);
    assert(signedUp != null);
    assert(signingIn != null);
    assert(signedIn != null);
    assert(error != null);
    return signedUp();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult signingUp(),
    TResult signedUp(),
    TResult signingIn(),
    TResult signedIn(String token),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (signedUp != null) {
      return signedUp();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(AuthInitial value),
    @required TResult signingUp(AuthSigningUp value),
    @required TResult signedUp(AuthSignedUp value),
    @required TResult signingIn(AuthSigningIn value),
    @required TResult signedIn(AuthSignedIn value),
    @required TResult error(AuthError value),
  }) {
    assert(initial != null);
    assert(signingUp != null);
    assert(signedUp != null);
    assert(signingIn != null);
    assert(signedIn != null);
    assert(error != null);
    return signedUp(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(AuthInitial value),
    TResult signingUp(AuthSigningUp value),
    TResult signedUp(AuthSignedUp value),
    TResult signingIn(AuthSigningIn value),
    TResult signedIn(AuthSignedIn value),
    TResult error(AuthError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (signedUp != null) {
      return signedUp(this);
    }
    return orElse();
  }
}

abstract class AuthSignedUp implements AuthState {
  const factory AuthSignedUp() = _$AuthSignedUp;
}

/// @nodoc
abstract class $AuthSigningInCopyWith<$Res> {
  factory $AuthSigningInCopyWith(
          AuthSigningIn value, $Res Function(AuthSigningIn) then) =
      _$AuthSigningInCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthSigningInCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $AuthSigningInCopyWith<$Res> {
  _$AuthSigningInCopyWithImpl(
      AuthSigningIn _value, $Res Function(AuthSigningIn) _then)
      : super(_value, (v) => _then(v as AuthSigningIn));

  @override
  AuthSigningIn get _value => super._value as AuthSigningIn;
}

/// @nodoc
class _$AuthSigningIn implements AuthSigningIn {
  const _$AuthSigningIn();

  @override
  String toString() {
    return 'AuthState.signingIn()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is AuthSigningIn);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult signingUp(),
    @required TResult signedUp(),
    @required TResult signingIn(),
    @required TResult signedIn(String token),
    @required TResult error(String message),
  }) {
    assert(initial != null);
    assert(signingUp != null);
    assert(signedUp != null);
    assert(signingIn != null);
    assert(signedIn != null);
    assert(error != null);
    return signingIn();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult signingUp(),
    TResult signedUp(),
    TResult signingIn(),
    TResult signedIn(String token),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (signingIn != null) {
      return signingIn();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(AuthInitial value),
    @required TResult signingUp(AuthSigningUp value),
    @required TResult signedUp(AuthSignedUp value),
    @required TResult signingIn(AuthSigningIn value),
    @required TResult signedIn(AuthSignedIn value),
    @required TResult error(AuthError value),
  }) {
    assert(initial != null);
    assert(signingUp != null);
    assert(signedUp != null);
    assert(signingIn != null);
    assert(signedIn != null);
    assert(error != null);
    return signingIn(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(AuthInitial value),
    TResult signingUp(AuthSigningUp value),
    TResult signedUp(AuthSignedUp value),
    TResult signingIn(AuthSigningIn value),
    TResult signedIn(AuthSignedIn value),
    TResult error(AuthError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (signingIn != null) {
      return signingIn(this);
    }
    return orElse();
  }
}

abstract class AuthSigningIn implements AuthState {
  const factory AuthSigningIn() = _$AuthSigningIn;
}

/// @nodoc
abstract class $AuthSignedInCopyWith<$Res> {
  factory $AuthSignedInCopyWith(
          AuthSignedIn value, $Res Function(AuthSignedIn) then) =
      _$AuthSignedInCopyWithImpl<$Res>;
  $Res call({String token});
}

/// @nodoc
class _$AuthSignedInCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $AuthSignedInCopyWith<$Res> {
  _$AuthSignedInCopyWithImpl(
      AuthSignedIn _value, $Res Function(AuthSignedIn) _then)
      : super(_value, (v) => _then(v as AuthSignedIn));

  @override
  AuthSignedIn get _value => super._value as AuthSignedIn;

  @override
  $Res call({
    Object token = freezed,
  }) {
    return _then(AuthSignedIn(
      token == freezed ? _value.token : token as String,
    ));
  }
}

/// @nodoc
class _$AuthSignedIn implements AuthSignedIn {
  const _$AuthSignedIn(this.token) : assert(token != null);

  @override
  final String token;

  @override
  String toString() {
    return 'AuthState.signedIn(token: $token)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AuthSignedIn &&
            (identical(other.token, token) ||
                const DeepCollectionEquality().equals(other.token, token)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(token);

  @JsonKey(ignore: true)
  @override
  $AuthSignedInCopyWith<AuthSignedIn> get copyWith =>
      _$AuthSignedInCopyWithImpl<AuthSignedIn>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult signingUp(),
    @required TResult signedUp(),
    @required TResult signingIn(),
    @required TResult signedIn(String token),
    @required TResult error(String message),
  }) {
    assert(initial != null);
    assert(signingUp != null);
    assert(signedUp != null);
    assert(signingIn != null);
    assert(signedIn != null);
    assert(error != null);
    return signedIn(token);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult signingUp(),
    TResult signedUp(),
    TResult signingIn(),
    TResult signedIn(String token),
    TResult error(String message),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (signedIn != null) {
      return signedIn(token);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object>({
    @required TResult initial(AuthInitial value),
    @required TResult signingUp(AuthSigningUp value),
    @required TResult signedUp(AuthSignedUp value),
    @required TResult signingIn(AuthSigningIn value),
    @required TResult signedIn(AuthSignedIn value),
    @required TResult error(AuthError value),
  }) {
    assert(initial != null);
    assert(signingUp != null);
    assert(signedUp != null);
    assert(signingIn != null);
    assert(signedIn != null);
    assert(error != null);
    return signedIn(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(AuthInitial value),
    TResult signingUp(AuthSigningUp value),
    TResult signedUp(AuthSignedUp value),
    TResult signingIn(AuthSigningIn value),
    TResult signedIn(AuthSignedIn value),
    TResult error(AuthError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (signedIn != null) {
      return signedIn(this);
    }
    return orElse();
  }
}

abstract class AuthSignedIn implements AuthState {
  const factory AuthSignedIn(String token) = _$AuthSignedIn;

  String get token;
  @JsonKey(ignore: true)
  $AuthSignedInCopyWith<AuthSignedIn> get copyWith;
}

/// @nodoc
abstract class $AuthErrorCopyWith<$Res> {
  factory $AuthErrorCopyWith(AuthError value, $Res Function(AuthError) then) =
      _$AuthErrorCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class _$AuthErrorCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements $AuthErrorCopyWith<$Res> {
  _$AuthErrorCopyWithImpl(AuthError _value, $Res Function(AuthError) _then)
      : super(_value, (v) => _then(v as AuthError));

  @override
  AuthError get _value => super._value as AuthError;

  @override
  $Res call({
    Object message = freezed,
  }) {
    return _then(AuthError(
      message == freezed ? _value.message : message as String,
    ));
  }
}

/// @nodoc
class _$AuthError implements AuthError {
  const _$AuthError(this.message) : assert(message != null);

  @override
  final String message;

  @override
  String toString() {
    return 'AuthState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is AuthError &&
            (identical(other.message, message) ||
                const DeepCollectionEquality().equals(other.message, message)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(message);

  @JsonKey(ignore: true)
  @override
  $AuthErrorCopyWith<AuthError> get copyWith =>
      _$AuthErrorCopyWithImpl<AuthError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object>({
    @required TResult initial(),
    @required TResult signingUp(),
    @required TResult signedUp(),
    @required TResult signingIn(),
    @required TResult signedIn(String token),
    @required TResult error(String message),
  }) {
    assert(initial != null);
    assert(signingUp != null);
    assert(signedUp != null);
    assert(signingIn != null);
    assert(signedIn != null);
    assert(error != null);
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object>({
    TResult initial(),
    TResult signingUp(),
    TResult signedUp(),
    TResult signingIn(),
    TResult signedIn(String token),
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
    @required TResult initial(AuthInitial value),
    @required TResult signingUp(AuthSigningUp value),
    @required TResult signedUp(AuthSignedUp value),
    @required TResult signingIn(AuthSigningIn value),
    @required TResult signedIn(AuthSignedIn value),
    @required TResult error(AuthError value),
  }) {
    assert(initial != null);
    assert(signingUp != null);
    assert(signedUp != null);
    assert(signingIn != null);
    assert(signedIn != null);
    assert(error != null);
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object>({
    TResult initial(AuthInitial value),
    TResult signingUp(AuthSigningUp value),
    TResult signedUp(AuthSignedUp value),
    TResult signingIn(AuthSigningIn value),
    TResult signedIn(AuthSignedIn value),
    TResult error(AuthError value),
    @required TResult orElse(),
  }) {
    assert(orElse != null);
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AuthError implements AuthState {
  const factory AuthError(String message) = _$AuthError;

  String get message;
  @JsonKey(ignore: true)
  $AuthErrorCopyWith<AuthError> get copyWith;
}
