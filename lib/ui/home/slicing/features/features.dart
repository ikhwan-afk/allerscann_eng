import 'package:allerscan_eng/consts/colors.dart';
import 'package:allerscan_eng/consts/fonts.dart';
import 'package:allerscan_eng/ui/home/slicing/features/article/see_more/article_list.dart';
import 'package:allerscan_eng/ui/home/slicing/features/bmi/count/count_page.dart';
import 'package:allerscan_eng/ui/home/slicing/features/calori/count/count_page.dart';
import 'package:flutter/material.dart';
import 'package:allerscan_eng/ui/home/slicing/features/widgets/feature_card.dart';

class FiturSection extends StatelessWidget {
  const FiturSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text(
            "More Features",
            style: AppTextStyles.poppinsBold3.copyWith(color: colorBlack),
          ),
          const SizedBox(height: 5),
          Text(
            "Explore additional tools that support your needs",
            style: AppTextStyles.montsReg1.copyWith(color: colorBlack),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FeatureCard(
                title: "BMI",
                assetPath: "assets/icons/bmi.png",
                routeBuilder: BMICountPage(),
              ),
              FeatureCard(
                title: "Daily Calorie",
                assetPath: "assets/icons/bmr.png",
                routeBuilder: CaloriCountPage(),
              ),
              FeatureCard(
                title: "Article",
                assetPath: "assets/icons/article.png",
                routeBuilder: ArticleListPage(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
