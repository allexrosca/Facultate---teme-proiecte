const int buton = A1; // se utilizeaza butonul asociat pinului A2  
const int led =  13;  // pentru a aprinde ledul conectat la pinul digital 13            
unsigned long timp; 
void setup() {
  pinMode(led, OUTPUT);
  pinMode(buton, INPUT);
    Serial.begin(9600);
}
 
void loop() {
  if (digitalRead(buton)) {
    digitalWrite(led, HIGH); 
    timp=millis();



  } else {
    digitalWrite(led, LOW);
  if (timp != 0){
 Serial.println(timp/100);
 timp = 0;
  }

  }


}
