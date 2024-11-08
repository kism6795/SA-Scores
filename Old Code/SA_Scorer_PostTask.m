%% MATB SA Quiz Scorer
%{ 
    Written by Kieran J Smith, kieran.smith@colorado.edu on February 15th, 2023 
    as part of a project in conjunction with Draper Labs to score
    objective freeze-probe quizzes designed to assess SA in a modified
    MATB-II task.

    Specifically designed for the post-testing calculation of SA scores on a
    given trial in the event that scores were lost for any reason during
    testing
%}
%clear; clc;
s = 3;
base_folder = 'C:\Users\kiera\OneDrive\Documents\Kieran\CU\Research\SA\';
date_time = '09231534';
data_folder = 'Subject Data';
subject_folder = {'Subject-001-0922','Subject-002-0923','Subject-003-0926'};
subject_folder = subject_folder{s};
response_file = 'SA Assessment1.csv';
flow_rates = [1000, 500, 800, 400, 500, 500, 700, 800, 800];
trial_num = 9;
nTrials = 12;

data_path = fullfile(base_folder,data_folder,subject_folder);

fid = fopen(fullfile(data_path,'report-card.txt'),'wt');



%% Import generated XML file
load(fullfile(base_folder,data_folder,subject_folder,'events.mat'));
events = events2; clear events2
for trial_num = 1:nTrials

    %% Import MATB Data
    [rate_data, sysmon_data, track_data, comm_data, resman_data] = getMATBdata_PostTask(data_path);
    
    %% downselect data preceding the freeze probe
    probe_time = rate_data.times(trial_num,:);
    probe_time = minsec2sec(probe_time);
    sysmon_data = sysmon_data(minsec2sec(sysmon_data.times)<=probe_time(1),:);
    track_data = track_data(minsec2sec(track_data.times)<=probe_time(1),:);
    comm_data = comm_data(minsec2sec(comm_data.times)<=probe_time(1),:);
    resman_data = resman_data(minsec2sec(resman_data.times)<=probe_time(1),:);
    
    %% Import Questionnaire Answers - takes a few seconds
    %{
    1 = yes
    2 = no
    %}
    nQuestions = 91;
    QIDvars = cell(1,nQuestions);
    for i = 1:nQuestions
        QIDvars{i} = sprintf('QID%d',i+1);
    end
    
    % question IDs that don't exist (-1)
    QIDvars(75) = [];
    QIDvars(73) = [];
    QIDvars(44) = [];
    QIDvars(17) = [];
    QIDvars(16) = [];
    QIDvars(15) = [];
    QIDvars(14) = [];
    QIDvars(7) = [];
    
    % setting import options because MATLAB changes readtable
    opts = detectImportOptions(fullfile(base_folder,data_folder,subject_folder,response_file));
    opts = setvartype(opts,QIDvars,'char');
    
    response_data = readtable(fullfile(base_folder,data_folder,subject_folder,response_file),opts);
    
    if exist('response_data.RecipientLastName','var')
        response_data = removevars(response_data,{'RecipientLastName','RecipientFirstName','RecipientEmail','ExternalReference'});
    end
    
    %% filter out ONLY this subjects responses
    response_data = response_data(end-11:end,:);
    
    QIDs = [5 9 19 20 24 37 42 53 54 59 63 71 83 86 87 88 91 92];
    
    %% Score SA Answers
    fprintf(fid,'Trial Number %d:\n', trial_num);
    sa_scores = zeros(nTrials,3);
    sa_scores = scoreRESMAN(response_data, rate_data, resman_data, sa_scores, flow_rates, trial_num, fid); % updated with fid
    sa_scores = scoreSYSMON(response_data, rate_data, sysmon_data, sa_scores, events, trial_num, fid);
    sa_scores = scoreTRACK(response_data, rate_data, track_data, sa_scores, events, trial_num, fid);
    sa_scores = scoreCOMM(response_data, rate_data, comm_data, sa_scores, events, trial_num, fid);
    
    
    %% quick analysis
    sa_score_totals = sum(sa_scores')';
    
    %trial_diff = trial_params.taskLoad(1:7)+trial_params.memoryLoad(1:7);
    %scatter(trial_diff,sa_score_totals)
    
    fprintf('SA Scores [Trial %d]:\n %d %d %d %d\n', trial_num, sa_scores(trial_num,1), ...
        sa_scores(trial_num,2), sa_scores(trial_num,3),sa_score_totals(trial_num))
end
fclose(fid);