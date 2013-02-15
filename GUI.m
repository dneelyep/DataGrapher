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

% Last Modified by GUIDE v2.5 11-Feb-2013 22:41:42

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
                                                                                                           
                                                                                                           global gyroXs gyroYs gyroZs
                                                                                                           
                                                                                                           % Choose default command line output for GUI
                                                                                                           handles.output = hObject;
                                                                                                           
                                                                                                           % Update handles structure
                                                                                                           guidata(hObject, handles);
                                                                                                           
                                                                                                           numberOfReadings = length(cell2mat(varargin(2))) - 1;
                                                                                                           set(handles.timeSlider, 'Max', numberOfReadings);
                                                                                                           set(handles.timeSlider, 'SliderStep', [numberOfReadings/100 3]);
                                                                                                           
                                                                                                           set(handles.animSpeedSlider, 'SliderStep', [1/100, 1/10])
                                                                                                           set(handles.animSpeedSlider, 'Max', 20);
                                                                                                           
                                                                                                           plot(handles.lightVsTime, 1 : length(cell2mat(varargin(2))), cell2mat(varargin(2)), 1 : length(cell2mat(varargin(9))), cell2mat(varargin(9)))
                                                                                                           plot(handles.pressureVsTime, 1 : length(cell2mat(varargin(3))), cell2mat(varargin(3)), 1 : length(cell2mat(varargin(10))), cell2mat(varargin(10)))
                                                                                                           plot(handles.temperatureVsTime, 1 : length(cell2mat(varargin(4))), cell2mat(varargin(4)), 1 : length(cell2mat(varargin(11))), cell2mat(varargin(11)))
                                                                                                           
                                                                                                           rocketCoords = cell2mat(varargin(5));
                                                                                                           X = rocketCoords(1:2, 1:21);
                                                                                                           Y = rocketCoords(1:2, 22:42);
                                                                                                           Z = rocketCoords(1:2, 43:63);
                                                                                                           surf(handles.rocketSim, X, Y, Z);
                                                                                                           rotate3d(handles.rocketSim); % Allow the plot to be rotated.
                                                                                                           
                                                                                                           gyroXs = cell2mat(varargin(6));
                                                                                                           gyroYs = cell2mat(varargin(7));
                                                                                                           gyroZs = cell2mat(varargin(8));
                                                                                                           
                                                                                                           xlabel(handles.rocketSim, 'X');
                                                                                                           ylabel(handles.rocketSim, 'Y');
                                                                                                           zlabel(handles.rocketSim, 'Z');
                                                                                                           
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
                                                                                                           global gyroXs gyroYs gyroZs
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
                                                                                                           
                                                                                                           % TODO Check for moving the slider in the negative direction.
                                                                                                           theTime = cast(time, 'uint8');
                                                                                                           rotate(rocket, [1 0 0], gyroXs(theTime + 1));
                                                                                                           rotate(rocket, [0 1 0], gyroYs(theTime + 1));
                                                                                                           rotate(rocket, [0 0 1], gyroZs(theTime + 1));
                                                                                                           
                                                                                                           % TODO Make the forward button the default animation button.
                                                                                                           % Make sure axes are scaled properly after every rotation.
                                                                                                           axis(handles.rocketSim, [-3 3 -3 3 -3 3 -1 3]);
                                                                                                           
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
                                                                                                                   t = timer('TimerFcn', {@animateOneFrame, handles}, 'Period', (1 / get(handles.animSpeedSlider, 'Value')) + 0.001, 'ExecutionMode', 'fixedRate', 'TasksToExecute', numberOfReadings - get(handles.timeSlider, 'Value') - 1);
                                                                                                                       start(t)
                                                                                                                       end
                                                                                                                       if (get(handles.timeSlider, 'Value') ~= 0 && get(handles.backAnimDirectionButton, 'Value') == 1)
                                                                                                                           t = timer('TimerFcn', {@animateOneFrame, handles}, 'Period', (1 / get(handles.animSpeedSlider, 'Value')) + 0.001, 'ExecutionMode', 'fixedRate', 'TasksToExecute', get(handles.timeSlider, 'Value'));
                                                                                                                               start(t)
                                                                                                                               end
                                                                                                                               
                                                                                                                               % --- Executes during object creation, after setting all properties.
                                                                                                                               function animSpeedSlider_CreateFcn(hObject, eventdata, handles)
                                                                                                                               
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
                                                                                                                                           
