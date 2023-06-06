// Programmed by: Dleamnor Euraze Cawaling and Mark Anthony Occena for CMSC 198
// Date Programmed: A.Y. 2022-2023
// Program Title: Arduino Uno Code for pH Water Monitoring System
// Program Description: This program reads the pH sensor data and display it on a 16x2 LCD with I2C. 
// Materials needed:
//    PH-450C Liquid pH sensor with E201-BNC Electrode for Arduino
//    Arduino Uno Board
//    1602A LCD with I2C

//---- Start: Including of all libraries ----//
#include <stdlib.h>
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <SoftwareSerial.h> // communication between arduino and nodemcu
//---- End: Includinf of all libraries ----//

//---- Start: Defining of variables ----//
SoftwareSerial nodemcu(5, 6); // serial communication from esp; 5=RX, 6-=TX
LiquidCrystal_I2C lcd(0x27, 16, 2);

// variables to send data to nodeMCU
char buff2[10];
String valueString = "";
String value = "";

// variables for reading the pH
const int ph_sensor_pin = A0;
int phval = 0; 
unsigned long int avgval; 
int buffer_arr[10],temp;
float ph_act;
//--- End: Defining of variables ----//

void setup() {
  pinMode(13,OUTPUT);  
  Serial.begin(9600);
  nodemcu.begin(9600); //Initialize SoftwareSerial for communication with NodeMCU

  lcd.init();
  lcd.begin(16, 2);
  lcd.backlight();
  lcd.setCursor(2,0);
  lcd.print("Welcome to");
  lcd.setCursor(5,1);
  lcd.print("Agwa");
  delay(2000);
  lcd.clear();
}

float readPH(){
  float calibration_value = 21.34 + 1.08;
  
  for(int i=0;i<10;i++) { 
    buffer_arr[i]=analogRead(A0);
    delay(30);
  }
  
  //Sorting Analog values 
  for(int i=0;i<9;i++){
    for(int j=i+1;j<10;j++){
      if(buffer_arr[i]>buffer_arr[j]){
        temp=buffer_arr[i];
        buffer_arr[i]=buffer_arr[j];
        buffer_arr[j]=temp;
      }
    }
  }  
  
  //calculate the average of a 6 centre sample Analog values
  avgval=0;
  for(int i=2;i<8;i++)
    avgval+=buffer_arr[i];
    float volt=(float)avgval*5.0/1024/6; 
    ph_act = -5.70 * volt + calibration_value;

  return ph_act;
}

void displaypHValueLCD(float pH_value){
  lcd.setCursor(0,0);
  lcd.print("pH val: ");
  lcd.setCursor(9,0);
  lcd.print(pH_value);

  //display
  if(pH_value>=6.5 && pH_value<=9.0){
    lcd.setCursor(0,1);
    lcd.print("Normal");
  }else if(pH_value<6.5){
    lcd.setCursor(0,1);
    lcd.print("Acidic");
  }else{
    lcd.setCursor(0,1);
    lcd.print("Basic ");
  }
  Serial.print("pH Value: ");
  Serial.println(pH_value);
}

void loop() {
  float pH_value = readPH();
  displaypHValueLCD(pH_value);

  // send to NodeMCU
  value =  dtostrf(pH_value, 4, 2, buff2);  //4 is minimum width, 2 is number of decimal places
  valueString = valueString + value + ",";
  nodemcu.println(valueString);
  valueString = ""; //reset the valueString
  delay(2000);
}
