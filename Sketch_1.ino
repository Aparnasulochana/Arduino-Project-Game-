const int buttonPin1 = 2; // Pin connected to button 1
const int buttonPin2 = 4; // Pin connected to button 2

void setup() {
  Serial.begin(9600); // Start serial communication at 9600 baud
  pinMode(buttonPin1, INPUT_PULLUP); // Set button 1 as input with pull-up
  pinMode(buttonPin2, INPUT_PULLUP); // Set button 2 as input with pull-up
}

void loop() {
  int buttonState1 = digitalRead(buttonPin1); // Read button 1 state
  int buttonState2 = digitalRead(buttonPin2); // Read button 2 state

  // Send the states over serial
  Serial.print(buttonState1);
  Serial.print(",");
  Serial.println(buttonState2);

  delay(100); // Short delay for stability
}