package com.uoflusli;

import java.util.HashMap;
import java.util.Map;

/** Class that represents the payload of a data packet that uses
 * the verbose packet structure. */
public class VerbosePacket {
    // TODO Verify that the types of each of these fields are correct. See specs in CDR
    // or ask Nathan.
    /** A Map from the fields that make up a packet to the readings of those fields. */
    private HashMap<PacketField, Object> fieldValues = new HashMap<>();

    /** Contsruct a new VerbosePacket using a HashMap that contains all required fields. */
    public VerbosePacket(HashMap<PacketField, Object> readings) {
        fieldValues = (HashMap<PacketField, Object>) readings.clone();
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

    /** Get a Map of this VerbosePacket's various field values. */
    public HashMap<PacketField, Object> getFieldValues() {
        return fieldValues;
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

    /** Get the String representation of this PacketField. */
    @Override
    public String toString() {
        return stringRep;
    }

    PacketField(String stringRep) {
        this.stringRep = stringRep;
    }
}