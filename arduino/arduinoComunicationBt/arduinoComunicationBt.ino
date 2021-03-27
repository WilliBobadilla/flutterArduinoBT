/*
  Autor: Williams Bobadilla
  Fecha creacion: 25 marzo 2021
  Descripcion: software para la demostracion de la conexion de flutter con arduino, mediante
  un modulo bluetooth, un sensor y un servomotor, en el Arduino Day.
*/

#include <SoftwareSerial.h>
#include <Servo.h> 

Servo servo;  //creamos un objeto servo 
SoftwareSerial BT(7, 8); // RX, TX
String received = "";
bool receiving = false;



long tiempoActual;//para guardar el tiempo en todo momento
long tiempoPrevio=0;
const long intervalo=2000;
int lecturaSensor;

void setup() {
  Serial.begin(9600);
  BT.begin(9600);
  servo.attach(3);//indicamos que esta en la patita 4 
  servo.write(0);//comenzamos en el angulo 0
}

void loop() {
 tiempoActual=millis();
 if(tiempoActual-tiempoPrevio>=intervalo ){
   tiempoPrevio=tiempoActual;//actualizamos el tiempo previo
   lecturaSensor=analogRead(A0);
   escribir_datos(lecturaSensor);
   Serial.print("escribiendo ");
   Serial.println(lecturaSensor);
 }
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
    servo.write(received.toInt());
    receiving = false;
    received = ""; //limpiamos para futuros mensajes
  }
}

void escribir_datos(int dataToWrite) {
  BT.print("#");
  BT.print(dataToWrite);
  BT.println("*");
}
