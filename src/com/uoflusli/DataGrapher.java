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

        System.out.println(dataFile.getRootElement());

        ParentNode root = dataFile.getRootElement();

        ArrayList<Node> packets = new ArrayList<Node>();

        System.out.println(root.getChild(1));

        System.out.println(root.getChild(1).getChild(1));

        System.out.println(root.getChild(1).getChild(1).getValue());


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
