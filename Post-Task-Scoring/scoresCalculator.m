%% scores Calculator
% did you somehow lose the 'Scores-000-0000.txt' file for a participant?
% run this.
% currently adds all QIDs in. Just copy into word, replace all:
% "QID*SA Scores" with "SA Scores" (Use wildcards checked)

%% Set these
subjString = '017-0222';
data_path = 'C:\Users\kiera\Documents\Kieran\CU\Research\SA\Subject Data\';
subject_folder = ['Subject-' subjString];
date_time = findDateTime(fullfile(data_path,subject_folder));

%% These probably won't change
output_file = ['Scores-', subjString, '.txt'];
nTrials = 12;
response_file = "SA Assessment.csv";

%% Run This
fid = fopen(fullfile(data_path,subject_folder,output_file),'w');
subj_sa_scores = nan(nTrials,3);
subj_matb_scores = nan(nTrials,1);
writeQIDs = false;

for i = 1:nTrials
    fprintf(fid,'Trial %d Scores:\n', i);
    subj_sa_scores(i,:) = SA_Scorer_Post_Test(i,data_path, subject_folder,response_file, ...
        date_time, fid, nTrials, writeQIDs);
    subj_matb_scores(i) = MATB_Scorer_PostTest(i, fullfile(data_path,subject_folder), date_time);
    fprintf(fid,'SA Scores: %0.1f, %0.1f, %0.1f; Total: %0.1f\n', subj_sa_scores(i,1), subj_sa_scores(i,2), subj_sa_scores(i,3), sum(subj_sa_scores(i,:)));
    fprintf(fid,'MB Score: %f\n', subj_matb_scores(i));
    fprintf(fid,'Total Compensation: ?\n');
end
fclose(fid);

%% fxns
function date_time = findDateTime(subject_folder)
    x = dir(subject_folder);
    for k=1:length(x)
        if strfind(x(k).name, 'RATE')
            temp = extractBetween(x(k).name, 'RATE_','.txt');
            break
        end
    end
    date_time = temp{1};
end