part of 'auth_cubit.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = AuthInitial;
  const factory AuthState.signingUp() = AuthSigningUp;
  const factory AuthState.signedUp() = AuthSignedUp;
  const factory AuthState.signingIn() = AuthSigningIn;
  const factory AuthState.signedIn(String token) = AuthSignedIn;
  const factory AuthState.error(String message) = AuthError;
}
