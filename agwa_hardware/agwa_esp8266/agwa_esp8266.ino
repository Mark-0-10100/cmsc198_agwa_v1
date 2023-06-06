// Programmed by: Dleamnor Euraze Cawaling and Mark Anthony Occena for CMSC 198
// Date Programmed: A.Y. 2022-2023
// Program Title: NodeMCU ESP8266 Code for pH Water Monitoring System
// Program Description: This program handles the Wi-Fi connectivity and communication with the Firebase Realtime Database.
//                      and saves data to realtime database 
// Materials needed:
//    NodeMCU ESP8266
// Libraries needed: Firebase_ESP8266_Client by mobitz

//---- Start: Including of all libraries ----//
#include <stdlib.h>
#include <ESP8266WiFi.h>
#include <FirebaseESP8266.h>
#include <SoftwareSerial.h>
//#include<ArduinoJson.h>
//---- End: Includinf of all libraries ----//

//D6 = Rx; D5 = Tx
//SoftwareSerial nodemcu(D6,D5);

//---- Start: Defining of variables ----//
#define ENABLE_FB_DEBUG true

// First Estate WiFi
//#define WIFI_SSID "GlobeAtHome_d5648_2.4"
//#define WIFI_PASSWORD "3sa9ZpZW"

// My HotSpot
#define WIFI_SSID "OPPO A5s"
#define WIFI_PASSWORD "123456789"

// UPV Miagao WiFi
//#define WIFI_SSID "UPVMIAGAO"
//#define WIFI_PASSWORD ""

// SG Studio WiFi
//#define WIFI_SSID "Studio SG 2.4GHZ"
//#define WIFI_PASSWORD "SGStudio_2023"

#define FIREBASE_HOST "https://agwa-trial-space-v1-default-rtdb.asia-southeast1.firebasedatabase.app"
#define FIREBASE_AUTH "Y7oDCQ3VJGsfp21Iw7IqG0cZf3vpvhSulPrH6pHZ"

float receivedpHValue;

FirebaseData firebaseData;
//--- End: Defining of variables ----//

void setup() {
  Serial.begin(9600);  
  connectToWiFi();
  connectToFirebase();
  Firebase.reconnectWiFi(true);
//  delay(1000);
}

void loop() {
  if (Serial.available() > 0){
    receivedpHValue = Serial.parseFloat();

    // Print the received pH value
    Serial.print("Received pH Value: ");
    Serial.println(receivedpHValue);
    
  }
  if(Firebase.setFloat(firebaseData, "/pHValue", receivedpHValue)){
    Serial.println("pH data sent to Firebase");
    Serial.print("PH Value = ");
    Serial.println(receivedpHValue);
    Serial.println("\n");
//    delay(1000);
  }else{
    Serial.println(firebaseData.errorReason());
  }
  delay(1000);
}

void connectToWiFi() {
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Starting to connect");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print("Connecting...");
  }
  Serial.println("\nConnected to WiFi: ");
  Serial.println(WiFi.localIP());
}

void connectToFirebase() {
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Serial.println("\nConnected to Firebase");
}

void reconnectToFirebase() {
  Serial.println("\nReconnecting to Firebase");
  Firebase.begin(FIREBASE_HOST, FIREBASE_AUTH);
  Serial.println("\nConnected to Firebase");
}
