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
        title: Text("Inicio"),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 20.0,
          ),
          Text(
            "Sensor de luz",
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "46",
                style: TextStyle(
                  fontSize: 50.0,
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                height: 50.0,
                width: 50.0,
                child: Text(
                  "LUX",
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}
