import 'package:flutter/material.dart';
import 'package:flutter_arduino_b_t/app/modules/conexionbt/controllers/conexionbt_controller.dart';
import 'package:flutter_arduino_b_t/app/modules/home/widgets/drawer_side.dart';

import 'package:get/get.dart';

class ConexionbtView extends GetView<ConexionbtController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        title: Text('Conexion BT'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          Container(height: 30),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text(
                    ' Bluetooth',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                Obx(() => Switch(
                      value: controller.bluetoothState.value,
                      onChanged: (bool value) {
                        controller.future(
                            value); //to change the status the bluetooth conection
                      },
                    ))
              ],
            ),
          ),
          Container(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Dispositivo:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Obx(() => DropdownButton(
                      items: controller.items,
                      onChanged: (value) {
                        print("seleccionado" + value.toString());
                        controller.device.value = value;
                        //controller.dispositivoSeleccionado = value;
                      },
                      value: controller.devicesList.isNotEmpty
                          ? controller.device.value
                          : null,
                    )),
                Obx(() => RaisedButton(
                      onPressed: controller.connected.value
                          ? controller.disconnect
                          : controller.connect,
                      child: Text(controller.connected.value
                          ? 'Desconectar'
                          : 'Connectar'),
                    )),
              ],
            ),
          ),
          Container(height: 25),
        ],
      )),
    );
  }
}
