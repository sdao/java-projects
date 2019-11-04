import java.nio.*;

/// This class implements the core game.
/// You won't need to edit anything inside this class to make the game work.
/// But if you want to customize any mechanics, look at reset() and update().
class Game extends GameBase
{
  private Ball ball = new Ball();
  private Player leftPlayer = new Player(true);
  private Player rightPlayer = new Player(false);
  private boolean isRunning = false;

  public boolean leftUpKeyState = false;
  public boolean leftDownKeyState = false;
  public boolean rightUpKeyState = false;
  public boolean rightDownKeyState = false;

  private long stateTimestamp = 0;

  public int port() {
    return 12345;
  }

  public void setRunning(boolean running) {
    isRunning = running;
    stateTimestamp = System.currentTimeMillis();
  }

  private void localUpdate() {
    if (isRunning) {
        ball.move();
  
        if (ball.isPastLeftEdge()) {
          ball.reset();
          rightPlayer.incrementScore();
          setRunning(false);
        }
        else if (ball.isPastRightEdge()) {
          ball.reset();
          leftPlayer.incrementScore();
          setRunning(false);
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

    // Left player is always controllable in local mode, and controllable
    // by the server in networked mode.
    if (leftUpKeyState) {
      leftPlayer.moveUp();
    }
    if (leftDownKeyState) {
      leftPlayer.moveDown();
    }

    // Right player is always controllable in local mode, but not
    // controllable by the server in networked mode.
    if (rightUpKeyState && !isServer()) {
      rightPlayer.moveUp();
    }
    if (rightDownKeyState && !isServer()) {
      rightPlayer.moveDown();
    }
  }

  private void serverUpdate() {
    localUpdate();

    // Send new state.
    ByteBuffer tx = ByteBuffer.allocate(
      Player.SERIALIZED_NUM_BYTES + Ball.SERIALIZED_NUM_BYTES +
      SERIALIZED_NUM_BYTES);
    leftPlayer.serialize(tx);
    ball.serialize(tx);
    this.serialize(tx);
    sendPacket(tx);
    
    // Receive right player position and isRunning flag.
    ByteBuffer rx = getLastPacket(
      Player.SERIALIZED_NUM_BYTES + SERIALIZED_NUM_BYTES);
    if (rx != null) {
      rightPlayer.deserialize(rx);
      this.deserialize(rx);
    }
  }

  private void clientUpdate() {
    // Right player is controllable by the client, so update now.
    if (rightUpKeyState) {
      rightPlayer.moveUp();
    }
    if (rightDownKeyState) {
      rightPlayer.moveDown();
    }

    // Send right player position and isRunning flag.
    ByteBuffer tx = ByteBuffer.allocate(
      Player.SERIALIZED_NUM_BYTES + SERIALIZED_NUM_BYTES);
    rightPlayer.serialize(tx);
    this.serialize(tx);
    sendPacket(tx);

    // Receive new state.
    ByteBuffer rx = getLastPacket(
      Player.SERIALIZED_NUM_BYTES + Ball.SERIALIZED_NUM_BYTES +
      SERIALIZED_NUM_BYTES);
    if (rx != null) {
      leftPlayer.deserialize(rx);
      ball.deserialize(rx);
      this.deserialize(rx);
    }
  }

  public void reset() {
    ball.reset();
  }

  public void update() {
    if (isServer()) {
      serverUpdate();
    }
    if (isClient()) {
      clientUpdate();
    }
    else {
      localUpdate();
    }

    ball.display();
    leftPlayer.display();
    rightPlayer.display();
  }

  // --- WARNING! ---
  // --- Don't touch the code below this point. ---
  // --- It is used to implement networking. ---

  static final int SERIALIZED_NUM_BYTES = Long.BYTES + 2 * Integer.BYTES;

  public void serialize(ByteBuffer buffer)
  {
    buffer.putLong(stateTimestamp);
    buffer.putInt(isRunning ? 1 : 0);
    buffer.putInt(rightPlayer.getScore());
  }

  public void deserialize(ByteBuffer buffer)
  {
    long newStateTimestamp = buffer.getLong();
    int newIsRunning = buffer.getInt();
    int newRightScore = buffer.getInt();
    if (newStateTimestamp > stateTimestamp) {
      stateTimestamp = newStateTimestamp;
      isRunning = (newIsRunning != 0);
      while (rightPlayer.getScore() < newRightScore) {
        rightPlayer.incrementScore();
      }
    }
  }
}
