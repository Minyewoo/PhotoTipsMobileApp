import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:photo_tips/cubit/user_cubit.dart';
import 'package:photo_tips/data/models/user.dart';
import 'package:photo_tips/data/network_exception.dart';
import 'package:photo_tips/data/repositories/auth_repository.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  final ApiAuthRepository _authRepository;
  final UserCubit _userCubit;

  AuthCubit(this._authRepository, this._userCubit) : super(AuthState.initial());

  Future<void> signIn(String email, String password) async {
    try {
      emit(AuthState.signingIn());
      final token = await _authRepository.fetchToken(email, password);
      emit(AuthState.signedIn(token));
      await _userCubit.getUser(token);
    } on NetworkException {
      emit(AuthState.error("Проблемы с соединением"));
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    try {
      emit(AuthState.signingUp());

      await _authRepository.signUp(name, email, password);
      emit(AuthState.signedUp());
      signIn(email, password);
    } on NetworkException {
      emit(AuthState.error("Проблемы с соединением"));
    }
  }

  void logOut() {
    clear();
    emit(AuthState.initial());
    _userCubit.emit(UserState.initial());
  }

  @override
  AuthState fromJson(Map<String, dynamic> json) {
    try {
      final token = json['token'];
      return AuthState.signedIn(token);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic> toJson(AuthState state) {
    if (state is AuthSignedIn) {
      return {'token': state.token};
    } else {
      return null;
    }
  }
}
