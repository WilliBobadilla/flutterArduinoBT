import 'package:flutter/material.dart';
import 'package:flutter_arduino_b_t/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SideBar extends StatelessWidget {
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
                    Icons.person,
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
                Center(
                  child: Text(
                    "Locura",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
                Center(
                  child: Text(
                    "Example",
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
            leading: Icon(Icons.home),
            title: Text('Inicio'),
            onTap: () {
              if (Get.currentRoute == Routes.HOME) {
                Get.back();
              } else {
                Get.toNamed(Routes.HOME);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Conexíon'),
            onTap: () {
              if (Get.currentRoute == Routes.CONEXIONBT) {
                Get.back();
              } else {
                Get.toNamed(Routes.CONEXIONBT);
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Encargado'),
            onTap: () {},
          ),
          Column(
            children: [
              ListTile(
                leading: Icon(Icons.border_color),
                title: Text('Historial'),
                onTap: () {},
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.update),
            title: Text('Cambiar Usuario'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Cerrar Sesión'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
