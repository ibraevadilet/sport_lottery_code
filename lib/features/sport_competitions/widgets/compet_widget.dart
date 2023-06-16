import 'package:flutter/material.dart';
import 'package:sport_lottery/features/competitions_for_admin/logic/models/compet_model.dart';
import 'package:sport_lottery/features/sport_competitions/compet_detail_screen.dart';
import 'package:sport_lottery/helpers/app_colors.dart';
import 'package:sport_lottery/helpers/app_text_styles.dart';
import 'package:sport_lottery/widgets/spaces.dart';

class CompetWidget extends StatelessWidget {
  const CompetWidget({super.key, required this.model});

  final CompetModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CompetDetailScreen(
              model: model,
            ),
          ),
        );
      },
      child: Container(
        width: getWidth(context),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.colorFED5E4LightBlue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.name,
              style: AppTextStyles.s19W700(),
            ),
            const SizedBox(height: 10),
            Text(
              'Дата проведения: ${model.date}',
              style: AppTextStyles.s16W400(),
            ),
          ],
        ),
      ),
    );
  }
}
