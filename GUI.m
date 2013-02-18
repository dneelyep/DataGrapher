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

% Last Modified by GUIDE v2.5 18-Feb-2013 13:51:24

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
                                                                                                           
                                                                                                           
                                                                                                           % --- Executes just before GUI is made visible.
                                                                                                           function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
                                                                                                           global gyroXs gyroYs gyroZs previousSliderValue
                                                                                                           
                                                                                                           % Choose default command line output for GUI
                                                                                                           handles.output = hObject;
                                                                                                           
                                                                                                           % Update handles structure
                                                                                                           guidata(hObject, handles);
                                                                                                           
                                                                                                           numberOfReadings = length(cell2mat(varargin(2))) - 1;
                                                                                                           set(handles.timeSlider, 'Max', numberOfReadings);
                                                                                                           set(handles.timeSlider, 'SliderStep', [numberOfReadings/100 3]);
                                                                                                           
                                                                                                           set(handles.animSpeedSlider, 'SliderStep', [1/100, 1/10])
                                                                                                           set(handles.animSpeedSlider, 'Max', 10);
                                                                                                           
                                                                                                           % TODO Convert the readings into matrices in GUI, while I'm reading in the
                                                                                                           % data?
                                                                                                           % Convert arguments into named matrices for ease of reading.
                                                                                                           irradiance1s = cell2mat(varargin(2));
                                                                                                           pressure1s = cell2mat(varargin(3));
                                                                                                           temperature1s = cell2mat(varargin(4));
                                                                                                           
                                                                                                           irradiance2s = cell2mat(varargin(5));
                                                                                                           pressure2s = cell2mat(varargin(6));
                                                                                                           temperature2s = cell2mat(varargin(7));
                                                                                                           
                                                                                                           rocketCoords = cell2mat(varargin(8));
                                                                                                           
                                                                                                           gyroXs = cell2mat(varargin(9));
                                                                                                           gyroYs = cell2mat(varargin(10));
                                                                                                           gyroZs = cell2mat(varargin(11));
                                                                                                           
                                                                                                           % TODO Add units to the plots.
                                                                                                           plot(handles.lightVsTime, 1 : length(irradiance1s), irradiance1s, 1 : length(irradiance2s), irradiance2s);
                                                                                                           plot(handles.pressureVsTime, 1 : length(pressure1s), pressure1s, 1 : length(pressure2s), pressure2s);
                                                                                                           plot(handles.temperatureVsTime, 1 : length(temperature1s), temperature1s, 1 : length(temperature2s), temperature2s);
                                                                                                           
                                                                                                           X = rocketCoords(1:2, 1:21);
                                                                                                           Y = rocketCoords(1:2, 22:42);
                                                                                                           Z = rocketCoords(1:2, 43:63);
                                                                                                           surf(handles.rocketSim, X, Y, Z);
                                                                                                           rotate3d(handles.rocketSim); % Allow the plot to be rotated.
                                                                                                           
                                                                                                           xlabel(handles.rocketSim, 'X');
                                                                                                           ylabel(handles.rocketSim, 'Y');
                                                                                                           zlabel(handles.rocketSim, 'Z');
                                                                                                           
                                                                                                           % Initialize the previous slider value to a default.
                                                                                                           previousSliderValue = get(handles.timeSlider, 'Value');
                                                                                                           
                                                                                                           % UIWAIT makes GUI wait for user response (see UIRESUME)
                                                                                                           % uiwait(handles.guiWindow);
                                                                                                           
                                                                                                           % --- Outputs from this function are returned to the command line.
                                                                                                           function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
                                                                                                           % Get default command line output from handles structure
                                                                                                           varargout{1} = handles.output;
                                                                                                           
                                                                                                           % --- Executes on slider movement.
                                                                                                           % TODO Have this execute on slider scrubbing without releasing the mouse
                                                                                                           % button.
                                                                                                           function timeSlider_Callback(hObject, eventdata, handles)
                                                                                                           global gyroXs gyroYs gyroZs previousSliderValue
                                                                                                           
                                                                                                           % Remove the previous red vertical lines from graphs.
                                                                                                           delete(findall(0,'type', 'line', '-and', 'Color', 'r'));
                                                                                                           
                                                                                                           lightY = get(handles.lightVsTime,'YLim');
                                                                                                           tempY  = get(handles.temperatureVsTime,'YLim');
                                                                                                           pressY = get(handles.pressureVsTime,'YLim');
                                                                                                           
                                                                                                           time = get(hObject, 'Value');
                                                                                                           line([time time],lightY,'Color','r', 'Parent', handles.lightVsTime);
                                                                                                           line([time time],pressY,'Color','r', 'Parent', handles.pressureVsTime);
                                                                                                           line([time time],tempY,'Color','r', 'Parent', handles.temperatureVsTime);
                                                                                                           
                                                                                                           X = get(get(handles.rocketSim, 'Children'), 'Xdata');
                                                                                                           Y = get(get(handles.rocketSim, 'Children'), 'Ydata');
                                                                                                           Z = get(get(handles.rocketSim, 'Children'), 'Zdata');
                                                                                                           rocket = surf(handles.rocketSim, X, Y, Z);
                                                                                                           
                                                                                                           % Make sure axes are scaled properly after every rotation.
                                                                                                           axis(handles.rocketSim, [-3 3 -3 3 -3 3 -1 3]);
                                                                                                           sliderMovedRight= ge(get(handles.timeSlider, 'Value'), previousSliderValue);
                                                                                                           
                                                                                                           % Rotate the rocket accordingly.
                                                                                                           theTime = cast(time, 'uint8');
                                                                                                           if sliderMovedRight
                                                                                                               rotate(rocket, [1 0 0], gyroXs(theTime + 1));
                                                                                                                   rotate(rocket, [0 1 0], gyroYs(theTime + 1));
                                                                                                                       rotate(rocket, [0 0 1], gyroZs(theTime + 1));
                                                                                                                       else
                                                                                                                           if theTime - 1 > 0 % Make sure we don't attempt to access a 0 or negative reading index.
                                                                                                                                   rotate(rocket, [-1 0 0], gyroXs(theTime - 1));
                                                                                                                                           rotate(rocket, [0 -1 0], gyroYs(theTime - 1));
                                                                                                                                                   rotate(rocket, [0 0 -1], gyroZs(theTime - 1));
                                                                                                                                                       end
                                                                                                                                                       end
                                                                                                                                                       previousSliderValue = get(handles.timeSlider, 'Value');
                                                                                                                                                       
                                                                                                                                                       % --- Executes during object creation, after setting all properties.
                                                                                                                                                       function timeSlider_CreateFcn(hObject, eventdata, handles)
                                                                                                                                                       
                                                                                                                                                       if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
                                                                                                                                                           set(hObject,'BackgroundColor',[.9 .9 .9]);
                                                                                                                                                           end
                                                                                                                                                           
                                                                                                                                                           % --- Executes on button press in animateButton.
                                                                                                                                                           function animateButton_Callback(hObject, eventdata, handles)
                                                                                                                                                           % hObject    handle to animateButton (see GCBO)
                                                                                                                                                           % eventdata  reserved - to be defined in a future version of MATLAB
                                                                                                                                                           % handles    structure with handles and user data (see GUIDATA)
                                                                                                                                                           numberOfReadings = get(handles.timeSlider, 'Max');
                                                                                                                                                           
                                                                                                                                                           if (get(handles.forwardAnimDirectionButton, 'Value') == 1)
                                                                                                                                                               t = timer('TimerFcn', {@animateOneFrame, handles}, 'Period', (1 / get(handles.animSpeedSlider, 'Value')) + 0.01, 'ExecutionMode', 'fixedRate', 'TasksToExecute', numberOfReadings - get(handles.timeSlider, 'Value') - 1);
                                                                                                                                                                   start(t)
                                                                                                                                                                   end
                                                                                                                                                                   if (get(handles.timeSlider, 'Value') ~= 0 && get(handles.backAnimDirectionButton, 'Value') == 1)
                                                                                                                                                                       t = timer('TimerFcn', {@animateOneFrame, handles}, 'Period', (1 / get(handles.animSpeedSlider, 'Value')) + 0.01, 'ExecutionMode', 'fixedRate', 'TasksToExecute', get(handles.timeSlider, 'Value'));
                                                                                                                                                                           start(t)
                                                                                                                                                                           end
                                                                                                                                                                           
                                                                                                                                                                           % --- Executes during object creation, after setting all properties.
                                                                                                                                                                           function animSpeedSlider_CreateFcn(hObject, eventdata, handles)
                                                                                                                                                                           % TODO Make the minimum of the anim speed > 0 - otherwise you can divide by
                                                                                                                                                                           % zero.
                                                                                                                                                                           
                                                                                                                                                                           if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
                                                                                                                                                                               set(hObject,'BackgroundColor',[.9 .9 .9]);
                                                                                                                                                                               end
                                                                                                                                                                               set(hObject, 'Value', 1);
                                                                                                                                                                               
                                                                                                                                                                               function animSpeedSlider_Callback(hObject, eventdata, handles, varargin)
                                                                                                                                                                               
                                                                                                                                                                               
                                                                                                                                                                               function animateOneFrame(source, event, handles)
                                                                                                                                                                               % Animate a single frame of data.
                                                                                                                                                                               
                                                                                                                                                                               if (get(handles.forwardAnimDirectionButton, 'Value') == 1)
                                                                                                                                                                                   set(handles.timeSlider, 'Value', get(handles.timeSlider, 'Value') + 1);
                                                                                                                                                                                   else
                                                                                                                                                                                       set(handles.timeSlider, 'Value', get(handles.timeSlider, 'Value') - 1);
                                                                                                                                                                                       end
                                                                                                                                                                                       timeSlider_Callback(handles.timeSlider, event, handles);
