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
//
//        System.out.println(root);
//
        // Iterate through all packets in the document.
        for (int packet = 0; packet <root.getChildElements().size(); packet++) {
            System.out.println(root.getChild(packet));

            // Iterate through all data readings in a packet.
            for (int dataReading = 1; dataReading < root.getChild(packet).getChildCount(); dataReading++) {
                if (root.getChild(packet).getChild(dataReading) instanceof Element) {

                    switch (((Element) root.getChild(packet).getChild(dataReading)).getQualifiedName()) {
                        case "Type": break;
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
