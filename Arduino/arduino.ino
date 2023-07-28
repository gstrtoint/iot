#include <ArduinoJson.h>
#include <ESP8266WiFi.h>
#include <ESP8266WebServer.h>

//const char* ssid = "PMSL-SEC-INFORMATICA";
const char* ssid = "nosnaarea";
const char* password = "santilima";
//const char* password = "s3c-1nf0rm@t1c@";
int ledPin = D3;

ESP8266WebServer server(443);

void handleRequest() {
  if (server.method() == HTTP_POST) {
    DynamicJsonDocument jsonDoc(1024); // Adjust the size according to your JSON payload

    // Parse the JSON body
    DeserializationError error = deserializeJson(jsonDoc, server.arg("plain"));

    if (error) {
      // Failed to parse JSON
      server.send(400, "application/json", "Invalid JSON payload");
      return;
    }

    // Check if the field exists and extract its value
    if (jsonDoc.containsKey("key")) {
      const String fieldValue =  String(jsonDoc["key"].as<const char*>());
      String str = "6iAFjM#!3h53";      
      //Se a key for igual aciona o rele
      if(strcmp(fieldValue.c_str(), str.c_str())==0){
        const int daley = jsonDoc["delay"].as<int>();
        digitalWrite(ledPin, HIGH);   
        delay(daley);                  
        digitalWrite(ledPin, LOW);
        // Use the extracted fieldValue as needed
        server.send(200, "text/plain", "Sucesso");         
      } else {
        // Use the extracted fieldValue as needed
        server.send(200, "text/plain", "Chave de acesso invalida!");
      }
    } else {
      // Field not found in the JSON
      server.send(400, "application/json", "Field not found");
    }
  } else {
    server.send(405, "text/plain", "Method Not Allowed");
  }
}

void setup() {
  Serial.begin(115200);

  Serial.print("Connection to ");
  Serial.println(ssid);
  WiFi.hostname("AutoHome");
  WiFi.begin(ssid, password);

  pinMode(ledPin, OUTPUT);
  digitalWrite(ledPin, LOW);

  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }

  Serial.println("WiFi connected");
  Serial.println("IP address: " + WiFi.localIP().toString());

  server.on("/endpoint", handleRequest);
  server.begin();
}

void loop() {
  server.handleClient();
}