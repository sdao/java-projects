class Ball
{
  /// The ball's XY-position.
  private PVector position = new PVector(0, 0);

  /// The ball's XY-velocity.
  /// This is the amount that it will move on each update.
  private PVector velocity = new PVector(0, 0);

  /// The radius of the ball.
  /// Used for collision with players.
  private float radius = 5.0;

  public Ball()
  {
  }

  /// Returns true if the given `player` intersects this ball.
  /// Returns false if the `player` and this ball aren't touching.
  public boolean intersect(Player player)
  {
    // Note: if you look very carefully, this isn't mathematically correct.
    // It actually checks that the player intersects this ball's bounding box.
    // But that is good enough for our use here.
    PVector a = new PVector(position.x + radius, position.y + radius);
    PVector b = new PVector(position.x + radius, position.y - radius);
    PVector c = new PVector(position.x - radius, position.y + radius);
    PVector d = new PVector(position.x - radius, position.y - radius);
    return player.isPointInside(a) ||
        player.isPointInside(b) ||
        player.isPointInside(c) ||
        player.isPointInside(d);
  }

  /// Changes the ball's x-velocity so that it moves rightwards, but
  /// at the same speed as before.
  public void bounceTowardsRight()
  {
    // The x-velocity needs to be positive for the ball to
    // move rightwards. Take the absolute value of the x-velocity,
    // which is positive.
    velocity.x = abs(velocity.x);
  }
  
  /// Changes the ball's x-velocity so that it moves leftwards, but
  /// at the same speed as before.
  public void bounceTowardsLeft()
  {
    // The x-velocity needs to be negative for the ball to
    // move leftwards. Take the absolute value of the x-velocity,
    // which is positive, then negate it to get a negative value.
    velocity.x = -abs(velocity.x);
  }

  /// Changes the ball's y-velocity so that it moves towards the
  /// bottom, but at the same speed as before.
  public void bounceTowardsBottom()
  {
    // TODO(REQUIRED): Implement this. See bounceTowardsRight() for a hint.
    
  }
  
  /// Changes the ball's y-velocity so that it moves towards the
  /// top, but at the same speed as before.
  public void bounceTowardsTop()
  {
    // TODO(REQUIRED): Implement this. See bounceTowardsLeft() for a hint.
    
  }

  /// Whether the ball is past the left edge of the screen.
  public boolean isPastLeftEdge()
  {
    return position.x <= 0;
  }

  /// Whether the ball is past the right edge of the screen.
  public boolean isPastRightEdge()
  {
    return position.x >= width;
  }

  /// Whether the ball is beyond the top edge of the screen.
  public boolean isPastTopEdge()
  {
    // TODO(REQUIRED): Implement this. See isPastLeftEdge() for a hint.
    return false;
  }

  /// Whether the ball is beyond the bottom edge of the screen.
  public boolean isPastBottomEdge()
  {
    // TODO(REQUIRED): Implement this. See isPastRightEdge() for a hint.
    return false;
  }

  public void reset()
  {
    // Reposition the ball at the center of the screen.
    position.x = width * 0.5;
    position.y = height * 0.5;

    // Choose a random x-direction (left or rightwards) to
    // initialize the velocity.
    // TODO: Try changing the velocity to a different value
    // instead of 1. Or try randomizing the magnitude.
    if (random(1) > 0.5) {
      velocity.x = 1;
    }
    else {
      velocity.x = -1;
    }

    // Choose a random y-direction (up or downwards) to
    // initialize the velocity.
    // TODO: Try changing the velocity to a different value
    // instead of 1. Or try randomizing the magnitude.
    if (random(1) > 0.5) {
      velocity.y = 1;
    }
    else {
      velocity.y = -1;
    }
  }

  public void move()
  {
    position.x += velocity.x;
    position.y += velocity.y;
  }

  public void display()
  {
    // TODO: Make the ball look nicer.
    // When you change the drawing, make sure that it fits within the `radius`; the radius
    // is used to compute collision with the paddles. If you want to make the ball
    // larger, make sure to change the `radius` private instance variable also.
    circle(position.x, position.y, radius * 2);
  }

  // --- WARNING! ---
  // --- Don't touch the code below this point. ---
  // --- It is used to implement networking. ---

  static final int SERIALIZED_NUM_BYTES = Float.BYTES * 4;

  public void serialize(ByteBuffer buffer)
  {
    buffer.putFloat(position.x);
    buffer.putFloat(position.y);
    buffer.putFloat(velocity.x);
    buffer.putFloat(velocity.y);
  }

  public void deserialize(ByteBuffer buffer)
  {
    position.x = buffer.getFloat();
    position.y = buffer.getFloat();
    velocity.x = buffer.getFloat();
    velocity.y = buffer.getFloat();
  }
}
