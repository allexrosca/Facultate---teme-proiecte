 
#include <SPI.h>
#include <SD.h>
 
void setup() {
  Serial.begin(9600);
  while (!Serial) {
    ; // va asteptam sa deschideti consola seriala
  }
  if (!SD.begin(4)) { // 4 este pinul SS al cardului SD
    Serial.println("Nu putem accesa cardul... aveti un card acolo ? este formatat FAT16 sau FAT32 ?");    
    return; // iese si nu mai face nimic
  }  
  Serial.println("Accesare card -> OK");
}
 
int opt = 1;
void loop() {
  if (opt>0)
  {
    Serial.println("\n\nIntroduceti optiunea: ");
    Serial.println("1 - Fisierul exista ?");
    Serial.println("2 - Crearea fisierului.");
    Serial.println("3 - Citirea si afisarea fisierului.");
    Serial.println("4 - Stergerea fisierului.");  
    opt = 0;
  }
 
  if (Serial.available())
  {
    opt = Serial.read()-'0';
  }
 
  if (opt==1){
     if(SD.exists("myFile.txt")) Serial.println("DA, exista");
     else Serial.println("NU l-am gasit");
  }
 
  if (opt==2){
    File myFile = SD.open("myFile.txt", FILE_WRITE);
    if (myFile){
      myFile.println("Salutari din Arduino.");
      myFile.close();
      Serial.println("Am creat fisierul!");
    }
  }
 
 
  if (opt==3){
    if (SD.exists("myFile.txt")){
      File myFile = SD.open("myFile.txt", FILE_READ);    
      while (myFile.available()) {
        Serial.write(myFile.read());
      }    
      myFile.close();
    }
    else
    {
      Serial.println("Fisier Inexistent");
    }
  }
 
  if(opt==4){
    if (SD.exists("myFile.txt")) {SD.remove("myFile.txt");Serial.println("Fisier sters.");}
    else Serial.println("Nu am ce sterge.");
  }
 
}
