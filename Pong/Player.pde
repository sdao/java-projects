class Player
{
  /// If true, then this is the left paddle.
  /// If false, then this is the right paddle.
  private boolean isLeftPlayer;
  
  /// Current score. Should increase over time.
  private int score = 0;
  
  /// The paddle's Y-position (how high or low it is on the edge of the screen).
  private float yPosition = 0.0;
  
  /// The size of the paddle.
  /// TODO: Change this if you want to shrink or grow the paddle.
  private PVector size = new PVector(10.0, 40.0);

  private PFont font = null;

  public Player(boolean isLeftPlayer)
  {
    this.isLeftPlayer = isLeftPlayer;
  }
  
  /// The x-coordinate of the player's left edge.
  public float left()
  {
    if (isLeftPlayer) {
      return 0;
    }
    else {
      return width - size.x;
    }
  }
  
  /// The x-coordinate of the player's right edge.
  public float right()
  {
    if (isLeftPlayer) {
      return size.x;
    }
    else {
      return width;
    }
  }

  /// The y-coordinate of the player's top edge.
  public float top()
  {
    return yPosition - 0.5 * size.y;
  }
  
  /// The y-coordinate of the player's bottom edge.
  public float bottom()
  {
    return yPosition + 0.5 * size.y;
  }

  /// Whether the given point is inside the player's bounding rectangle.
  public boolean isPointInside(PVector point)
  {
    return point.x >= left() && point.x <= right() && point.y >= top() && point.y <= bottom();
  }

  /// Increases the player's score by one.
  public void incrementScore()
  {
    // TODO(REQUIRED): Implement this.
    score++;
  }

  /// Gets the current score.
  public int getScore()
  {
    return score;
  }

  /// Changes the y-position of the paddle, moving it upwards.
  public void moveUp()
  {
    yPosition -= 3.0;

    // Prevent the player from going past the top of the screen.
    if (yPosition < 0.0) {
      yPosition = 0.0;
    }
  }

  /// Changes the y-position of the paddle, moving it downwards.
  public void moveDown()
  {
    // TODO(REQUIRED): Implement this. See moveUp() for a hint.
    // Make sure to also prevent the player from going past the
    // bottom of the screen, which you can check by using the `height`
    // global variable.
    yPosition += 3.0;
    if (yPosition > height) {
      yPosition = height;
    }
  }

  public void display()
  {
    // TODO: The player's paddle is just a plain rectangle by default.
    // Customize the drawing of the paddle by filling it, changing the shape, etc.
    // Note that you should change the size of the paddle by modifying the `size`
    // private instance variable; the `size` is used to compute collision with the ball.
    rect(left(), top(), size.x, size.y);

    // Set up font/positioning of score text labels.
    if (font == null) {
      font = createFont("Arial", 16.0);
    }
    textFont(font);
    float textX;
    if (isLeftPlayer) {
      textAlign(LEFT, TOP);
      textX = 0;
    }
    else {
      textAlign(RIGHT, TOP);
      textX = width;
    }
    
    // TODO(REQUIRED): Write the player's score.
    text("Score: " + score, textX, 0.0); 
  }

  // --- WARNING! ---
  // --- Don't touch the code below this point. ---
  // --- It is used to implement networking. ---

  static final int SERIALIZED_NUM_BYTES = Float.BYTES + Integer.BYTES;

  public void serialize(ByteBuffer buffer)
  {
    buffer.putFloat(yPosition);
    buffer.putInt(score);
  }

  public void deserialize(ByteBuffer buffer)
  {
    yPosition = buffer.getFloat();
    score = buffer.getInt();
  }
}
