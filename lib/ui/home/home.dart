import 'package:allerscan_eng/consts/colors.dart';
import 'package:allerscan_eng/consts/fonts.dart';
import 'package:allerscan_eng/ui/home/slicing/article/article.dart';
import 'package:allerscan_eng/ui/home/slicing/banner/banners.dart';
import 'package:allerscan_eng/ui/home/slicing/features/features.dart';
import 'package:allerscan_eng/ui/home/slicing/header/header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:allerscan_eng/ui/manage/manage_allergies/providers/allergy_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await Provider.of<AllergyProvider>(
      context,
      listen: false,
    ).loadSelectedAllergies();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: colorWhite,
      body:
          _isLoading
              ? Center(child: CircularProgressIndicator(color: primaryColor))
              : SingleChildScrollView(
                child: Column(
                  children: [
                    HeaderSection(size: size),
                    const SizedBox(height: 10),
                    const BannerSection(), // Make sure internal texts are also in English
                    const FiturSection(), // Previously: FiturSection
                    const BeritaSection(), // Previously: BeritaSection
                  ],
                ),
              ),
    );
  }

  AppBar buildAppBar(BuildContext context) => AppBar(
    elevation: 0,
    centerTitle: true,
    title: Text(
      'AllerScan',
      style: AppTextStyles.poppinsBold2.copyWith(color: colorBlack),
    ),
    backgroundColor: secondaryColor,
  );
}
