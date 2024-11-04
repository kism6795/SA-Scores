function sa_scores = scoreRESMAN_PostTest(response_data, rate_data, resman_data, sa_scores, flow_rates, trial_num, fid)
%{
in response_data:
1 = yes
2 = no
%}
%for i = 1:length(rate_data.times)
    i = trial_num;
    current_pump_status = getPumpStatus(rate_data.times(i,:), resman_data.times, resman_data.pumps, resman_data.actions);
    current_fuel_levels = getFuelLevels(rate_data.times(i,:), resman_data.times, resman_data.fuel_levels, current_pump_status, flow_rates);
    
    %% LEVEL 1 Questions
    if ~isnan(response_data.QID19)
        % Is pump 1 turned on?
        if (response_data.QID19) == 1 && current_pump_status(1) == 1
            % correct if 'yes' and 'on'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID19: 1; SA: 1\n');        
        elseif (response_data.QID19) == 2 && current_pump_status(1) == 0
            % correct if 'no' and 'off'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID19: 1; SA: 1\n');        
        elseif (response_data.QID19) == 2 && current_pump_status(1) == 2
            % correct if 'no' and 'failed'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID19: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID19: 0; SA: 1\n');        
        end
    end
    
    if ~isnan(response_data.QID20)
        % Is pump 2 turned off?
        if (response_data.QID20) == 1 && current_pump_status(2) == 0
            % correct if 'yes' and 'off'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID20: 1; SA: 1\n');        
        elseif (response_data.QID20) == 2 && current_pump_status(2) == 1
            % correct if 'no' and 'on'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID20: 1; SA: 1\n');        
        elseif (response_data.QID20) == 2 && current_pump_status(2) == 2
            % correct if 'no' and 'failed'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID20: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID20: 0; SA: 1\n');        
        end
    end

    if ~isnan(response_data.QID21)
        % Is pump 3 currently failed?
        if (response_data.QID21) == 1 && current_pump_status(3) == 2
            % correct if 'yes' and 'failed'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID21: 1; SA: 1\n');        
        elseif (response_data.QID21) == 2 && current_pump_status(3) == 1
            % correct if 'no' and 'on'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID21: 1; SA: 1\n');        
        elseif (response_data.QID21) == 2 && current_pump_status(3) == 0
            % correct if 'no' and 'off'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID21: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID21: 0; SA: 1\n');        
        end
    end    

    if ~isnan(response_data.QID22)
        % Is pump 4 turned on?
        if (response_data.QID22) == 1 && current_pump_status(4) == 1
            % correct if 'yes' and 'on'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID22: 1; SA: 1\n');        
        elseif (response_data.QID22) == 2 && current_pump_status(4) == 0
            % correct if 'no' and 'off'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID22: 1; SA: 1\n');        
        elseif (response_data.QID22) == 2 && current_pump_status(4) == 2
            % correct if 'no' and 'failed'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID22: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID22: 0; SA: 1\n');        
        end
    end
    
    if ~isnan(response_data.QID23)
        % Is pump 5 turned off?
        if (response_data.QID23) == 1 && current_pump_status(5) == 0
            % correct if 'yes' and 'off'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID23: 1; SA: 1\n');        
        elseif (response_data.QID23) == 2 && current_pump_status(5) == 1
            % correct if 'no' and 'on'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID23: 1; SA: 1\n');        
        elseif (response_data.QID23) == 2 && current_pump_status(5) == 2
            % correct if 'no' and 'failed'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID23: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID23: 0; SA: 1\n');        
        end
    end

    if ~isnan(response_data.QID24)
        % Is pump 6 currently failed?
        if (response_data.QID24) == 1 && current_pump_status(6) == 2
            % correct if 'yes' and 'failed'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID24: 1; SA: 1\n');        
        elseif (response_data.QID24) == 2 && current_pump_status(6) == 1
            % correct if 'no' and 'on'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID24: 1; SA: 1\n');        
        elseif (response_data.QID24) == 2 && current_pump_status(6) == 0
            % correct if 'no' and 'off'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID24: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID24: 0; SA: 1\n');        
        end
    end        
    
    if ~isnan(response_data.QID25)
        % Is pump 7 turned on?
        if (response_data.QID25) == 1 && current_pump_status(7) == 1
            % correct if 'yes' and 'on'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID25: 1; SA: 1\n');        
        elseif (response_data.QID25) == 2 && current_pump_status(7) == 0
            % correct if 'no' and 'off'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID25: 1; SA: 1\n');        
        elseif (response_data.QID25) == 2 && current_pump_status(7) == 2
            % correct if 'no' and 'failed'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID25: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID25: 0; SA: 1\n');        
        end
    end
    
    if ~isnan(response_data.QID26)
        % Is pump 8 turned off?
        if (response_data.QID26) == 1 && current_pump_status(8) == 0
            % correct if 'yes' and 'off'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID26: 1; SA: 1\n');        
        elseif (response_data.QID26) == 2 && current_pump_status(8) == 1
            % correct if 'no' and 'on'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID26: 1; SA: 1\n');        
        elseif (response_data.QID26) == 2 && current_pump_status(8) == 2
            % correct if 'no' and 'failed'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID26: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID26: 0; SA: 1\n');        
        end
    end
    
    if ~isnan(response_data.QID27)
        % Is the fuel level of tank A within the light blue range?
        if (response_data.QID27) == 1 && (current_fuel_levels(1) <= 3000 && current_fuel_levels(1) >= 2000)
            % correct if 'yes' and 'below 3000 and above 2000'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID27: 1; SA: 1\n');        
        elseif (response_data.QID27) == 2 && (current_fuel_levels(1) <= 2000 || current_fuel_levels(1) >= 3000)
            % correct if 'no' and 'below 2000 or above 3000'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID27: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID27: 0; SA: 1; SA: 1\n');        
        end
    end
    
    if ~isnan(response_data.QID28)
        % Is the fuel level of tank B within the light blue range?
        if (response_data.QID28) == 1 && (current_fuel_levels(2) <= 3000 && current_fuel_levels(2) >= 2000)
            % correct if 'yes' and 'below 3000 and above 2000'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID28: 1; SA: 1\n');        
        elseif (response_data.QID28) == 2 && (current_fuel_levels(2) <= 2000 || current_fuel_levels(2) >= 3000)
            % correct if 'no' and 'below 2000 or above 3000'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID28: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID28: 0; SA: 1\n');        
        end
    end
    
    if ~isnan(response_data.QID29)
        % Is tank C more than 3/4 full?
        if (response_data.QID29) == 1 && current_fuel_levels(3) >= 1500
            % correct if 'yes' and 'above 1500'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID29: 1; SA: 1\n');        
        elseif (response_data.QID29) == 2 && current_fuel_levels(3) <= 1500
            % correct if 'no' and 'below 1500'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID29: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID29: 0; SA: 1\n');        
        end
    end

    if ~isnan(response_data.QID30)
        % Is tank D less than 1/4 full?
        if (response_data.QID30) == 1 && current_fuel_levels(4) <= 500
            % correct if 'yes' and 'below 500'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID30: 1; SA: 1\n');        
        elseif (response_data.QID30) == 2 && current_fuel_levels(4) >= 500
            % correct if 'no' and 'above 500'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID30: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID30: 0; SA: 1\n');        
        end
    end

    if ~isnan(response_data.QID31)
        % Is the flow rate for pump 1 above 800 (when switched on)?
        if (response_data.QID31) == 1
            % correct if 'yes' (P1 = 1000)
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID31: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID31: 0; SA: 1\n');        
        end
    end
    
    if ~isnan(response_data.QID32)
        % Is the flow rate for pump 2 above 500 (when switched on)?
        if (response_data.QID32) == 2
            % correct if 'no' (P2 = 500)
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID32: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID32: 0; SA: 1\n');        
        end
    end
    
    if ~isnan(response_data.QID33)
        % Is the flow rate for pump 3 below 800 (when switched on)?
        if (response_data.QID33) == 2
            % correct if 'no' (P3 = 800)
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID33: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID33: 0; SA: 1\n');        
        end
    end
    
    if ~isnan(response_data.QID34)
        % Is the flow rate for pump 4 below 500 (when switched on)?
        if (response_data.QID34) == 1
            % correct if 'yes' (P4 = 400)
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID34: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID34: 0; SA: 1\n');        
        end
    end
    
    if ~isnan(response_data.QID35)
        % Is the flow rate for pump 5 above 500 (when switched on)?
        if (response_data.QID35) == 2
            % correct if 'no' (P5 = 500)
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID35: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID35: 0; SA: 1\n');        
        end
    end
    
    if ~isnan(response_data.QID36)
        % Is the flow rate for pump 6 below 500 (when switched on)?
        if (response_data.QID36) == 2
            % correct if 'no' (P6 = 500)
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID36: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID36: 0; SA: 1\n');        
        end
    end
    
    if ~isnan(response_data.QID37)
        % Is the flow rate for pump 7 above 800 (when switched on)?
        if (response_data.QID37) == 2
            % correct if 'no' (P7 = 700)
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID37: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID37: 0; SA: 1\n');        
        end
    end
    
    if ~isnan(response_data.QID38)
        % Is the flow rate for pump 8 above 800 (when switched on)?
        if (response_data.QID38) == 2
            % correct if 'no' (P8 = 800)
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID38: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID38: 0; SA: 1\n');        
        end
    end

    if ~isnan(response_data.QID100)
        % Is pump 1 currently failed?
        if (response_data.QID100) == 2 && current_pump_status(1) == 2  % yes = 2 for this question 
            % correct if 'yes' and 'failed'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID100: 1; SA: 1\n');        
        elseif (response_data.QID100) == 3 && current_pump_status(1) == 1  % yes = 2 for this question 
            % correct if 'no' and 'on'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID100: 1; SA: 1\n');        
        elseif (response_data.QID100) == 3 && current_pump_status(1) == 0 % yes = 2 for this question 
            % correct if 'no' and 'off'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID100: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID100: 0; SA: 1\n');        
        end
    end 

    if ~isnan(response_data.QID101)
        % Is pump 2 currently failed?
        if (response_data.QID101) == 2 && current_pump_status(2) == 2 % yes = 2 for this question 
            % correct if 'yes' and 'failed'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID101: 1; SA: 1\n');        
        elseif (response_data.QID101) == 3 && current_pump_status(2) == 1 % yes = 2 for this question 
            % correct if 'no' and 'on'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID101: 1; SA: 1\n');        
        elseif (response_data.QID101) == 3 && current_pump_status(2) == 0 % yes = 2 for this question 
            % correct if 'no' and 'off'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID101: 1; SA: 1\n');        
        else
            %incorrect
    	    fprintf(fid,'QID101: 0; SA: 1\n');        
        end
    end 

    if ~isnan(response_data.QID102)
        % Is pump 4 currently failed?
        if (response_data.QID102) == 2 && current_pump_status(4) == 2 % yes = 2 for this question 
            % correct if 'yes' and 'failed'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID102: 1; SA: 1\n');        
        elseif (response_data.QID102) == 3 && current_pump_status(4) == 1 % yes = 2 for this question 
            % correct if 'no' and 'on'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID102: 1; SA: 1\n');        
        elseif (response_data.QID102) == 3 && current_pump_status(4) == 0 % yes = 2 for this question 
            % correct if 'no' and 'off'
            sa_scores(1) = sa_scores(1) + 1;    % level 1 SA
    	    fprintf(fid,'QID102: 1; SA: 1\n');        
        else
            % incorrect
    	    fprintf(fid,'QID102: 0; SA: 1\n');        
        end
    end 


%% LEVEL 2 Questions    
    pumps_on = current_pump_status == 1;
    flow_A = pumps_on(1)*flow_rates(1) + pumps_on(2)*flow_rates(2) + pumps_on(8)*flow_rates(8) - pumps_on(7)*flow_rates(7) - 800;
    flow_B = pumps_on(3)*flow_rates(3) + pumps_on(4)*flow_rates(4) + pumps_on(7)*flow_rates(7) - pumps_on(8)*flow_rates(8) - 800;
    flow_C = pumps_on(5)*flow_rates(5) - pumps_on(1)*flow_rates(1);
    flow_D = pumps_on(6)*flow_rates(6) - pumps_on(3)*flow_rates(3);
    
    if ~isnan(response_data.QID53)
        % Is the fuel level of tank A increasing?
        % Tank A = P1+P2+P8-P7-800;
        if (response_data.QID53) == 1 && flow_A > 0 && current_fuel_levels(1) < 4000 
            % if 'yes' and flow rate A is positive, and tank A is NOT full
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID53: 1; SA: 2\n');        
        elseif (response_data.QID53) == 2 && flow_A <= 0 && current_fuel_levels(1) > 0 
            % if 'no' and flow rate A is non-increasing, and tank A is NOT empty
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID53: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID53: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID54)
        % Is the fuel level of tank B increasing?
        % Tank B = P3+P4+P7-P8-800;
        if (response_data.QID54) == 1 && flow_B > 0 && current_fuel_levels(2) < 4000 
            % if 'yes' and flow rate B is positive, and tank A is NOT full
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID54: 1; SA: 2\n');        
        elseif (response_data.QID54) == 2 && flow_B < 0 && current_fuel_levels(2) > 0 
            % if 'no' and flow rate B is non-increasing, and tank A is NOT empty
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID54: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID54: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID55)
        % Is the fuel level of tank C increasing?
        % Tank C = P5-P1;
        if (response_data.QID55) == 1 && flow_C > 0 && current_fuel_levels(3) < 2000 
            % if 'yes' and flow rate C is positive, and tank A is NOT full
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA, response i
    	    fprintf(fid,'QID55: 1; SA: 2\n');        
        elseif (response_data.QID55) == 2 && flow_C <= 0 && current_fuel_levels(3) > 0 
            % if 'no' and flow rate C is non-increasing, and tank A is NOT empty
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID55: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID55: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID56)
        % Is the fuel level of tank D increasing?
        % Tank D = P6 - P3;
        if (response_data.QID56) == 1 && flow_D > 0 && current_fuel_levels(4) < 2000 
            % if 'yes' and flow rate D is positive, and tank A is NOT full
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID56: 1; SA: 2\n');        
        elseif (response_data.QID56) == 2 && flow_D <= 0 && current_fuel_levels(4) > 0 
            % if 'no' and flow rate D is non-increasing, and tank A is NOT empty
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID56: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID56: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID57)
        % Is the flow rate for pump 1 nominal (when switched on)?
        if (response_data.QID57) == 1
            % if 'yes', incorrect
    	    fprintf(fid,'QID57: 0; SA: 2\n');        
        elseif (response_data.QID57) == 2
            % if 'no', correct
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID57: 1; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID58)
        % Is the flow rate for pump 2 nominal (when switched on)?
        if (response_data.QID58) == 1
            % if 'yes', correct
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID58: 1; SA: 2\n');        
        elseif (response_data.QID58) == 2
            % if 'no', incorrect
    	    fprintf(fid,'QID58: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID59)
        % Is the flow rate for pump 3 nominal (when switched on)?
        if (response_data.QID59) == 1
            % if 'yes', correct
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID59: 1; SA: 2\n');        
        elseif (response_data.QID59) == 2
            % if 'no', incorrect
    	    fprintf(fid,'QID59: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID60)
        % Is the flow rate for pump 4 nominal (when switched on)?
        if (response_data.QID60) == 1
            % if 'yes', incorrect
    	    fprintf(fid,'QID60: 0; SA: 2\n');        
        elseif (response_data.QID60) == 2
            % if 'no', correct
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID60: 1; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID61)
        % Is the flow rate for pump 5 nominal (when switched on)?
        if (response_data.QID61) == 1
            % if 'yes', correct
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID61: 1; SA: 2\n');        
        elseif (response_data.QID61) == 2
            % if 'no', incorrect
    	    fprintf(fid,'QID61: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID62)
        % Is the flow rate for pump 6 nominal (when switched on)?
        if (response_data.QID62) == 1
            % if 'yes', correct
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID62: 1; SA: 2\n');        
        elseif (response_data.QID62) == 2
            % if 'no', incorrect
    	    fprintf(fid,'QID62: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID63)
        % Is the flow rate for pump 7 nominal (when switched on)?
        if (response_data.QID63) == 1
            % if 'yes', incorrect
    	    fprintf(fid,'QID63: 0; SA: 2\n');        
        elseif (response_data.QID63) == 2
            % if 'no', correct
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID63: 1; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID64)
        % Is the flow rate for pump 8 nominal (when switched on)?
        if (response_data.QID64) == 1
            % if 'yes', correct
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID64: 1; SA: 2\n');        
        elseif (response_data.QID64) == 2
            % if 'no', incorrect
    	    fprintf(fid,'QID64: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID65)
        % Would turning ON pump 1 help to minimize any tank current violations?
        if (response_data.QID65) == 1 && current_fuel_levels(1)<2000 && current_pump_status(1) ~= 1
            % if 'yes' and tank A is below 2000 and pump 1 is not on
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID65: 1; SA: 2\n');        
        elseif (response_data.QID65) == 2 && (current_fuel_levels(1)>2000 || current_pump_status(1) == 1)
            % if 'no' and (tank A is above 2000 or pump 1 is already on)
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID65: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID65: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID66)
        % Would turning OFF pump 1 help to minimize any tank current violations?
        if (response_data.QID66) == 1 && current_fuel_levels(1)>3000 && current_pump_status(1) == 1
            % if 'yes' and tank A is above 3000 and pump 1 is on
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID66: 1; SA: 2\n');        
        elseif (response_data.QID66) == 2 && (current_fuel_levels(1)<3000 || current_pump_status(1) ~= 1)
            % if 'no' and (tank A is below 3000 or pump 1 is not on)
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID66: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID66: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID67)
        % Would turning ON pump 2 help to minimize any tank current violations?
        if (response_data.QID67) == 1 && current_fuel_levels(1)<2000 && current_pump_status(2) ~= 1
            % if 'yes' and tank A is below 2000 and pump 2 is not on
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID67: 1; SA: 2\n');        
        elseif (response_data.QID67) == 2 && (current_fuel_levels(1)>2000 || current_pump_status(2) == 1)
            % if 'no' and (tank A is above 2000 or pump 2 is already on)
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID67: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID67: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID68)
        % Would turning OFF pump 2 help to minimize any tank current violations?
        if (response_data.QID68) == 1 && current_fuel_levels(1)>3000 && current_pump_status(2) == 1
            % if 'yes' and tank A is above 3000 and pump 2 is on
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID68: 1; SA: 2\n');        
        elseif (response_data.QID68) == 2 && (current_fuel_levels(1)<3000 || current_pump_status(2) ~= 1)
            % if 'no' and (tank A is below 3000 or pump 2 is not on)
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID68: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID68: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID69)
        % Would turning ON pump 3 help to minimize any tank current violations?
        if (response_data.QID69) == 1 && current_fuel_levels(2)<2000 && current_pump_status(3) ~= 1
            % if 'yes' and tank B is below 2000 and pump 3 is not on
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID69: 1; SA: 2\n');        
        elseif (response_data.QID69) == 2 && (current_fuel_levels(2)>2000 || current_pump_status(3) == 1)
            % if 'no' and (tank B is above 2000 or pump 3 is already on)
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID69: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID69: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID70)
        % Would turning OFF pump 3 help to minimize any tank current violations?
        if (response_data.QID70) == 1 && current_fuel_levels(2)>3000 && current_pump_status(3) == 1
            % if 'yes' and tank B is above 3000 and pump 3 is on
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID70: 1; SA: 2\n');        
        elseif (response_data.QID70) == 2 && (current_fuel_levels(2)<3000 || current_pump_status(3) ~= 1)
            % if 'no' and (tank B is below 3000 or pump 3 is not on)
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID70: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID70: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID71)
        % Would turning on pump 4 help to minimize any tank current violations?
        if (response_data.QID71) == 1 && current_fuel_levels(2)<2000 && current_pump_status(4) ~= 1
            % if 'yes' and tank A is below 2000 and pump 4 is not on
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID71: 1; SA: 2\n');        
        elseif (response_data.QID71) == 2 && (current_fuel_levels(2)>2000 || current_pump_status(4) == 1)
            % if 'no' and (tank A is above 2000 or pump 4 is already on)
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID71: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID71: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID72)
        % Would turning off pump 4 help to minimize any tank current violations?
        if (response_data.QID72) == 1 && current_fuel_levels(2)>3000 && current_pump_status(4) == 1
            % if 'yes' and tank B is above 3000 and pump 4 is on
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID72: 1; SA: 2\n');        
        elseif (response_data.QID72) == 2 && (current_fuel_levels(2)<3000 || current_pump_status(4) ~= 1)
            % if 'no' and (tank B is below 3000 or pump 4 is not on)
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID72: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID72: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID73)
        % Do you currently need to turn on pump 5 to be able to use pump 1?
        if (response_data.QID73) == 1 && current_fuel_levels(3)==0 && current_pump_status(5) ~= 1
            % if 'yes' and tank C is empty and pump 5 is off
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID73: 1; SA: 2\n');        
        elseif (response_data.QID73) == 2 && (current_fuel_levels(3)>0 || current_pump_status(5) == 1)
            % if 'no' and (tank C is above 0 or pump 5 is  on)
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID73: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID73: 0; SA: 2\n');        
        end
    end
    
    if ~isnan(response_data.QID75)
        % Do you currently need to turn on pump 6 to be able to use pump 3?
        if (response_data.QID75) == 1 && current_fuel_levels(4)==0 && current_pump_status(6) ~= 1
            % if 'yes' and tank D is empty and pump 6 is off
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID75: 1; SA: 2\n');        
        elseif (response_data.QID75) == 2 && (current_fuel_levels(4)>0 || current_pump_status(6) == 1)
            % if 'no' and (tank D is above 0 or pump 6 is  on)
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
    	    fprintf(fid,'QID75: 1; SA: 2\n');        
        else
            % incorrect
    	    fprintf(fid,'QID75: 0; SA: 2\n');        
        end
    end

    %{
    Commenting these out (and removing from qualtrics) on 10/13/2023 because we
    believe the logic has the potential to be too complex to code an answer to or requires
    simplification that would demand complex logic for responders. 

    if ~isnan(response_data.QID77)
        % Would turning ON pump 7 help to minimize any tank current violations?
        if (response_data.QID77) == 1 && current_fuel_levels(2)<2000 && current_fuel_levels(1)>2000 && current_pump_status(7) ~= 1
            % if 'yes' and tank B is below 2000 and tank A is above 2000 and pump 7 is not on
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
        elseif (response_data.QID77) == 1 && current_fuel_levels(1)>3000 && current_fuel_levels(2)<3000 && current_pump_status(7) ~= 1
            % if 'yes' and tank A is above 3000 and tank B is below 3000 and pump 7 is not on
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
        elseif (response_data.QID77) == 2
            % if 'no'
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
            % and 'yes' would NOT have been the correct response
            if current_fuel_levels(2)<2000 && current_fuel_levels(1)>2000 && current_pump_status(7) ~= 1
                % if tank B is below 2000 and tank A is above 2000 and pump 7 is not on
                sa_scores(2) = sa_scores(2) - 1;    % SUBTRACT level 2 SA
            elseif current_fuel_levels(1)>3000 && current_fuel_levels(2)<3000 && current_pump_status(7) ~= 1
                % if tank A is above 3000 and tank B is below 3000 and pump 7 is not on
                sa_scores(2) = sa_scores(2) - 1;    % SUBTRACT level 2 SA
            end
        else
            % incorrect
        end
    end
    
    if ~isnan(response_data.QID78)
        % Would turning OFF pump 7 help to minimize any tank current
        % violations? (ignoring other pump states)
        % Yes, if (A is below 2000 and B is above 2000) or if (B is above 3000 and A is below 3000)
        if (response_data.QID78) == 1 && current_fuel_levels(1)<2000 && current_fuel_levels(2)>2000 && current_pump_status(7) == 1
            % if 'yes' and tank B is above 2000 and tank A is below 2000 and pump 7 is on
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
        elseif (response_data.QID78) == 1 && current_fuel_levels(2)>3000 && current_fuel_levels(1)<3000 && current_pump_status(7) == 1
            % if 'yes' and tank A is below 3000 and tank B is above 3000 and pump 7 is on
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
        elseif (response_data.QID78) == 2
            % if 'no'
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
            % and 'yes' would NOT have been the correct response (i.e.
            % subtract again if 'no' is the wrong answer) am i going crazy?
            if current_fuel_levels(1)<2000 && current_fuel_levels(2)>2000 && current_pump_status(7) == 1
                % if tank B is above 2000 and tank A is below 2000 and pump 7 is on
                sa_scores(2) = sa_scores(2) - 1;    % level 2 SA
            elseif current_fuel_levels(2)>3000 && current_fuel_levels(1)<3000 && current_pump_status(7) == 1
                % if tank A is below 3000 and tank B is above 3000 and pump 7 is on
                sa_scores(2) = sa_scores(2) - 1;    % level 2 SA
            end
        else
            % incorrect
        end
    end
    
    if ~isnan(response_data.QID79)
        % Could you turn ON pump 8 to minimize any current tank violations? (regardless of failures)
        if (response_data.QID79) == 1 && current_fuel_levels(1)<2000 && current_fuel_levels(2)>2000 && current_pump_status(8) ~= 1
            % if 'yes' and tank A is below 2000 and tank B is above 2000 and pump 8 is not on
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
        elseif (response_data.QID79) == 1 && current_fuel_levels(2)>3000 && current_fuel_levels(1)<3000 && current_pump_status(8) ~= 1
            % if 'yes' and tank B is above 3000 and tank A is below 3000 and pump 8 is not on
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
        elseif (response_data.QID79) == 2
            % if 'no'
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
            % and 'yes' would NOT have been the correct response
            if current_fuel_levels(1)<2000 && current_fuel_levels(2)>2000 && current_pump_status(8) ~= 1
                % if tank A is below 2000 and tank B is above 2000 and pump 8 is not on
                sa_scores(2) = sa_scores(2) - 1;    % SUBTRACT level 2 SA
            elseif current_fuel_levels(2)>3000 && current_fuel_levels(1)<3000 && current_pump_status(8) ~= 1
                % if tank B is above 3000 and tank A is below 3000 and pump 8 is not on
                sa_scores(2) = sa_scores(2) - 1;    % SUBTRACT level 2 SA
            end
        else
            % incorrect
        end
    end
    
    if ~isnan(response_data.QID80)
        % Could you turn OFF pump 8 to minimize any current tank violations? (regardless of failures)
        if (response_data.QID80) == 1 && current_fuel_levels(2)<2000 && current_fuel_levels(1)>2000 && current_pump_status(8) == 1
            % if 'yes' and tank A is above 2000 and tank B is below 2000 and pump 8 is on
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
        elseif (response_data.QID80) == 1 && current_fuel_levels(1)>3000 && current_fuel_levels(2)<3000 && current_pump_status(8) == 1
            % if 'yes' and tank B is below 3000 and tank A is above 3000 and pump 8 is on
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
        elseif (response_data.QID80) == 2
            % if 'no'
            sa_scores(2) = sa_scores(2) + 1;    % level 2 SA
            % and 'yes' would NOT have been the correct response (i.e.
            % subtract again if 'no' is the wrong answer) am i going crazy?
            if current_fuel_levels(2)<2000 && current_fuel_levels(1)>2000 && current_pump_status(8) == 1
                % if tank A is above 2000 and tank B is below 2000 and pump 8 is on
                sa_scores(2) = sa_scores(2) - 1;    % level 2 SA
            elseif current_fuel_levels(1)>3000 && current_fuel_levels(2)<3000 && current_pump_status(8) == 1
                % if tank B is below 3000 and tank A is above 3000 and pump 8 is on
                sa_scores(2) = sa_scores(2) - 1;    % level 2 SA
            end
        else
            % incorrect
        end
    end
    %}

    %% LEVEL 3
    if ~isnan(response_data.QID81)
        % If no changes to the pumps occur, do you expect tank A to be in
        %   violation of its upper limit in 30 seconds.
        if (response_data.QID81) == 1 && (flow_A*0.5+current_fuel_levels(1)) > 3000
            % if 'yes' and (flow_A/min x 0.5min + current level (A) > 3000)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID81: 1; SA: 3\n');      
        elseif (response_data.QID81) == 2 && (flow_A*0.5+current_fuel_levels(1)) < 3000
            % if 'no' and (flow_A/min x 0.5min + current level (A) < 3000)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID81: 1; SA: 3\n');      
        else
            % incorrect
    	    fprintf(fid,'QID81: 0; SA: 3\n');      
        end
    end
    
    if ~isnan(response_data.QID82)
        % If no changes to the pumps occur, do you expect tank A to be in
        %   violation of its lower limit in 30 seconds.
        if (response_data.QID82) == 1 && (flow_A*0.5+current_fuel_levels(1)) < 2000
            % if 'yes' and (flow_A/min x 0.5min + current level (A) < 2000)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID82: 1; SA: 3\n');        
        elseif (response_data.QID82) == 2 && (flow_A*0.5+current_fuel_levels(1)) > 2000
            % if 'no' and (flow_A/min x 0.5min + current level (A) > 2000)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID82: 1; SA: 3\n');        
        else
            % incorrect
    	    fprintf(fid,'QID82: 0; SA: 3\n');        
        end
    end
    
    if ~isnan(response_data.QID83)
        % If no changes to the pumps occur, do you expect tank B to be in
        %   violation of its upper limit in 30 seconds.
        if (response_data.QID83) == 1 && (flow_B*0.5+current_fuel_levels(2)) > 3000
            % if 'yes' and (flow_B/min x 0.5min + current level (B) > 3000)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID83: 1; SA: 3\n');        
        elseif (response_data.QID83) == 2 && (flow_B*0.5+current_fuel_levels(2)) < 3000
            % if 'no' and (flow_B/min x 0.5min + current level (B) < 3000)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID83: 1; SA: 3\n');        
        else
            % incorrect
    	    fprintf(fid,'QID83: 0; SA: 3\n');        
        end
    end
    
    if ~isnan(response_data.QID84)
        % If no changes to the pumps occur, do you expect tank B to be in
        %   violation of its lower limit in 30 seconds.
        if (response_data.QID84) == 1 && (flow_B*0.5+current_fuel_levels(2)) < 2000
            % if 'yes' and (flow_B/min x 0.5min + current level (B) < 2000)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID84: 1; SA: 3\n');        
        elseif (response_data.QID84) == 2 && (flow_A*0.5+current_fuel_levels(2)) > 2000
            % if 'no' and (flow_B/min x 0.5min + current level (B) > 2000)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID84: 1; SA: 3\n');        
        else
            % incorrect
    	    fprintf(fid,'QID84: 0; SA: 3\n');        
        end
    end
    
    if ~isnan(response_data.QID85)
        % If no changes to the pumps occur, do you expect tank C to be 
        %   empty in 30 seconds.
        if (response_data.QID85) == 1 && (flow_C*0.5+current_fuel_levels(3)) <= 0
            % if 'yes' and (flow_C/min x 0.5min + current level (C) <= 0)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID85: 1; SA: 3\n');        
        elseif (response_data.QID85) == 2 && (flow_C*0.5+current_fuel_levels(3)) > 0
            % if 'no' and (flow_C/min x 0.5min + current level (C) > 0)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID85: 1; SA: 3\n');        
        else
            % incorrect
    	    fprintf(fid,'QID85: 0; SA: 3\n');        
        end
    end
    
    if ~isnan(response_data.QID86)
        % If no changes to the pumps occur, do you expect tank D to be 
        %   empty in 30 seconds.
        if (response_data.QID86) == 1 && (flow_D*0.5+current_fuel_levels(4)) <= 0
            % if 'yes' and (flow_D/min x 0.5min + current level (D) <= 0)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID86: 1; SA: 3\n');        
        elseif (response_data.QID86) == 2 && (flow_D*0.5+current_fuel_levels(4)) > 0
            % if 'no' and (flow_D/min x 0.5min + current level (D) > 0)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID86: 1; SA: 3\n');        
        else
            % incorrect
    	    fprintf(fid,'QID86: 0; SA: 3\n');        
        end
    end

    if ~isnan(response_data.QID95)
        % If no changes to the pumps occur, do you expect pump 1 to turn
        % off within the next 15 seconds?
        % yes if tank C empties (0) or tank A fills (4000)
         % yes = 2 & no = 3 for this question 
        if (response_data.QID95) == 2 && ((flow_C*0.25+current_fuel_levels(3)) <= 0 || (flow_A*0.25+current_fuel_levels(1))>=4000) % yes = 2 for this question 
            % if 'yes' and (flow_C/min x 0.25min + current level(C) <= 0 OR (flow_A/min x 0.25min + current level(A) >= 0)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID95: 1; SA: 3\n');        
        elseif (response_data.QID95) == 3 && ((flow_C*0.25+current_fuel_levels(3)) > 0 && (flow_A*0.25+current_fuel_levels(1)) < 4000) % yes = 2 for this question 
            % if 'no' and (flow_C/min x 0.25min + current level(C) > 0 AND (flow_A/min x 0.25min + current level(A) < 0)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID95: 1; SA: 3\n');        
        else
            % incorrect
    	    fprintf(fid,'QID95: 0; SA: 3\n');        
        end
    end    
    
    if ~isnan(response_data.QID96)
        % If no changes to the pumps occur, do you expect pump 3 to turn
        % off within the next 15 seconds?
        % yes if tank D empties (0) or tank B fills (4000)
         % yes = 2 & no = 3 for this question 
        if (response_data.QID96) == 2 && ((flow_D*0.25+current_fuel_levels(4)) <= 0 || (flow_B*0.25+current_fuel_levels(2))>=4000)
            % if 'yes' and (flow_D/min x 0.25min + current level(D) <= 0 OR (flow_B/min x 0.25min + current level(B) >= 0)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID96: 1; SA: 3\n');        
        elseif (response_data.QID96) == 3 && ((flow_D*0.25+current_fuel_levels(4)) > 0 && (flow_B*0.25+current_fuel_levels(2)) < 4000)
            % if 'no' and (flow_D/min x 0.25min + current level(D) > 0 AND (flow_B/min x 0.25min + current level(B) < 0)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID96: 1; SA: 3\n');        
        else
            % incorrect
    	    fprintf(fid,'QID96: 0; SA: 3\n');        
        end
    end
    
    if ~isnan(response_data.QID93)
        % If no changes to the pumps occur, do you expect pump 5 to turn
        % off within the next 15 seconds?
        % Yes if tank D will be full (2000) in 15 seconds or less
        if (response_data.QID93) == 2 && (flow_C*0.25+current_fuel_levels(3)) >= 2000 % yes = 2 for this question 
            % if 'yes' and (flow_C/min x 0.25min + current level (C) >= 2000)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID93: 1; SA: 3\n');        
        elseif (response_data.QID93) == 3 && (flow_C*0.25+current_fuel_levels(3)) < 2000 % yes = 2 for this question 
            % if 'no' and (flow_D/min x 0.5min + current level (C) < 2000)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID93: 1; SA: 3\n');        
        else
            % incorrect
    	    fprintf(fid,'QID93: 0; SA: 3\n');        
        end
    end
    
    if ~isnan(response_data.QID94)
        % If no changes to the pumps occur, do you expect pump 6 to turn
        % off within the next 15 seconds?
        % Yes if tank D will be full (2000) in 15 seconds or less
        if (response_data.QID94) == 2 && (flow_D*0.25+current_fuel_levels(4)) >= 2000 % yes = 2 for this question 
            % if 'yes' and (flow_D/min x 0.5min + current level (D) >= 2000)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID94: 1; SA: 3\n');        
        elseif (response_data.QID94) == 3 && (flow_D*0.25+current_fuel_levels(4)) < 2000 % yes = 2 for this question 
            % if 'no' and (flow_D/min x 0.5min + current level (D) < 2000)
            sa_scores(3) = sa_scores(3) + 1;    % level 3 SA
    	    fprintf(fid,'QID94: 1; SA: 3\n');        
        else
            % incorrect
    	    fprintf(fid,'QID94: 0; SA: 3\n');        
        end
    end
    
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



end

% fuel level change rates
% flow rate nominality
% pump adjustments
% 30-second projection of violations/empty C/D

%% RESMAN Functions
function pump_status = getPumpStatus(current_time, pump_times, pumps, actions)
% Returns the pump states at the 'current_time' using the
% actions performed on them from time t = 00:00 onwards
pump_status = zeros(1,8);

% get index for most recent data point
current_time = current_time(1)*60 + current_time(2);
count = getLastDatum(pump_times, current_time);

% update pump status according to each event before count
for i = 1:count
    switch actions{i}
        case 'On'
            pump_status(pumps(i)) = 1;
        case 'Off'
            pump_status(pumps(i)) = 0;
        case 'Fail'
            pump_status(pumps(i)) = 2;
        case 'Fix'
            pump_status(pumps(i)) = 0;
    end
end

end



function current_fuel_levels = getFuelLevels(current_time, pump_times, fuel_levels, pump_status, flow_rates)
% Updates the fuel levels to their state at the 'current_time' using the
% most recent fuel levels and most recent pump flow rates

current_fuel_levels = zeros(1,4);

% get index for most recent data point
current_time = current_time(1)*60 + current_time(2);
count = getLastDatum(pump_times, current_time);

% calculate current fuel levels
minutes_since = (current_time - (pump_times(count,1)*60 + pump_times(count,2)))/60;
current_fuel_levels = fuel_levels(count,:);
active_pumps = find(pump_status == 1); % subset of pumps that are on;
for i = 1:length(active_pumps)
    switch active_pumps(i)
        case 1     % if pump 1 is on
            % add fuel to tank A
            current_fuel_levels(1) = current_fuel_levels(1) +...
                flow_rates(1)*minutes_since;
            % remove fuel from tank C
            current_fuel_levels(3) = current_fuel_levels(3) -...
                flow_rates(1)*minutes_since;
        case 2     % if pump 2 is on
            % add fuel to tank A
            current_fuel_levels(1) = current_fuel_levels(1) +...
                flow_rates(2)*minutes_since;
        case 3     % if pump 3 is on
            % add fuel to tank B
            current_fuel_levels(2) = current_fuel_levels(2) +...
                flow_rates(3)*minutes_since;
            % remove fuel from tank D
            current_fuel_levels(4) = current_fuel_levels(4) -...
                flow_rates(3)*minutes_since;
        case 4     % if pump 4 is on
            % add fuel to tank B
            current_fuel_levels(2) = current_fuel_levels(2) +...
                flow_rates(4)*minutes_since;     
        case 5     % if pump 5 is on
            % add fuel to tank C
            current_fuel_levels(3) = current_fuel_levels(3) +...
                flow_rates(5)*minutes_since;
        case 6     % if pump 6 is on
            % add fuel to tank D
            current_fuel_levels(4) = current_fuel_levels(4) +...
                flow_rates(6)*minutes_since;
        case 7     % if pump 7 is on
            % add fuel to tank B
            current_fuel_levels(2) = current_fuel_levels(2) +...
                flow_rates(7)*minutes_since;
            % remove fuel from tank A
            current_fuel_levels(1) = current_fuel_levels(1) -...
                flow_rates(7)*minutes_since;
        case 8     % if pump 8 is on
            % add fuel to tank A
            current_fuel_levels(1) = current_fuel_levels(1) +...
                flow_rates(8)*minutes_since;
            % remove fuel from tank B
            current_fuel_levels(2) = current_fuel_levels(2) -...
                flow_rates(8)*minutes_since;      
    end
end

% subtract from A and B for constant depletion
current_fuel_levels(1) = current_fuel_levels(1) - ...
    flow_rates(9)*minutes_since;
current_fuel_levels(2) = current_fuel_levels(2) - ...
    flow_rates(9)*minutes_since;
end




