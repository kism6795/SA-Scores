%% compile MATB Scores

% set data locations
subjString = {'001-0922','002-0923','003-0926','004-1025','005-1110',...
              '006-1111','007-1113','008-1215','009-1219','010-1221',...
              '011-0123','012-0125','013-0126','014-0130','015-0202',...
              '016-0208','017-0222','018-0226','019-0227','020-0229',...
              '021-0309','022-0404','023-0412','024-0416','025-0426'};
dataPath = 'C:\Users\kiera\Documents\Kieran\CU\Research\SA\Subject Data\';

% set parameters
nSubs = length(subjString);
nTrials = 12;
matb_scores = zeros(nSubs,nTrials);

% calculate scores by participant
for s = 5:nSubs
    % Find MATB RATE file (with TLX rating info)
    subjFolder = fullfile(dataPath,['Subject-' subjString{s}]);
    RATEregex = fullfile(subjFolder,"RATE_*.txt");
    RATEfile = dir(RATEregex);

    % disambiguate between multiple files (cases where task crashed, etc.)
    if length(RATEfile)>2.
        warning('More than one TLX PC response found. Using the first one: %s\n',...
            TLXfilename(1).name)
        date_time = extractBetween(RATEfile(1).name,'RATE_','.txt');
        date_time = date_time{:};
    elseif isempty(TLXfilename)
        error('No TLX responses found for subject %d. Ensure all files are in correct location.',s)
    else
        date_time = extractBetween(RATEfile.name,'RATE_','.txt');
        date_time = date_time{:};
    end
    
    % score each trial one by one
    for i = 1:nTrials
        try
            matb_scores(s,i) = MATB_Scorer_PostTest(i, subjFolder, date_time);
        catch e
            warning('MATB_Scorer_PostTest gave the following error:\n%s\n%s\n',e.identifier,e.message);
            warning('Setting MATB score to 0 for subject %d, trial %d',s,i);
            matb_scores(s,i) = 0;
        end
    end
end

%% Save results
save(fullfile(dataPath,'all_matb_scores.mat'),'matb_scores');