part of 'submission_cubit.dart';

@freezed
abstract class SubmissionState with _$SubmissionState {
  const factory SubmissionState.initial() = SubmissionInitial;
  const factory SubmissionState.loading() = SubmissionLoading;
  const factory SubmissionState.loaded(List<Submission> submissions) = SubmissionLoaded;
  const factory SubmissionState.error(String message) = SubmissionError;
}
