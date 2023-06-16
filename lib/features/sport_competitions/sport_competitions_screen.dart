import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_lottery/features/competitions_for_admin/logic/cubits/competition_cubit/competition_cubit.dart';
import 'package:sport_lottery/features/sport_competitions/widgets/compet_widget.dart';
import 'package:sport_lottery/widgets/app_error_text.dart';
import 'package:sport_lottery/widgets/app_indicator.dart';
import 'package:sport_lottery/widgets/custom_app_bar.dart';

class SportCompetitionsScreen extends StatelessWidget {
  const SportCompetitionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompetitionCubit()..getCompets(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Соревнования'),
        body: BlocBuilder<CompetitionCubit, CompetitionState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const AppIndicator(),
              error: (error) => AppErrorText(error: error),
              successGet: (model) => model.isEmpty
                  ? const Center(
                      child: Text('Соревнования отсутствуют'),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.separated(
                        itemCount: model.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) => CompetWidget(
                          model: model[index],
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
