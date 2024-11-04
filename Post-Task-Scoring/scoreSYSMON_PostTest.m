function sa_scores = scoreSYSMON_PostTest(response_data, rate_data, sysmon_data, sa_scores, events, trial_num, fid)
%{
in response_data:
1 = yes
2 = no
%}
%for i = 1:length(rate_data.times)
i = trial_num;
    current_light_status = getLightStatus(rate_data.times(i,:), sysmon_data.times, sysmon_data.F_num, sysmon_data.RTs, events);
    current_last_lights = getLastFailures(rate_data.times(i,:), sysmon_data.times, sysmon_data.F_num, sysmon_data.RTs, events);
    
    
   %% LEVEL 1 Questions
    if ~isnan(response_data.QID2)
        % Is the F5 warning light green?
        % green = 'off', white = 'on'
        if (response_data.QID2) == 1 && current_light_status(5) == 0
            % correct if 'yes' and 'off'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID2: 1; SA: 1\n');        
        elseif (response_data.QID2) == 2 && current_light_status(5) == 1
            % correct if 'no' and 'on'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA    
    	    fprintf(fid,'QID2: 1; SA: 1\n');                
        else
            % incorrect
    	    fprintf(fid,'QID2: 0; SA: 1\n');        
        end
    end

    if ~isnan(response_data.QID3)
        % Is the F6 warning light red?
        % red = 'on', white = 'off'
        if (response_data.QID3) == 1 && current_light_status(6) == 1
            % correct if 'yes' and 'on'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID3: 1; SA: 1\n');        
        elseif (response_data.QID3) == 2 && current_light_status(6) == 0
            % correct if 'no' and 'off'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA   
    	    fprintf(fid,'QID3: 1; SA: 1\n');                 
        else
            % incorrect
    	    fprintf(fid,'QID3: 0; SA: 1\n');        
        end
    end

    if ~isnan(response_data.QID4)
        % Is the F1 scale centered?
        % centered = 'off'
        if (response_data.QID4) == 1 && current_light_status(1) == 0
            % correct if 'yes' and 'off'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID4: 1; SA: 1\n');        
        elseif (response_data.QID4) == 2 && current_light_status(1) == 1
            % correct if 'no' and 'on'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA   
    	    fprintf(fid,'QID4: 1; SA: 1\n');                 
        else
            % incorrect
    	    fprintf(fid,'QID4: 0; SA: 1\n');        
        end
    end

    if ~isnan(response_data.QID5)
        % Is the F2 scale centered?
        % centered = 'off'
        if (response_data.QID5) == 1 && current_light_status(2) == 0
            % correct if 'yes' and 'off'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID5: 1; SA: 1\n');        
        elseif (response_data.QID5) == 2 && current_light_status(2) == 1
            % correct if 'no' and 'on'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA   
    	    fprintf(fid,'QID5: 1; SA: 1\n');                 
        else
            % incorrect
    	    fprintf(fid,'QID5: 0; SA: 1\n');        
        end
    end

    if ~isnan(response_data.QID6)
        % Is the F3 scale centered?
        % centered = 'off'
        if (response_data.QID6) == 1 && current_light_status(3) == 0
            % correct if 'yes' and 'off'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID6: 1; SA: 1\n');        
        elseif (response_data.QID6) == 2 && current_light_status(3) == 1
            % correct if 'no' and 'on'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA   
    	    fprintf(fid,'QID6: 1; SA: 1\n');                 
        else
            % incorrect
    	    fprintf(fid,'QID6: 0; SA: 1\n');        
        end
    end

    if ~isnan(response_data.QID7)
        % Is the F4 scale centered?
        % centered = 'off'
        if (response_data.QID7) == 1 && current_light_status(4) == 0
            % correct if 'yes' and 'off'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID7: 1; SA: 1\n');        
        elseif (response_data.QID7) == 2 && current_light_status(4) == 1
            % correct if 'no' and 'on'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA   
    	    fprintf(fid,'QID7: 1; SA: 1\n');                 
        else
            % incorrect
    	    fprintf(fid,'QID7: 0; SA: 1\n');        
        end
    end

    
    %% LEVEL 2 Questions    
    if ~isnan(response_data.QID39) % had QID2 for inner ifs until 1/3/24
        % Is the F5 warning light nominal?
        % nominal = 'off'
        if (response_data.QID39) == 1 && current_light_status(5) == 0
            % correct if 'yes' and 'off'
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID39: 1; SA: 2\n');        
        elseif (response_data.QID39) == 2 && current_light_status(5) == 1
            % correct if 'no' and 'on'
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID39: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID39: 0; SA: 2\n');        
        end
    end

    if ~isnan(response_data.QID40)
        % Is the F6 warning light nominal?
        % nominal = 'off'
        if (response_data.QID40) == 1 && current_light_status(6) == 0
            % correct if 'yes' and 'off'
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID40: 1; SA: 2\n');        
        elseif (response_data.QID40) == 2 && current_light_status(6) == 1
            % correct if 'no' and 'on'
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID40: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID40: 0; SA: 2\n');        
        end
    end

    if ~isnan(response_data.QID41)
        % Is the F1 warning scale nominal?
        % nominal = 'off'
        if (response_data.QID41) == 1 && current_light_status(1) == 0
            % correct if 'yes' and 'off'
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID41: 1; SA: 2\n');        
        elseif (response_data.QID41) == 2 && current_light_status(1) == 1
            % correct if 'no' and 'on'
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID41: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID41: 0; SA: 2\n');        
        end
    end

    if ~isnan(response_data.QID42)
        % Is the F2 warning scale nominal?
        % nominal = 'off'
        if (response_data.QID42) == 1 && current_light_status(2) == 0
            % correct if 'yes' and 'off'
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID42: 1; SA: 2\n');        
        elseif (response_data.QID42) == 2 && current_light_status(2) == 1
            % correct if 'no' and 'on'
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID42: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID42: 0; SA: 2\n');        
        end
    end

    if ~isnan(response_data.QID43)
        % Is the F3 warning scale nominal?
        % nominal = 'off'
        if (response_data.QID43) == 1 && current_light_status(3) == 0
            % correct if 'yes' and 'off'
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID43: 1; SA: 2\n');        
        elseif (response_data.QID43) == 2 && current_light_status(3) == 1
            % correct if 'no' and 'on'
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID43: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID43: 0; SA: 2\n');        
        end
    end

    if ~isnan(response_data.QID44)
        % Is the F4 warning scale nominal?
        % nominal = 'off'
        if (response_data.QID44) == 1 && current_light_status(4) == 0
            % correct if 'yes' and 'off'
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID44: 1; SA: 2\n');        
        elseif (response_data.QID44) == 2 && current_light_status(4) == 1
            % correct if 'no' and 'on'
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID44: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID44: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID46)
        % Is the autopilot currently operating on the secondary flight computer?
        % 0 = 'off' = nominal 
        % had QID44 here til 1/3/24
        if (response_data.QID46) == 1 && current_light_status(5) == 1 &&  current_light_status(6) == 0
            % correct if 'yes' and F5 is on and F6 is nominal
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID46: 1; SA: 2\n');        
        elseif (response_data.QID46) == 2 && current_light_status(5) == 0
            % correct if 'no' and F5 is nominal
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID46: 1; SA: 2\n');        
        elseif (response_data.QID46) == 2 && current_light_status(6) == 1
            % correct if 'no' and F6 is on
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID46: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID46: 0; SA: 2\n');        
        end
    end

    %% LEVEL 3
    upcoming_failures = getNextFailures(rate_data.times(i,:), events);

    if ~isnan(response_data.QID89)
        % Do you expect pump 1 to fail within the next 15 seconds?
        if (response_data.QID89) == 1 && upcoming_failures(1) == 1
            % correct if 'yes' and P1 has an upcoming failure
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID89: 1; SA: 3\n');        
        elseif (response_data.QID89) == 2 && upcoming_failures(1) == 0
            % correct if 'no' and P1 does not have an upcoming failure
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID89: 1; SA: 3\n');        
        else
            % incorrect
    	    fprintf(fid,'QID89: 0; SA: 3\n');        
        end
    end

    if ~isnan(response_data.QID90)
        % Do you expect pump 2 to fail within the next 15 seconds?
        if (response_data.QID90) == 1 && upcoming_failures(2) == 1
            % correct if 'yes' and P3 has an upcoming failure
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID90: 1; SA: 3\n');        
        elseif (response_data.QID90) == 2 && upcoming_failures(2) == 0
            % correct if 'no' and P3 does not have an upcoming failure
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID90: 1; SA: 3\n');        
        else
            % incorrect
    	    fprintf(fid,'QID90: 0; SA: 3\n');        
        end
    end

    if ~isnan(response_data.QID91)
        % Do you expect pump 3 to fail within the next 15 seconds?
        if (response_data.QID91) == 1 && upcoming_failures(3) == 1
            % correct if 'yes' and P3 has an upcoming failure
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID91: 1; SA: 3\n');        
        elseif (response_data.QID91) == 2 && upcoming_failures(3) == 0
            % correct if 'no' and P3 does not have an upcoming failure
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID91: 1; SA: 3\n');        
        else
            % incorrect
    	    fprintf(fid,'QID91: 0; SA: 3\n');        
        end
    end

    if ~isnan(response_data.QID92)
        % Do you expect pump 4 to fail within the next 15 seconds?
        % nominal = 'off'
        if (response_data.QID92) == 1 && upcoming_failures(4) == 1
            % correct if 'yes' and P1 has an upcoming failure
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID92: 1; SA: 3\n');        
        elseif (response_data.QID92) == 2 && upcoming_failures(4) == 0
            % correct if 'no' and P1 does not have an upcoming failure
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID92: 1; SA: 3\n');        
        else
            % incorrect
    	    fprintf(fid,'QID92: 0; SA: 3\n');        
        end
    end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


end

%% SYSMON Functions
function light_status = getLightStatus(current_time, light_times, lights, RTs, events)
% Returns the light states at the 'current_time' using the
% reaction time data from the last 15 seconds
light_status = zeros(1,6);

% get index for most recent data point
current_time = current_time(1)*60 + current_time(2);
count = getLastDatum(light_times, current_time);

% update light status according to each event within last 15 sec
%{
neat little detail: MATB auto fails you and fixes the issue if it's 
    off-nominal during the questionnaires. it also does not record the
    light alert UNTIL you've failed to respond (after questionnaires are
    done)

SO: if there was a sysmon event in events.mat and it did not appear in the
    MATB data, then there is an open light (light_status = 1); if there was a
    sysmon event in the mat file and it DOES appear with a reaction time,
    then there is not an open light (light_status = 0), and same if there's
    no sysmon event at all.
%}
% turn on each light that has been switched on (accord to .mat file)
round_time = floor(current_time);
for i = round_time-15:1:round_time
    if events.sysmon(i+1) ~= 0
        light_status(events.sysmon(i+1)) = 1;   % 1 = 'on' = needs to be clicked
    end
end

% turn off each light that was reacted to
i = count;
seconds_since = (current_time - (light_times(i,1)*60 + light_times(i,2)))/60;
while i>0 && seconds_since < 15 % time that errors last for before defaulting
    if ~isnan(RTs(count))   
        % if the RT shows that the light has been resolved
        if RTs(count) > 0 && RTs(count) < seconds_since 
            light_status(lights(i)) = 0;    % 0 = 'off' = nominal
        end
    end
    seconds_since = (current_time - (light_times(i,1)*60 + light_times(i,2)))/60;
    i = i-1;
end


end

function last_lights = getLastFailures(current_time, light_times, lights, RTs, events)
% Returns the most recent time each system went off-nominal (or returns
% -1 if it hasn't happened yet)
last_lights = -1*ones(1,6);

% get index for most recent data point
current_time = current_time(1)*60 + current_time(2);

% update light status according to each event in the mat file
for i = 1:current_time
    if events.sysmon(i+1) ~= 0
        last_lights(events.sysmon(i+1)) = events.times(i+1);
    end
end

end

function future_fails = getNextFailures(current_time, events)
% Returns whether or not (1/0) pumps 1-4 have upcoming failures within the 
% next 15 seconds
future_fails = zeros(1,4);

% get index for most recent data point
current_time = current_time(1)*60 + current_time(2);
round_time = floor(current_time);

% update pump status according to each event within next 15 sec
for i = round_time:round_time+15
    if i < length(events.resman) % stops us from searching over the end
        if events.resman(i+1) >= 1 && events.resman(i+1) <= 4
            future_fails(events.resman(i+1)) = 1;
        end
    end
end

end

