function sa_scores = SA_Scorer_Post_Test(trial_num,data_path, subject_folder,response_file, date_time, fid, nTrials)
%% MATB SA Quiz Scorer
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

%% Import generated events file
load(fullfile(data_path,subject_folder,'events.mat'));
events = events2; clear events2

%% Import MATB Data
[rate_data, sysmon_data, track_data, comm_data, resman_data] = getMATBdata_PostTest(date_time, fullfile(data_path,subject_folder));

%% Import Questionnaire Answers - takes a few seconds
%{
1 = yes
2 = no
%}

% silently read table
id = 'MATLAB:table:ModifiedAndSavedVarnames';
warning('off',id)
response_data = readtable(fullfile(data_path,subject_folder,response_file));
warning('on',id)

if exist('response_data.RecipientLastName','var')
    response_data = removevars(response_data,{'RecipientLastName','RecipientFirstName','RecipientEmail','ExternalReference'});
end

response_data = response_data(end-nTrials+1:end,:); % pull out last nTrials only

%% Score RESMAN Answers
sa_scores = zeros(1,3);
sa_scores = scoreRESMAN_PostTest(response_data(trial_num,:), rate_data, resman_data, sa_scores, flow_rates, trial_num, fid);
sa_scores = scoreSYSMON_PostTest(response_data(trial_num,:), rate_data, sysmon_data, sa_scores, events, trial_num, fid);
sa_scores = scoreTRACK_PostTest(response_data(trial_num,:), rate_data, track_data, sa_scores, events, trial_num, fid);
sa_scores = scoreCOMM_PostTest(response_data(trial_num,:), rate_data, comm_data, track_data, sa_scores, events, trial_num, fid);

%% pull out trial of interest, sorry this is so inefficient
sa_score = sum(sa_scores);

end