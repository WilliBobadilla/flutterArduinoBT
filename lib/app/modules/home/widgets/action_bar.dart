import 'package:flutter/material.dart';
import 'package:flutter_arduino_b_t/app/modules/conexionbt/controllers/conexionbt_controller.dart';
import 'package:get/get.dart';

List<Widget> actionBar() {
  ConexionbtController conexionbtController = Get.find<ConexionbtController>();
  return [
    conexionbtController.isConnected
        ? Icon(Icons.bluetooth_connected_rounded, color: Colors.green[900])
        : Icon(Icons.bluetooth_disabled_rounded, color: Colors.red[900]),
    Container(width: 20)
  ];
}
