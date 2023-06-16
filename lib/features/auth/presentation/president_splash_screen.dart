import 'package:flutter/material.dart';
import 'package:sport_lottery/features/auth/presentation/select_role_screen.dart';

import 'package:sport_lottery/helpers/app_text_styles.dart';
import 'package:sport_lottery/widgets/custom_button.dart';

class PresidentSplashScreen extends StatelessWidget {
  const PresidentSplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Image.asset(
                  'assets/images/лого_ВТ_2.png',
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'При поддержке Президента Национальной Федерации Таэквондо ВТ Кыргызской Республики',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.s16W400(),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Назарбаева Азизбека Абдилатовича',
                textAlign: TextAlign.center,
                style: AppTextStyles.s22W700(),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomButton(
                  text: 'Далее',
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SelectRoleScreen(),
                      ),
                      (protected) => false,
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
