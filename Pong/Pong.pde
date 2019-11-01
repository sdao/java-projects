Game game = new Game();

void setup() {
  size(600, 600);
  game.reset();
}

void draw() {
  background(0, 200, 120);
  game.update();
}

void keyPressed() {
  if (key == ' ') {
    game.isRunning = true;
  }
  else if (key == '0') {
    game.startServer();
  }
  else if (key == '1') {
    game.startClient();
  }
  else if (key == 'w') {
    game.leftUpKeyState = true;
  }
  else if (key == 's') {
    game.leftDownKeyState = true;
  }
  else if (key == 'i') {
    game.rightUpKeyState = true;
  }
  else if (key == 'k') {
    game.rightDownKeyState = true;
  }
}

void keyReleased() {
  if (key == 'w') {
    game.leftUpKeyState = false;
  }
  else if (key == 's') {
    game.leftDownKeyState = false;
  }
  else if (key == 'i') {
    game.rightUpKeyState = false;
  }
  else if (key == 'k') {
    game.rightDownKeyState = false;
  }
}
