function varargout = TugasWP(varargin)
%TUGASWP MATLAB code file for TugasWP.fig
%      TUGASWP, by itself, creates a new TUGASWP or raises the existing
%      singleton*.
%
%      H = TUGASWP returns the handle to a new TUGASWP or the handle to
%      the existing singleton*.
%
%      TUGASWP('Property','Value',...) creates a new TUGASWP using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to TugasWP_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      TUGASWP('CALLBACK') and TUGASWP('CALLBACK',hObject,...) call the
%      local function named CALLBACK in TUGASWP.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TugasWP

% Last Modified by GUIDE v2.5 24-Apr-2022 22:34:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TugasWP_OpeningFcn, ...
                   'gui_OutputFcn',  @TugasWP_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before TugasWP is made visible.
function TugasWP_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for TugasWP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TugasWP wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TugasWP_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes when entered data in editable cell(s) in tabeldata.
function tabeldata_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to tabeldata (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in tabeldata.
function tabeldata_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tabeldata (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Tampilkan.
function Tampilkan_Callback(hObject, eventdata, handles)
% hObject    handle to Tampilkan (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('TugasWP.csv');
opts.SelectedVariableNames = (2:6);
data = readmatrix('TugasWP.csv',opts);
set(handles.tabeldata,'data', data);

% --- Executes on button press in Proses.
function Proses_Callback(hObject, eventdata, handles)
% hObject    handle to Proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('TugasWP.csv');
opts.SelectedVariableNames = (2:6);
data = readmatrix('TugasWP.csv',opts);

%Atribut tiap-tiap kriteria, dimana nilai 1 = benefit, dan 0 = cost
krt = [1,0,1,1,1];

%Nilai bobot tiap kriteria
wght = [5,4,3,2,3];

%Hitung nilai jumlah row dan column dari data
[m, n]=size (data);

%Hitung nilai jumlah row dan column dari data
[m, n]=size (data);

%Membagi bobot per kriteria dengan jumlah total seluruh bobot
wght= round(wght./sum(wght),2);

%Kali weight cost dengan -1 agar berubah jadi minus
for j=1:n
    if krt(j)==0, wght(j)=-1*wght(j);
    end
end

%Melakukan perhitungan vektor(S) per baris (alternatif)
for i=1:m
    S(i)=prod(data(i,:).^wght);
end

%tahapan ketiga, proses perangkingan
V= S/sum(S);

[sortedDist, index] = sort(V,'descend');
result = sortedDist.';
idx = index.';
ss = [result idx];
disp(ss);

set(handles.tabeldata1,'data',ss);