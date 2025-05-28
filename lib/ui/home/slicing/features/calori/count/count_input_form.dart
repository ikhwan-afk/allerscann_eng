import 'package:allerscan_eng/consts/fonts.dart';
import 'package:flutter/material.dart';
import 'package:allerscan_eng/consts/colors.dart';

class CaloriInputForm extends StatelessWidget {
  final TextEditingController weightController;
  final TextEditingController heightController;
  final TextEditingController ageController;
  final String gender;
  final double activityFactor;
  final ValueChanged<String?> onGenderChanged;
  final ValueChanged<double?> onActivityChanged;
  final VoidCallback onCalculatePressed;

  const CaloriInputForm({
    super.key,
    required this.weightController,
    required this.heightController,
    required this.ageController,
    required this.gender,
    required this.activityFactor,
    required this.onGenderChanged,
    required this.onActivityChanged,
    required this.onCalculatePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDropdownGender(),
        const SizedBox(height: 10),
        _buildInputField("Weight (kg)", weightController),
        const SizedBox(height: 10),
        _buildInputField("Height(cm)", heightController),
        const SizedBox(height: 10),
        _buildInputField("Age", ageController),
        const SizedBox(height: 10),
        _buildActivityDropdown(context),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
            onPressed: onCalculatePressed,
            child: Text(
              'Calculate',
              style: AppTextStyles.montsBold5.copyWith(color: colorWhite),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        floatingLabelStyle: const TextStyle(color: primaryColor),
        border: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: colorGray1, width: 1),
        ),
        fillColor: Colors.white,
        filled: true,
      ),
    );
  }

  Widget _buildDropdownGender() {
    return DropdownButtonFormField<String>(
      value: gender,
      decoration: _dropdownDecoration("Gender"),
      items: const [
        DropdownMenuItem(value: 'Male', child: Text('Male')),
        DropdownMenuItem(value: 'Women', child: Text('Women')),
      ],
      onChanged: onGenderChanged,
    );
  }

  Widget _buildActivityDropdown(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: DropdownButtonFormField<double>(
            value: activityFactor,
            decoration: _dropdownDecoration("Activity Level"),
            items: const [
              DropdownMenuItem(value: 1.2, child: Text('Very low activity')),
              DropdownMenuItem(value: 1.3, child: Text('Light (1-3x/week)')),
              DropdownMenuItem(
                value: 1.55,
                child: Text('Moderate (3-5x/week)'),
              ),
              DropdownMenuItem(value: 1.73, child: Text('Intense (6-7x/week)')),
            ],
            onChanged: onActivityChanged,
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.help_outline, color: primaryColor),
          onPressed: () {
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    backgroundColor: colorWhite,
                    title: Text(
                      'Activity Level Explanation',
                      style: AppTextStyles.poppinsBold4.copyWith(
                        color: primaryColor,
                      ),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '1. Very low activity\n',
                                  style: AppTextStyles.poppinsBold6.copyWith(
                                    color: colorBlack,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'This level reflects a sedentary lifestyle, typically involving prolonged sitting or lying down with minimal physical movement. Examples include working on a computer all day, watching TV for hours, or resting without significant physical activity.\n\n',
                                  style: AppTextStyles.montsReg2.copyWith(
                                    color: colorBlack,
                                  ),
                                ),
                                TextSpan(
                                  text: '2. Light\n',
                                  style: AppTextStyles.poppinsBold6.copyWith(
                                    color: colorBlack,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'Light activity refers to minimal physical movement 1 to 3 times per week. Examples include standing for periods, typing, teaching, or other non-strenuous activities.\n\n',
                                  style: AppTextStyles.montsReg2.copyWith(
                                    color: colorBlack,
                                  ),
                                ),
                                TextSpan(
                                  text: '3. Moderate\n',
                                  style: AppTextStyles.poppinsBold6.copyWith(
                                    color: colorBlack,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'This level applies to individuals who are physically active about 3 to 5 times per week. Activities may include house cleaning, walking, shopping, or casual cycling.\n\n',
                                  style: AppTextStyles.montsReg2.copyWith(
                                    color: colorBlack,
                                  ),
                                ),
                                TextSpan(
                                  text: '4. Intense\n',
                                  style: AppTextStyles.poppinsBold6.copyWith(
                                    color: colorBlack,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      'Intense activity includes physically demanding work or high-intensity exercise performed almost daily. Examples are hiking, heavy gardening, or construction work.\n',
                                  style: AppTextStyles.montsReg2.copyWith(
                                    color: colorBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text(
                          'Close',
                          style: AppTextStyles.montsReg2.copyWith(
                            color: colorBlack,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
            );
          },
        ),
      ],
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      floatingLabelStyle: const TextStyle(color: primaryColor),
      border: const OutlineInputBorder(),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: 2),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: colorGray1, width: 1),
      ),
      fillColor: Colors.white,
      filled: true,
    );
  }
}
