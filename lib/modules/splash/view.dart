import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/modules/splash/controller.dart';

class SplashScreen extends StatelessWidget {
  final splashCtrl = Get.put(SplashController());
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 150,
          width: 150,
          color: Colors.white,
          child: Align(
              alignment: Alignment.center,
              child: Lottie.asset(
                'assets/lotties/sun.json',
                //height: 150,

                width: double.infinity,
                frameRate: FrameRate(70),
                animate: true,
                repeat: true,
              )),
        ),
      ),
    );
  }
}
