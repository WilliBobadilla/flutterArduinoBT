import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/conexionbt_controller.dart';

class ConexionbtView extends GetView<ConexionbtController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ConexionbtView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ConexionbtView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
