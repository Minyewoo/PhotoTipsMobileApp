import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_tips/cubit/auth_cubit.dart';
import 'package:photo_tips/cubit/user_cubit.dart';
import 'package:photo_tips/data/models/submission.dart';
import 'package:photo_tips/data/network_exception.dart';
import 'package:photo_tips/data/repositories/submission_repository.dart';

part 'submission_state.dart';
part 'submission_cubit.freezed.dart';

class SubmissionCubit extends Cubit<SubmissionState> {
  final SubmissionRepository _submissionRepository;
  final AuthCubit _authCubit;
  SubmissionCubit(this._submissionRepository, this._authCubit) : super(SubmissionState.initial());

  Future<void> getSubmissions() async {
    try {
      emit(SubmissionState.loading());
      var state = _authCubit.state;
      if(state is AuthSignedIn)
      {
        final submissions = await _submissionRepository.fetchSubmissions(state.token);
        emit(SubmissionState.loaded(submissions));
      }
      else emit(SubmissionState.loaded([]));
    } on NetworkException {
      emit(SubmissionState.error("Проблемы с получением данных пользователя"));
    }
  }
}
