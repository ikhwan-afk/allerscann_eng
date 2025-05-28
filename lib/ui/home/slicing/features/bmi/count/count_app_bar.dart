// import 'package:allerscan/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:allerscan_eng/consts/colors.dart';
import 'package:allerscan_eng/consts/fonts.dart';

class BMICustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BMICustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: primaryColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: colorWhite,
        // onPressed: () {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(builder: (context) => Home()),
        //   );
        // },
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'Body Mass Index',
        style: AppTextStyles.poppinsBold2.copyWith(color: colorWhite),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
