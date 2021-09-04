part of 'password_changer_cubit.dart';

@freezed
abstract class PasswordChangerState with _$PasswordChangerState {
  const factory PasswordChangerState.initial() = PasswordChangerInitial;
  const factory PasswordChangerState.loading() = PasswordChangerLoading;
  const factory PasswordChangerState.loaded() = PasswordChangerLoaded;
  const factory PasswordChangerState.error(String message) = PasswordChangerError;
}

