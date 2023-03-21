function [distTravelled, locoTime, meanLocoSpeed, maxSpeed,centerTime, centerFrames, speedArray] = extractMeasuresFromOFtrial(trialData,LOCOTHRESHOLD, BORDERLIMIT)
%Extract and return:
% distance travelled
% mean speed
% max speed
% time spent locomoting
% time spent away from walls
% speed trace

%% Checking input variables amd setting defaults
if isempty(trialData)
    warning('empty trial data!');

end

if (~exist('LOCOTHRESHOLD', 'var'))
    LOCOTHRESHOLD = 40;
    return
end
if (~exist('BORDERLIMIT', 'var'))
    BORDERLIMIT = 0.15;
    return
end


%% initialize variables


distTravelled = nan;
meanLocoSpeed = nan;
maxSpeed = nan;
locoTime = nan;
centerTime = nan;
speedArray = [];

FRAMERATE = trialData.FRAMERATE;
coordData = trialData.coordData;
nFRAMES = length(coordData);



speedArray = getVelocityFromTraj(coordData, 1, FRAMERATE, 1, FRAMERATE);
displacement = cumsum(speedArray(1:floor(FRAMERATE):end));
distTravelled = displacement(end-1);
maxSpeed = max(speedArray);

%how much the mice are locomoting

locoFrames = find(speedArray>LOCOTHRESHOLD);
nLocoFrames = length(locoFrames); %how many frames are over threshold
locoTime = frames2sec(nLocoFrames, FRAMERATE);
meanLocoSpeed = mean(speedArray(locoFrames), 'omitnan');

% how much time they spend in the center
% define "borders" the 20% closest to borders
% so, centermask will be 20-80% of the max movement of the animal

xMovementRange = range(coordData(:, 1));
yMovementRange = range(coordData(:, 2));


nearLeftFrames = find(coordData(:, 1) < (min(coordData(:, 1))+xMovementRange*BORDERLIMIT));
nearRightFrames = find(coordData(:, 1) > (max(coordData(:, 1))-xMovementRange*BORDERLIMIT));
nearLRframes = union (nearLeftFrames, nearRightFrames);
nearTopFrames = find(coordData(:, 2) < (min(coordData(:, 2))+yMovementRange*BORDERLIMIT));
nearBottomFrames = find(coordData(:, 2) > (max(coordData(:, 2))-yMovementRange*BORDERLIMIT));
nearTBframes = union (nearTopFrames, nearBottomFrames);
borderFrames = union(nearLRframes, nearTBframes);


% pack results

centerFrames = setdiff(1:nFRAMES, borderFrames);
centerTime = frames2sec(length(centerFrames), FRAMERATE);




