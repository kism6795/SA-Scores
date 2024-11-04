function [adj_sa_trial_scores, raw_sa_trial_scores] = adjust_SA_trial_numbers( ...
    raw_sa_scores, adj_sa_scores, nSubs, data_path ...
        )
    
    % sets SA scores to their appropriate trial numbers
    % for all participants (up to here), sa scores are put in slots 1-X, with X
    % being how many assessments that participant completed. here, we adjust
    % for cases where the first trial(s) of the SA assessment are omitted
    % (i.e., trials 4-12 should contain the data, not trials 1-3). This is
    % essential for aligning SA scores with their associated phys data

    adj_sa_trial_scores = adj_sa_scores;
    raw_sa_trial_scores = raw_sa_scores;
    
    for s = 5:nSubs
        % subject 24 is missing the first trial (not the last one)
        if s == 24
            temp1 = raw_sa_trial_scores(s,1:11,:);
            temp2 = raw_sa_trial_scores(s,12,:);
            raw_sa_trial_scores(s,:,:) = [temp2 temp1];
            clear temp1 temp2
        
            temp1 = adj_sa_trial_scores(s,1:11,:);
            temp2 = adj_sa_trial_scores(s,12,:);
            adj_sa_trial_scores(s,:,:) = [temp2 temp1];
            clear temp1 temp2
        end
        
        % subject 25 is missing the first 4 trials (not the last 4).
        if s == 25
            temp1 = raw_sa_trial_scores(s,1:8,:);
            temp2 = raw_sa_trial_scores(s,9:12,:);
            raw_sa_trial_scores(s,:,:) = [temp2 temp1];
            clear temp1 temp2
        
            temp1 = adj_sa_trial_scores(s,1:8,:);
            temp2 = adj_sa_trial_scores(s,9:12,:);
            adj_sa_trial_scores(s,:,:) = [temp2 temp1];
            clear temp1 temp2
        end
    end
    
    % save aligned data to data_path
    save(fullfile(data_path,'adj_sa_trial_scores.mat'),'adj_sa_trial_scores');
    save(fullfile(data_path,'raw_sa_trial_scores.mat'),'raw_sa_trial_scores');

end