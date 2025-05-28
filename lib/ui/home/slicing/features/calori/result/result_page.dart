import 'package:allerscan_eng/consts/colors.dart';
import 'package:allerscan_eng/consts/fonts.dart';
import 'package:allerscan_eng/ui/home/slicing/features/calori/count/count_page.dart';
import 'package:allerscan_eng/ui/home/slicing/features/calori/result/macro_section.dart';
import 'package:allerscan_eng/ui/home/slicing/features/calori/result/tips.dart';
import 'package:flutter/material.dart';
import 'package:allerscan_eng/ui/navbar/navbar.dart';

class CalorieResultPage extends StatelessWidget {
  final double bmr;
  final double tdee;

  const CalorieResultPage({Key? key, required this.bmr, required this.tdee})
    : super(key: key);

  Map<String, dynamic> calculateMacros(double calorieTarget) {
    double carbsCalories = calorieTarget * 0.5;
    double proteinCalories = calorieTarget * 0.3;
    double fatCalories = calorieTarget * 0.2;

    return {
      'protein': (proteinCalories / 4).round(),
      'carbs': (carbsCalories / 4).round(),
      'fat': (fatCalories / 9).round(),
      'total': calorieTarget.round(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final cuttingCalories = tdee * 0.8;
    final bulkingCalories = tdee * 1.2;

    final cuttingMacros = calculateMacros(cuttingCalories);
    final bulkingMacros = calculateMacros(bulkingCalories);

    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          color: colorWhite,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Daily Calorie Result',
          style: AppTextStyles.poppinsBold2.copyWith(color: colorWhite),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            CaloriTipsCard(
              title: "👨‍⚕️ Your BMR Result",
              value: "${bmr.round()} kcal/day",
              description:
                  "*BMR is the minimum amount of calories your body needs to maintain basic functions like breathing, regulating temperature, and heartbeat while you're at rest (e.g., sleeping). These calories are essential for survival even without physical activity.",
            ),
            const SizedBox(height: 16),
            CaloriTipsCard(
              title: "🏃‍♂️ Your TDEE Result",
              value: "${tdee.round()} kcal/day",
              description:
                  "*TDEE is the total number of calories you need per day based on your physical activity, including walking, studying, exercising, and light daily tasks. Knowing your TDEE helps you decide whether to gain (surplus), lose (deficit), or maintain weight (balanced).",
            ),
            const SizedBox(height: 24),
            CalorieMacroSection(
              title: "Bulking",
              subtitle:
                  "Bulking is performed when you want to increase muscle mass or gain weight. Calorie intake is higher than daily needs to give the body enough energy to build muscle.",
              macros: bulkingMacros,
            ),
            const SizedBox(height: 24),
            CalorieMacroSection(
              title: "Cutting",
              subtitle:
                  "Cutting is done to lose weight or reduce body fat. Calorie intake is reduced so that the body uses stored fat as a source of energy.",
              macros: cuttingMacros,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => CaloriCountPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Check Again",
                  style: AppTextStyles.montsBold5.copyWith(color: colorWhite),
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Navbar()),
                    (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorWhite,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: primaryColor, width: 2),
                  ),
                ),
                child: Text(
                  "Back to Home",
                  style: AppTextStyles.montsBold5.copyWith(color: primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
