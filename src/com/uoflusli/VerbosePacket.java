package com.uoflusli;

import java.util.HashMap;
import java.util.Map;

/** Class that represents the payload of a data packet that uses
 * the verbose packet structure. */
public class VerbosePacket {
    // TODO Verify that the types of each of these fields are correct. See specs in CDR
    // or ask Nathan.

    private Map<PacketField, Object> fieldValues = new HashMap<>();

    /** Contsruct a new VerbosePacket with all required fields. */
    public VerbosePacket(int hour, int minute, int second, int pressure1, int temperature1, int humidity1,
                         int irradiance1, int radiation1, int pressure2, int temperature2, int humidity2,
                         int irradiance2, int radiation2, String latitude, String longitude, int accelX, int accelY,
                         int accelZ, int gyroX, int gyroY, int gyroZ, int bearing) {

        fieldValues.put(PacketField.Hour, hour);
        fieldValues.put(PacketField.Minute, minute);
        fieldValues.put(PacketField.Second, second);
        fieldValues.put(PacketField.Pressure1, pressure1);
        fieldValues.put(PacketField.Temperature1, temperature1);
        fieldValues.put(PacketField.Humidity1, humidity1);
        fieldValues.put(PacketField.Solar_Irradiance1, irradiance1);
        fieldValues.put(PacketField.UV_Radiation1, radiation1);
        fieldValues.put(PacketField.Pressure2, pressure2);
        fieldValues.put(PacketField.Temperature2, temperature2);
        fieldValues.put(PacketField.Humidity2, humidity2);
        fieldValues.put(PacketField.Solar_Irradiance2, irradiance2);
        fieldValues.put(PacketField.UV_Radiation2, radiation2);
        fieldValues.put(PacketField.GPSLatitude, latitude);
        fieldValues.put(PacketField.GPSLongitude, longitude);
        fieldValues.put(PacketField.Accelerometer_X, accelX);
        fieldValues.put(PacketField.Accelerometer_Y, accelY);
        fieldValues.put(PacketField.Accelerometer_Z, accelZ);
        fieldValues.put(PacketField.Gyro_X, gyroX);
        fieldValues.put(PacketField.Gyro_Y, gyroY);
        fieldValues.put(PacketField.Gyro_Z, gyroZ);
        fieldValues.put(PacketField.Bearing, bearing);
    }

    /** Print out a string representation of this VerbosePacket. */
    @Override
    public String toString() {
        return "Time: " + fieldValues.get(PacketField.Hour) + ":"
                + fieldValues.get(PacketField.Minute) + ":" + fieldValues.get(PacketField.Second)+ "\n" +

               "Reading 1:" + "\n" +
               "Pressure: " + fieldValues.get(PacketField.Pressure1) + "\n" +
               "Temperature: " + fieldValues.get(PacketField.Temperature1) + "\n" +
               "Humidity: " + fieldValues.get(PacketField.Humidity1) + "\n" +
               "Solar Irradiance: " + fieldValues.get(PacketField.Solar_Irradiance1) + "\n" +
               "UV Radiation: " + fieldValues.get(PacketField.UV_Radiation1) + "\n" +

                "Reading 2:" + "\n" +
                "Pressure: " + fieldValues.get(PacketField.Pressure2) + "\n" +
                "Temperature: " + fieldValues.get(PacketField.Temperature2) + "\n" +
                "Humidity: " + fieldValues.get(PacketField.Humidity2) + "\n" +
                "Solar Irradiance: " + fieldValues.get(PacketField.Solar_Irradiance2) + "\n" +
                "UV Radiation: " + fieldValues.get(PacketField.UV_Radiation2) + "\n" +

               "Latitude: " + fieldValues.get(PacketField.GPSLatitude) + "\n" +
               "Longitude: " + fieldValues.get(PacketField.GPSLongitude) + "\n" +
               "Accelerometer - X: " + fieldValues.get(PacketField.Accelerometer_X) + "\n" +
               "Accelerometer - Y: " + fieldValues.get(PacketField.Accelerometer_Y) + "\n" +
               "Accelerometer - Z: " + fieldValues.get(PacketField.Accelerometer_Z) + "\n" +
               "Gyroscope - X: " + fieldValues.get(PacketField.Gyro_X) + "\n" +
               "Gyroscope - Y: " + fieldValues.get(PacketField.Gyro_Y) + "\n" +
               "Gyroscope - Z: " + fieldValues.get(PacketField.Gyro_Z) + "\n" +
               "Bearing: " + fieldValues.get(PacketField.Bearing) + "\n\n";
    }
}

enum PacketField {
    Type("Type"), Hour("Hour"), Minute("Minute"), Second("Second"), Pressure1("Pressure1"),
    Temperature1("Temperature1"), Humidity1("Humidity1"), Solar_Irradiance1("Solar_Irradiance1"),
    UV_Radiation1("UV_Radiation1"), Pressure2("Pressure2"), Temperature2("Temperature2"),
    Humidity2("Humidity2"), Solar_Irradiance2("Solar_Irradiance2"), UV_Radiation2("UV_Radiation2"),
    GPSLatitude("GPS.Latitude"), GPSLongitude("GPS.Longitude"), Accelerometer_X("Accelerometer_X"),
    Accelerometer_Y("Accelerometer_Y"), Accelerometer_Z("Accelerometer_Z"), Gyro_X("Gyro_X"), Gyro_Y("Gyro_Y"),
    Gyro_Z("Gyro_Z"), Bearing("Bearing");

    // TODO Check if latitude/longitude are stored as an int, a string, or maybe a series of ints where each int represents precision.
    /** A string representation of the field name. */
    private String stringRep;

    PacketField(String stringRep) {
        this.stringRep = stringRep;
    }
}