%% Code to compare SA Scores & MATB Performance
data_path = 'C:\Users\kiera\Documents\Kieran\CU\Research\SA\Subject Data\';
subjString = {'001-0922','002-0923','003-0926','004-1025','005-1110',...
              '006-1111','007-1113','008-1215','009-1219','010-1221',...
              '011-0123','012-0125','013-0126','014-0130','015-0202',...
              '016-0208','017-0222','018-0226','019-0227','020-0229',...
              '021-0309','022-0404','023-0412','024-0416','025-0426',...
              '026-0717','027-0724','028-0729','029-0730','030-0802',...
              '031-0806','032-0807','033-0810','034-0823','035-0916'};
nTrials = 12;
nSubs = length(subjString);

% Load Adjusted SA Scores (adj_sa_scores)
% load('adj_sa_scores.mat')
temp = load(fullfile(data_path,'adj_sa_trial_scores.mat'));
adj_sa_trial_scores = temp.adj_sa_trial_scores;

% Load raw_sa_scores
temp = load(fullfile(data_path,'raw_sa_trial_scores.mat'));
raw_sa_trial_scores = temp.raw_sa_trial_scores;
% sa_scores = load(['C:\Users\kiera\Documents\Kieran\CU\Research\SA\' ...
%                   'Subject Data\allSAscores.mat']);

% Load z-score adjusted matb scores
temp = load("C:\Users\kiera\Documents\Kieran\CU\Research\SA\Subject Data\" + ...
      sprintf("z_adj_MATB_sub_scores_5-%d.mat",nSubs));
z_adj_sub_scores = temp.z_adj_sub_scores;

%% Convert sa score to nan if no SA Assessment was presented 
% This has already been done in SAscoreAdjuster.m
% Just double check here.
adj_sa_trial_scores(:,:,4) = adj_sa_trial_scores(:,:,1) + ...
                       adj_sa_trial_scores(:,:,2) + ...
                       adj_sa_trial_scores(:,:,3);

if sum(sum(adj_sa_trial_scores(:,:,4)==0)) > 0
    error(['Some trials without SA assessments seem to still contain' ...
           'zeros instead of NaNs'])
end


%% Load MATB Score Files
MATBscores = nan(nSubs,nTrials);

for s = 5:length(subjString)
    if s == 13
        continue;
    end
    fid = fopen(fullfile(data_path, ['Subject-' subjString{s}], ...
                         sprintf('Scores-%s.txt',subjString{s})));
    tline = fgetl(fid);
    ct = 1;
    % Iterate through the report card
    while ischar(tline)
        if tline(1) == 'M'  % Pull MATB lines
            MATBscores(s, ct) = str2double(extractAfter(tline,'MB Score:'));
            ct = ct+1;
        end
        tline = fgetl(fid);
    end
    fclose(fid);   
end
save('MATBscores.mat','MATBscores')

matb_scores = MATBscores;
raw_matb = reshape(matb_scores,nTrials*nSubs,1);
save(fullfile('C:\Users\kiera\Documents\Kieran\CU\Research\SA\Subject Data','all_matb_scores.mat'),'matb_scores');% matb_scores

% use z-score-adjusted matb scores (reshape to match)
MATBscores = pagetranspose(z_adj_sub_scores(:,5,:));
MATBscores = reshape(MATBscores, nTrials, nSubs, 1)';
MATBscores(MATBscores==MATBscores(1,1)) = nan;

%% Plot Adjusted Scores vs. MATB Scores
% remove similar colors
cucolors = [188 39 49;
            129 190 161;
            64 134 160;
            107 78 113;
            203 151 0;
            250 245 252
            34 34 34;]/255;
C = cucolors;
shapes = [repmat('o',length(C),1);
          repmat('s',length(C),1);
          repmat('^',length(C),1);
          repmat('h',length(C),1);
          repmat('d',length(C),1)];
C = [C;C;C;C;C]; % for more subj

plotpath = 'C:\Users\kiera\Documents\Kieran\CU\Research\SA\Analysis\Plotting';

addpath(plotpath);

for i = 1:4
    figure;
    fig_comps.fig = gcf;
    j = 1;
    for s = 5:nSubs
        if s == 13
            continue;
        end
        scatter(adj_sa_trial_scores(j,:,i), -MATBscores(j,:), ...
            'MarkerFaceColor',C(j,:),...
            'MarkerEdgeColor','k', ...
            'MarkerFaceAlpha',0.5, ...
            'Marker', shapes(j),...
            'SizeData',100);
        hold on;
        j=j+1;

    end
    % Select form of SA Score and MATB Score
    sa1 = adj_sa_trial_scores(:,:,i);
    sa1 = reshape(sa1,nTrials*nSubs,1);
    sa2 = -MATBscores; % NEGATE MATB Penalties to get Performance
    sa2 = reshape(sa2,nTrials*nSubs,1);

    % run either spearman rank or pearson correlation
    if kstest(sa1) || kstest(sa2)
        [r, p] = corr(sa1,sa2,'type','Spearman','rows','complete');
        teststr = 'Spearman:';
        rstr = sprintf('\\rho = %0.2f ',r);
    else
        [r, p] = corr(sa1,sa2,'type','Pearson','rows','complete');
        teststr = 'Pearson:';
        rstr = sprintf('r = %0.2f ',r);
    end

    P(i) = p;

    if p < 0.01
        pstr = 'p < 0.01';
    else
        pstr = sprintf('p = %0.2f ',p);
    end

    titlestr = {teststr, rstr, pstr};


    % plot the correlation
    % figure;
    % scatter(sa, matb,'MarkerFaceColor',C(i,:),...
    %     'MarkerEdgeColor','k','MarkerFaceAlpha',0.5,'SizeData',100);
    % hold on;
    xlabel(sprintf('Adjusted Level %d SA',i));
    title(sprintf('Task Performance vs. Level %d SA',i))

    if i == 4
        title('Task Performance vs. Total SA')
        xlabel('Total Adjusted SA Score');
    end

    ylabel('Task Performance (+ better)');

    annotation('textbox',[0.15,0.75,0.15,0.15],'String',titlestr, ...
        'BackgroundColor','w','FontName','Yu Mincho');
    grid on;
    R(1,i) = r; P(1,i) = p;

    mu = [mean(sa1,'omitmissing'),mean(sa2,'omitmissing')];
    sigma = cov(sa1,sa2,'omitrows');
    a = plotErrorEllipse(mu, sigma);
    plot(a(1, :) + mu(1), a(2, :) + mu(2), ...
        'LineStyle','--', ...
        'Color',C(7,:), ...
        'LineWidth',1.2);
    
    legend(string(1:nSubs-5),'Location','eastoutside');

    STANDARDIZE_FIGURE(fig_comps);
end

rmpath(plotpath);

%% Sanity Check
figure
scatter(raw_matb, sa2);
xlabel('Raw MATB Penalties');
ylabel('Adjusted MATB Performance');
title('MATB Score Sanity Check');

%% Plot Raw Scores
for i = 1:4
    figure;
    % [r, p] = corrcoef(sa_scores(:,:,i),-MATBscores,'rows','complete')
    if i == 4
        sa_level = raw_sa_trial_scores(:,:,1)...
                   + raw_sa_trial_scores(:,:,2)...
                   + raw_sa_trial_scores(:,:,3);
    else
        sa_level = raw_sa_trial_scores(:,:,i);
    end
    [r, p] = corr(sa_level(~isnan(sa_level)),-MATBscores(~isnan(sa_level)),'Type','Spearman');
    scatter(sa_level,-MATBscores,'MarkerFaceColor',C(i,:),...
        'MarkerEdgeColor','k','MarkerFaceAlpha',0.5,'SizeData',100);
    hold on;
    xlabel(sprintf('Raw Level %d SA',i));
    if i == 4
        xlabel('Total Raw SA Score');
    end
    ylabel('MATB Score');
    % title(sprintf('r = %0.2f p = %0.2f',r(1,2),p(1,2)))
    title(sprintf('r = %0.2f p = %0.2f',r,p))
    grid on;
    % R(2,i) = r(1,2); P(2,i) = p(1,2);
    R(2,i) = r; P(2,i) = p;
end

%% Compare R & P Values
figure;
% colormap(cucolors)
b = bar(R');
b(1).FaceColor = cucolors(1,:);
b(2).FaceColor = cucolors(2,:);
ylabel('correlation coeff [r]')
xticklabels({'Level 1','Level 2','Level 3','Total'})
legend({'Adjusted Scores','Raw Scores'})

%% Additional plots
plotpath = 'C:\Users\kiera\Documents\Kieran\CU\Research\SA\Analysis\Plotting';
addpath(plotpath);

figure;
scatter(raw_sa_trial_scores(~isnan(raw_sa_trial_scores)), adj_sa_trial_scores(~isnan(raw_sa_trial_scores)), 100, 'o','filled', 'MarkerFaceAlpha',0.3);
xlabel('Raw SA Score (each level, 0-6)');
ylabel('Adjusted SA Score');
xlim([0 6])
ylim([-4.5 3])
grid on;
[r,p] = corr(raw_sa_trial_scores(~isnan(raw_sa_trial_scores)), ...
    adj_sa_trial_scores(~isnan(raw_sa_trial_scores)),'type','Spearman');
if p<0.01   
    txt = sprintf('r = %0.2f\np < 0.01',r);
else
    txt = sprintf('r = %0.2f\np = %0.2f',r,p);
end
annotation( ...
    'textbox', [0.25, 0.5, 0.1, 0.1], 'String', txt,'BackgroundColor','w', ...
    'FontName','Yu Mincho' ...
    )
hold on;

X = [ones(length(raw_sa_trial_scores(~isnan(raw_sa_trial_scores))),1) raw_sa_trial_scores(~isnan(raw_sa_trial_scores))];
b = X\adj_sa_trial_scores(~isnan(raw_sa_trial_scores));
xx = 0:6;
yy = xx*b(2)+b(1);
plot(xx,yy,'--k');

fig_comps.fig = gcf;
STANDARDIZE_FIGURE(fig_comps);

% Test for Normality
figure;
[h,p,ksstat,cv] = kstest(raw_sa_trial_scores(~isnan(raw_sa_trial_scores)));
histogram(raw_sa_trial_scores(~isnan(raw_sa_trial_scores)));
title('Raw SA Score');
xlabel('Raw SA Score (each level, 0-6)');
ylabel('# Occurrences');
if p<0.01   
    txt = sprintf('K = %0.2f\np < 0.01',ksstat);
else
    txt = sprintf('K = %0.2f\np = %0.2f',ksstat,p);
end
annotation( ...
    'textbox', [0.25, 0.5, 0.1, 0.1], 'String', txt,'BackgroundColor','w', ...
    'FontName','Yu Mincho' ...
    )
grid on;

fig_comps.fig = gcf;
STANDARDIZE_FIGURE(fig_comps);

figure;
[h,p,ksstat,cv] = kstest(adj_sa_trial_scores(~isnan(raw_sa_trial_scores)));
histogram(adj_sa_trial_scores(~isnan(raw_sa_trial_scores)));
title('Adjusted SA Score');
xlabel('Adjusted Score');
ylabel('# Occurrences')
if p<0.01   
    txt = sprintf('K = %0.2f\np < 0.01',ksstat);
else
    txt = sprintf('K = %0.2f\np = %0.2f',ksstat,p);
end
annotation( ...
    'textbox', [0.25, 0.5, 0.1, 0.1], 'String', txt,'BackgroundColor','w', ...
    'FontName','Yu Mincho' ...
    )
grid on;

fig_comps.fig = gcf;
STANDARDIZE_FIGURE(fig_comps);

%% Correlations between SA Levels

for i = 1:3
    figure;
    fig_comps.fig = gcf;

    % idcs of two levels to compare
    idx1 = i;
    idx2 = i+1;
    if idx2 > 3
        idx2 = 1;
    end
    j=1;
    for s = 5:nSubs
        if s == 13
            continue;
        end
        scatter(adj_sa_trial_scores(j,:,idx1), adj_sa_trial_scores(j,:,idx2), ...
            'MarkerFaceColor',C(j,:),...
            'MarkerEdgeColor','k', ...
            'MarkerFaceAlpha',0.5, ...
            'Marker', shapes(j),...
            'SizeData',100);
        hold on;
        j=j+1;
    end
    % Select form of SA Score and MATB Score
    sa1 = adj_sa_trial_scores(:,:,idx1);
    sa1 = reshape(sa1,nTrials*nSubs,1);
    sa2 = adj_sa_trial_scores(:,:,idx2);
    sa2 = reshape(sa2,nTrials*nSubs,1);

    % run either spearman rank or pearson correlation
    if kstest(sa1) || kstest(sa2)
        [r, p] = corr(sa1,sa2,'type','Spearman','rows','complete');
        teststr = 'Spearman:';
        rstr = sprintf('\\rho = %0.2f ',r);
    else
        [r, p] = corr(sa1,sa2,'type','Pearson','rows','complete');
        teststr = 'Pearson:';
        rstr = sprintf('r = %0.2f ',r);
    end

    P(i) = p;

    if p < 0.01
        pstr = 'p < 0.01';
    else
        pstr = sprintf('p = %0.2f ',p);
    end

    titlestr = {teststr, rstr, pstr};


    % plot the correlation
    % figure;
    % scatter(sa, matb,'MarkerFaceColor',C(i,:),...
    %     'MarkerEdgeColor','k','MarkerFaceAlpha',0.5,'SizeData',100);
    % hold on;
    xlabel(sprintf('Adjusted Level %d SA',idx1));
    ylabel(sprintf('Adjusted Level %d SA',idx2));
    title(sprintf('Level %d SA vs. Level %d SA',idx1,idx2))

    annotation('textbox',[0.15,0.75,0.15,0.15],'String',titlestr, ...
        'BackgroundColor','w','FontName','Yu Mincho');
    grid on;
    R(1,i) = r; P(1,i) = p;

    mu = [mean(sa1,'omitmissing'),mean(sa2,'omitmissing')];
    sigma = cov(sa1,sa2,'omitrows');
    a = plotErrorEllipse(mu, sigma);
    plot(a(1, :) + mu(1), a(2, :) + mu(2), ...
        'LineStyle','--', ...
        'Color',C(7,:), ...
        'LineWidth',1.2);
    
    legend(string(1:nSubs-5),'Location','eastoutside');

    
    fig_comps.fig = gcf;
    STANDARDIZE_FIGURE(fig_comps);
end

%% Clear path
rmpath(plotpath);