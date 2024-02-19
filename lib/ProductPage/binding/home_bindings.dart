import 'package:get/get.dart';
import 'package:transmedia_project/ProductPage/controller/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
