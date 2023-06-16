part of 'competition_cubit.dart';

@freezed
class CompetitionState with _$CompetitionState {
  const factory CompetitionState.initial() = _Initial;

  const factory CompetitionState.loading() = _Loading;
  const factory CompetitionState.error(String error) = _Error;
  const factory CompetitionState.successGet(List<CompetModel> model) =
      _SuccessGet;
  const factory CompetitionState.successAdd() = _SuccessAdd;

  const CompetitionState._();
  bool get isLoading => maybeWhen(
        orElse: () => false,
        loading: () => true,
      );
}
