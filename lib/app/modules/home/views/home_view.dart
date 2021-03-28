import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_arduino_b_t/app/widgets/action_bar.dart';
import 'package:flutter_arduino_b_t/app/widgets/custom_drawer.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        actions: actionBar(),
        title: Text("Arduino Day"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Sensor de luz",
              style: TextStyle(
                fontSize: 40.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    controller.sensor.value,
                    style: TextStyle(
                      fontSize: 50.0,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.topLeft,
                  height: 50.0,
                  child: Text(
                    "LUX",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                )
              ],
            ),
            Text(
              "Control Servo Motor",
              style: TextStyle(
                fontSize: 40.0,
              ),
            ),
            Obx(
              () => Text(
                controller.valorSlider.value.toStringAsFixed(2) + " º",
                style: TextStyle(
                  fontSize: 35.0,
                ),
              ),
            ),
            Obx(
              () => Slider(
                value: controller.valorSlider.value,
                min: 0,
                max: 180,
                onChanged: (value) {
                  controller.valorSlider.value = value;
                },
                onChangeEnd: (value) {
                  //Enviar
                  print(value);
                  controller.conexionbtController
                      .sendMessageToBluetooth(value.toString());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
