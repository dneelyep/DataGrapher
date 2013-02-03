function [] = plotGraphs(csvFile)
% PLOTGRAPHS - A script to automatically plot graphs of several different
% quantities in the data packets received from the SMD.
% INPUT - xmlFile = The path of the CSV file from which to read data.

% Needed graphs:
% ** Atmospheric data (pressure, temperature, humidity, irradiance, radiation, readings 1 and 2)
% *** vs. time
% *** vs. latitude
% *** vs. longitude
% 
% ** Accelerometer data (AccelX/Y/Z)
% *** vs. time
% *** vs. latitude
% *** vs. longitude
% 
% ** Gyroscope data (Gyro_X/Y/Z)
% *** vs. time
% *** vs. latitude
% *** vs. longitude
% 
% ** Bearing data
% *** vs. time
% *** vs. latitude
% *** vs. longitude

% xmlDataFile = xmlread(xmlFile);
% packets = xmlDataFile.getElementsByTagName('packet');
% 
% pressure1 = xmlDataFile.getElementsByTagName('Pressure1')
% temperature1 = xmlDataFile.getElementsByTagName('Temperature1')
% humidity1 = xmlDataFile.getElementsByTagName('Humditiy1')
% irradiance1 = xmlDataFile.getElementsByTagName('Solar_Irradiance1')
% radiaton1 = xmlDataFile.getElementsByTagName('UV_Radiation1')
% 
% pressure2 = xmlDataFile.getElementsByTagName('Pressure2')
% temperature2 = xmlDataFile.getElementsByTagName('Temperature2')
% humidity2 = xmlDataFile.getElementsByTagName('Humdity2')
% irradiance2 = xmlDataFile.getElementsByTagName('Solar_Irradiance2')
% radiaton2 = xmlDataFile.getElementsByTagName('UV_Radiation2')
% 
% accelX = xmlDataFile.getElementsByTagName('Accelerometer_X')
% accelY = xmlDataFile.getElementsByTagName('Accelerometer_Y')
% accelZ = xmlDataFile.getElementsByTagName('Accelerometer_Z')
% 
% gyroX = xmlDataFile.getElementsByTagName('Gyro_X')
% gyroY = xmlDataFile.getElementsByTagName('Gyro_Y')
% gyroZ = xmlDataFile.getElementsByTagName('Gyro_Z')
% 
% bearing = xmlDataFile.getElementsByTagName('Bearing')
% 
% % Use this to get the data of a given tag: gyroX =
% % xmlFile.getElementsByTagName('Gyro_X').item(3).getFirstChild().getData
% 
% % xmlFile.getElementsByTagName('Gyro_X').getLength()
% gyroXElements = xmlDataFile.getElementsByTagName('Gyro_X');
% 
% gyro_x_data = [];
% 
% for gyroX=0; gyroXElements.getLength()-1
%     gyro_x_data(end + 1) = java.lang.Double.parseDouble(  gyroXElements.item(gyroX).getFirstChild().getData()  );
% end
% 
% gyro_x_data

data = importdata(csvFile, '|')

hours = data(1:5, 1)
minutes = data(1:5, 2)
seconds = data(1:5, 3);
pressure1s = data(1:5, 4)
temperature1s = data(1:5, 5);
humidity1s = data(1:5, 6);
irradiance1s = data(1:5, 7);
radiation1s = data(1:5, 8);
pressure2s = data(1:5, 9);
temperature2s = data(1:5, 10);
humidity2s = data(1:5, 11);
irradiance2s = data(1:5, 12);
radiation2s = data(1:5, 13);
latitudes = data(1:5, 14)
longitudes = data(1:5, 15)
accelXs = data(1:5, 16);
accelYs = data(1:5, 17);
accelZs = data(1:5, 18);
gyroXs = data(1:5, 19);
gyroYs = data(1:5, 20);
gyroZs = data(1:5, 21);
bearings = data(1:5, 22);

plot(latitudes, pressure1s)
xlabel('Latitude')
ylabel('Pressure - Reading 1')
title('Pressure [r1] vs latitude')

plot(longitudes, pressure1s)
xlabel('Longitude')
ylabel('Pressure - Reading 1')
title('Pressure [r1] vs longitude')

plot(latitudes, pressure2s)
xlabel('Latitude')
ylabel('Pressure - Reading 2')
title('Pressure vs latitude')
title('Pressure [r2] vs latitude')

plot(longitudes, pressure2s)
xlabel('Longitude')
ylabel('Pressure - Reading 2')
title('Pressure [r2] vs longitude')




% ** Atmospheric data (pressure, temperature, humidity, irradiance, radiation, readings 1 and 2)
% *** vs. time
% *** vs. latitude
% *** vs. longitude
% 
% ** Accelerometer data (AccelX/Y/Z)
% *** vs. time
% *** vs. latitude
% *** vs. longitude
% 
% ** Gyroscope data (Gyro_X/Y/Z)
% *** vs. time
% *** vs. latitude
% *** vs. longitude
% 
% ** Bearing data
% *** vs. time
% *** vs. latitude
% *** vs. longitude
