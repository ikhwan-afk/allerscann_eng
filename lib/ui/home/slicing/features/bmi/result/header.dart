import 'package:flutter/material.dart';

class BMIHeader extends StatelessWidget {
  final bool isContentVisible;
  final String bmiCategory; // Menambahkan parameter untuk kategori BMI

  const BMIHeader({
    Key? key,
    required this.isContentVisible,
    required this.bmiCategory, // Menerima kategori BMI
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String imagePath;

    switch (bmiCategory.trim().toLowerCase()) {
      case 'underweight':
        imagePath = 'assets/images/underweight.png';
        break;
      case 'ideal':
        imagePath = 'assets/images/ideal.png';
        break;
      case 'overweight':
        imagePath = 'assets/images/overweight.png';
        break;
      case 'obesitas':
        imagePath = 'assets/images/obesitas.png';
        break;
      default:
        imagePath = 'assets/images/underweight.png';
        break;
    }

    return AnimatedOpacity(
      opacity: isContentVisible ? 1.0 : 0.0,
      duration: const Duration(seconds: 2),
      child: Center(child: Image.asset(imagePath, width: 180, height: 180)),
    );
  }
}
