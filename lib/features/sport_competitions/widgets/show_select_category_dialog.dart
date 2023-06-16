import 'package:flutter/material.dart';
import 'package:sport_lottery/features/sport_competitions/widgets/category_widget.dart';
import 'package:sport_lottery/widgets/custom_button.dart';

Future<String?> showSelectCategoryDialog(BuildContext context) async {
  String? category;
  await showDialog(
    context: context,
    builder: (context) => StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 10),
        title: const Text('Выберите категорию'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CategoryWidget(
              titile: 'Дети',
              isSelected: category == 'Дети',
              onTap: () {
                setState(() {
                  category = 'Дети';
                });
              },
            ),
            CategoryWidget(
              titile: 'Юноши',
              isSelected: category == 'Юноши',
              onTap: () {
                setState(() {
                  category = 'Юноши';
                });
              },
            ),
            CategoryWidget(
              titile: 'Кадеты',
              isSelected: category == 'Кадеты',
              onTap: () {
                setState(() {
                  category = 'Кадеты';
                });
              },
            ),
            CategoryWidget(
              titile: 'Юниоры',
              isSelected: category == 'Юниоры',
              onTap: () {
                setState(() {
                  category = 'Юниоры';
                });
              },
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    text: 'Отмена',
                    onPressed: () {
                      category = null;
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: CustomButton(
                    text: 'Применить',
                    onPressed: () {
                      if (category != null) {
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }),
  );
  return category;
}
