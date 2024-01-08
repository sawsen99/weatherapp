import 'package:get/instance_manager.dart';
import 'package:weatherapp/modules/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(city: 'boumerdes'));
  }
}
