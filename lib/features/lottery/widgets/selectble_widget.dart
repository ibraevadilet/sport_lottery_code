import 'package:flutter/material.dart';
import 'package:sport_lottery/helpers/app_text_styles.dart';

class SelectbleWidget extends StatelessWidget {
  const SelectbleWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });
  final String title;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
          ),
          child: Text(
            title,
            style: AppTextStyles.s15W600(),
          ),
        ),
      ),
    );
  }
}
