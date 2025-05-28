import 'package:allerscan_eng/ui/scan/service/alergi_service.dart';
import 'package:flutter/material.dart';
import 'package:allerscan_eng/consts/colors.dart';
import 'package:allerscan_eng/consts/fonts.dart';

class FailurePage extends StatelessWidget {
  final List<String> detectedAllergies;

  const FailurePage({super.key, required this.detectedAllergies});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/danger.png', height: 50),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Allergens Detected!',
                      style: AppTextStyles.poppinsBold4.copyWith(
                        color: colorRed1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'This product contains ingredients that may trigger allergic reactions. It is recommended to avoid consumption.',
                      style: AppTextStyles.montsReg2.copyWith(
                        color: colorBlack,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'PRODUCT CONTENT',
            style: AppTextStyles.montsBold5.copyWith(color: colorBlack),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                detectedAllergies
                    .map(
                      (allergy) => Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: colorRed2,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          allergy,
                          style: AppTextStyles.montsBold6.copyWith(
                            color: colorRed1,
                          ),
                        ),
                      ),
                    )
                    .toList(),
          ),
          const SizedBox(height: 24),
          Text(
            'FURTHER EXPLANATION',
            style: AppTextStyles.montsBold5.copyWith(color: colorBlack),
          ),
          const SizedBox(height: 12),
          FutureBuilder<List<AllergyWarning>>(
            future: fetchAllergyWarnings(detectedAllergies),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return _buildGeneralErrorUI(snapshot.error.toString());
              } else if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Text('No data available.');
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      snapshot.data!.map((warning) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '• ${warning.allergy}',
                                style: AppTextStyles.poppinsBold5.copyWith(
                                  color: primaryColor,
                                ),
                              ),
                              const SizedBox(height: 6),
                              _buildRichText('Reaction: ', warning.reaction),
                              _buildRichText('Treatment: ', warning.treatment),
                              _buildRichText('Medication: ', warning.medicine),
                            ],
                          ),
                        );
                      }).toList(),
                );
              } else {
                return const Text('No data available.');
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRichText(String label, String content) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: label,
            style: AppTextStyles.montsBold6.copyWith(color: colorBlack),
          ),
          TextSpan(
            text: content,
            style: AppTextStyles.montsReg2.copyWith(color: colorBlack),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralErrorUI(String errorMessage) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Image.asset('assets/images/no_internet.png', height: 150),
          const SizedBox(height: 12),
          Text(
            'No Internet Connection',
            style: AppTextStyles.montsBold5.copyWith(color: colorBlack),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Please check your connection and try again.',
            style: AppTextStyles.montsReg2.copyWith(color: colorBlack),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
