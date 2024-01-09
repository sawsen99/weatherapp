import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/constants.dart';
import 'package:weatherapp/modules/home/binding.dart';
import 'package:weatherapp/modules/splash/view.dart';

void main() async {
  runApp(const MyApp());
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'World Weather',
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => SplashScreen(),
          binding: HomeBinding(),
        )
      ],
    );
  }
}
