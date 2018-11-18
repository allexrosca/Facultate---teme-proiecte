
    const int trigPin = 4;
    const int echoPin = 3;
    long duration;
    int distance;
    
    void setup() {
      pinMode(2,OUTPUT);
      pinMode(5,OUTPUT);
      pinMode(12,OUTPUT);
      pinMode(13,OUTPUT);
      pinMode(11,OUTPUT);
      pinMode(10,OUTPUT);
      pinMode(9,OUTPUT);
      pinMode(8,OUTPUT);
    pinMode(trigPin, OUTPUT);
    pinMode(echoPin, INPUT); 
    Serial.begin(9600); 
    }
    void loop() {

  digitalWrite(2,LOW);
  digitalWrite(5,HIGH);
    digitalWrite(trigPin, LOW);
    delayMicroseconds(2);
    digitalWrite(trigPin, HIGH);
    delayMicroseconds(10);
    digitalWrite(trigPin, LOW);
    duration = pulseIn(echoPin, HIGH);
    distance= duration*0.034/2;
    Serial.print("Distance: ");
    Serial.println(distance);

  if(distance>=0 && distance<=40)
    {digitalWrite(8,HIGH);
    digitalWrite(9,LOW);
digitalWrite(10,LOW);
digitalWrite(11,LOW);
digitalWrite(12,LOW);
digitalWrite(13,LOW);
    delay(200);}

    if(distance>=41 && distance<=80)
    {digitalWrite(8,HIGH);
    digitalWrite(9,HIGH);
    digitalWrite(10,LOW);
digitalWrite(11,LOW);
digitalWrite(12,LOW);
digitalWrite(13,LOW);
    delay(200);}

        if(distance>=81 && distance<=120)
    {digitalWrite(8,HIGH);
    digitalWrite(9,HIGH);
    digitalWrite(10,HIGH);
    digitalWrite(11,LOW);
    digitalWrite(12,LOW);
digitalWrite(13,LOW);
    delay(200);}

    
        if(distance>=121 && distance <=160)
   { digitalWrite(8,HIGH);
    digitalWrite(9,HIGH);
    digitalWrite(10,HIGH);
    digitalWrite(11,HIGH);
    digitalWrite(12,LOW);
digitalWrite(13,LOW);
    delay(200);}

            if(distance>=161 && distance <=200)
   { digitalWrite(8,HIGH);
    digitalWrite(9,HIGH);
    digitalWrite(10,HIGH);
    digitalWrite(11,HIGH);
    digitalWrite(12,HIGH);
digitalWrite(13,LOW);
    delay(200);}


            if(distance>=201)
   { digitalWrite(8,HIGH);
    digitalWrite(9,HIGH);
    digitalWrite(10,HIGH);
    digitalWrite(11,HIGH);
    digitalWrite(12,HIGH);
digitalWrite(13,HIGH);
    delay(200);}

delay(200);

    }
