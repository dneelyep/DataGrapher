package com.uoflusli;

import nu.xom.*;

import java.io.IOException;
import java.util.ArrayList;

/** Class that will, given an XML data file to parse, generate graphs
 * of various ship parameters, usually with respect to time. */
public class DataGrapher {

    public static void main(String[] args) {
        Document dataFile = null; // TODO No need to initialize to null here.

        try {
            dataFile = new Builder().build("src/com/uoflusli/testData.xml");
        } catch (ParsingException e) {
            System.err.println("Error parsing data file!");
            e.printStackTrace();
        } catch (IOException e) {
            System.err.println("Error parsing data file!");
            e.printStackTrace();
        }

        Element root = dataFile.getRootElement();

        int packetType = null;
        int packetHour = null;
        int packetMinute = null;
        int packetSecond = null;
        int packetPressure1 = null;
        int packetTemperature1 = null;
        int packetHumidity1 = null;
        int packetIrradiance1 = null;
        int packetRadiation1 = null;
        int packetPressure2 = null;
        int packetTemperature2 = null;
        int packetHumidity2 = null;
        int packetIrradiance2 = null;
        int packetRadiation2 = null;
        int packetLatitude = null;
        int packetLongitude = null;
        int packetAccelX = null;
        int packetAccelY = null;
        int packetAccelZ = null;
        int packetGyroX = null;
        int packetGyroY = null;
        int packetGyroZ = null;
        int packetBearing = null;

        // Iterate through all packets in the document.
        for (int packet = 0; packet <root.getChildElements().size(); packet++) {
            System.out.println(root.getChild(packet));

            // Iterate through all data readings in a packet.
            for (int dataReading = 1; dataReading < root.getChild(packet).getChildCount(); dataReading++) {
                if (root.getChild(packet).getChild(dataReading) instanceof Element) {
                    Node data = root.getChild(packet).getChild(dataReading);

                    // TODO Make an enum or similar to clean up this code. Rather than a big switch
                    // statement, store string representation in the enum.
                    switch (((Element) root.getChild(packet).getChild(dataReading)).getQualifiedName()) {
                        case "Type": packetType = Integer.parseInt(data.getValue()); break;
                        case "Hour": break;
                        case "Minute": break;
                        case "Second": break;
                        case "Pressure1": break;
                        case "Temperature1": break;
                        case "Humidity1": break;
                        case "Solar Irradiance1": break;
                        case "UV Radiation1": break;
                        case "Pressure2": break;
                        case "Temperature2": break;
                        case "Humidity2": break;
                        case "Solar Irradiance2": break;
                        case "UV Radiation2": break;
                        case "GPS.Latitude": break;
                        case "GPS.Longitude": break;
                        case "Accelerometer X": break;
                        case "Accelerometer Y": break;
                        case "Accelerometer Z": break;
                        case "Gyro X": break;
                        case "Gyro Y": break;
                        case "Gyro Z": break;
                        case "Bearing": break;
                    }


                    System.out.println(  ((Element) root.getChild(packet).getChild(dataReading)).getQualifiedName() );
                }
            }

            System.out.println();
        }


//        System.out.println(root.getChild(1));
//
//        System.out.println(root.getChild(1).getChild(1));
//
//        System.out.println(root.getChild(1).getChild(1).getValue());


//        for (int i = 0; i < root.getChildCount(); i++) {
//            System.out.println(root.getChild(i));
//        }


            /*try {
            floorDataFile = new Builder().build(floorPath);
            Element root = floorDataFile.getRootElement();
            Elements rangeElements = root.getChildElements();

            // Make an array of Ranges, that's as large as the number of
            // Ranges stored in the data file.
            ranges = new ArrayList<>(rangeElements.size());

            for (int i = 0; i < rangeElements.size(); i++) {
                Element e = rangeElements.get(i);
                String fileX = e.getFirstChildElement("x").getValue();
                String fileY = e.getFirstChildElement("y").getValue();*/

    }
}
