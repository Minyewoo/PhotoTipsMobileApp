import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_tips/data/models/photo.dart';
import 'package:photo_tips/data/network_exception.dart';
import 'package:photo_tips/data/repositories/photo_repository.dart';

part 'photo_state.dart';
part 'photo_cubit.freezed.dart';

class PhotoCubit extends Cubit<PhotoState> {
  final PhotoRepository _photoRepository;

  PhotoCubit(this._photoRepository) : super(PhotoState.initial());

  Future<void> getPhotos(String token) async {
    try {
      emit(PhotoState.loading());
      final photos = await _photoRepository.fetchPhotos(token);
      emit(PhotoState.loaded(photos));
    } on NetworkException {
      emit(PhotoState.error("Проблемы с получением данных пользователя"));
    }
  }
}
