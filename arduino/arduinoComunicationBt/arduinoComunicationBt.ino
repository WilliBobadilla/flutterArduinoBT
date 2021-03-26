
/*
  Autor: Williams Bobadilla
  Fecha creacion: 25 marzo 2021
  Descripcion: software para la demostracion de la conexion de flutter con arduino, mediante
  un modulo bluetooth, un sensor y un servomotor.

*/


#include <SPI.h>
#include <MFRC522.h>
#include  <Wire.h>
#include <SoftwareSerial.h>

typedef struct {
  byte TagName[48];  //Drug Name
  byte weight[12];    //Dosage
  byte race[4];  //remaining
} TagInfo;

TagInfo tagInfo;
const byte tagNameBlockAddr[3] = {1, 2, 4};

byte block;
byte len;

const int RST_PIN = 9;  // pines usados para el rfid
const int SS_PIN = 10;

MFRC522 mfrc522(SS_PIN, RST_PIN);  // creamos el objeto mfrc522 para usar luego las funcionalidades del rfid
MFRC522::MIFARE_Key key;

SoftwareSerial BT(7, 8); // RX, TX
String received = "";
bool receiving = false;

int cargandoLed = 4;
void setup() {

  Serial.begin(9600);
  pinMode(cargandoLed, OUTPUT);
  BT.begin(9600);
  //------------configuraciones para el rfid-----------
  SPI.begin();
  mfrc522.PCD_Init();

  for (byte i = 0; i < 6; i++) {
    key.keyByte[i] = 0xFF;
  }

}


void loop() {
  int length = BT.available();
  while (BT.available() > 0) {
    char data = BT.read();
    //Serial.print(data);
    received = received + data;
    receiving = true;
  }
  if (receiving == true) {
    //here we have to go to write the code in the rfid tag
    //we do in this way because only when the program get out from the while we get the whole message
    Serial.print("recibido:  ");
    Serial.println(received);
    receiving = false;
    received = ""; //clean for futures messages
  }
  
}





void escribir_datos(String dataToWrite) {
  BT.print("#");
  for (byte i = 0; i < 16; i++) {
    //BT.print(buffer[i], HEX);
    //BT.write(tagInfo.TagName[i]);
  }
  BT.println("*");


}
