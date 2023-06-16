import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_lottery/features/competitions_for_admin/logic/models/compet_model.dart';
import 'package:sport_lottery/features/my_athletes/logic/models/student_model.dart';
import 'package:sport_lottery/features/my_athletes/widgets/delete_dismissible_widget.dart';
import 'package:sport_lottery/features/sport_competitions/compet_my_students_cubit/compet_my_students_cubit.dart';
import 'package:sport_lottery/features/sport_competitions/widgets/show_select_athletes_dialog.dart';
import 'package:sport_lottery/features/sport_competitions/widgets/show_select_category_dialog.dart';
import 'package:sport_lottery/helpers/app_colors.dart';
import 'package:sport_lottery/helpers/app_text_styles.dart';
import 'package:sport_lottery/helpers/date_formates.dart';
import 'package:sport_lottery/widgets/app_indicator.dart';
import 'package:sport_lottery/widgets/spaces.dart';

class CompetDetailScreen extends StatefulWidget {
  const CompetDetailScreen({super.key, required this.model});
  final CompetModel model;

  @override
  State<CompetDetailScreen> createState() => _CompetDetailScreenState();
}

class _CompetDetailScreenState extends State<CompetDetailScreen> {
  List<StudentModel> selectedStudents = [];
  @override
  void initState() {
    context.read<CompetMyStudentsCubit>().getCompetStudents(widget.model.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          DateTime.now().isBefore(dedlineFormat.parse(widget.model.dedline))
              ? Builder(
                  builder: (context) => FloatingActionButton(
                    onPressed: () async {
                      final selectedCategory =
                          await showSelectCategoryDialog(context);
                      if (selectedCategory != null) {
                        await showSelectAthletesDialog(
                          context,
                          List.from(selectedStudents),
                          widget.model.id,
                          selectedCategory,
                        );
                      }
                    },
                    child: const Icon(Icons.add),
                  ),
                )
              : null,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Text(
                'Мои ученики, принимающие участие в данном соревновании:',
                textAlign: TextAlign.center,
                style: AppTextStyles.s16W400(),
              ),
              const SizedBox(height: 5),
              Text(
                widget.model.name,
                style: AppTextStyles.s19W700(),
              ),
              const SizedBox(height: 12),
              Text(
                'Дедлайн сдачи заявок: ${widget.model.dedline}',
                style: AppTextStyles.s19W700(),
              ),
              const SizedBox(height: 12),
              Expanded(
                child:
                    BlocConsumer<CompetMyStudentsCubit, CompetMyStudentsState>(
                  listener: (context, state) {
                    state.whenOrNull(
                      successGet: (model) {
                        selectedStudents.addAll(model);
                      },
                    );
                  },
                  builder: (context, state) {
                    return state.maybeWhen(
                      orElse: () => const AppIndicator(),
                      successGet: (model) => model.isEmpty
                          ? const Center(
                              child: Text(
                                'Вы еще не добавили своих учеников в соревнование',
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.separated(
                              itemCount: model.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (context, index) =>
                                  DeleteDismissibleWidget(
                                onDelete: () {
                                  context
                                      .read<CompetMyStudentsCubit>()
                                      .deleteCompetStudent(
                                        widget.model.id,
                                        model[index].id,
                                      );
                                  selectedStudents.clear();
                                },
                                child: Container(
                                  width: getWidth(context),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColors.colorFED5E4LightBlue,
                                  ),
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
                                      Text(
                                        'Категория: ${model[index].category}',
                                        style: AppTextStyles.s16W400(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
