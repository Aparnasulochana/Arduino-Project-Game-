
import processing.serial.*;

Serial myPort;
String val = "";
int buttonState1 = 0;
int buttonState2 = 0;

void setup() {
  size(400, 400);
  println(Serial.list()); // List all available ports
  myPort = new Serial(this, "COM5", 9600); // Update with the correct port
}

void draw() {
  background(255);

  if (myPort.available() > 0) {
    val = myPort.readStringUntil('\n'); // Read incoming data
    if (val != null) {
      try {
        String[] data = split(trim(val), ","); // Split the received data
        buttonState1 = int(data[0]);
        buttonState2 = int(data[1]);
      } catch (Exception e) {
        println("Error parsing data: " + e);
      }
    }
  }

  // Draw button 1
  fill(buttonState1 == 0 ? color(51, 153, 102) : color(153, 51, 0)); // Green = pressed, Red = not pressed
  ellipse(100, height / 2, 50, 50);

  // Draw button 2
  fill(buttonState2 == 0 ? color(51, 153, 102) : color(153, 51, 0)); // Green = pressed, Red = not pressed
  ellipse(300, height / 2, 50, 50);
}
