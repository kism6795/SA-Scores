%% Code to adjust SA Scores for difficulty
% Kieran J Smith, 1/2/2024

% Requires:
% 1. running reportCardGenerator (in Post-Task-Scoring Folder)
% 2. running report_card_reader.m code to get percentage correct for each
%    question (in this folder)
% 3. adjusting nSubs number below
% Requires downloading data manually from qualtrics, selecting 'More
% Options', and clicking "Export viewing order data for randomized surveys"

% Generates sa_scores2.mat1/
%           allSAscores.mat
% in this folder (\SA\Analysis\SA-Scores)

% Generates raw_sa_scores.mat
%           adj_sa_scores.mat
% in data_path:

data_path = 'C:\Users\kiera\Documents\Kieran\CU\Research\SA\Subject Data';
load(fullfile(data_path, 'reportCards.mat')) % reportCards
load(fullfile(data_path, 'allSAscores.mat')) % sa_scores
load(fullfile(data_path, 'QIDs.mat')) % QIDs

QIDs.adjustment = 1-QIDs.prctCorrect;
sa_scores2 = 0*(sa_scores);
nSubs = 35;
nTrials = 12;

%% Calculate Adjusted Scores
for s = 5:nSubs
    for j = 1:nTrials
        for k = 1:18
            level = reportCards{s,j}.level(k); % find which SA Level QID(k) corresponds to
            if level>0 % if data exists here
                % find whether subject i on trial j got question k correct
                correctness = reportCards{s,j}.correct(k); 
                if correctness == 1
                    % find the correct adjustment for each QID(k)
                    adjustment = QIDs.adjustment( ...
                        QIDs.QID == reportCards{s,j}.QID(k) ...
                        ); 
                elseif correctness == 0
                    % find the correct adjustment for each QID(k)
                    adjustment = -QIDs.prctCorrect( ...
                        QIDs.QID == reportCards{s,j}.QID(k) ...
                        ); 
                 elseif correctness == -1
                    % when no report card exists
                    adjustment = NaN;
                end
                % add adjusted score to sa_scores
                sa_scores2(s,j,level) = sa_scores2(s,j,level) + adjustment; 
            end
        end
    end
end

% save('sa_scores2.mat','sa_scores2'); % use 'adj_sa_scores.mat' instead
% save('allSAscores.mat','sa_scores'); % use 'raw_sa_scores.mat' instead

%% Set zeros to nans
raw_sa_scores = sa_scores;
adj_sa_scores = sa_scores2;
% for s = 1:nSubs
%     no_sa_count = 0; % how many no-sa-assessments per subject
%     for t = 1:nTrials
%         sat = sum(sa_scores(s,t,:),'omitmissing');
% 
%         if sat == 0 % if no SA Assessment is presented on this trial
%             no_sa_count = no_sa_count + 1;
%             if no_sa_count > 2 && s>5 && s~=10 && s~=13 && s~=24 && s~=25
%                 warning('Subject %d appears to have %d trials w/o an SA Asssessment',s,no_sa_count);
%             end
%             % warning('Subject %d appears to have %d trials w/o an SA Asssessment',s,no_sa_count);
%             for l = 1:3
%                 raw_sa_scores(s,t,l) = NaN;
%                 adj_sa_scores(s,t,l) = NaN;
%             end
%         end
%     end
% end

save(fullfile(data_path,'raw_sa_scores.mat'),'raw_sa_scores');
save(fullfile(data_path,'adj_sa_scores.mat'),'adj_sa_scores')

%% Plot it
scatter(raw_sa_scores(raw_sa_scores~=-1), adj_sa_scores(raw_sa_scores~=-1), 100, 'o','filled', 'MarkerFaceAlpha',0.3);
xlabel('Raw SA Score (each level, 0-6)');
ylabel('Adjusted SA Score');
xlim([0 6])
ylim([-4.5 3])
grid on;
[r,p] = corr(raw_sa_scores(~isnan(raw_sa_scores)), ...
    adj_sa_scores(~isnan(raw_sa_scores)),'type','Spearman');
if p<0.01   
    txt = sprintf('r = %0.2f\np < 0.01',r);
else
    txt = sprintf('r = %0.2f\np = %0.2f',r,p);
end
annotation('textbox', [0.25, 0.5, 0.1, 0.1], 'String', txt,'BackgroundColor','w')
hold on;

X = [ones(length(raw_sa_scores(raw_sa_scores~=-1)),1) raw_sa_scores(raw_sa_scores~=-1)];
b = X\adj_sa_scores(raw_sa_scores~=-1);
xx = 0:6;
yy = xx*b(2)+b(1);
plot(xx,yy,'--k');


% Test for Normality
figure;
[h,p,ksstat,cv] = kstest(raw_sa_scores(raw_sa_scores~=-1));
histogram(raw_sa_scores(raw_sa_scores~=-1));
title('Raw SA Score');
xlabel('Raw SA Score (each level, 0-6)');
ylabel('# Occurrences');
if p<0.01   
    txt = sprintf('K = %0.2f\np < 0.01',ksstat);
else
    txt = sprintf('K = %0.2f\np = %0.2f',ksstat,p);
end
annotation('textbox', [0.25, 0.5, 0.1, 0.1], 'String', txt,'BackgroundColor','w')
grid on;

figure;
[h,p,ksstat,cv] = kstest(adj_sa_scores(raw_sa_scores~=-1));
histogram(adj_sa_scores(raw_sa_scores~=-1));
title('Adjusted SA Score');
xlabel('Adjusted Score');
ylabel('# Occurrences')
if p<0.01   
    txt = sprintf('K = %0.2f\np < 0.01',ksstat);
else
    txt = sprintf('K = %0.2f\np = %0.2f',ksstat,p);
end
annotation('textbox', [0.25, 0.5, 0.1, 0.1], 'String', txt,'BackgroundColor','w')
grid on;


%% Adjust trial Numbers
% addpath('C:\Users\kiera\Documents\Kieran\CU\Research\SA\Analysis\psychophys\AnalysisPipeline');
[adj_sa_trial_scores, raw_sa_trial_scores] = adjust_SA_trial_numbers( ...
    raw_sa_scores, adj_sa_scores, nSubs, data_path ...
        );
% rmpath('C:\Users\kiera\Documents\Kieran\CU\Research\SA\Analysis\psychophys\AnalysisPipeline');
