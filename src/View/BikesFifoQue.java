package View;

import Model.Bike;

import java.util.LinkedList;
import java.util.Queue;

/**
 * <h1>BikesFifoQue</h1>
 * {@docRoot}
 * just a FIFO for the Addbikes in a que..
 * Created by NIK1114 on 2016-10-16.
 * @version 1.0
 * @since   2016-10-16
 * @param
 * @throws : no
 */
public class BikesFifoQue  {
  private static Queue<Bike> bikesQueFIFO = new LinkedList<Bike>();

  /**
   * @param newBike
   */
  public static void enqueue(Bike newBike) { //add a bike in the que
    bikesQueFIFO.add(newBike);
    System.out.println("bikesQueFIFO size: " + bikesQueFIFO.size());
  }

  public static boolean isEmty() {
    return bikesQueFIFO.isEmpty();
  }


  public static Bike dequeue() {
    return bikesQueFIFO.remove();
  }
}
