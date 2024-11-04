function sa_scores = scoreCOMM_PostTest(response_data, rate_data, comm_data, track_data, sa_scores, events, trial_num, fid)
%{
in response_data:
1 = yes
2 = no
%}
%for i = 1:length(rate_data.times)
i = trial_num;
    [current_freq, correct_freq] = getRadioStatus(rate_data.times(i,:), comm_data, events);    
    session_status = getSessionStatus(rate_data.times(i,:), events);
    future_comms = getNextComm(rate_data.times(i,:), events);
    planes_nearby = arePlanesNearby(rate_data.times(i,:), comm_data, track_data, events);
    own_last_30 = getLastOwn(rate_data.times(i,:), comm_data, track_data, events);
    other_last_15 = getLastOther(rate_data.times(i,:), comm_data, track_data, events);

   %% LEVEL 1 Questions
    if ~isnan(response_data.QID10)
        % Were you instructed to set the NAV1 radio to a different frequency in the last 15 seconds?
        if (response_data.QID10) == 1 && other_last_15(3)
            % correct if 'yes' & NAV1 changed in last 15 sec
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID10: 1; SA: 1\n');        
        elseif (response_data.QID10) == 2 && ~other_last_15(3)
            % correct if 'no' & NAV1 not changed
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA    
    	    fprintf(fid,'QID10: 1; SA: 1\n');                
        else
            % incorrect
    	    fprintf(fid,'QID10: 0; SA: 1\n');        
        end
    end    
    
    if ~isnan(response_data.QID11)
        % Were you instructed to set the NAV2 radio to a different frequency in the last 15 seconds?
        if (response_data.QID11) == 1 && other_last_15(3)
            % correct if 'yes' & NAV2 changed in last 15 sec
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID11: 1; SA: 1\n');        
        elseif (response_data.QID11) == 2 && ~other_last_15(3)
            % correct if 'no' & NAV2 not changed
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA     
    	    fprintf(fid,'QID11: 1; SA: 1\n');               
        else
            % incorrect
    	    fprintf(fid,'QID11: 0; SA: 1\n');        
        end
    end

    if ~isnan(response_data.QID12)
        % Were you instructed to set the COM1 radio to a different frequency in the last 15 seconds?
        if (response_data.QID12) == 1 && other_last_15(1)
            % correct if 'yes' & COM1 changed in last 15 sec
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID12: 1; SA: 1\n');        
        elseif (response_data.QID12) == 2 && ~other_last_15(1)
            % correct if 'no' & COM1 not changed
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA    
    	    fprintf(fid,'QID12: 1; SA: 1\n');                
        else
            % incorrect
    	    fprintf(fid,'QID12: 0; SA: 1\n');        
        end
    end
    
    if ~isnan(response_data.QID13)
        % Were you instructed to set the COM2 radio to a different frequency in the last 15 seconds?
        if (response_data.QID13) == 1 && other_last_15(2)
            % correct if 'yes' & COM2 changed in last 15 sec
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID13: 1; SA: 1\n');        
        elseif (response_data.QID13) == 2 && ~other_last_15(2)
            % correct if 'no' & COM2 not changed
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA    
    	    fprintf(fid,'QID13: 1; SA: 1\n');                
        else
            % incorrect
    	    fprintf(fid,'QID13: 0; SA: 1\n');        
        end
    end
    
    if ~isnan(response_data.QID14)
        % Is a communication session active?
        if (response_data.QID14) == 1 && session_status ~= 0
            % correct if 'yes' & active
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID14: 1; SA: 1\n');        
        elseif (response_data.QID14) == 2 && session_status == 0
            % correct if 'no' & inactive
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA     
    	    fprintf(fid,'QID14: 1; SA: 1\n');               
        else
            % incorrect
    	    fprintf(fid,'QID14: 0; SA: 1\n');        
        end
    end

    if ~isnan(response_data.QID99)
            % Did the plane receive any instructions from audio files?-------------CHANGING TO LAST 30 SECONDS
        if (response_data.QID99) == 1 && own_last_30
            % correct if 'yes' & OWN event occured in last 30s
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID99: 1; SA: 1\n');        
        elseif (response_data.QID99) == 2 && ~own_last_30
            % correct if 'no' & no OWN event occured in last 30s
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID99: 1; SA: 1\n');        
        else
            % incorrect otherwise
    	    fprintf(fid,'QID99: 0; SA: 1\n');        
        end

    end

    if ~isnan(response_data.QID109)
    % Is your plane's call sign NASA 504?
        if (response_data.QID109) == 2 % yes = 2 for this question 
            % correct if 'yes'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID109: 1; SA: 1\n');        
        else
            % incorrect
    	    fprintf(fid,'QID109: 0; SA: 1\n');        
        end
     end


    %% LEVEL 2 Questions    

   if ~isnan(response_data.QID47)
        % Will a comm session end within the next 30 seconds?
        if (response_data.QID47) == 1 && future_comms(2) == 1
            % correct if 'yes' & at least 1 comm sesh is ending
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID47: 1; SA: 2\n');        
        elseif (response_data.QID47) == 2 && future_comms(2) == 0
            % correct if 'no' & no comm sesh is ending
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA       
    	    fprintf(fid,'QID47: 1; SA: 2\n');             
        else
            % incorrect
    	    fprintf(fid,'QID47: 0; SA: 2\n');        
        end
    end

    if ~isnan(response_data.QID48)
        % Will a comm session begin within the next 30 seconds?
        if (response_data.QID48) == 1 && future_comms(1) == 1
            % correct if 'yes' & at least 1 comm sesh is upcoming
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID48: 1; SA: 2\n');        
        elseif (response_data.QID48) == 2 && future_comms(1) == 0
            % correct if 'no' & no comm sesh is upcoming
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA      
    	    fprintf(fid,'QID48: 1; SA: 2\n');              
        else
            % incorrect
    	    fprintf(fid,'QID48: 0; SA: 2\n');        
        end
    end

    if ~isnan(response_data.QID49)
        % Does the NAV1 radio need to be changed?
        if (response_data.QID49) == 1 && current_freq(1) ~= correct_freq(1)
            % correct if 'yes' & current frequency is not correct
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID49: 1; SA: 2\n');        
        elseif (response_data.QID49) == 2 && current_freq(1) == correct_freq(1)
            % correct if 'no' & current frequency is  correct
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA 
    	    fprintf(fid,'QID49: 1; SA: 2\n');                   
        else
            % incorrect
    	    fprintf(fid,'QID49: 0; SA: 2\n');        
        end
    end

    if ~isnan(response_data.QID50)
        % Does the NAV2 radio need to be changed?
        if (response_data.QID50) == 1 && current_freq(2) ~= correct_freq(2)
            % correct if 'yes' & current frequency is not correct
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID50: 1; SA: 2\n');        
        elseif (response_data.QID50) == 2 && current_freq(2) == correct_freq(2)
            % correct if 'no' & current frequency is  correct
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA    
    	    fprintf(fid,'QID50: 1; SA: 2\n');                
        else
            % incorrect
    	    fprintf(fid,'QID50: 0; SA: 2\n');        
        end
    end

    if ~isnan(response_data.QID51)
        % Does the COM1 radio need to be changed?
        if (response_data.QID51) == 1 && current_freq(3) ~= correct_freq(3)
            % correct if 'yes' & current frequency is not correct
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID51: 1; SA: 2\n');        
        elseif (response_data.QID51) == 2 && current_freq(3) == correct_freq(3)
            % correct if 'no' & current frequency is  correct
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA   
    	    fprintf(fid,'QID51: 1; SA: 2\n');                 
        else
            % incorrect
    	    fprintf(fid,'QID51: 0; SA: 2\n');        
        end
    end

    if ~isnan(response_data.QID52)
        % Does the COM2 radio need to be changed?
        if (response_data.QID52) == 1 && current_freq(4) ~= correct_freq(4)
            % correct if 'yes' & current frequency is not correct
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID52: 1; SA: 2\n');        
        elseif (response_data.QID52) == 2 && current_freq(4) == correct_freq(4)
            % correct if 'no' & current frequency is  correct
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA   
    	    fprintf(fid,'QID52: 1; SA: 2\n');                 
        else
            % incorrect
    	    fprintf(fid,'QID52: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID104)
        % Are there several planes nearby?
        
        if (response_data.QID104) == 2 && planes_nearby % yes = 2 for this question 
            % correct if yes and planes_nearby
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID104: 1; SA: 2\n');        
        elseif (response_data.QID104) == 3 && ~planes_nearby % yes = 2 for this question 
            % correct if no and if ~planes_nearby
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID104: 1; SA: 2\n');        
        else
            % incorrect otherwise
    	    fprintf(fid,'QID104: 0; SA: 2\n');        
        end
    end
    

    %% LEVEL 3 Questions

    if ~isnan(response_data.QID88)
        % Do you expect to have to change a radio frequency soon (within 30 seconds)?
        if (response_data.QID88) == 1 && future_comms(1) == 1
            % correct if 'yes' & a comm session starts in the next 30
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID88: 1; SA: 3\n');        
        elseif (response_data.QID88) == 1 && session_status == 1
            % correct if 'yes' & a comm session is active & comm hasn't
            % happened yet
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA    
    	    fprintf(fid,'QID88: 1; SA: 3\n');                
        elseif (response_data.QID88) == 2 && session_status == 2
            % correct if 'no' & comm has already occurred
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA  
    	    fprintf(fid,'QID88: 1; SA: 3\n');                  
        elseif (response_data.QID88) == 2 && session_status == 0 && future_comms(1) == 0
            % correct if 'no' & no session is active or projected
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA  
    	    fprintf(fid,'QID88: 1; SA: 3\n');                  
        else
            % incorrect
    	    fprintf(fid,'QID88: 0; SA: 3\n');        
        end
    end



end

%% COMM Functions

% test these!
function other_last_15 = getLastOther(current_time, comm_data, track_data, events)
other_last_15 = [false;false;false;false];
current_time = current_time(1)*60 + current_time(2); % time of freeze probe
search_time = current_time-15;  % 30-seconds before freeze probe
start_count = getLastDatum(comm_data.times, search_time); % current index in comm_data
end_count = getLastDatum(comm_data.times, current_time); % 30s prior index in comm_data

for j = start_count:end_count
    if strcmp(comm_data.ship_exp{j},'OTHER')
        if strcmp(comm_data.radio_exp{j},'COM1')
            own_last_30(1) = true;
        elseif strcmp(comm_data.radio_exp{j},'COM2')
            own_last_30(2) = true;
        elseif strcmp(comm_data.radio_exp{j},'NAV1')
            own_last_30(3) = true;
        elseif strcmp(comm_data.radio_exp{j},'NAV2')
            own_last_30(4) = true;
        end    
    end
end

end

function own_last_30 = getLastOwn(current_time, comm_data, track_data, events)
own_last_30 = false;
current_time = current_time(1)*60 + current_time(2); % time of freeze probe
search_time = current_time-30;  % 30-seconds before freeze probe
start_count = getLastDatum(comm_data.times, search_time); % current index in comm_data
end_count = getLastDatum(comm_data.times, current_time); % 30s prior index in comm_data

for j = start_count:end_count
    if strcmp(comm_data.ship_exp{j},'OWN')
        own_last_30 = true;
        break;
    end
end

end


function planes_nearby = arePlanesNearby(current_time, comm_data, track_data, events)
% planes_nearby = if two OTHER radio calls happened within 30 seconds of one another AND the corresponding track event hasn't ended
% look through last 90 seconds of data (current_time-90)
current_time = current_time(1)*60 + current_time(2); % time of freeze probe
search_time = current_time-90;  % 90-seconds before freeze probe
start_count = getLastDatum(comm_data.times, search_time); % current index in comm_data
end_count = getLastDatum(comm_data.times, current_time); % 90s prior index in comm_data
two_calls = []; % indices that represent the second call within 30s
last_ship_time = -999; % initialized negative to avoid first other being considered the 'second'

% search for times where two ships were called within 30 secs
for j = start_count:end_count
    j_time = comm_data.times(j,1)*60 + comm_data.times(j,2);
    if strcmp(comm_data.ship_exp{j},'OTHER')
        if (j_time - last_ship_time) < 30
            two_calls = [two_calls;j]; % add index of second other call
        end
        last_ship_time = comm_data.times(j,1)*60 + comm_data.times(j,2);
    end
end

% find the last time two calls were made within last 90 seconds
two_call_times = comm_data.times(two_calls,1)*60 + comm_data.times(two_calls,2);
if isempty(two_call_times)
    planes_nearby = false;
elseif ~isempty(two_call_times)
    % can't be zero because it has to be the second call
    last_two_call_time = floor(two_call_times(end)); % round to nearest i
end

% search through tracking data from last two-call-time to present
% if tracking event has started and ended, then planes_nearby = false,
% if tracking event has not started, then planes_nearby = true
% if tracking event has started and not ended, then planes_nearby = true
if ~isempty(two_call_times) && ~isempty(events.track)
    track_started = false;
    track_ended = false;
    for k = last_two_call_time+1:last_two_call_time+16 % search 15 seconds after last two call time
        if events.track(k) == 1
            track_started = true;
        elseif events.track(k) == 2 && track_started
            track_ended = true;
        end
    end
    if track_started && track_ended
        planes_nearby = false;
    elseif track_started && ~track_ended
        planes_nearby = false;
    elseif ~track_started
        planes_nearby = true;
    else
        print("unexpected outcome!")
    end
else
    planes_nearby = false;
end

end



function [current_freq, correct_freq] = getRadioStatus(current_time, comm_data, events)
% Returns current correct frequencies and actual frequencies

% a little concerned this is wrong (kjs 10/10/2023)
current_freq = [112.500, 112.500, 126.500, 126.500];
correct_freq = [112.500, 112.500, 126.500, 126.500];

% get time (sec) for most recent data point
current_time = current_time(1)*60 + current_time(2);
count = getLastDatum(comm_data.times, current_time);
round_time = floor(current_time);

% change correct frequency if own-comm event happens that doesn't appear
% later
for i = round_time-30:1:round_time
    if events.comm(i+1) == 2
        switch  events.comm_radio{i+1}
            case 'NAV1'
                correct_freq(1) = (events.comm_freq{i+1});
            case 'NAV2'
                correct_freq(2) = (events.comm_freq{i+1});
            case 'COM1'
                correct_freq(3) = (events.comm_freq{i+1});
            case 'COM2'
                correct_freq(4) = (events.comm_freq{i+1});
        end
    end
end

% adjust each radio that was changed
i = 1;
while i<=count
    if strcmp(comm_data.ship_exp{i},'OWN')
        switch comm_data.radio_exp{i}
            case 'NAV1'
                correct_freq(1) = comm_data.freq_exp(i);
            case 'NAV2'
                correct_freq(2) = comm_data.freq_exp(i);
            case 'COM1'
                correct_freq(3) = comm_data.freq_exp(i);
            case 'COM2'
                correct_freq(4) = comm_data.freq_exp(i);
        end
    end
    
    switch comm_data.radio_act{i}
        case 'NAV1'
            current_freq(1) = comm_data.freq_act(i);
        case 'NAV2'
            current_freq(2) = comm_data.freq_act(i);
        case 'COM1'
            current_freq(3) = comm_data.freq_act(i);
        case 'COM2'
            current_freq(4) = comm_data.freq_act(i);
    end
    i = i+1;
end
end

function session_status = getSessionStatus(current_time, events)
% Returns active session status (1 = active, 0 = not)
session_status = 0;

% get time (sec) for most recent data point
current_time = current_time(1)*60 + current_time(2);
round_time = floor(current_time);

% adjust each time the session status changes
for i = 1:round_time
    if events.comm(i+1) == 2
        session_status = 2;
    elseif events.comm(i+1) == 3
        session_status = 1;
    elseif events.comm(i+1) == 4
        session_status = 0;
    end
end

end

function future_comms = getNextComm(current_time, events)
% Returns session changes within next 30 seconds
future_comms = [0,0]; %[begin i/o, end i/o];

% get time (sec) for most recent data point
current_time = current_time(1)*60 + current_time(2);
round_time = floor(current_time);

% adjust each time the session status changes
for i = round_time:1:round_time+30
    if i < length(events.comm)
        if events.comm(i+1) == 3 % if an event starts
            future_comms(1) = 1;
        elseif events.comm(i+1) == 4 % if an event ends
            future_comms(2) = 1;
        end
    end
end
end

