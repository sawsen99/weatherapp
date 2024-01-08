import 'package:get/get.dart';
import 'package:weatherapp/modules/onboarding/view.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 6), () {
      Get.offAll(OnboardingScreen());
    });
    super.onInit();
  }
}
