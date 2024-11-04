function sa_scores = SA_Scorer_Post_Test(trial_num, data_path, ...
    subject_folder, response, subj_notes, fid, s)
% MATB SA Quiz Scorer
%{ 
    Written by Kieran J Smith, kieran.smith@colorado.edu on August 23, 2022 
    as part of a project in conjunction with Draper Labs to score
    objective freeze-probe quizzes designed to assess SA in a modified
    MATB-II task.

    This copy made 1/2/24 to score missed trials after an experiment (after
    data has been moved to my computer, and to track which questions each 
    participant gets correct).
%}

if ~exist('trial_num', 'var') || nargin<1
    fprintf('Using Default Inputs!!!\n')
    trial_num = 1;
    subject_folder = 'Subject-001-0922';
    response_file = "SA Assessment.csv";
    date_time = '09222022';
end

flow_rates = [1000, 500, 800, 400, 500, 500, 700, 800, 800];


% Find trial notes
trial_notes = subj_notes(subj_notes.Trial == trial_num,:);

% pull out subject's SA responses only -- changed 11/3/2024
response = response(response.ID == s,:);

% Trial number in MATB Data (Nth rate data)
mb_notes = subj_notes(subj_notes.MATBData == 1,:);
mb_trial_num = find(mb_notes.Trial == trial_num);

% Trial number in SA Assessment (Nth submission)
sa_trial_num = trial_num;
% if sa_trial_num ~= trial_num
%     sa_trial_num = trial_num;
% end

% if SA Assessment or MATB Data doesn't exist, return nans
if trial_notes.SAAssessment ~= 1 || trial_notes.MATBData == 0
    sa_scores = NaN(1,3);
    fprintf("\tSkipping trial %d.\n", trial_num);
    return
end

% if no SA Assessment exists due to SAQ Settings, return nans
if strcmp(response.RO_BR_FL_4(response.Trial == sa_trial_num), ...
        'None Indicator') || ...
        strcmp(response.RO_BR_FL_4(response.Trial == sa_trial_num), ...
        'WM & SAM Only Indicator')

    sa_scores = NaN(1,3);
    fprintf("\tNo SA Assessment trial %d.\n", trial_num);
    return
end

% If MATB Data for this trial is on a separate file
if isnan(trial_notes.MATBData)
    % Last two trials of s5 on a MATB File
    mb_notes = subj_notes(isnan(subj_notes.MATBData),:);
    mb_trial_num = find(mb_notes.Trial == trial_num);
    subject_folder = fullfile(subject_folder, 'missing-trials');
    fprintf("\tPulling trial %d MATB Data from missing-trials folder.\n", ...
        trial_num);
end

% find time printed on MATB Files
date_time = findDateTime(fullfile(data_path,subject_folder));

% Import generated events file
load(fullfile(data_path,subject_folder,'events.mat'));
events = events2; clear events2

% Import MATB Data
[rate, sysmon, track, comm, resman] = getMATBdata_PostTest( ...
    date_time, fullfile(data_path,subject_folder) ...
    );

% Import Questionnaire Answers - takes a few seconds
%{
1 = yes
2 = no
%}

if exist('response_data.RecipientLastName','var')
    response = removevars(response,{'RecipientLastName', ...
        'RecipientFirstName','RecipientEmail','ExternalReference'});
end

% Score Subtask Answers
% if MATB Data Exists for this round
sa_scores = zeros(1,3);
sa_scores = scoreRESMAN_PostTest( ...
    response(response.Trial == sa_trial_num,:), rate, ...
    resman, sa_scores, flow_rates, mb_trial_num, fid ...
    );
sa_scores = scoreSYSMON_PostTest( ...
    response(response.Trial == sa_trial_num,:), rate, ...
    sysmon, sa_scores, events, mb_trial_num, fid ...
    );
sa_scores = scoreTRACK_PostTest( ...
    response(response.Trial == sa_trial_num,:), rate, ...
    track, sa_scores, events, mb_trial_num, fid ...
    );
sa_scores = scoreCOMM_PostTest( ...
    response(response.Trial == sa_trial_num,:), rate, ...
    comm, track, sa_scores, events, mb_trial_num, fid ...
    );

end