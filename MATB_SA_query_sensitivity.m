%% MATB Question SA Sensitivity Analysis
% For each question asked, participants either got the answer correct (1)
% or incorrect (0) 
% I want to make a double violin plot of trial MATB scores in each of these
% conditions. 

% I have a cell array of tables for each {subj,trial} combination. Each
% table contains all QIDs asked and correctness for each
data_folder = 'C:\Users\kiera\Documents\Kieran\CU\Research\SA\Subject Data';
load(fullfile(data_folder,'reportCards.mat')); % comes from report_card_reader.m in this folder
load(['C:\Users\kiera\Documents\Kieran\CU\Research\SA\Analysis\' ...
    'MATB_Scores\adj_MATB_sub_scores.mat']);
load(["C:\Users\kiera\Documents\Kieran\CU\Research\SA\Subject Data\" + ...
    "z_adj_MATB_sub_scores_5-21_.mat"]);

adj_sub_scores = z_adj_sub_scores;

violinpath = 'C:\Users\kiera\Documents\Kieran\CU\Research\SA\Analysis\Plotting\';

% create a struct? so that qid_vs_matb.QID1 contains (0): a vector of matb
% scores when QID1 was answered incorreclty and (1): a vector of matb
% scores when QID1 was answered correctly
qid_vs_matb = struct();

nSubs = 21; 
nTrials = 12;

for s = 5:nSubs
    for t = 1:nTrials
        for i = 1:height(reportCards{s,t})
            if reportCards{s,t}.QID(i) > 0
                qid = sprintf('QID%d',reportCards{s,t}.QID(i));
                if reportCards{s,t}.correct(i)
                    crct = 'y';
                else
                    crct = 'n';
                end
                % append if it exists
                % if exist('qid_vs_matb.(qid).(crct)','var')
                %     disp('this works');
                if isfield(qid_vs_matb,qid) && isfield(qid_vs_matb.(qid),crct)   
                    qid_vs_matb.(qid).(crct) = [qid_vs_matb.(qid).(crct) ...
                                                adj_sub_scores(t,5,s)];
                else
                    qid_vs_matb.(qid).(crct) = adj_sub_scores(t,5,s);
                end
            end
        end
    end
end

%% Plot significant results
C = [188 39 49;
    129 190 161;
    64 134 160;
    56 54 97;
    107 78 113;
    203 151 0;
    34 34 34;
    250 245 252]/255; % CU Colors

addpath(violinpath);
qids = fieldnames(qid_vs_matb);
nQID = length(qids);
diff = nan(1,nQID);
for q = 1:nQID
    if isfield(qid_vs_matb.(qids{q}),'n') ...
        && isfield(qid_vs_matb.(qids{q}),'y')
        
        % pad arrays with nans to be equal size (for violin plot)
        correct = qid_vs_matb.(qids{q}).y;
        incorrect = qid_vs_matb.(qids{q}).n;
        if length(incorrect)<length(correct)
            incorrect = padarray(incorrect, ...
                                 [0 length(correct)-length(incorrect)],...
                                 nan,'post');
        end
        if length(correct)<length(incorrect)
            correct = padarray(correct, ...
                                 [0 length(incorrect)-length(correct)],...
                                 nan,'post');
        end

        % run ranksum test
        [p(q),h(q)] = ranksum(correct, incorrect);
        if ~isnan(h(q)) &&  q == 19 % h(q) % 
            figure;
            vp = violinplot([correct' incorrect']); hold on;
            for c=1:length(vp)
                vp(c).ViolinColor = {C(2,:)};
            end
            title(qids{q})
            xlabel('# of participants');
            xticklabels({'correct','incorrect'});
            ylabel('MATB Score');
        end
        diff(q) = median(incorrect,'omitmissing') ... 
                  - median(correct,'omitmissing');
    end
end

figure;
vp = violinplot(diff); hold on;
for c=1:length(vp)
    vp(c).ViolinColor = {C(1,:)};
end
yline(0);
ylabel('additional mistakes when incorrect SA')
title('each point represents the difference for one QID')
rmpath(violinpath);