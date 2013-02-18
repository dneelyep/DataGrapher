function [] = plotGraphs(csvFile)
% PLOTGRAPHS - A script to automatically plot graphs of several different
% quantities in the data packets received from the SMD.
% INPUT - csvFile = The path of the CSV file from which to read data.

data = importdata(csvFile, '|');
[rowLength colLength] = size(data);

hours = data(1:rowLength, 1);
minutes = data(1:rowLength, 2);
seconds = data(1:rowLength, 3);
pressure1s = data(1:rowLength, 4);
temperature1s = data(1:rowLength, 5);
humidity1s = data(1:rowLength, 6);
irradiance1s = data(1:rowLength, 7);
radiation1s = data(1:rowLength, 8);
pressure2s = data(1:rowLength, 9);
temperature2s = data(1:rowLength, 10);
humidity2s = data(1:rowLength, 11);
irradiance2s = data(1:rowLength, 12);
radiation2s = data(1:rowLength, 13);
latitudes = data(1:rowLength, 14);
longitudes = data(1:rowLength, 15);
accelXs = data(1:rowLength, 16);
accelYs = data(1:rowLength, 17);
accelZs = data(1:rowLength, 18);
gyroXs = data(1:rowLength, 19);
gyroYs = data(1:rowLength, 20);
gyroZs = data(1:rowLength, 21);
bearings = data(1:rowLength, 22);

% Note that rowLength represents the number of packets read.

endOfTime = colLength;
numberOfReadings = rowLength;

% Set up the rocket representation.
[X Y Z] = cylinder(3);
Z = (Z * 6) - 3*ones(size(Z));

mygui = GUI(5000, irradiance1s, pressure1s, temperature1s, irradiance2s, pressure2s, temperature2s, [X Y Z], gyroXs, gyroYs, gyroZs);
