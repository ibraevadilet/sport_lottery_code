import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_lottery/features/auth/data/auth_repo.dart';
import 'package:sport_lottery/features/auth/domain/auth_use_case.dart';
import 'package:sport_lottery/features/auth/presentation/auth_cubit/auth_cubit.dart';
import 'package:sport_lottery/helpers/app_colors.dart';
import 'package:sport_lottery/helpers/app_text_styles.dart';
import 'package:sport_lottery/widgets/app_indicator.dart';
import 'package:sport_lottery/widgets/buttom_navigator.dart';
import 'package:sport_lottery/widgets/custom_app_bar.dart';
import 'package:sport_lottery/widgets/custom_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthUseCase(GetAuthRepoImpl())),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Авторизация'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Требуется выполнить вход через Google аккаунт',
                textAlign: TextAlign.center,
                style: AppTextStyles.s20W700(
                  color: AppColors.color38B6FFBLue,
                ),
              ),
              const SizedBox(height: 12),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  state.whenOrNull(
                    loaded: (user) => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const BottomTranerNavigatorScreen(),
                      ),
                      (route) => false,
                    ),
                    loading: () => showDialog(
                      context: context,
                      builder: (context) => const AppIndicator(),
                    ),
                  );
                },
                builder: (context, state) => CustomButton(
                  onPressed: () {
                    context.read<AuthCubit>().getAuth();
                  },
                  text: 'Войти',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
