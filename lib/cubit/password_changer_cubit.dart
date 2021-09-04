import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_changer_state.dart';
part 'password_changer_cubit.freezed.dart';

class PasswordChangerCubit extends Cubit<PasswordChangerState> {
  PasswordChangerCubit() : super(PasswordChangerState.initial());
}
