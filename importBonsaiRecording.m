function data = importBonsaiRecording(fileName)
% read filename, check if it exists, if not, return empty;
% if file exists, open it and return the contents as a table

%% Checking input variables amd setting defaults
if (~exist('fileName', 'var'))
    warning('fileName missing');
    data = [];
    return
end

%initialize local variables:

% bonsai datafile structure: 
% column names are FRAME, X, Y, Displacement, nFrames?, Timestamp, interval, inst speed, locomoting, instSpeedLocooting, center 

XCOL = 2; YCOL = 3; TIMEINTCOL = 7; CENTERCOL = 11; 

% xlsread returns the FIRST sheet in excel workbook, change the value if you want some other sheet 


bonsaiDataTable = readmatrix(fileName);
% check if the data file is of correct shape, should have 11 columns
[nRows, nCols] = size(bonsaiDataTable);
if (nCols ~= 11)
    warning('Bonsai file structure invalid');
    data = [];
    return
end
    
    
FRAMERATE = 1 / bonsaiDataTable(1, TIMEINTCOL); 
coordData = bonsaiDataTable(:, XCOL:YCOL);

% pack up results
data.coordData = coordData;
data.FRAMERATE = FRAMERATE; 
data.isCenter = bonsaiDataTable(:, CENTERCOL);
data.fileName = fileName;


end

