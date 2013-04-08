function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 06-Apr-2013 23:21:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% TODO Problems to fix:
% * Need consistent, useful sliderStep values that are independent of the
% number of readings.
% * Need to always display the X, Y, Z axis labels, not have them disappear
% on rotate.
% * Possibly do XML processing in Matlab.
% * Need to apply rotations to rocket as scrubbing happens.

% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, ~, handles, varargin)
% TODO: Provide overlays of the data readings on the graphs. See:
% http://blogs.mathworks.com/community/2008/08/25/overlaying-information-on-a-plot/

% Choose default command line output for GUI
global readings previousSliderValue lastAx lastAy lastAz
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

numberOfReadings = length(readings.hours) - 1;
set(handles.timeSlider, 'Max', numberOfReadings);
set(handles.timeSlider, 'Min', 1);
set(handles.timeSlider, 'SliderStep', [1/numberOfReadings 5/numberOfReadings]);

set(handles.animSpeedSlider, 'SliderStep', [1/100, 1/10]);
% TODO Find a way to automatically calculate a suitable Max.
set(handles.animSpeedSlider, 'Max', 15);

rocketCoords = cell2mat(varargin(3));

% TODO Add units to the plots.
plot(handles.lightVsTime, 1 : length(readings.irradiance1s), readings.irradiance1s, 1 : length(readings.irradiance2s), readings.irradiance2s);
plot(handles.pressureVsTime, 1 : length(readings.pressure1s), readings.pressure1s, 1 : length(readings.pressure2s), readings.pressure2s);
plot(handles.temperatureVsTime, 1 : length(readings.temperature1s), readings.temperature1s, 1 : length(readings.temperature2s), readings.temperature2s);

X = rocketCoords(1:2, 1:21);
Y = rocketCoords(1:2, 22:42);
Z = rocketCoords(1:2, 43:63);
surf(handles.rocketSim, X, Y, Z);
% TODO If we want, a cylinder shape might be more useful.
% cylinder(handles.rocketSim, [0.5 0]);
rotate3d(handles.rocketSim); % pAllow the plot to be rotated.

xlabel(handles.rocketSim, 'X');
ylabel(handles.rocketSim, 'Y');
zlabel(handles.rocketSim, 'Z');

% Initialize the previous slider and lastX/Y/Z values to safe defaults.
previousSliderValue = get(handles.timeSlider, 'Value');
lastAx = 0;
lastAy = 0;
lastAz = 0;

% Set up a listener that activates on time slider scrubbing, to perform animations on scrubbing.
scrubbingListener = handle.listener(handles.timeSlider,'ActionEvent',{@timeSlider_Callback, handles});
setappdata(handles.guiWindow, 'sliderListeners', scrubbingListener);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.guiWindow);

% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(~, ~, handles) 
% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on slider movement.
function timeSlider_Callback(hObject, ~, handles)
    global previousSliderValue readings lastAx lastAy lastAz

    % TODO Do I need this, since I've set the step size to 1?
    % Make sure the slider's value is always an integer - easier to work with.
    roundedValue = round(get(handles.timeSlider, 'Value'));
    set(handles.timeSlider, 'Value', roundedValue);

    % Remove previous red vertical lines and text pieces from graphs.
    delete(findall(0, 'type', 'line', '-and', 'Color', 'r'));
    delete(findall(0, 'type', 'text'));

    lightY = get(handles.lightVsTime,'YLim');
    tempY  = get(handles.temperatureVsTime,'YLim');
    pressY = get(handles.pressureVsTime,'YLim');

    time = get(hObject, 'Value');

    line([time time], lightY, 'Color', 'r', 'Parent', handles.lightVsTime);
    line([time time], pressY, 'Color', 'r', 'Parent', handles.pressureVsTime);
    line([time time], tempY,  'Color', 'r', 'Parent', handles.temperatureVsTime);

    X = get(get(handles.rocketSim, 'Children'), 'Xdata');
    Y = get(get(handles.rocketSim, 'Children'), 'Ydata');
    Z = get(get(handles.rocketSim, 'Children'), 'Zdata');
    rocket = surf(handles.rocketSim, X, Y, Z);

    % Make sure axes are scaled properly after every rotation.
    axis(handles.rocketSim, [-3 3 -3 3 -3 3 -1 3]);
    sliderMovedRight= ge(get(handles.timeSlider, 'Value'), previousSliderValue);

    set(handles.lightReading1,    'String', sprintf('Reading 1: %d', readings.irradiance1s(time)));
    set(handles.lightReading2,    'String', sprintf('Reading 2: %d', readings.irradiance2s(time)));
    set(handles.pressureReading1, 'String', sprintf('Reading 1: %d', readings.pressure1s(time)));
    set(handles.pressureReading2, 'String', sprintf('Reading 2: %d', readings.pressure2s(time)));
    set(handles.tempReading1,     'String', sprintf('Reading 1: %d', readings.temperature1s(time)));
    set(handles.tempReading2,     'String', sprintf('Reading 2: %d', readings.temperature2s(time)));

    set(handles.timeReading, 'String', sprintf('t: %d:%d:%d', readings.hours(time), readings.minutes(time), readings.seconds(time)));
         
    % TODO Should I be using xHat here? If I'm using a unit vector in
    % the x-direction, I will probably not get a right angle between
    % xHat and a.
    xHat = [1 0 0];
    yHat = [0 1 0];
    zHat = [0 0 1];
         
    % Rotate the rocket accordingly.
    lowerLimit = previousSliderValue;
    if sliderMovedRight
        upperLimit = get(handles.timeSlider, 'Value');
        stepValue  = 1;
    else
        upperLimit = get(handles.timeSlider, 'Value') + 1;
        stepValue  = -1;
    end

    if previousSliderValue == 0 
        previousSliderValue = 1; % Make sure we don't allow invalid matrix indeces later.
    end

    totalAlpha = 0;
    totalBeta  = 0;
    totalGamma = 0;
    
    if time >= 0 % Make sure we don't attempt to access a 0 or negative reading index.
        for loopTime = lowerLimit : stepValue : upperLimit %previousSliderValue : get(handles.timeSlider, 'Value')
            % a is the vector produced from the difference between the 
            % previous and current acceleration readings.
            a = [readings.accelXs(loopTime)-lastAx readings.accelYs(loopTime)-lastAy readings.accelZs(loopTime)-lastAz];

            projOfAOntoX = dot(a, xHat) * xHat;
            projOfAOntoY = dot(a, yHat) * yHat;
            projOfAOntoZ = dot(a, zHat) * zHat;
        
            %LEFTOFFHERE Need to make sure if I should use abs(a) to
            %calculate the magnitude of a or not.
            alpha = acos( projOfAOntoX / abs(a) ) * sign(readings.accelXs(loopTime)-lastAx);
            beta  = acos( projOfAOntoY / abs(a) ) * sign(readings.accelYs(loopTime)-lastAy);
            gamma = acos( projOfAOntoZ / abs(a) ) * sign(readings.accelZs(loopTime)-lastAz);

            totalAlpha = totalAlpha + alpha;
            totalBeta  = totalBeta  + alpha;
            totalGamma = totalGamma + alpha;

            lastAx = readings.accelXs(loopTime);
            lastAy = readings.accelYs(loopTime);
            lastAz = readings.accelZs(loopTime);
        end
        
        %rotate(rocket, [1 0 0], gyroXs(loopTime));
        %rotate(rocket, [0 1 0], gyroYs(loopTime));
        %rotate(rocket, [0 0 1], gyroZs(loopTime));
        rotate(rocket, [stepValue 0 0], totalAlpha);
        rotate(rocket, [0 stepValue 0], totalBeta);
        rotate(rocket, [0 0 stepValue], totalGamma);
    end
    previousSliderValue = get(handles.timeSlider, 'Value');

% --- Executes during object creation, after setting all properties.
function timeSlider_CreateFcn(hObject, ~, ~)

if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in animateButton.
function animateButton_Callback(~, ~, handles)
global animationProcess
numberOfReadings = get(handles.timeSlider, 'Max');

get(handles.animateButton, 'Value')
get(handles.animateButton)
if (get(handles.animateButton, 'Value') == 1) % Animate if the toggle button is enabled.
    if (get(handles.animDirectionGroup, 'SelectedObject') == handles.forwardAnimDirectionButton)
        animationProcess = timer('TimerFcn', {@animateOneFrame, handles}, 'Period', (1 / get(handles.animSpeedSlider, 'Value')) + 0.01, 'ExecutionMode', 'fixedRate', 'TasksToExecute', numberOfReadings - get(handles.timeSlider, 'Value') - 1);
        start(animationProcess)
    end
    if (get(handles.timeSlider, 'Value') ~= 0 && get(handles.backAnimDirectionButton, 'Value') == 1)
        animationProcess = timer('TimerFcn', {@animateOneFrame, handles}, 'Period', (1 / get(handles.animSpeedSlider, 'Value')) + 0.01, 'ExecutionMode', 'fixedRate', 'TasksToExecute', get(handles.timeSlider, 'Value'));
        start(animationProcess)
    end
    set(handles.animateButton, 'String', 'Stop');
else % Stop animation if the toggle button is disabled.
    stop(animationProcess)
    set(handles.animateButton, 'String', 'Animate!');
end

% --- Executes during object creation, after setting all properties.
function animSpeedSlider_CreateFcn(hObject, ~, ~)
% TODO Make the minimum of the anim speed > 0 - otherwise you can divide by
% zero.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
set(hObject, 'Value', 1);

function animSpeedSlider_Callback(~, ~, ~, varargin)

function animateOneFrame(~, event, handles)
% Animate a single frame of data.
get(handles.forwardAnimDirectionButton)
if (get(handles.forwardAnimDirectionButton, 'Value') == 1)
    set(handles.timeSlider, 'Value', get(handles.timeSlider, 'Value') + 1);
else
    set(handles.timeSlider, 'Value', get(handles.timeSlider, 'Value') - 1);
end
timeSlider_Callback(handles.timeSlider, event, handles);
