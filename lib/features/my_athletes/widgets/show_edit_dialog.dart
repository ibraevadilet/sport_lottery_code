import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_lottery/features/my_athletes/logic/cubits/cubit/student_cubit.dart';
import 'package:sport_lottery/features/my_athletes/logic/models/student_model.dart';
import 'package:sport_lottery/helpers/app_colors.dart';
import 'package:sport_lottery/helpers/app_text_styles.dart';
import 'package:sport_lottery/widgets/custom_button.dart';
import 'package:sport_lottery/widgets/custom_text_field.dart';
import 'package:sport_lottery/widgets/spaces.dart';
import 'package:sport_lottery/widgets/styled_toasts.dart';

showEditDialog(
  BuildContext context,
  Function() onSuccess,
  StudentModel model,
) async {
  final fioController = TextEditingController(text: model.name);
  final ageController = TextEditingController(text: model.age.toString());
  final weightController = TextEditingController(text: model.weight.toString());

  String fio = model.name;
  String age = model.age.toString();
  String weight = model.weight.toString();
  String gender = model.gender;
  List<String> genders = ['М', 'Ж'];

  await showDialog(
    context: context,
    builder: (context) => BlocProvider(
      create: (context) => StudentCubit(),
      child: StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          content: SizedBox(
            width: getWidth(context),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 12),
                const Text('Изменение данных ученика'),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: fioController,
                  hintText: 'ФИО',
                  onChanged: (fioFrom) {
                    fio = fioFrom;
                  },
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: ageController,
                  hintText: 'Год рождения',
                  keyboardType: TextInputType.number,
                  onChanged: (ageFrom) {
                    age = ageFrom;
                  },
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  controller: weightController,
                  hintText: 'Вес (кг)',
                  keyboardType: TextInputType.number,
                  onChanged: (weightFrom) {
                    weight = weightFrom;
                  },
                ),
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.color38B6FFBLue,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      isExpanded: true,
                      style: AppTextStyles.s15W400(color: AppColors.white),
                      hint: Center(
                        child: Text(
                          'Выберите пол',
                          style: AppTextStyles.s15W400(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      selectedItemBuilder: (context) => genders
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.color38B6FFBLue,
                                ),
                                child: Text(
                                  e,
                                  style: AppTextStyles.s16W600(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      value: gender,
                      iconEnabledColor: AppColors.white,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            gender = newValue;
                          });
                        }
                      },
                      items: genders
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Container(
                                alignment: Alignment.center,
                                width: getWidth(context),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.color38B6FFBLue,
                                ),
                                child: Text(
                                  e,
                                  style: AppTextStyles.s16W600(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: 'Отмена',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: BlocConsumer<StudentCubit, StudentState>(
                        listener: (context, state) {
                          state.whenOrNull(
                            successAdd: () {
                              showSuccessSnackBar('Успешно изменен!');
                              Navigator.pop(context);
                              onSuccess();
                            },
                          );
                        },
                        builder: (context, state) {
                          return CustomButton(
                            isLoading: state.isLoading,
                            color: AppColors.colorF0912FFDarkBLue,
                            text: 'Сохранить',
                            onPressed: () async {
                              context.read<StudentCubit>().editStudents(
                                    StudentModel(
                                      gender: gender,
                                      id: model.id,
                                      name: fio,
                                      weight: int.parse(weight),
                                      age: int.parse(age),
                                      trainer: model.trainer,
                                    ),
                                  );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    ),
  );
}
