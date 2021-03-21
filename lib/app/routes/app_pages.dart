import 'package:get/get.dart';

import 'package:flutter_arduino_b_t/app/modules/conexionbt/bindings/conexionbt_binding.dart';
import 'package:flutter_arduino_b_t/app/modules/conexionbt/views/conexionbt_view.dart';
import 'package:flutter_arduino_b_t/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_arduino_b_t/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CONEXIONBT,
      page: () => ConexionbtView(),
      binding: ConexionbtBinding(),
    ),
  ];
}
