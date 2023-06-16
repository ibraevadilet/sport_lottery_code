import 'package:flutter/material.dart';
import 'package:sport_lottery/features/auth/presentation/auth_page.dart';
import 'package:sport_lottery/features/competitions_for_admin/competitions_for_admin_screen.dart';
import 'package:sport_lottery/helpers/app_colors.dart';
import 'package:sport_lottery/helpers/saved_data.dart';
import 'package:sport_lottery/widgets/buttom_navigator.dart';
import 'package:sport_lottery/widgets/custom_button.dart';
import 'package:sport_lottery/widgets/custom_text_field.dart';
import 'package:sport_lottery/widgets/styled_toasts.dart';

class SelectRoleScreen extends StatefulWidget {
  const SelectRoleScreen({super.key});

  @override
  State<SelectRoleScreen> createState() => _SelectRoleScreenState();
}

class _SelectRoleScreenState extends State<SelectRoleScreen> {
  final String password = 'нацфед2023';
  String pass = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите роль'),
        backgroundColor: AppColors.color38B6FFBLue,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  text: 'Админ',
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 12),
                            const Text('Введите пароль'),
                            const SizedBox(height: 12),
                            CustomTextField(
                              hintText: 'Пароль',
                              obscureText: true,
                              onChanged: (passFrom) {
                                pass = passFrom;
                              },
                            ),
                            const SizedBox(height: 12),
                            CustomButton(
                              text: 'Войти',
                              onPressed: () {
                                if (password == pass) {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const CompetitionsForAdminScreen(),
                                    ),
                                  );
                                } else {
                                  if (pass.isEmpty) {
                                    showErrorSnackBar('Введите пароль');
                                  } else {
                                    showErrorSnackBar('Неверный пароль');
                                  }
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                CustomButton(
                  text: 'Тренер',
                  onPressed: () async {
                    final name = await SavedData.getName();
                    if (name.isEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AuthScreen(),
                        ),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const BottomTranerNavigatorScreen(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
