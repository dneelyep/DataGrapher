DataGrapher
===========

This is a project to automatically graph the data that we get from the SMD sensors.

* How it works:
Currently, the method of doing this is a bit convoluted. First, the Java program takes the
input XML file and converts it into a CSV file. Then, we run a Matlab script on that CSV file
to generate the graphs. Why? Lack of knowledge of Matlab's features. Hopefully I can clean this
up as time goes on.