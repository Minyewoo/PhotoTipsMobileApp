part of 'user_cubit.dart';

@freezed
abstract class UserState with _$UserState {
  const factory UserState.initial() = UserInitial;
  const factory UserState.loading() = UserLoading;
  const factory UserState.loaded(User user) = UserLoaded;
  const factory UserState.error(String message) = UserError;
}
