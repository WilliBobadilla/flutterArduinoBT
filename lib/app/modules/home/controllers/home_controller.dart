import 'package:flutter_arduino_b_t/app/modules/conexionbt/controllers/conexionbt_controller.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  ConexionbtController conexionbtController;
  var valorSlider = 0.0.obs;
  var sensor = "0".obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    conexionbtController = Get.find<ConexionbtController>();
    super.onReady();
  }

  @override
  void onClose() {}
}
