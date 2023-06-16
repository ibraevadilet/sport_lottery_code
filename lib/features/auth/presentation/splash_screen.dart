import 'package:flutter/material.dart';
import 'package:sport_lottery/features/auth/presentation/president_splash_screen.dart';

import 'package:sport_lottery/helpers/app_colors.dart';
import 'package:sport_lottery/helpers/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const PresidentSplashScreen(),
        ),
        (protected) => false,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.color38B6FFBLue,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: Image.asset(
                  'assets/images/logo.png',
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                'Жеребьевка для соревнований',
                textAlign: TextAlign.center,
                style: AppTextStyles.s40W700(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
