import 'package:flutter/material.dart';
import 'package:rovertaxi/Utilities/res/color.dart';

import '../../Utilities/routes/routes_name.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () async {
      Navigator.pushNamed(context, RoutesName.homeView);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: const Center(
          child: Text(
            'Rover Taxi',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: AppColors.primaryBackgroundColor),
          ),
        ),
      ),
    );
  }
}
