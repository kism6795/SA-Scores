%% Report Card Reader!
% Updated 1/4/2024
% first run reportCardGenerator.m in:
% C:\Users\kiera\Documents\Kieran\CU\Research\SA\Analysis\SA-Scores\Post-Task-Scoring

% compiles report cards ('reportCards') and saves them as 'outfile' in
% 'data_folder'

outfile = 'reportCards.mat';
data_folder = 'C:\Users\kiera\Documents\Kieran\CU\Research\SA\Subject Data';
subjString = {'001-0922','002-0923','003-0926','004-1025','005-1110',...
              '006-1111','007-1113','008-1215','009-1219','010-1221',...
              '011-0123','012-0125','013-0126','014-0130','015-0202',...
              '016-0208','017-0222','018-0226','019-0227','020-0229',...
              '021-0309','022-0404','023-0412','024-0416','025-0426',...
              '026-0717','027-0724','028-0729','029-0730','030-0802',...
              '031-0806','032-0807','033-0810','034-0823','035-0916'};
report_card_file = 'ReportCard.txt';
nTrials = 12;
trial_num = 0;
nSubs = length(subjString);

nQuestions = 110;
QID = zeros(nQuestions,1);
for i = 1:nQuestions
    QID(i) = i+1;
end

% question IDs that don't exist (-1)
QID(75) = [];
QID(73) = [];
QID(44) = [];
QID(17) = [];
QID(16) = [];
QID(15) = [];
QID(14) = [];
QID(7) = [];

Asked = zeros(length(QID),1);
Correct = zeros(length(QID),1);

reportCards = cell(nSubs,nTrials);

QIDs = table(QID, Asked, Correct); % summary of all correct/incorrect answers
clear QID Asked Correct;

for s = 5:nSubs
    if s == 13
        continue;
    end
    % Open the Report Card & read line 1
    data_path = fullfile(data_folder,['Subject-' subjString{s}]);
    fid = fopen(fullfile(data_path,report_card_file));
    tline = fgetl(fid);

    % Define table for subj 5, trials 1-12
    QID = -1*ones(18,1);
    correct = -1*ones(18,1);
    level = -1*ones(18,1);

    for k = 1:nTrials
        reportCards{s,k} = table(QID,correct,level);
    end
    count = 1;
    clear QID correct;

    % Iterate through the report card
    while ischar(tline)
        if tline(1) == 'T'  % Skip "Trial Number:" lines
            temp = strtrim(extractBetween(tline,'Trial', ':'));
            trial_num = str2double(temp{1});
            count = 1;
        elseif tline(1) == 'Q'  % Pull QID lines
            QID = extractBetween(tline,'QID',':');
            QID = str2double(QID{1});
            correct = extractBetween(tline,':',';');
            correct = str2double(correct);
            level = str2double(extractAfter(tline,'SA:'));

            % add QID & correctness to reportCards
            reportCards{s,trial_num}.QID(count) = QID;
            reportCards{s,trial_num}.correct(count) = correct;
            reportCards{s,trial_num}.level(count) = level;
            count = count+1; % increment counter

            idx = find(QIDs.QID==QID); % find the appropriate index
            % Increase Asked & Correct Counts accordingly
            QIDs.Asked(idx) = QIDs.Asked(idx)+1;
            if correct
                QIDs.Correct(idx) = QIDs.Correct(idx)+1;
            end
        else
            warning("Line Skipped")
        end
        tline = fgetl(fid);
    end
    fclose(fid);   
end


%% Calculate Utility
QIDs.prctCorrect = QIDs.Correct./QIDs.Asked;
QIDs = QIDs(QIDs.Asked~=0, :);
bar(QIDs.QID, QIDs.prctCorrect);
xlabel('QID'); ylabel('% Correct');

save(fullfile(data_folder,outfile),'reportCards');
save(fullfile(data_folder,'QIDs.mat'),'QIDs');

