package com.uoflusli;

import nu.xom.*;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

/** Class that will, given an XML data file to parse, generate graphs
 * of various ship parameters, usually with respect to time. */
public class DataGrapher {

    /** A list of packets that are parsed from the provided data file. */
    private ArrayList<VerbosePacket> packets;

    public static void main(String[] args) {
        new DataGrapher();
    }

    public DataGrapher() {
        packets = new ArrayList<>();

        try {
            Document dataFile = new Builder().build("src/com/uoflusli/testData.xml");
            readFile(dataFile);
        } catch (ParsingException | IOException e) {
            System.err.println("Error parsing data file!");
            e.printStackTrace();
        }

        for (VerbosePacket packet : packets) {
            System.out.println(packet.toString());
        }

        write(packets);
    }

    /** Read the contents of the provided dataFile, storing readings in the
     * packets list. */
    private void readFile(Document dataFile) {
        HashMap<PacketField, Object> packetFields = new HashMap<>();

        Element root = dataFile.getRootElement();

        for (int packet = 0; packet < root.getChildCount(); packet++) {

            if (root.getChild(packet) instanceof Element && ((Element) root.getChild(packet)).getQualifiedName().equals("packet")) {
                // Iterate through all data readings in a packet.
                for (int dataReading = 0; dataReading < root.getChild(packet).getChildCount(); dataReading++) {

                    if (root.getChild(packet).getChild(dataReading) instanceof Element) {
                        Node data = root.getChild(packet).getChild(dataReading);

                        // TODO Test all combinations of optional/required packets, make sure that
                        // data will always be parsed correctly.
                        // TODO Make an enum or similar to clean up this code. Rather than a big switch
                        // statement, store string representation in the enum.
                        // TODO For the 14-bit padded int data types (See Message Lengths.xslx), make sure
                        // if they are padded to the left or right. EG 00xxxx or xxxx00. If padded to the right,
                        // I will need to substring them to remove the unneeded 0s.
                        for (PacketField field : PacketField.values()) {
                            if (field.toString().equals( ((Element) root.getChild(packet).getChild(dataReading)).getQualifiedName() )) {

                                packetFields.put(field,
                                        (field.toString().equals("GPS.Latitude") || field.toString().equals("GPS.Longitude")
                                                ? data.getValue() : Integer.parseInt(data.getValue()) ) );

                            }
                        }

                    }
                }

                packets.add(new VerbosePacket(packetFields));
            }
        }
    }

    /** Write out the provided list of packets into an output file named data.csv in the form:
     *
     * type|hour|minute|second|pressure1|temperature1|humidity1|irradiance1|radiation1|pressure2|temperature2|
     * humidity2|irradiance2|radiation2|String latitude|String longitude|accelX|accelY|accelZ|gyroX|gyroY|gyroZ|bearing
     * (without a newline). */
    private void write(ArrayList<VerbosePacket> packets) {
        try {
            FileWriter writer = new FileWriter("data.csv", false);
            PrintWriter printWriter = new PrintWriter(writer);

            for (VerbosePacket packet : packets) {
                for (PacketField field : PacketField.values()) {
                    printWriter.print(packet.getFieldValues().get(field));

                    if (field != PacketField.Bearing) // Don't print an extra | symbol to the right of the csv values.
                        printWriter.print("|");
                }
                printWriter.println();
            }

            printWriter.close();
        } catch (IOException e) {
            System.err.println("Could not write data to CSV file!");
            e.printStackTrace();
        }
    }
}
