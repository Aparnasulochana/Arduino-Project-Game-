int paddle_width = 60;
int paddle_height = 10;
int ball_size = 10;
float ball_x, ball_y;
float ball_dx = 2;
float ball_dy = 2;
int paddle_x;
boolean isGameRunning = false;
boolean isLevelSelection = false;
boolean isMainMenu = true;

void setup() {
  size(400, 520);
  resetGame();
}

void draw() {
  background(0);  // Background color

  if (isMainMenu) {
    showMainMenu();
  } else if (isLevelSelection) {
    showLevelSelection();
  } else if (isGameRunning) {
    runGame();
  }
}

void showMainMenu() {
  // Display main menu screen with options to start the game
  fill(255);  // White text
  textSize(32);
  textAlign(CENTER, CENTER);
  text("Paddle Game", width / 2, height / 4);

  fill(255, 0, 0);  // Red button
  rect(150, 200, 100, 50);  // Start game button
  fill(255);  // White text on button
  textSize(18);
  text("Start Game", width / 2, 225);

  fill(0, 255, 0);  // Green button
  rect(150, 270, 100, 50);  // Level Select button
  fill(255);  // White text on button
  text("Levels", width / 2, 295);

  // Handle button clicks
  if (mousePressed) {
    if (mouseX > 150 && mouseX < 250 && mouseY > 200 && mouseY < 250) {
      isMainMenu = false;
      isGameRunning = true;  // Start the game
    } else if (mouseX > 150 && mouseX < 250 && mouseY > 270 && mouseY < 320) {
      isMainMenu = false;
      isLevelSelection = true;  // Go to level selection
    }
  }
}

void showLevelSelection() {
  // Display level selection screen
  fill(255);  // White text
  textSize(32);
  textAlign(CENTER, CENTER);
  text("Select Level", width / 2, height / 4);

  fill(255, 0, 0);  // Red button for Level 1
  rect(150, 200, 100, 50);  // Level 1 button
  fill(255);  // White text on button
  textSize(18);
  text("Level 1", width / 2, 225);

  fill(0, 255, 0);  // Green button for Level 2
  rect(150, 270, 100, 50);  // Level 2 button
  fill(255);  // White text on button
  textSize(18);
  text("Level 2", width / 2, 295);

  fill(0, 0, 255);  // Blue button for Level 3
  rect(150, 340, 100, 50);  // Level 3 button
  fill(255);  // White text on button
  textSize(18);
  text("Level 3", width / 2, 365);

  // Handle button clicks
  if (mousePressed) {
    if (mouseX > 150 && mouseX < 250 && mouseY > 200 && mouseY < 250) {
      isLevelSelection = false;
      isGameRunning = true;
      // Set level-specific properties (speed, difficulty, etc.)
      ball_dx = 2;
      ball_dy = 2;
    } else if (mouseX > 150 && mouseX < 250 && mouseY > 270 && mouseY < 320) {
      isLevelSelection = false;
      isGameRunning = true;
      ball_dx = 3;
      ball_dy = 3;  // Increase speed for Level 2
    } else if (mouseX > 150 && mouseX < 250 && mouseY > 340 && mouseY < 390) {
      isLevelSelection = false;
      isGameRunning = true;
      ball_dx = 4;
      ball_dy = 4;  // Increase speed for Level 3
    }
  }
}

void runGame() {
  // Ball and paddle logic
  moveBall();
  movePaddle();

  // Draw ball
  fill(255, 0, 0);  // Red ball
  ellipse(ball_x, ball_y, ball_size, ball_size);

  // Draw paddle
  fill(0, 255, 0);  // Green paddle
  rect(paddle_x, height - 30, paddle_width, paddle_height);

  // Check for collisions with walls
  if (ball_x <= 0 || ball_x >= width) {
    ball_dx = -ball_dx;  // Ball bounces off the sides
  }

  if (ball_y <= 0) {
    ball_dy = -ball_dy;  // Ball bounces off the top
  }

  // Check for collision with paddle
  if (ball_y + ball_size / 2 >= height - 30 && ball_x >= paddle_x && ball_x <= paddle_x + paddle_width) {
    ball_dy = -ball_dy;  // Ball bounces off the paddle
  }

  // Game over condition
  if (ball_y >= height) {
    gameOver();
  }
}

void moveBall() {
  ball_x += ball_dx;
  ball_y += ball_dy;
}

void movePaddle() {
  paddle_x = mouseX - paddle_width / 2;  // Paddle follows the mouse
  if (paddle_x < 0) {
    paddle_x = 0;  // Prevent paddle from going off the left side
  }
  if (paddle_x > width - paddle_width) {
    paddle_x = width - paddle_width;  // Prevent paddle from going off the right side
  }
}

void gameOver() {
  fill(255);  // White text
  textSize(32);
  textAlign(CENTER, CENTER);
  text("Game Over", width / 2, height / 4);
  textSize(18);
  text("Click to Restart", width / 2, height / 2);

  if (mousePressed) {
    resetGame();
    isGameRunning = false;
    isMainMenu = true;  // Go back to main menu
  }
}

void resetGame() {
  ball_x = width / 2;
  ball_y = height / 2;
  ball_dx = random(2, 4);
  ball_dy = random(2, 4);
  paddle_x = width / 2 - paddle_width / 2;
}
