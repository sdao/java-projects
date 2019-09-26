// Follow the numbered steps (1) through (4) to create your own meme.
public class Doge extends PApplet
{
  PImage image;
  PFont font;

  // The setup() function is run once at the beginning of your
  // Processing sketch.
  void setup()
  {
    // 1. Find a background image for your meme.
    // Wikipedia might be a good place to start.
    // Make sure you grab a "png" or "jpg" file.
    // Replace the url below, and change the "jpg" paramter in loadImage() if necessary.
    String url = "https://upload.wikimedia.org/wikipedia/commons/5/58/Shiba_inu_taiki.jpg";
    image = loadImage(url, "jpg");
    
    // 2. Change the multiplication below to resize your image to better fit the screen.
    // Notice that we have to cast to (int) here.
    frame.setSize((int) (image.width * 0.4), (int) (image.height * 0.4));
  
    // The for{} loop below just prints out the name of all fonts to the Console
    // tab below so you can choose one in step #2.
    println("--- Fonts on your computer ---");
    for (String fontName : PFont.list()) {
      println(fontName);
    }
  
    // 3. Choose a font installed on this computer, and choose the font size.
    // Try "Comic Sans MS" or "Impact" if you're unsure what to use.
    font = createFont("Comic Sans MS", 48);
  }
  
  // After setup(), the draw() function gets called infinitely until
  // the Processing sketch is stopped.
  void draw()
  {
    // This draws the background image to fill the entire window.
    image(image, 0, 0, width, height);
  
    // This sets the current font to whatever you chose in setup().
    textFont(font);
  
    // 4. Edit or add more fill() and text() lines to create your meme.
    // - fill() takes three arguments - red, green, blue - that are
    //   integers between 0 and 255, inclusive.
    // - text() takes a String and the x- and y-coordinates where the
    //   text will get drawn.
    // Both of these functions have more variations (or "overloads"),
    // and you can see more details in the Processing reference:
    // <https://processing.org/reference/>.
    fill(0, 100, 150);
    text("wow", 90, 150);
    
    fill(0, 200, 150);
    text("much java", 200, 680);
    
    fill(100, 200, 150);
    text("very cs", 140, 550);
    
    fill(200, 100, 150);
    text("what r u typin", 400, 270);
    
    fill(120, 50, 220);
    text("so computer", 430, 850);
  }
}
