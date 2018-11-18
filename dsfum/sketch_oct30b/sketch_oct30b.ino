void setup() {
  pinMode(10,OUTPUT);
  pinMode(11,OUTPUT);
  pinMode(12,OUTPUT);
  pinMode(13,OUTPUT);
}
 
void loop() {  
  for(int i=10; i<14; i++)
     if(i-10 == millis()/300 % 4)
         digitalWrite(i,LOW);
     else    
         digitalWrite(i,HIGH);    
}
