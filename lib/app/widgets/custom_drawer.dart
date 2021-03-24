import 'package:flutter/material.dart';
import 'package:flutter_arduino_b_t/app/routes/app_pages.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Icon(
                    Icons.satellite_outlined,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
                Center(
                  child: Text(
                    "Flutter + Arduino",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                Center(
                  child: Text(
                    "Ejemplo Bluetooth",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Get.currentRoute == Routes.HOME
                  ? Colors.blue
                  : Colors.grey[700],
            ),
            title: Text(
              'Inicio',
              style: TextStyle(
                color: Get.currentRoute == Routes.HOME
                    ? Colors.blue
                    : Colors.grey[700],
              ),
            ),
            onTap: () {
              if (Get.currentRoute == Routes.HOME) {
                Get.back();
              } else {
                Get.toNamed(Routes.HOME);
              }
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Get.currentRoute == Routes.CONEXIONBT
                  ? Colors.blue
                  : Colors.grey[700],
            ),
            title: Text(
              'Conexíon',
              style: TextStyle(
                color: Get.currentRoute == Routes.CONEXIONBT
                    ? Colors.blue
                    : Colors.grey[700],
              ),
            ),
            onTap: () {
              if (Get.currentRoute == Routes.CONEXIONBT) {
                Get.back();
              } else {
                Get.toNamed(Routes.CONEXIONBT);
              }
            },
          ),
        ],
      ),
    );
  }
}
