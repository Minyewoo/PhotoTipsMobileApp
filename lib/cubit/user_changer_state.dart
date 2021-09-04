part of 'user_changer_cubit.dart';

@freezed
abstract class UserChangerState with _$UserChangerState {
  const factory UserChangerState.initial() = UserChangerInitial;
  const factory UserChangerState.loading() = UserChangerLoading;
  const factory UserChangerState.loaded() = UserChangerLoaded;
  const factory UserChangerState.error(String message) = UserChangerError;
}
