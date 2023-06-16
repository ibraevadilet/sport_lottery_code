import 'package:flutter/material.dart';
import 'package:sport_lottery/features/my_athletes/logic/models/student_model.dart';
import 'package:sport_lottery/helpers/app_colors.dart';
import 'package:sport_lottery/helpers/app_text_styles.dart';
import 'package:sport_lottery/widgets/spaces.dart';

class AthleteWidget extends StatelessWidget {
  const AthleteWidget({
    super.key,
    required this.model,
    this.number,
  });
  final StudentModel model;
  final int? number;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.colorFED5E4LightBlue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          number != null
              ? Text(
                  'Номер: $number',
                  style: AppTextStyles.s16W400(),
                )
              : const SizedBox(),
          SizedBox(height: number != null ? 5 : 0),
          Text(
            'Имя: ${model.name}',
            style: AppTextStyles.s16W400(),
          ),
          const SizedBox(height: 5),
          Text(
            'Год рождения: ${model.age}',
            style: AppTextStyles.s16W400(),
          ),
          const SizedBox(height: 5),
          Text(
            'Вес: ${model.weight}',
            style: AppTextStyles.s16W400(),
          ),
          Text(
            'Пол: ${model.gender}',
            style: AppTextStyles.s16W400(),
          ),
          Text(
            'Категория: ${model.category}',
            style: AppTextStyles.s16W400(),
          ),
          Text(
            'Тренер: ${model.trainer}',
            style: AppTextStyles.s16W400(),
          ),
        ],
      ),
    );
  }
}
