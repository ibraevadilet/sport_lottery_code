import 'package:flutter/material.dart';
import 'package:sport_lottery/features/my_athletes/my_athletes_screen.dart';
import 'package:sport_lottery/features/profile/profile_screen.dart';
import 'package:sport_lottery/features/sport_competitions/sport_competitions_screen.dart';

import 'package:sport_lottery/helpers/app_colors.dart';

class BottomTranerNavigatorScreen extends StatefulWidget {
  const BottomTranerNavigatorScreen({Key? key}) : super(key: key);

  @override
  State<BottomTranerNavigatorScreen> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomTranerNavigatorScreen> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.color38B6FFBLue,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 10,
        selectedFontSize: 10,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
        selectedItemColor: AppColors.white,
        unselectedItemColor: AppColors.white.withOpacity(0.5),
        currentIndex: index,
        onTap: (indexFrom) async {
          setState(() {
            index = indexFrom;
          });
        },
        items: [
          BottomNavigationBarItem(
            activeIcon: const Icon(
              Icons.sports_martial_arts_outlined,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.sports_martial_arts_outlined,
              color: Colors.white.withOpacity(
                0.5,
              ),
            ),
            label: 'Ученики',
          ),
          BottomNavigationBarItem(
            activeIcon: const Icon(
              Icons.sports_score_rounded,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.sports_score_rounded,
              color: Colors.white.withOpacity(
                0.5,
              ),
            ),
            label: 'Соревнования',
          ),
          BottomNavigationBarItem(
            activeIcon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            icon: Icon(
              Icons.person,
              color: Colors.white.withOpacity(
                0.5,
              ),
            ),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}

List<Widget> pages = [
  const MyAthletesScreen(),
  const SportCompetitionsScreen(),
  const ProfileScreen(),
];
