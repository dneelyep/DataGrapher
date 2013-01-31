package com.uoflusli;

/** Class that represents the payload of a data packet that uses
 * the verbose packet structure. */
public class VerbosePacket {
    // TODO Verify that the types of each of these fields are correct. See specs in CDR
    // or ask Nathan.

    /** The type of this packet. VerbosePackets should have a type of 4, as specified in the CDR. */
    private int type = 4;

    /** The hour this packet was originally transmitted.*/
    private int hour;

    /** The minute this packet was originally transmitted.*/
    private int minute;

    /** The second this packet was originally transmitted.*/
    private int second;

    /** The first pressure reading in this packet. */
    private int pressure1;

    /** The first temperature reading in this packet. */
    private int temperature1;

    /** The first humidity reading in this packet. */
    private int humidity1;

    /** The first solar irradiance reading in this packet. */
    private int irradiance1;

    /** The first UV radiation reading in this packet. */
    private int radiation1;

    /** The second pressure reading in this packet. */
    private int pressure2;

    /** The second temperature reading in this packet. */
    private int temperature2;

    /** The second humidity reading in this packet. */
    private int humidity2;

    /** The second solar irradiance reading in this packet. */
    private int irradiance2;

    /** The second UV radiation reading in this packet. */
    private int radiation2;

    /** The latitude of the SMD at the time this packet was transmitted. */
    private int latitude;

    /** The longitude of the SMD at the time this packet was transmitted. */
    private int longitude;

    /** The accelerometer's x reading at the time of packet transmission. */
    private int accelX;

    /** The accelerometer's y reading at the time of packet transmission. */
    private int accelY;

    /** The accelerometer's z reading at the time of packet transmission. */
    private int accelZ;

    /** The gyroscope's x reading at the time of packet transmission. */
    private int gyroX;

    /** The gyroscope's y reading at the time of packet transmission. */
    private int gyroY;

    /** The gyroscope's z reading at the time of packet transmission. */
    private int gyroZ;

    /** The SMD's bearing at the time of packet transmission. */
    private int bearing;

    /** Contsruct a new VerbosePacket with all required fields. */
    public VerbosePacket(int hour, int minute, int second, int pressure1, int temperature1, int humidity1,
                         int irradiance1, int radiation1, int pressure2, int temperature2, int humidity2,
                         int irradiance2, int radiation2, int latitude, int longitude, int accelX, int accelY,
                         int accelZ, int gyroX, int gyroY, int gyroZ, int bearing) {

        this.hour = hour;
        this.minute = minute;
        this.second = second;
        this.pressure1 = pressure1;
        this.temperature1 = temperature1;
        this.humidity1 = humidity1;
        this.irradiance1 = irradiance1;
        this.radiation1 = radiation1;
        this.pressure2 = pressure2;
        this.temperature2 = temperature2;
        this.humidity2 = humidity2;
        this.irradiance2 = irradiance2;
        this.radiation2 = radiation2;
        this.latitude = latitude;
        this.longitude = longitude;
        this.accelX = accelX;
        this.accelY = accelY;
        this.accelZ = accelZ;
        this.gyroX = gyroX;
        this.gyroY = gyroY;
        this.gyroZ = gyroZ;
        this.bearing = bearing;
    }

    /** Print out a string representation of this VerbosePacket. */
    public String toString() {
        return "Time: " + hour + ":" + minute + ":" + second + "\n" +

               "Reading 1:" +
               "Pressure: " + pressure1 +
               "Temperature: " + temperature1 +
               "Humidity: " + humidity1 +
               "Solar Irradiance: " + irradiance1 +
               "UV Radiation: " + radiation1 + "\n" +

               "Reading 2:" +
               "Pressure: " + pressure2 +
               "Temperature: " + temperature2 +
               "Humidity: " + humidity2 +
               "Solar Irradiance: " + irradiance2 +
               "UV Radiation: " + radiation2 + "\n" +

               "Latitude: " + latitude +
               "Longitude: " + longitude +
               "Accelerometer - X: " + accelX +
               "Accelerometer - Y: " + accelY +
               "Accelerometer - Z: " + accelZ +
               "Gyroscope - X: " + gyroX +
               "Gyroscope - Y: " + gyroY +
               "Gyroscope - Z: " + gyroZ +
               "Bearing: " + bearing;
    }
}
