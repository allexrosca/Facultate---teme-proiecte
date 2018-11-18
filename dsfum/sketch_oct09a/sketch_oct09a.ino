
void setup() {
  // put your setup code here, to run once:
  pinMode(LED_BUILTIN, OUTPUT);
  Serial.begin(9600);
}


}
void loop() {

     int sentByte = Serial.read();
     if (sentByte == '1')
      { digitalWrite(LED_BUILTIN, HIGH);
        s=1;  
           Serial.println("pornit"); }
     else if (sentByte == '2')
      { digitalWrite(LED_BUILTIN, LOW);
        s=0;
        Serial.println("oprit"); }

           
  
}
