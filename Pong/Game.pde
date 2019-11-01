import java.nio.*;
import processing.net.*;

class Game
{
  Ball ball = new Ball();
  Player leftPlayer = new Player(true);
  Player rightPlayer = new Player(false);
  
  Server s;
  Client c;
  
  public boolean isRunning = false;
  public boolean leftUpKeyState = false;
  public boolean leftDownKeyState = false;
  public boolean rightUpKeyState = false;
  public boolean rightDownKeyState = false;
  
  void reset() {
    ball.reset();
  }

  void startServer() {
    if (s != null) {
      print("Server already started");
      return;
    }
    if (c != null) {
      print("Client already started");
      return;
    }
    
    s = new Server(Pong.this, 12345);
  }
  
  void startClient() {
    if (s != null) {
      print("Server already started");
      return;
    }
    if (c != null) {
      print("Client already started");
      return;
    }
    
    c = new Client(Pong.this, "127.0.0.1", 12345);
  }

  void localUpdate() {
    if (isRunning) {
        ball.move();
  
        if (ball.isPastLeftEdge()) {
          ball.reset();
          rightPlayer.incrementScore();
          isRunning = false;
        }
        else if (ball.isPastRightEdge()) {
          ball.reset();
          leftPlayer.incrementScore();
          isRunning = false;
        }
        
        if (ball.intersect(leftPlayer)) {
          ball.bounceTowardsRight();
        }
        else if (ball.intersect(rightPlayer)) {
          ball.bounceTowardsLeft();
        }
        
        if (ball.isPastTopEdge()) {
          ball.bounceTowardsBottom();
        }
        else if (ball.isPastBottomEdge()) {
          ball.bounceTowardsTop();
        }
    }
  
    if (leftUpKeyState) {
      leftPlayer.moveUp();
    }
    if (leftDownKeyState) {
      leftPlayer.moveDown();
    }
    if (s != null) {
      if (!s.active()) {
        s = null;
        return;
      }

      // Send new state.
      ByteBuffer buf = ByteBuffer.allocate(4 * 3);
      buf.putFloat(leftPlayer.yPosition);
      buf.putFloat(ball.position.x);
      buf.putFloat(ball.position.y);
      s.write(buf.array());
      
      // Receive right player position.
      Client sc = s.available();
      if (sc != null) {
        int available = sc.available();
        int numPackets = available / 4;
        if (numPackets > 0) {
          byte[] rcv = new byte[numPackets * 4];
          sc.readBytes(rcv);
          ByteBuffer wrap = ByteBuffer.wrap(rcv);
          int packetOffset = (numPackets - 1) * 4;
          rightPlayer.yPosition = wrap.getFloat(packetOffset + 0);
        }
      }
    }
    else {
      if (rightUpKeyState) {
        rightPlayer.moveUp();
      }
      if (rightDownKeyState) {
        rightPlayer.moveDown();
      }
    }
  }

  void remoteUpdate() {
    if (rightUpKeyState) {
      rightPlayer.moveUp();
    }
    if (rightDownKeyState) {
      rightPlayer.moveDown();
    }

    if (!c.active()) {
      c = null;
      return;
    }

    // Send right player position.
    ByteBuffer buf = ByteBuffer.allocate(4);
    buf.putFloat(rightPlayer.yPosition);
    c.write(buf.array());

    // Receive new state.
    int available = c.available();
    int numPackets = available / (4 * 3);
    if (numPackets > 0) {
      byte[] rcv = new byte[numPackets * (4 * 3)];
      c.readBytes(rcv);
      ByteBuffer wrap = ByteBuffer.wrap(rcv);
      int packetOffset = (numPackets - 1) * (4 * 3);
      leftPlayer.yPosition = wrap.getFloat(packetOffset + 0);
      ball.position.x = wrap.getFloat(packetOffset + 4);
      ball.position.y = wrap.getFloat(packetOffset + 8);
    }
  }

  void update() {
    if (c != null) {
      remoteUpdate();
    }
    else {
      localUpdate();
    }

    ball.display();
    leftPlayer.display();
    rightPlayer.display();
  }
}
