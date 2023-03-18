function fileName = getFilenameForSample(datafolder, EXPID, SAMPLEID, TASKID)
% returns a string with filename matching the specs- should be unique

%% Checking input variables amd setting defaults
if (~exist('TASKID', 'var'))
    warning('TASKID missing - defaulting to OF');
    TASKID = 'OF';
end

if (~exist('SAMPLEID', 'var'))
    warning('SAMPLEID missing - defaulting to S01');
    TASKID = 'S01';
end

%% initialize everything

% Windows / mac compatibility
if (isunix)
    separator = '/';
else
    separator = '\';
end


fileName = ''; % return variable initialized to empty string
FILETYPESTRING = ['*.xlsx'];
DATATYPESTRING = 'Bonsai_Analysis';

% build the search string
expIDstring = [EXPID '_' TASKID '_' DATATYPESTRING '_' SAMPLEID FILETYPESTRING];
searchString =  [datafolder separator expIDstring];

% try to find the file
dirlist = dir (searchString);
if isempty(dirlist)
    warning(['File ' expIDstring ' was not found on path ' datafolder ]);
else
    fileName = [dirlist.folder separator dirlist.name];
end
end
