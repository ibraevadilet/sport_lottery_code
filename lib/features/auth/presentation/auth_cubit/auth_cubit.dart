import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sport_lottery/features/auth/data/user_model.dart';
import 'package:sport_lottery/features/auth/domain/auth_use_case.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authUseCase) : super(const AuthState.loading());
  final AuthUseCase authUseCase;

  GoogleSignIn googleSignIn = GoogleSignIn();

  getAuth() async {
    GoogleSignInAccount? googleUser = kIsWeb
        ? await googleSignIn.signInSilently()
        : await googleSignIn.signIn();
    if (googleUser != null) {
      emit(const AuthState.loading());
      emit(
        AuthState.loaded(
          await authUseCase.setUser(
            await googleUser.authentication,
          ),
        ),
      );
    }
  }
}
