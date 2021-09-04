part of 'photo_cubit.dart';

@freezed
abstract class PhotoState with _$PhotoState {
  const factory PhotoState.initial() = PhotoInitial;
  const factory PhotoState.loading() = PhotoLoading;
  const factory PhotoState.loaded(List<Photo> photos) = PhotoLoaded;
  const factory PhotoState.error(String message) = PhotoError;
}
