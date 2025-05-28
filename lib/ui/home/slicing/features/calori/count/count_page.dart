import 'package:allerscan_eng/consts/fonts.dart';
import 'package:allerscan_eng/ui/home/slicing/features/calori/count/count_app_bar.dart';
import 'package:allerscan_eng/ui/home/slicing/features/calori/count/count_input_form.dart';
import 'package:allerscan_eng/ui/home/slicing/features/calori/result/result_page.dart';
import 'package:flutter/material.dart';
import 'package:allerscan_eng/consts/colors.dart';

class CaloriCountPage extends StatefulWidget {
  const CaloriCountPage({super.key});

  @override
  State<CaloriCountPage> createState() => _CaloriCountPageState();
}

class _CaloriCountPageState extends State<CaloriCountPage> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  String gender = 'Male';
  double activityFactor = 1.2;
  double bmr = 0.0;
  double tdee = 0.0;

  void calculateCalori() {
    final double weight = double.tryParse(weightController.text) ?? 0;
    final double height = double.tryParse(heightController.text) ?? 0;
    final int age = int.tryParse(ageController.text) ?? 0;

    if (weight > 0 && height > 0 && age > 0) {
      if (gender == 'Male') {
        bmr = 13.7 * weight + 5 * height - 6.8 * age + 65;
      } else {
        bmr = 9.6 * weight + 1.8 * height - 4.7 * age + 655;
      }

      tdee = bmr * activityFactor;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CalorieResultPage(bmr: bmr, tdee: tdee),
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter valid data.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: const CaloriCustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/bmi_1.png',
                width: 240,
                height: 240,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Calculate Your BMR & TDEE Now!',
              style: AppTextStyles.poppinsBold2.copyWith(color: colorBlack),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Know your energy needs (BMR) and how many calories you need per day based on your activity level (TDEE).',
                style: AppTextStyles.montsReg1.copyWith(color: colorBlack),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            CaloriInputForm(
              onGenderChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
              weightController: weightController,
              heightController: heightController,
              ageController: ageController,
              gender: gender,
              activityFactor: activityFactor,
              onActivityChanged: (value) {
                setState(() {
                  activityFactor = value!;
                });
              },
              onCalculatePressed: calculateCalori,
            ),
          ],
        ),
      ),
    );
  }
}
