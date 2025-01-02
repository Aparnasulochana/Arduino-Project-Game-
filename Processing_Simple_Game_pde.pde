import processing.serial.*;

Serial myPort;
String val = "";
int buttonState1 = 0;
int buttonState2 = 0;

// Game variables
int targetButton; // Which button the player should press
int score = 0; // Player's score
int gameState = 0; // 0 = waiting, 1 = active game
long startTime; // Start time of the current round
int timeLimit = 2000; // Time limit in milliseconds for each round

void setup() {
  size(400, 400);
  println(Serial.list()); // List all available ports
  myPort = new Serial(this, "COM5", 9600); // Update with the correct port
  resetGame();
}

void draw() {
  background(255);

  // Read serial data
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

  // Draw buttons
  fill(buttonState1 == 0 ? color(51, 153, 102) : color(153, 51, 0)); // Green = pressed, Red = not pressed
  ellipse(100, height / 2, 50, 50);
  fill(buttonState2 == 0 ? color(51, 153, 102) : color(153, 51, 0)); // Green = pressed, Red = not pressed
  ellipse(300, height / 2, 50, 50);

  // Game logic
  if (gameState == 1) {
    // Highlight the target button
    if (targetButton == 1) {
      fill(255, 204, 0); // Yellow for Button 1
      ellipse(100, height / 2, 60, 60);
    } else if (targetButton == 2) {
      fill(255, 204, 0); // Yellow for Button 2
      ellipse(300, height / 2, 60, 60);
    }

    // Check for correct button press
    if (targetButton == 1 && buttonState1 == 0) {
      score += 10;
      resetGame();
    } else if (targetButton == 2 && buttonState2 == 0) {
      score += 10;
      resetGame();
    }

    // Check for timeout
    if (millis() - startTime > timeLimit) {
      score -= 5; // Penalty for missing the target
      resetGame();
    }
  }

  // Display score
  fill(0);
  textSize(20);
  textAlign(CENTER);
  text("Score: " + score, width / 2, 50);
}

void resetGame() {
  targetButton = int(random(1, 3)); // Randomly select Button 1 or Button 2
  startTime = millis(); // Record the start time
  gameState = 1; // Set game state to active
  // Adjust time limit based on the score (optional difficulty increase)
  timeLimit = max(500, 2000 - score * 10);
}
