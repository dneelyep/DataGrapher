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
                                                                                                           % This function has no output args, see OutputFcn.
                                                                                                           % hObject    handle to figure
                                                                                                           % eventdata  reserved - to be defined in a future version of MATLAB
                                                                                                           % handles    structure with handles and user data (see GUIDATA)
                                                                                                           % varargin   command line arguments to GUI (see VARARGIN)
                                                                                                           
                                                                                                           % Choose default command line output for GUI
                                                                                                           handles.output = hObject;
                                                                                                           
                                                                                                           % Update handles structure
                                                                                                           guidata(hObject, handles);
                                                                                                           set(findobj('Tag', 'lightVsTime'), 'UserData', [1,1,1;3,3,3]);
                                                                                                           
                                                                                                           % TODO Add another plot for the second irradiance reading.
                                                                                                           plot(handles.lightVsTime, 1 : length(cell2mat(varargin(2))), cell2mat(varargin(2)))
                                                                                                           plot(handles.pressureVsTime, 1 : length(cell2mat(varargin(3))), cell2mat(varargin(3)))
                                                                                                           plot(handles.temperatureVsTime, 1 : length(cell2mat(varargin(4))), cell2mat(varargin(4)))
                                                                                                           
                                                                                                           numberOfReadings = length(cell2mat(varargin(2)));
                                                                                                           set(handles.timeSlider, 'Max', numberOfReadings);
                                                                                                           set(handles.timeSlider, 'SliderStep', [numberOfReadings/100 3]);
                                                                                                           
                                                                                                           set(handles.animSpeedSlider, 'SliderStep', [1/100, 1/10])
                                                                                                           set(handles.animSpeedSlider, 'Max', 20);
                                                                                                           
                                                                                                           % Set up the rocket display.
                                                                                                           axes(handles.rocketSim);
                                                                                                           rocketCoords = cell2mat(varargin(5));
                                                                                                           global X Y Z
                                                                                                           X = rocketCoords(1:2, 1:21);
                                                                                                           Y = rocketCoords(1:2, 22:42);
                                                                                                           Z = rocketCoords(1:2, 43:63);
                                                                                                           surf(X, Y, Z);
                                                                                                           
                                                                                                           % UIWAIT makes GUI wait for user response (see UIRESUME)
                                                                                                           % uiwait(handles.guiWindow);
                                                                                                           
                                                                                                           % --- Outputs from this function are returned to the command line.
                                                                                                           function varargout = GUI_OutputFcn(hObject, eventdata, handles) 
                                                                                                           % varargout  cell array for returning output args (see VARARGOUT);
                                                                                                           % hObject    handle to figure
                                                                                                           % eventdata  reserved - to be defined in a future version of MATLAB
                                                                                                           % handles    structure with handles and user data (see GUIDATA)
                                                                                                           
                                                                                                           % Get default command line output from handles structure
                                                                                                           varargout{1} = handles.output;
                                                                                                           
                                                                                                           % --- Executes on slider movement.
                                                                                                           % TODO Have this execute on slider scrubbing without releasing the mouse
                                                                                                           % button.
                                                                                                           function timeSlider_Callback(hObject, eventdata, handles)
                                                                                                           % hObject    handle to timeSlider (see GCBO)
                                                                                                           % eventdata  reserved - to be defined in a future version of MATLAB
                                                                                                           % handles    structure with handles and user data (see GUIDATA)
                                                                                                           delete(findall(0,'type', 'line', '-and', 'Color', 'r'));
                                                                                                           lightY = get(handles.lightVsTime,'YLim');
                                                                                                           tempY  = get(handles.temperatureVsTime,'YLim');
                                                                                                           pressY = get(handles.pressureVsTime,'YLim');
                                                                                                           
                                                                                                           time = get(hObject, 'Value');
                                                                                                           line([time time],lightY,'Color','r', 'Parent', handles.lightVsTime);
                                                                                                           line([time time],pressY,'Color','r', 'Parent', handles.pressureVsTime);
                                                                                                           line([time time],tempY,'Color','r', 'Parent', handles.temperatureVsTime);
                                                                                                           
                                                                                                           % rotate(threeDeeRocket, [1, 0, 0], 10);
                                                                                                           % rotate(h, [1 0 0], deg); % note: second input marks axis of rotation
                                                                                                           % rotate(handles.rocketSim, [1 0 0], 10);
                                                                                                           % get(handles.rocketSim, 'xdata')
                                                                                                           % axes(handles.rocketSim);
                                                                                                           % rocketCoords = cell2mat(varargin(5));
                                                                                                           % X = rocketCoords(1:2, 1:21);
                                                                                                           % Y = rocketCoords(1:2, 22:42);
                                                                                                           % Z = rocketCoords(1:2, 43:63);
                                                                                                           surf(X, Y, Z);
                                                                                                           
                                                                                                           % --- Executes during object creation, after setting all properties.
                                                                                                           function timeSlider_CreateFcn(hObject, eventdata, handles)
                                                                                                           % hObject    handle to timeSlider (see GCBO)
                                                                                                           % eventdata  reserved - to be defined in a future version of MATLAB
                                                                                                           % handles    empty - handles not created until after all CreateFcns called
                                                                                                           
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
                                                                                                                   t = timer('TimerFcn', {@animateOneFrame, handles}, 'Period', (1 / get(handles.animSpeedSlider, 'Value')) + 0.001, 'ExecutionMode', 'fixedRate', 'TasksToExecute', numberOfReadings - get(handles.timeSlider, 'Value'));
                                                                                                                   else
                                                                                                                       t = timer('TimerFcn', {@animateOneFrame, handles}, 'Period', (1 / get(handles.animSpeedSlider, 'Value')) + 0.001, 'ExecutionMode', 'fixedRate', 'TasksToExecute', get(handles.timeSlider, 'Value'));
                                                                                                                       end
                                                                                                                       start(t)
                                                                                                                       
                                                                                                                       % --- Executes on slider movement.
                                                                                                                       function animSpeedSlider_Callback(hObject, eventdata, handles)
                                                                                                                       % hObject    handle to animSpeedSlider (see GCBO)
                                                                                                                       % eventdata  reserved - to be defined in a future version of MATLAB
                                                                                                                       % handles    structure with handles and user data (see GUIDATA)
                                                                                                                       
                                                                                                                       % --- Executes during object creation, after setting all properties.
                                                                                                                       function animSpeedSlider_CreateFcn(hObject, eventdata, handles)
                                                                                                                       % hObject    handle to animSpeedSlider (see GCBO)
                                                                                                                       % eventdata  reserved - to be defined in a future version of MATLAB
                                                                                                                       % handles    empty - handles not created until after all CreateFcns called
                                                                                                                       
                                                                                                                       if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
                                                                                                                           set(hObject,'BackgroundColor',[.9 .9 .9]);
                                                                                                                           end
                                                                                                                           
                                                                                                                           function animateOneFrame(source, event, handles)
                                                                                                                           % Animate a single frame of data.
                                                                                                                           
                                                                                                                           stepValues = get(handles.timeSlider, 'SliderStep');
                                                                                                                           
                                                                                                                           if (get(handles.forwardAnimDirectionButton, 'Value') == 1)
                                                                                                                               set(handles.timeSlider, 'Value', get(handles.timeSlider, 'Value') + 1);
                                                                                                                               else
                                                                                                                                   set(handles.timeSlider, 'Value', get(handles.timeSlider, 'Value') - 1);
                                                                                                                                   end
                                                                                                                                   timeSlider_Callback(handles.timeSlider, event, handles);
                                                                                                                                   
