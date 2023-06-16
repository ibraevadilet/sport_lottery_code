part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.loaded(UserModel user) = _Loaded;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.singOut() = _SignOut;
}
