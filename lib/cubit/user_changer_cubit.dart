import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_changer_state.dart';
part 'user_changer_cubit.freezed.dart';

class UserChangerCubit extends Cubit<UserChangerState> {
  UserChangerCubit() : super(UserChangerState.initial());
}
