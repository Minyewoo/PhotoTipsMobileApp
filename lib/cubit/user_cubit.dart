import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_tips/data/models/user.dart';
import 'package:photo_tips/data/network_exception.dart';
import 'package:photo_tips/data/repositories/user_repository.dart';

part 'user_state.dart';
part 'user_cubit.freezed.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository _userRepository;

  UserCubit(this._userRepository) : super(UserState.initial());

  Future<void> getUser(String token) async {
    try {
      emit(UserState.loading());
      final user = await _userRepository.fetchUser(token);
      emit(UserState.loaded(user));
    } on NetworkException {
      emit(UserState.error("Проблемы с получением данных пользователя"));
    }
  }
}
