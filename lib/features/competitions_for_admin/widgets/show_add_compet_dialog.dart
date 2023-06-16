import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sport_lottery/features/competitions_for_admin/logic/cubits/competition_cubit/competition_cubit.dart';
import 'package:sport_lottery/features/competitions_for_admin/logic/models/compet_model.dart';
import 'package:sport_lottery/helpers/app_colors.dart';
import 'package:sport_lottery/widgets/custom_button.dart';
import 'package:sport_lottery/widgets/custom_text_field.dart';
import 'package:sport_lottery/widgets/spaces.dart';
import 'package:sport_lottery/widgets/styled_toasts.dart';

showAddCompetDialog(BuildContext context, Function() onSuccess) async {
  String name = '';
  String date = '';
  String dedline = '';

  bool allEntred() => name.isNotEmpty && date.isNotEmpty && dedline.isNotEmpty;
  await showDialog(
    context: context,
    builder: (context) => BlocProvider(
      create: (context) => CompetitionCubit(),
      child: AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10),
        content: SizedBox(
          width: getWidth(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              const Text('Добавьте соревнование'),
              const SizedBox(height: 12),
              CustomTextField(
                hintText: 'Название',
                onChanged: (nameFrom) {
                  name = nameFrom;
                },
              ),
              const SizedBox(height: 12),
              CustomTextField(
                hintText: 'Дата проведения (01.01.2023)',
                keyboardType: TextInputType.number,
                onChanged: (dateFrom) {
                  date = dateFrom;
                },
              ),
              const SizedBox(height: 12),
              CustomTextField(
                hintText: 'Дедлайн (01.01.2023)',
                inputFormatters: [
                  MaskTextInputFormatter(
                    mask: '##.##.#### ##:##:##',
                    filter: {
                      '#': RegExp(r'[0-9]'),
                    },
                  ),
                ],
                keyboardType: TextInputType.number,
                onChanged: (dedlineFrom) {
                  dedline = dedlineFrom;
                },
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
                    child: BlocConsumer<CompetitionCubit, CompetitionState>(
                      listener: (context, state) {
                        state.whenOrNull(
                          successAdd: () {
                            showSuccessSnackBar('Успешно добавлен!');
                            Navigator.pop(context);
                            onSuccess();
                          },
                        );
                      },
                      builder: (context, state) {
                        return CustomButton(
                          isLoading: state.isLoading,
                          color: AppColors.colorF0912FFDarkBLue,
                          text: 'Добавить',
                          onPressed: () async {
                            final String docId = DateTime.now()
                                .millisecondsSinceEpoch
                                .toString();
                            if (allEntred()) {
                              context.read<CompetitionCubit>().addCompets(
                                    CompetModel(
                                      id: docId,
                                      name: name,
                                      date: date,
                                      dedline: dedline,
                                    ),
                                  );
                            } else {
                              showErrorSnackBar('Заполните все поля');
                            }
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
      ),
    ),
  );
}
