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
        child: Text(
          "HomeView is working",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
