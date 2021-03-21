import 'package:flutter_arduino_b_t/app/modules/conexionbt/controllers/conexionbt_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut(() => ConexionbtController());
  }
}
