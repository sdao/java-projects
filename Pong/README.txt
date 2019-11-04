The Pong game has five files: Pong, Ball, Game, GameBase, and Player.
You will mostly be editing the Ball and Player classes.
You might want to edit Pong or Game if you have time and want to change the game's behavior.
Don't edit the GameBase class; it only contains code to implement networking.

CONTROLS:
These controls work out-of-the-box:
- [Spacebar] Launch the ball
- [0] Start server on this machine
- [1] Connect to server on another machine
Once you have implemented the methods marked TODO(REQUIRED), these controls will work:
- [w] Left paddle up
- [a] Left paddle down
- [i] Right paddle up
- [k] Right paddle down

TODO(REQUIRED):
The game has some code missing.
These are required to make the game work properly, so you'll need to implement these.
- Implement Ball.bounceTowardsBottom().
- Implement Ball.bounceTowardsTop().
- Implement Ball.isPastTopEdge().
- Implement Ball.isPastBottomEdge().
- Implement Player.isPointInside().
- Implement Player.incrementScore();
- Implement Player.moveDown().
- Inside Player.display(), write the player's score in the text instead of "Score: ???".

TODO:
These are some stretch goals that you should try to make the game more fun and more visually
appealing. They are not required to make the game work, but you should strongly consider them
if you have time.
- Change Pong.draw() to draw a different background.
- Change Ball.reset() to use different initial velocities.
- Change Ball.display() to draw the ball differently.
- Change Player.display() to draw the player paddles differently.

NETWORKING
Once player should be the server -- this player will control the left paddle.
The other player should be the client -- this player will control the right paddle.
The server player should press [0]. The default port is "12345". The titlebar will show the
server's IP address and port number.
The client player should press [1]. Enter the IP address and port number displayed in the server
computer's titlebar.
Try moving the paddles before starting the game to make sure that the server and client stay
in sync.