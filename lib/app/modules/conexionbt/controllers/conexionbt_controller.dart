import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_arduino_b_t/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';

class ConexionbtController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();

//---------bt conexion---------
  RxBool bluetoothState = RxBool(false);

// Instanciamos la clase FlutterBluetoothSerial y creamos el objeto bluetooth
  FlutterBluetoothSerial bluetooth = FlutterBluetoothSerial.instance;

// para guardar la conexion del bluetooth
  BluetoothConnection connection;

// para saber si esta conectado el bluetooth
  bool get isConnected => connection != null && connection.isConnected;

  RxList<BluetoothDevice> devicesList = RxList<BluetoothDevice>([]);

  bool isDisconnecting = false;
  String received = " "; // para almacenar lo recibido por bluetooth
  RxString receivedText = RxString("");
  bool recieving = false; //para guardar el estado de la recepcion de datos
  Rx<BluetoothDevice> device = Rx<BluetoothDevice>();
  RxBool connected = RxBool(false); //para saber el estado de la conexion

//items para el dropbownMenu, reactivos para que la interfaz se redibuje ante cambios
  RxList<DropdownMenuItem<BluetoothDevice>> items =
      RxList<DropdownMenuItem<BluetoothDevice>>([]);

  @override
  void onInit() {
    FlutterBluetoothSerial.instance.state.then((state) async {
      if (state == BluetoothState.STATE_ON) {
        bluetoothState.value = true; //estado de bluetooth en ON
      } else if (state == BluetoothState.STATE_OFF) {
        bluetoothState.value = false; //estado del bluetooth en OFF
        devicesList.clear(); // limpiamos la lista de dispositivos
      }
    });
    // escucha por cambios en el estado del bluetooth
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) async {
      if (state == BluetoothState.STATE_ON) {
        bluetoothState.value = true;
      } else if (state == BluetoothState.STATE_OFF) {
        bluetoothState.value = false;
        devicesList.clear();
      }
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }
  }

  Future<void> getPairedDevices() async {
    try {
      var dispositivos = await bluetooth.getBondedDevices();
      dispositivos.forEach((disp) {
        devicesList.add(disp);
      });
    } on PlatformException {
      print("Error");
    }
  }

  void future(bool value) async {
    if (value) {
      //al apretar el switch, si pasa a activado, activa el bluetooth
      await FlutterBluetoothSerial.instance.requestEnable();
      await getPairedDevices(); //obtenemos los dispositivos pareados
    } else {
      //de lo contrario, desactiva el BT
      await FlutterBluetoothSerial.instance.requestDisable();
      devicesList.clear(); //limpia la lista de dispositivos
    }

    getDeviceItems(); //va a actualizar los items del dropDownManu de la interfaz

    if (connected.value) {
      disconnect();
    }
  }

  ///Funcion para enviar los datos por el bluetooth
  ///input: String code
  ///output: null
  void sendMessageToBluetooth(String code) async {
    connection.output.add(utf8.encode(code + "\r\n"));
    await connection.output.allSent; //esperamos que envie todos los datos
  }

  void connect() async {
    if (device == null) {
      //si no se selecciono ningun dispositivo, no hace nada
    } else {
      if (!isConnected) {
        await BluetoothConnection.toAddress(device.value.address)
            .then((_connection) {
          // se solicita la conexion y se guarda los datos
          connection = _connection;
          connected.value = true;
          connection.input.listen((Uint8List data) {
            //homeController.cleanInput(); // clean data before read something new
            String datos = ascii.decode(data).toString();
            print("datos: " + datos);
            receiveDataToDecode(datos); //vamos a decodificar los datos
          });
        }).catchError((error) {
          print('Cannot connect, exception occurred');
          print(error);
        });
      }
    }
  }

  ///Funcion que desconecta el bluetooth
  ///input:null
  ///output: null
  void disconnect() async {
    await connection.close();
    if (!connection.isConnected) {
      connected.value = false;
    }
    devicesList.clear();
  }

  ///Funcion que crea la lista de dispositivos para el menu desplegable
  ///input: null
  ///output: null
  void getDeviceItems() {
    if (devicesList.isEmpty) {
      items.clear();
      items.add(DropdownMenuItem(
        child: Text("NONE"),
      ));
    } else {
      //recorremos todos los dispositivos y lo agregamos al dropDown Menu
      devicesList.forEach((device) {
        items.add(DropdownMenuItem(
          key: UniqueKey(),
          child: Text(device.name),
          value: device,
        ));
      });
    }
  }

  ///Funcion para decodificar los datos que llegan desde el hardware,
  ///el resultado se escribe en la variable global received
  ///input: String datos
  ///output: String dataReceived
  void receiveDataToDecode(String datos) {
    // a "#" is for the start and a "*" at the final to end the reception
    if (datos.contains("#") && !recieving) {
      // to start the reception
      recieving = true;
    }
    if (recieving) {
      received = received + datos;
    }
    if (datos.contains("*") && recieving) {
      // ya no recibimos datos ya que encontarmos al final "*"
      recieving = false;
      received = received
          .replaceAll("#", "")
          .replaceAll("*", ""); //limpiamos el dato y sacamos el # y *
      print("finalmente recibido es: " + received);
      homeController.sensor.value = received;
      received = ""; //clean the data

    }
  }
}
