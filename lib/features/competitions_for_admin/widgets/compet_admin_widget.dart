import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_lottery/features/competitions_for_admin/logic/cubits/competition_cubit/competition_cubit.dart';
import 'package:sport_lottery/features/competitions_for_admin/logic/models/compet_model.dart';
import 'package:sport_lottery/features/lottery/compet_detail_screen.dart';
import 'package:sport_lottery/features/my_athletes/widgets/delete_dismissible_widget.dart';
import 'package:sport_lottery/helpers/app_colors.dart';
import 'package:sport_lottery/helpers/app_text_styles.dart';
import 'package:sport_lottery/widgets/spaces.dart';

class CompetAdminWidget extends StatelessWidget {
  const CompetAdminWidget({super.key, required this.model});

  final CompetModel model;

  @override
  Widget build(BuildContext context) {
    return DeleteDismissibleWidget(
      onDelete: () async {
        await context.read<CompetitionCubit>().deleteCompets(model.id);
      },
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CompetDetailScreen(model: model),
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
      ),
    );
  }
}
