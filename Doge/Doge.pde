public class Doge extends PApplet
{
  PImage image;
  PFont font;

  void settings()
  {
    size(800, 600);
  }

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
  
    // The for{} loop below just prints out the name of all fonts to the Console
    // tab below so you can choose one in step #2.
    println("--- Fonts on your computer ---");
    for (String fontName : PFont.list()) {
      println(fontName);
    }
  
    // 2. Choose a font installed on this computer, and choose the font size.
    font = createFont("Comic Sans MS", 48);
  }
  
  // After setup(), the draw() function gets called infinitely until
  // the Processing sketch is stopped.
  void draw()
  {
    background(0);
  
    // 3. Go back to the top of the settings() method and change size(800, 600)
    // to dimensions that better fit the aspect ratio (ratio of width to height)
    // of your image.
    //
    // Here is some math behind the code below, but you can skip it;
    // you don't need to understand it.
    // Compute dimensions to make the image keep its existing aspect ratio
    // while being centered in the window.
    // 
    // w   image.width
    // - = -----------
    // h   image.height
    //
    // Solve for w; w = (image.width / image.height) * h;
    //
    // Then, to center the image, compute the difference between the screen
    // and image widths: (width - w)
    // and then move the image by half that (so that there is equal padding
    // on both sides).
    float h = height;
    float w = ((float) image.width / (float) image.height) * h;
    float x = (width - w) / 2.0f;
    image(image, x, 0, w, h);
  
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
    text("much java", 200, 300);
    
    fill(100, 200, 150);
    text("very cs", 140, 450);
    
    fill(200, 100, 150);
    text("what r u typin", 400, 180);
    
    fill(120, 50, 220);
    text("so computer", 430, 500);
  }
}
