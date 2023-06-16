import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sport_lottery/features/competitions_for_admin/logic/models/compet_model.dart';
import 'package:sport_lottery/features/lottery/logic/cubits/get_athletes_cubit/get_athletes_cubit.dart';
import 'package:sport_lottery/features/lottery/logic/models/athlete_model.dart';
import 'package:sport_lottery/features/lottery/widgets/athlete_widget.dart';
import 'package:sport_lottery/features/lottery/widgets/selectble_widget.dart';
import 'package:sport_lottery/helpers/app_colors.dart';
import 'package:sport_lottery/helpers/app_text_styles.dart';
import 'package:sport_lottery/widgets/app_indicator.dart';
import 'package:sport_lottery/widgets/spaces.dart';

class LotteryScreen extends StatefulWidget {
  const LotteryScreen({super.key, required this.model});
  final CompetModel model;

  @override
  State<LotteryScreen> createState() => _LotteryScreenState();
}

class _LotteryScreenState extends State<LotteryScreen> {
  List<AthleteModel> athletes = [];

  String selectedGender = 'Парни';
  String selectedCategory = 'Дети';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetAthletesCubit()..getBoyAthletes(widget.model.id, selectedCategory),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19),
            child: Column(
              children: [
                const SizedBox(height: 5),
                Text(
                  'Резултаты жеребьевки',
                  style: AppTextStyles.s19W700(),
                ),
                const SizedBox(height: 12),
                Builder(
                  builder: (context) => Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: AppColors.colorF0912FFDarkBLue,
                    ),
                    child: Row(
                      children: [
                        SelectbleWidget(
                          title: 'Дети',
                          isSelected: selectedCategory == 'Дети',
                          onTap: () {
                            setState(() {
                              selectedCategory = 'Дети';
                            });
                            selectedGender == 'Парни'
                                ? context
                                    .read<GetAthletesCubit>()
                                    .getBoyAthletes(
                                        widget.model.id, selectedCategory)
                                : context
                                    .read<GetAthletesCubit>()
                                    .getGirlAthletes(
                                        widget.model.id, selectedCategory);
                          },
                        ),
                        const SizedBox(width: 10),
                        SelectbleWidget(
                          title: 'Юноши',
                          isSelected: selectedCategory == 'Юноши',
                          onTap: () {
                            setState(() {
                              selectedCategory = 'Юноши';
                            });
                            selectedGender == 'Парни'
                                ? context
                                    .read<GetAthletesCubit>()
                                    .getBoyAthletes(
                                        widget.model.id, selectedCategory)
                                : context
                                    .read<GetAthletesCubit>()
                                    .getGirlAthletes(
                                        widget.model.id, selectedCategory);
                          },
                        ),
                        const SizedBox(width: 10),
                        SelectbleWidget(
                          title: 'Кадеты',
                          isSelected: selectedCategory == 'Кадеты',
                          onTap: () {
                            setState(() {
                              selectedCategory = 'Кадеты';
                            });
                            selectedGender == 'Парни'
                                ? context
                                    .read<GetAthletesCubit>()
                                    .getBoyAthletes(
                                        widget.model.id, selectedCategory)
                                : context
                                    .read<GetAthletesCubit>()
                                    .getGirlAthletes(
                                        widget.model.id, selectedCategory);
                          },
                        ),
                        const SizedBox(width: 10),
                        SelectbleWidget(
                          title: 'Юниоры',
                          isSelected: selectedCategory == 'Юниоры',
                          onTap: () {
                            setState(() {
                              selectedCategory = 'Юниоры';
                            });
                            selectedGender == 'Парни'
                                ? context
                                    .read<GetAthletesCubit>()
                                    .getBoyAthletes(
                                        widget.model.id, selectedCategory)
                                : context
                                    .read<GetAthletesCubit>()
                                    .getGirlAthletes(
                                        widget.model.id, selectedCategory);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Builder(
                  builder: (context) => Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: AppColors.colorF0912FFDarkBLue,
                    ),
                    child: Row(
                      children: [
                        SelectbleWidget(
                          title: 'Парни',
                          isSelected: selectedGender == 'Парни',
                          onTap: () {
                            setState(() {
                              selectedGender = 'Парни';
                            });
                            context.read<GetAthletesCubit>().getBoyAthletes(
                                widget.model.id, selectedCategory);
                          },
                        ),
                        const SizedBox(width: 12),
                        SelectbleWidget(
                          title: 'Девушки',
                          isSelected: selectedGender == 'Девушки',
                          onTap: () {
                            setState(() {
                              selectedGender = 'Девушки';
                            });
                            context.read<GetAthletesCubit>().getGirlAthletes(
                                widget.model.id, selectedCategory);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: BlocConsumer<GetAthletesCubit, GetAthletesState>(
                    listener: (context, state) {
                      state.whenOrNull(
                        success: (model) {
                          athletes.addAll(model);
                          setState(() {});
                        },
                      );
                    },
                    builder: (context, state) {
                      return state.maybeWhen(
                        orElse: () => const AppIndicator(),
                        success: (model) => model.isEmpty
                            ? const Center(
                                child: Text(
                                  'Участники отсутствуют',
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : ListView.separated(
                                itemCount: model.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, indexFirst) => Column(
                                  children: [
                                    const SizedBox(height: 12),
                                    Container(
                                      alignment: Alignment.center,
                                      width: getWidth(context),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.colorF0912FFDarkBLue,
                                      ),
                                      child: Text(
                                        'Весовая категория: ${model[indexFirst].weightCategory}',
                                        style: AppTextStyles.s16W600(
                                            color: Colors.white),
                                      ),
                                    ),
                                    const SizedBox(height: 12),
                                    model[indexFirst].students.isEmpty
                                        ? const Center(
                                            child: Text(
                                              'В данной весовой категории участники отсутствуют',
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        : MasonryGridView.count(
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 5,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: model[indexFirst]
                                                .students
                                                .length,
                                            crossAxisCount: 2,
                                            itemBuilder: (context, index) =>
                                                AthleteWidget(
                                              number: index + 1,
                                              model: model[indexFirst]
                                                  .students[index],
                                            ),
                                          ),
                                  ],
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
      ),
    );
  }
}
