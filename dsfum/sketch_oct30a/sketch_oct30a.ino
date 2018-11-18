#define Do  288
#define Re  303
#define Mi  364
#define Fa  384
#define Sol 432 
#define La  456
#define Si  512
#define DO  576
#define RE  650
#define dSol 407

int note[] = {
  Do,8/2, 
  Mi,12/2, Fa,4/2, Sol,8/2,  La,8/2, 
  Si,16/2,  Mi,8/2, Mi,8/2, 
  DO,12/2,  Si,4/2, Sol,8/2,  Sol,8/2,

  RE,12/2,  DO,4/2, Si,8/2, Si,8/2,
  dSol,12/2,  RE,4/2, DO,8/2, Si,8/2, La,8/2,
  Si,8/2, Sol,16/2, La,8/2,
  Si,12/2,  La,4/2, Sol,16/2, Fa,16/2

};


void setup() {
   pinMode(3, OUTPUT);
   for (int nota_curenta = 0; nota_curenta < 28; nota_curenta++) 
    {
      tone(3, note[nota_curenta*2],100*note[nota_curenta*2+1]); // 3 = pinul cu buzzer-ul, nota, delay
      delay(600);
      noTone(3);
    }  
}

void loop() {
  
}
