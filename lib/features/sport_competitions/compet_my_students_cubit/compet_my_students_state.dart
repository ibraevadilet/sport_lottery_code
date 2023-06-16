part of 'compet_my_students_cubit.dart';

@freezed
class CompetMyStudentsState with _$CompetMyStudentsState {
  const factory CompetMyStudentsState.initial() = _Initial;
  const factory CompetMyStudentsState.loading() = _Loading;
  const factory CompetMyStudentsState.error(String error) = _Error;
  const factory CompetMyStudentsState.successGet(List<StudentModel> model) =
      _SuccessGet;
  const factory CompetMyStudentsState.successAdd() = _SuccessAdd;

  const CompetMyStudentsState._();
  bool get isLoading => maybeWhen(
        orElse: () => false,
        loading: () => true,
      );
}
