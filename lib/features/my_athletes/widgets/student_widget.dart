import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_lottery/features/my_athletes/logic/cubits/cubit/student_cubit.dart';
import 'package:sport_lottery/features/my_athletes/logic/models/student_model.dart';
import 'package:sport_lottery/features/my_athletes/widgets/delete_dismissible_widget.dart';
import 'package:sport_lottery/features/my_athletes/widgets/show_edit_dialog.dart';
import 'package:sport_lottery/helpers/app_colors.dart';
import 'package:sport_lottery/helpers/app_text_styles.dart';
import 'package:sport_lottery/widgets/spaces.dart';

class StudentWidget extends StatelessWidget {
  const StudentWidget({
    super.key,
    required this.model,
  });

  final StudentModel model;

  @override
  Widget build(BuildContext context) {
    return DeleteDismissibleWidget(
      onDelete: () async {
        await context.read<StudentCubit>().deleteStudent(model.id);
      },
      child: Container(
        width: getWidth(context),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.colorFED5E4LightBlue,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                ],
              ),
            ),
            const SizedBox(width: 12),
            InkWell(
              onTap: () async {
                await showEditDialog(
                  context,
                  () {
                    context.read<StudentCubit>().getStudents();
                  },
                  model,
                );
              },
              child: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
