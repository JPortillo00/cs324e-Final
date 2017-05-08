void setup() {                
  // initialize the digital pins as an output.
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);
  pinMode(8, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
// Turn the Serial Protocol ON
  Serial.begin(9600);
     for(int i=1; i<13; i++){
      digitalWrite(i, HIGH);
    }

}

void loop() {
  byte byteRead;

   /*  check if data has been sent from the computer: */
  if (Serial.available()) {
  
    /* read the most recent byte */
    byteRead = Serial.read();
    //You have to subtract '0' from the read Byte to convert from text to a number.
    byteRead=byteRead-'0';
    
    //Turn off all LEDS
 
    if(byteRead == 0){
      digitalWrite(2, LOW);//first door on left
    }
    else if (byteRead == 1){
      digitalWrite(3, LOW);//second door from left
    }
    else if (byteRead == 2){
      digitalWrite(4, LOW);
    }
    else if (byteRead == 3){
      digitalWrite(5, LOW);
    }
    else if(byteRead == 4){
      digitalWrite(6, LOW);
    }

  }
}
