import 'package:allerscan_eng/consts/colors.dart';
import 'package:allerscan_eng/consts/fonts.dart';
import 'package:allerscan_eng/ui/home/slicing/features/calori/result/macro_card.dart';
import 'package:flutter/material.dart';

class CalorieMacroSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final Map<String, dynamic> macros;

  const CalorieMacroSection({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.macros,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.montsBold4.copyWith(color: colorBlack),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: AppTextStyles.montsReg2.copyWith(color: colorGray1),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CaloriMacroCard(
              label: "Carbohydrates",
              value: "${macros['carbs']} grams",
            ),
            CaloriMacroCard(
              label: "Protein",
              value: "${macros['protein']} grams",
            ),
            CaloriMacroCard(label: "Fat", value: "${macros['fat']} grams"),
          ],
        ),
      ],
    );
  }
}
