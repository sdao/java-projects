class Ball
{
    private PVector position = new PVector(0, 0);
    private PVector velocity = new PVector(0, 0);
    private float radius = 5.0;

    public Ball()
    {
    }

    public boolean intersect(Player player)
    {
      // Note: if you look very carefully, this isn't mathematically correct.
      // Bonus points if you swap this out for something that is.
      PVector a = new PVector(position.x + radius, position.y + radius);
      PVector b = new PVector(position.x + radius, position.y - radius);
      PVector c = new PVector(position.x - radius, position.y + radius);
      PVector d = new PVector(position.x - radius, position.y - radius);
      return player.isPointInside(a) || player.isPointInside(b) || player.isPointInside(c) || player.isPointInside(d);
    }
    
    public void bounceTowardsRight()
    {
      velocity.x = abs(velocity.x);
    }
    
    public void bounceTowardsLeft()
    {
      velocity.x = -abs(velocity.x);
    }

    public void bounceTowardsBottom()
    {
      velocity.y = abs(velocity.y);
    }
    
    public void bounceTowardsTop()
    {
      velocity.y = -abs(velocity.y);
    }

    public boolean isPastLeftEdge()
    {
      return position.x <= 0;
    }

    public boolean isPastRightEdge()
    {
      return position.x >= width;
    }

    public boolean isPastTopEdge()
    {
      return position.y <= 0;
    }
    
    public boolean isPastBottomEdge()
    {
      return position.y >= height;
    }

    public void reset()
    {
      position.x = width * 0.5;
      position.y = height * 0.5;
      if (random(1) > 0.5) {
        velocity.x = 1;
      }
      else {
        velocity.x = -1;
      }
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
      circle(position.x, position.y, radius * 2);
    }
}
