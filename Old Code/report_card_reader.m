%% Report Card Reader!

s = 3;
base_folder = 'C:\Users\kiera\OneDrive\Documents\Kieran\CU\Research\SA\';
date_time = '09231534';
data_folder = 'Subject Data';
subject_folder = {'Subject-001-0922','Subject-002-0923','Subject-003-0926'};
response_file = 'report-card.txt';
nTrials = 12;
trial_num = 0;

nQuestions = 91;
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

QIDs = table(QID, Asked, Correct);
clear QID Asked Correct;

for s = 1:3
    data_path = fullfile(base_folder,data_folder,subject_folder{s});
    fid = fopen(fullfile(data_path,'report-card.txt'));
    tline = fgetl(fid);
    count = 1;

    % Iterate through the report card
    while ischar(tline)
        if tline(1) == 'T'  % Skip "Trial Number:" lines
            trial_num = str2num(tline(13:end-1));
        elseif tline(1) == 'Q'  % Pull QID lines
            QID = extractBetween(tline,'QID',':');
            correct = str2num(extractAfter(tline,':'));
            QID = str2num(QID{1});
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
bar(QIDs.QID, QIDs.prctCorrect)

