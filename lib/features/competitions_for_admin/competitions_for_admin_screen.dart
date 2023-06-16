import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sport_lottery/features/competitions_for_admin/logic/cubits/competition_cubit/competition_cubit.dart';
import 'package:sport_lottery/features/competitions_for_admin/widgets/compet_admin_widget.dart';
import 'package:sport_lottery/features/competitions_for_admin/widgets/show_add_compet_dialog.dart';
import 'package:sport_lottery/widgets/app_error_text.dart';
import 'package:sport_lottery/widgets/app_indicator.dart';
import 'package:sport_lottery/widgets/custom_app_bar.dart';

class CompetitionsForAdminScreen extends StatelessWidget {
  const CompetitionsForAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompetitionCubit()..getCompets(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Соревнования'),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            onPressed: () async {
              await showAddCompetDialog(context, () {
                context.read<CompetitionCubit>().getCompets();
              });
            },
            child: const Icon(
              Icons.add,
            ),
          ),
        ),
        body: BlocBuilder<CompetitionCubit, CompetitionState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const AppIndicator(),
              error: (error) => AppErrorText(error: error),
              successGet: (model) => model.isEmpty
                  ? const Center(
                      child: Text('Добавьте соревнования'),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListView.separated(
                        itemCount: model.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) => CompetAdminWidget(
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
