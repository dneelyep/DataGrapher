package com.uoflusli;

import nu.xom.*;

import java.io.IOException;
import java.util.ArrayList;

/** Class that will, given an XML data file to parse, generate graphs
 * of various ship parameters, usually with respect to time. */
public class DataGrapher {

    /** A list of packets that are parsed from the provided data file. */
    private ArrayList<VerbosePacket> packets;

    public static void main(String[] args) {
        new DataGrapher();
    }

    public DataGrapher() {
        Document dataFile = null; // TODO No need to initialize to null here.
        packets = new ArrayList<>();

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

        // TODO This is a hack.
        // Initialize all types to very odd values to indicate error.
        int packetType = -9000;
        int packetHour = -9000;
        int packetMinute = -9000;
        int packetSecond = -9000;
        int packetPressure1 = -9000;
        int packetTemperature1 = -9000;
        int packetHumidity1 = -9000;
        int packetIrradiance1 = -9000;
        int packetRadiation1 = -9000;
        int packetPressure2 = -9000;
        int packetTemperature2 = -9000;
        int packetHumidity2 = -9000;
        int packetIrradiance2 = -9000;
        int packetRadiation2 = -9000;
        String packetLatitude = "-9000";
        String packetLongitude = "-9000";
        int packetAccelX = -9000;
        int packetAccelY = -9000;
        int packetAccelZ = -9000;
        int packetGyroX = -9000;
        int packetGyroY = -9000;
        int packetGyroZ = -9000;
        int packetBearing = -9000;

        // Iterate through all packets in the document.
        for (int packet = 0; packet <root.getChildElements().size(); packet++) {

            // Iterate through all data readings in a packet.
            for (int dataReading = 1; dataReading < root.getChild(packet).getChildCount(); dataReading++) {
                if (root.getChild(packet) instanceof Element
                        && root.getChild(packet).getChild(dataReading) instanceof Element
                        && ((Element) root.getChild(packet)).getQualifiedName().equals("packet")) {
                    Node data = root.getChild(packet).getChild(dataReading);

                    // TODO Make an enum or similar to clean up this code. Rather than a big switch
                    // statement, store string representation in the enum.
                    // TODO For the 14-bit padded int data types (See Message Lengths.xslx), make sure
                    // if they are padded to the left or right. EG 00xxxx or xxxx00. If padded to the right,
                    // I will need to substring them to remove the unneeded 0s.
                    if (((Element) root.getChild(packet).getChild(dataReading)).getQualifiedName().equals("GPS.Latitude")
                            || ((Element) root.getChild(packet).getChild(dataReading)).getQualifiedName().equals("GPS.Longitude")) {
                        System.out.println("Lat or long!");
                    }
                    else {
                        System.out.println(PacketField.valueOf(((Element) root.getChild(packet).getChild(dataReading)).getQualifiedName()));
                    }

                    switch (((Element) root.getChild(packet).getChild(dataReading)).getQualifiedName()) {
                        case "Type": packetType = Integer.parseInt(data.getValue()); break;
                        case "Hour": packetHour = Integer.parseInt(data.getValue()); break;
                        case "Minute": packetMinute = Integer.parseInt(data.getValue()); break;
                        case "Second": packetSecond = Integer.parseInt(data.getValue()); break;
                        case "Pressure1": packetPressure1 = Integer.parseInt(data.getValue()); break;
                        case "Temperature1": packetTemperature1 = Integer.parseInt(data.getValue()); break;
                        case "Humidity1": packetHumidity1 = Integer.parseInt(data.getValue()); break;
                        case "Solar_Irradiance1": packetIrradiance1 = Integer.parseInt(data.getValue()); break;
                        case "UV_Radiation1": packetRadiation1 = Integer.parseInt(data.getValue()); break;
                        case "Pressure2": packetPressure2 = Integer.parseInt(data.getValue()); break;
                        case "Temperature2": packetTemperature2 = Integer.parseInt(data.getValue()); break;
                        case "Humidity2": packetHumidity2 = Integer.parseInt(data.getValue()); break;
                        case "Solar_Irradiance2": packetIrradiance2 = Integer.parseInt(data.getValue()); break;
                        case "UV_Radiation2": packetRadiation2 = Integer.parseInt(data.getValue()); break;
                        case "GPS.Latitude": packetLatitude = data.getValue(); break;
                        case "GPS.Longitude": packetLongitude = data.getValue(); break;
                        case "Accelerometer_X": packetAccelX = Integer.parseInt(data.getValue()); break;
                        case "Accelerometer_Y": packetAccelY = Integer.parseInt(data.getValue()); break;
                        case "Accelerometer_Z": packetAccelZ = Integer.parseInt(data.getValue()); break;
                        case "Gyro_X": packetGyroX = Integer.parseInt(data.getValue()); break;
                        case "Gyro_Y": packetGyroY = Integer.parseInt(data.getValue()); break;
                        case "Gyro_Z": packetGyroZ = Integer.parseInt(data.getValue()); break;
                        case "Bearing": packetBearing = Integer.parseInt(data.getValue()); break;
                    }
                }
            }
            packets.add(new VerbosePacket(packetHour, packetMinute, packetSecond, packetPressure1,
                    packetTemperature1, packetHumidity1, packetIrradiance1, packetRadiation1, packetPressure2,
                    packetTemperature2, packetHumidity2, packetIrradiance2, packetRadiation2, packetLatitude,
                    packetLongitude, packetAccelX, packetAccelY, packetAccelZ, packetGyroX, packetGyroY,
                    packetGyroZ, packetBearing));

        }

        for (VerbosePacket packet : packets) {
            System.out.println(packet.toString());
        }
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
