int sensorpin = 5;                 // analog pin used to connect the sharp sensor
int val = 0;                 // variable to store the values from sensor(initially zero)

void setup()
{
  Serial.begin(9600);  
  pinMode(13, OUTPUT);
  pinMode(12, OUTPUT);
  pinMode(11, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(8, OUTPUT);
}
 
void loop()
{
  val = analogRead(sensorpin);
  if (val<310)
  {
    digitalWrite(13, HIGH);
    delay(200); 
    digitalWrite(12, LOW);
    digitalWrite(11, LOW);
    digitalWrite(10, LOW);
    digitalWrite(9, LOW);
    digitalWrite(8, LOW);
  }
  if((val>=310)&&(val<320))
  {
    digitalWrite(13, HIGH);
    digitalWrite(12, HIGH);
    delay(200); 
    digitalWrite(11, LOW);
    digitalWrite(10, LOW);
    digitalWrite(9, LOW);
    digitalWrite(8, LOW);
  }
  if((val>=320)&&(val<330))
  {
    digitalWrite(13, HIGH);
    digitalWrite(12, HIGH);
    digitalWrite(11, HIGH);
    delay(200); 
    digitalWrite(10, LOW);
    digitalWrite(9, LOW);
    digitalWrite(8, LOW);
  }

  if((val>=330)&&(val<340))
  {
    digitalWrite(13, HIGH);
    digitalWrite(12, HIGH);
    digitalWrite(11, HIGH);
    digitalWrite(10, HIGH);
    delay(200); 
    digitalWrite(9, LOW);
    digitalWrite(8, LOW);
  }
  if((val>=340)&&(val<350))
  {
    digitalWrite(13, HIGH);
    digitalWrite(12, HIGH);
    digitalWrite(11, HIGH);
    digitalWrite(10, HIGH);
    digitalWrite(9, HIGH);
    delay(200);
    digitalWrite(8, LOW);
  }
  if(val>=350)
  {
    digitalWrite(13, HIGH);
    digitalWrite(12, HIGH);
    digitalWrite(11, HIGH);
    digitalWrite(10, HIGH);
    digitalWrite(9, HIGH);
    digitalWrite(8, HIGH);
    delay(200);
  }
  
  
  Serial.println(val);            // prints the value of the sensor to the serial monitor
  delay(100);                    // wait for this much time before printing next value
}
