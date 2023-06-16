part of 'get_athletes_cubit.dart';

@freezed
class GetAthletesState with _$GetAthletesState {
  const factory GetAthletesState.loading() = _Loading;
  const factory GetAthletesState.error(String error) = _Error;
  const factory GetAthletesState.success(List<AthleteModel> model) = _Success;
}
