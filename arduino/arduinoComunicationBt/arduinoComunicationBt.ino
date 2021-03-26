
/*
  Autor: Williams Bobadilla
  Fecha creacion: 25 marzo 2021
  Descripcion: software para la demostracion de la conexion de flutter con arduino, mediante
  un modulo bluetooth, un sensor y un servomotor.

*/

#include <SoftwareSerial.h>


SoftwareSerial BT(7, 8); // RX, TX
String received = "";
bool receiving = false;


void setup() {
  Serial.begin(9600);
  BT.begin(9600);
}


void loop() {
  while (BT.available() > 0) {
    char data = BT.read();
    received = received + data;
    receiving = true;
  }
  if (receiving == true) {
    //aca tenemos que escribir el codigo en el servo,
    //hacemos esto aca con la bandera receiving debido a que el programa 
    //despues de salir del while es que recien podemos tener el mensaje completo
    Serial.print("recibido:  ");
    Serial.println(received);
    receiving = false;
    received = ""; //limpiamos para futuros mensajes
  }
}

void escribir_datos(String dataToWrite) {
  BT.print("#");
  BT.print(dataToWrite);
  BT.println("*");
}
