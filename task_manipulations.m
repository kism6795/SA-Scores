%% Need to write code to analyze MATB performance measures and SA scores across the different task manipulations
% I thought I did this before...
% Currently I have SA scores in a sa_scores(subj, trial, level) format.
% I have MATB Scores in a matb_scores(subj, trial) format
% I need trial_parameters in a (subj, trial) format

violinpath = 'C:\Users\kiera\Documents\Kieran\CU\Research\SA\Analysis\Plotting\';

%% load SA & MATB scores
load(['C:\Users\kiera\Documents\Kieran\CU\' ...
    'Research\SA\Subject Data\adj_sa_scores.mat'])
load(['C:\Users\kiera\Documents\Kieran\CU\' ...
    'Research\SA\Subject Data\all_matb_scores.mat'])
load(['C:\Users\kiera\Documents\Kieran\CU\' ...
    'Research\SA\Subject Data\all_matb_scores.mat'])

load(["C:\Users\kiera\Documents\Kieran\CU\Research\SA\Subject Data\" + ...
    "z_adj_MATB_sub_scores_5-21_.mat"]);

adj_sub_scores = z_adj_sub_scores;

%% Load trial parameters for each subject
base_folder = ['C:\Users\kiera\Documents\Kieran\CU\Research\SA\' ...
               'Subject Data\Subject-'];
subjString = {'001-0922','002-0923','003-0926','004-1025','005-1110',...
              '006-1111','007-1113','008-1215','009-1219','010-1221',...
              '011-0123','012-0125','013-0126','014-0130','015-0202',...
              '016-0208','017-0222','018-0226','019-0227','020-0229',...
              '021-0309'};
nSubs = length(subjString);
nTrials = 12;

categories = nan(nSubs,nTrials);
motivation = nan(nSubs,nTrials);
memory_load = nan(nSubs,nTrials);

for s = 5:nSubs
    data_path = [base_folder subjString{s}];
    temp = load(fullfile(data_path,'trial_params.mat'));
    subj_trial_params = temp.trial_params;
    task_load(s,:) = subj_trial_params.taskLoad';
    motivation(s,:) = subj_trial_params.motivation';
    memory_load(s,:) = subj_trial_params.memoryLoad';
end

save('task_load.mat','task_load');
save('motivation.mat','motivation');
save('memory_load.mat','memory_load');

%% Compare SA Across manipulations
adj_sa_scores(:,:,4) = adj_sa_scores(:,:,1)...
                       + adj_sa_scores(:,:,2)...
                       + adj_sa_scores(:,:,3);
adj_sa_scores(:,:,5) = matb_scores;

% contains violinplot
addpath(violinpath) 

% compile manipulations
manipulations = {task_load, motivation, memory_load};
x_labels = {'Task Load','Motivation','Memory Load'};

% iterate through different 'y' variables / outcomes
for i = 1:5
    sa_scores_trim = adj_sa_scores(:,:,i);

    % Iterate through different manipulations and plot differences
    for j = 1:3
        categories = manipulations{j};
        sa_scores_trim(sa_scores_trim==0) = nan;
        avg_subj_sa_score_low = nan(1,length(subjString));
        avg_subj_sa_score_hi = nan(1,length(subjString));
        
        % average a subjects scores
        for s = 5:length(subjString)
            avg_subj_sa_score_low(s) = mean( ...
                sa_scores_trim(s,(categories(s,:)==0)), ...
                'omitmissing' ...
                );        
            avg_subj_sa_score_hi(s) = mean( ...
                sa_scores_trim(s,(categories(s,:)==1)), ...
                'omitmissing' ...
                );
        end
        data1 = avg_subj_sa_score_low(~isnan(avg_subj_sa_score_low))';
        data2 = avg_subj_sa_score_hi(~isnan(avg_subj_sa_score_low))';
        labels = {['Low ' x_labels{j}],['High ' x_labels{j}]};
        fig1 = specific_plot(data1, data2, labels, p);
        title(['SA scores between ' x_labels{j} ' levels']);
        ylabel(sprintf('Average SA %d Score (per subj)',i));
        xlabel('Trial ##')
        if i==4 % For total SA
            ylabel('Average Total Score (per subj)');
        end
        if i==5 % For MATB Performance
            ylabel('Average Performance (per subj)');
            title(['MATB Performance between ' x_labels{j} ' levels']);
        end
        xlabel([x_labels{j} ' Level'])
    end
    
    % determine effects across trials
    % have to average across each trial instead of across each participant
    labels = cellfun(@(x) num2str(x), ...
                     num2cell(1:12), ...
                     'UniformOutput', false);
    figure; 
    vp = violinplot(sa_scores_trim, labels,...
        'MarkerSize', 0.1, ...
        'ViolinColor',[0.5, 0.5, 0.5]); hold on
    title(['SA scores across Trials']);
    ylabel(sprintf('Average SA %d Score (per subj)',i));
    if i==4 % For total SA
        ylabel('Average Total Score (per subj)');
    end
    if i==5 % For MATB Performance
        ylabel('Average Performance (per subj)');
        title('MATB Performance across trials');
    end
end


rmpath(violinpath);


%% Generate linear model of each outcome & all manipulations
subj_num = (repelem([1:nSubs]',nTrials)); %
trial_num = repmat([1:12]',nSubs,1);
motivation_labels = reshape(motivation',nSubs*nTrials,1);
memory_load_labels = reshape(memory_load',nSubs*nTrials,1);
task_load_labels = reshape(task_load',nSubs*nTrials,1);
sa_scores = reshape(adj_sa_scores(:,:,4),nSubs*nTrials,1);
matb_scores = reshape(z_adj_sub_scores(:,5,:),nSubs*nTrials,1);
% comment out to run matb_scores
data_table = table(subj_num,trial_num,motivation_labels, ...
                   memory_load_labels,task_load_labels, sa_scores);

% % comment out to run sa_scores
% data_table = table(subj_num,trial_num,motivation_labels, ...
%                    memory_load_labels,task_load_labels, matb_scores);
data_table = data_table(49:end,:);

% remove '_labels'
for i = 1:width(data_table)
    data_table.Properties.VariableNames{i} = strrep( ...
        data_table.Properties.VariableNames{i}, ...
        '_labels','' ...
        );
end


mdl = fitlm(data_table,'ResponseVar','sa_scores',...
            'PredictorVars',{'motivation','memory_load', ...
                             'task_load','trial_num', ...
                             'subj_num'},...
            'CategoricalVar', 'subj_num')


mdl = fitlm(data_table,'ResponseVar','sa_scores',...
            'PredictorVars',{'motivation','memory_load', ...
                             'task_load','trial_num', ...
                             'subj_num'},...
           'CategoricalVars',{'motivation', ...
                               'memory_load', ...
                               'task_load', ...
                               'subj_num'})

mdl = fitlm(data_table,'ResponseVar','sa_scores',...
            'PredictorVars',{'motivation','memory_load', ...
                             'task_load','trial_num', ...
                             'subj_num'})

%% Function to plot it all
function fig = specific_plot(data1, data2, labels, p)

    if ~kstest(data1-data2) % if the differences are normally distributed
        [h, p] = ttest2(data1,data2);
        str = sprintf('2-Sample t-Test: ');
    else % if data not normally distributed
        [p, h] = signrank(data1,data2);
        str = sprintf('Wilcoxon SR Test: ');
    end


    fig = figure;
    C = [188 39 49;
        129 190 161;
        64 134 160;
        56 54 97;
        107 78 113;
        203 151 0;
        34 34 34;
        250 245 252]/255; % CU Colors
    
    C = repmat(C,3,1);
    markers = repelem({'o','square','^'},6);

    % plot violins with tiny datapoints
    vp = violinplot([data1, data2], labels, ...
            'MarkerSize', 0.1, ...
            'ViolinColor',[0.5, 0.5, 0.5]); hold on   

    % plot datapoints per subject with connecting lines
    for k = 1:length(data1)
        temp = (rand-0.5)/3;
        plot([1+temp 2+temp], [data1(k), data2(k)], ...
             ['-' markers{k}], ...
             'MarkerFaceColor',C(k,:), ...
             'Color',[0.2, 0.2, 0.2]); 
        hold on;
    end  

    if p < 0.01
        str = sprintf('%sp<0.01',str);
    else
        str = sprintf('%sp=%0.2f',str,p);
    end
    annotation('textbox',[0.35,0.15,0.3,0.07],'String',str);
end