import 'package:get/get.dart';

import '../controllers/conexionbt_controller.dart';

class ConexionbtBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConexionbtController>(
      () => ConexionbtController(),
    );
  }
}
