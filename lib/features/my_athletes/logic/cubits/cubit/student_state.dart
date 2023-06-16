part of 'student_cubit.dart';

@freezed
class StudentState with _$StudentState {
  const factory StudentState.initial() = _Initial;
  const factory StudentState.loading() = _Loading;
  const factory StudentState.error(String error) = _Error;
  const factory StudentState.successGet(List<StudentModel> model) = _SuccessGet;
  const factory StudentState.successAdd() = _SuccessAdd;

  const StudentState._();
  bool get isLoading => maybeWhen(
        orElse: () => false,
        loading: () => true,
      );
}
