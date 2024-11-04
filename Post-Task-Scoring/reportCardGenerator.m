% Report Card Generator
% Written by Kieran J Smith, 1/3/2024 to generate score reports for each SA
% question in the SA assessment

% saves sa_scores to outfile in data_path
% index: sa_scores(subject #, trial #, SA level)
clear;
clc;

outfile = 'allSAscores.mat';

data_path = 'C:\Users\kiera\Documents\Kieran\CU\Research\SA\Subject Data\';
subjString = {'001-0922','002-0923','003-0926','004-1025','005-1110',...
              '006-1111','007-1113','008-1215','009-1219','010-1221',...
              '011-0123','012-0125','013-0126','014-0130','015-0202',...
              '016-0208','017-0222','018-0226','019-0227','020-0229',...
              '021-0309','022-0404','023-0412','024-0416','025-0426',...
              '026-0717','027-0724','028-0729','029-0730','030-0802',...
              '031-0806','032-0807','033-0810','034-0823','035-0916'};
nSubs = length(subjString);
nTrials = 12;
nT = nTrials*ones(1,nSubs);

% Read in subject notes & SA Responses
response_path = "C:\Users\kiera\Documents\Kieran\CU\Research\SA\" + ...
    "Subject Data\Questionnaires\";
response_file = "All_SA_Assessments_Sorted.xlsx";
notes_file = "All_Subject_Data_Notes.xlsx";

% Import notes & responses without matlab warning
id = 'MATLAB:table:ModifiedAndSavedVarnames';
warning('off',id)
response_data = readtable(fullfile(response_path,response_file));
data_notes = readtable(fullfile(response_path,notes_file));
warning('on',id)

sa_scores = nan(nSubs,nTrials,3);

for s = 5:nSubs
    % Find subject notes
    subj_notes = data_notes(data_notes.ID == s,:);

    fprintf('Scoring subject %d / %d.\n', s, nSubs);

    % Count # of trials missing SA
    no_sa_count = 0;

    % Open ReportCard file to write scores to  
    subject_folder = ['Subject-' subjString{s}];
    fid = fopen(fullfile(data_path,subject_folder,'ReportCard.txt'),'w');

    for i = 1:nTrials
        % Print trial # to file
	    fprintf(fid,'Trial %d:\n', i);

        % Compute SA Scores & Print to file
        sa_scores(s,i,:) = SA_Scorer_Post_Test(i, data_path, subject_folder, ...
            response_data, subj_notes, fid, s);

        % if total score is zero, set to NaN (these trials had no SAQ)
        if sum(sa_scores(s,i,:)) == 0
            sa_scores(s,i,:) = NaN;
            no_sa_count = no_sa_count + 1;
        end
    end

    if no_sa_count > 2
        warning(['More than two trials had Total SA score = 0 for ' ...
                'subject %d. Double check sa_assessment.csv and hard' ...
                'code a solution.'],s)
    end
    fclose(fid);
end

filename = fullfile(data_path, 'allSAscores.mat');
save(filename, 'sa_scores')