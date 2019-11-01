class Player
{
    private boolean isLeftPlayer;
    private int score = 0;
    private float yPosition = 0.0;
    private PVector size = new PVector(10.0, 40.0);

    public Player(boolean isLeftPlayer)
    {
      this.isLeftPlayer = isLeftPlayer;
    }

    public float top()
    {
      return yPosition - 0.5 * size.y;
    }
    
    public float bottom()
    {
      return yPosition + 0.5 * size.y;
    }
    
    public float left()
    {
      if (isLeftPlayer) {
        return 0;
      }
      else {
        return width - size.x;
      }
    }
    
    public float right()
    {
      if (isLeftPlayer) {
        return size.x;
      }
      else {
        return width;
      }
    }

    public boolean isPointInside(PVector point)
    {
      return point.x >= left() && point.x <= right() && point.y >= top() && point.y <= bottom();
    }

    public void incrementScore()
    {
    }

    public void moveUp()
    {
      yPosition -= 3.0;
    }
    
    public void moveDown()
    {
      yPosition += 3.0;
    }

    public void display()
    {
      rect(left(), top(), size.x, size.y);
    }
}
