// --- WARNING! ---
// --- Don't touch the code in this file. ---
// --- It is used to implement networking. ---

import javax.swing.*;
import processing.net.*;

abstract class GameBase
{  
  private Server s;
  private Client c;

  public abstract int port();

  public void startServer() {
    if (s != null) {
      print("Server already started");
      return;
    }
    if (c != null) {
      print("Client already started");
      return;
    }
    
    s = new Server(Pong.this, port());
    if (!s.active()) {
      JOptionPane.showMessageDialog(null, "Error starting server on this machine");
      s = null;
    }
  }
  
  public void startClient() {
    if (s != null) {
      print("Server already started");
      return;
    }
    if (c != null) {
      print("Client already started");
      return;
    }
    
    final String ip = JOptionPane.showInputDialog(
      null,
      "Enter name (IP address) of server:",
      "Connect to Server",
      JOptionPane.QUESTION_MESSAGE);
    final String portStr = JOptionPane.showInputDialog(
      null,
      "Enter port number:",
      "Connect to Server",
      JOptionPane.QUESTION_MESSAGE);
    int port;
    try {
      port = Integer.parseInt(portStr);
    }
    catch (NumberFormatException e)
    {
      JOptionPane.showMessageDialog(null, "Invalid port number");
      return;
    }
    
    c = new Client(Pong.this, ip, port);
    if (!c.active()) {
      JOptionPane.showMessageDialog(null, "Error connecting to '" + ip + ":" + port + "'");
      c = null;
    }
  }

  public boolean isServer() {
    if (s != null && !s.active()) {
      s = null;
    }
    return s != null;
  }

  public boolean isClient() {
    if (c != null && !c.active()) {
      c = null;
    }
    return c != null;
  }

  protected ByteBuffer getLastPacket(int numBytes) {
    Client client = null;
    if (isServer()) {
      client = s.available();
    }
    else if (isClient()) {
      client = c;
    }

    if (client != null) {
      int available = client.available();
      int numPackets = available / numBytes;
      if (numPackets > 0) {
        byte[] rcv = new byte[numBytes];
        for (int i = 0; i < numPackets; ++i) {
          client.readBytes(rcv);
        }
        return ByteBuffer.wrap(rcv);
      }
    }

    return null;
  }

  void sendPacket(ByteBuffer buffer) {
    if (isServer()) {
      s.write(buffer.array());
    }
    else if (isClient()) {
      c.write(buffer.array());
    }
  }
}
