import 'package:flutter/material.dart';
import 'package:sport_lottery/helpers/app_text_styles.dart';
import 'package:sport_lottery/widgets/custom_app_bar.dart';

class AboutProgrammScreen extends StatelessWidget {
  const AboutProgrammScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'О программе'),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Text(
              '''
          Проект автоматической жеребьевки спортсменов был разработан при поддержке Президента Национальной Федерации Таэквондо ВТ Кыргызской Республики, Назарбаева Азизбека Абдилатовича. Этот проект представляет инновационную систему для проведения жеребьевок в спортивных соревнованиях по таэквондо.
          
          Автоматическая жеребьевка обеспечивает справедливое и прозрачное распределение спортсменов по различным категориям и весовым классам. С помощью этой системы организаторы соревнований могут эффективно планировать и проводить жеребьевки без необходимости ручного вмешательства.
          
          Проект автоматической жеребьевки спортсменов значительно упрощает и ускоряет процесс организации соревнований, повышает их качество и надежность, а также способствует развитию таэквондо в Кыргызской Республике. Эта система открывает новые возможности для улучшения спортивных мероприятий и обеспечения честной борьбы между участниками.
          ''',
              style: AppTextStyles.s16W400(),
            ),
          ),
        ),
      ),
    );
  }
}
