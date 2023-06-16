import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_lottery/features/my_athletes/logic/cubits/cubit/student_cubit.dart';
import 'package:sport_lottery/features/my_athletes/logic/models/student_model.dart';
import 'package:sport_lottery/features/sport_competitions/compet_my_students_cubit/compet_my_students_cubit.dart';
import 'package:sport_lottery/helpers/app_colors.dart';
import 'package:sport_lottery/helpers/app_text_styles.dart';
import 'package:sport_lottery/widgets/app_error_text.dart';
import 'package:sport_lottery/widgets/app_indicator.dart';
import 'package:sport_lottery/widgets/custom_button.dart';
import 'package:sport_lottery/widgets/spaces.dart';
import 'package:sport_lottery/widgets/styled_toasts.dart';

Future<void> showSelectAthletesDialog(
  BuildContext context,
  List<StudentModel> selectedStudents,
  String competID,
  String selectedCategory,
) async {
  List<StudentModel> selectedNewStudents = [];
  await showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          content: BlocProvider(
            create: (context) =>
                StudentCubit()..getCategoryStudents(selectedCategory),
            child: SizedBox(
              width: getWidth(context),
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  Text(
                    'Выберите из списка тех, кого хотите добавить в $selectedCategory',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: BlocBuilder<StudentCubit, StudentState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          orElse: () => const AppIndicator(),
                          error: (error) => AppErrorText(error: error),
                          successGet: (model) => ListView.separated(
                            itemCount: model.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                if (selectedNewStudents
                                    .contains(model[index])) {
                                  setState(() {
                                    selectedNewStudents.remove(model[index]);
                                  });
                                } else {
                                  setState(() {
                                    selectedNewStudents.add(model[index]);
                                  });
                                }
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Имя: ${model[index].name}',
                                            style: AppTextStyles.s16W400(),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            'Год рождения: ${model[index].age}',
                                            style: AppTextStyles.s16W400(),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            'Вес: ${model[index].weight}',
                                            style: AppTextStyles.s16W400(),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Visibility(
                                      visible: selectedNewStudents
                                              .contains(model[index]) ||
                                          selectedStudents
                                              .contains(model[index]),
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.check,
                                          color: AppColors.colorF0912FFDarkBLue,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Отмена',
                          onPressed: () {
                            selectedStudents.clear();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: BlocConsumer<CompetMyStudentsCubit,
                            CompetMyStudentsState>(
                          listener: (context, state) {
                            state.whenOrNull(
                              successAdd: () {
                                Navigator.pop(context);
                              },
                            );
                          },
                          builder: (context, state) {
                            return CustomButton(
                              isLoading: state.isLoading,
                              text: 'Добавить',
                              onPressed: () {
                                if (selectedNewStudents.isNotEmpty) {
                                  context
                                      .read<CompetMyStudentsCubit>()
                                      .addCompetStudent(
                                          competID,
                                          selectedNewStudents,
                                          selectedCategory);
                                } else {
                                  showErrorSnackBar('Выберите учеников');
                                }
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
