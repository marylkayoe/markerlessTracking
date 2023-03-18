function [distTravelled, locoTime, meanLocoSpeed, maxSpeed,centerTime] = analyzeBonsaiOFrecording(dataFolder, EXPID, SAMPLEID, TASKID)

MAKEPLOTS = 1;
XYSCALE = 1;
LOCOTHRESHOLD = 40;
BORDERLIMIT = 0.15; %region from borders that's called border
fileName = getFilenameForSample(dataFolder, EXPID, SAMPLEID, TASKID);

trialData = importBonsaiRecording(fileName);
nFrames = length(trialData.coordData);
coordData = trialData.coordData;
FRAMERATE = trialData.FRAMERATE;

[distTravelled, locoTime, meanLocoSpeed, maxSpeed,centerTime, centerFrames, speedArray] = extractMeasuresFromOFtrial(trialData, LOCOTHRESHOLD, BORDERLIMIT);

if MAKEPLOTS
    f = plotOpenFieldTrial(coordData,speedArray, centerFrames, BORDERLIMIT, FRAMERATE, XYSCALE);
    
    figure; hold on;
    xAx = makexAxisFromFrames(nFrames, FRAMERATE);
    plot(xAx, speedArray, 'LineWidth', 2);
    xlabel('time (s)');
    ylabel ('speed (mm/s)');
    line([0, max(xAx)], [LOCOTHRESHOLD LOCOTHRESHOLD], 'LineStyle','--', 'LineWidth',2, 'Color', 'r');
    legend({'Speed' 'LOCOTHRESHOLD'});
    title ('speed in trial');
end
end

