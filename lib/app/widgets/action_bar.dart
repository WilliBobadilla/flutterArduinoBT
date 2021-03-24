import 'package:flutter/material.dart';
import 'package:flutter_arduino_b_t/app/modules/conexionbt/controllers/conexionbt_controller.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';

List<Widget> actionBar() {
  ConexionbtController conexionbtController = Get.find<ConexionbtController>();
  return [
    IconButton(
      icon: conexionbtController.isConnected
          ? Icon(
              Icons.bluetooth_connected_rounded,
              color: Colors.green[900],
            )
          : Icon(
              Icons.bluetooth_disabled_rounded,
              color: Colors.red[900],
            ),
      onPressed: () {
        if (!conexionbtController.isConnected) {
          Get.toNamed(Routes.CONEXIONBT);
        }
      },
    )
  ];
}
