Game game = new Game();

void setup() {
  size(600, 600);
  game.reset();
}

void draw() {
  // TODO: Modify the background color by changing this.
  // Also consider making the background more interesting by drawing a
  // pattern or an image.
  background(0, 200, 120);

  // This updates the game. Don't touch this line.
  game.update();

  // Update the titlebar text.
  if (game.isServer()) {
    surface.setTitle("Local IP: " + Server.ip() + " / Port: " + game.port());
  }
  else {
    surface.setTitle("Pong");
  }
}

void keyPressed() {
  if (key == ' ') {
    game.setRunning(true);
  }
  else if (key == '0') {
    game.startServer();
  }
  else if (key == '1') {
    game.startClient();
  }

  // Keybindings. Default is w/s to move left player, i/k to move right player.
  // If you edit these, you'll need to update the ones in keyReleased() too.
  if (key == 'w') {
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
  // Keybindings. These need to mirror the ones in keyPressed().
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
