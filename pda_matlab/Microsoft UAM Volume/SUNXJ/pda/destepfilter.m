function [y,num_corrected]=destepfilter(x,f0_range,hz_or_st) 
% [y,num_corrected]=destepfilter(x,f0_range,hz_or_st) 
% de-step filter: see Paul Bagshaw's Ph.D. thesis
%   Input parameters :
%
%       x:              Input f0 
%       f0_range:       a vector [low_f0 high_f0]
%       hz_or_st:  		'hz': the unit of f0 is Hz; 'st': the unit of f0 is semitone
%
%   Output parameters:
%       
%       y:        		filtered f0
%       num_corrected:  number of f0 points that have been corrected
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
%   
%   For update information, please check http://mel.speech.nwu.edu/sunxj.
%
%   Xuejing Sun
%   Department of Communication Sciences and Disorders
%   Northwestern University, USA
%   sunxj@northwestern.edu
%
%   Last modified: Dec. 19, 2001
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin<3
    error('the third argument is hz_or_st (hz or st) ')
end

[r,c]=size(x);
if min(r,c)~=1
    error('sorry, no matrix here!:(')
end

if r==1 % row vector
    len=c;
else
    x=x.';
    len=r;
end

% room for output
y = zeros(len,1);
num_corrected=0;
if (mod(len,2)==0)
    num_sets=len+1; % make it an odd number
else
    num_sets=len;
end
Set=zeros(num_sets,len);
set_index = (num_sets+1)/2;
true_pitch_set_index = 1;
octave_error_threshold = 0.75; %% 75% 
%  Put the first F0 value into Set(set_index)
Set(set_index,1)=x(1);
% FOR all other F0 values of a voiced region
for i=2:len
    % change set if octave error 
    % IF (current_F0_value > (preceding_F0_value * (1 + octave_error_threshold))
    if (strcmp(hz_or_st, 'hz'))
        if (x(i) > (x(i-1) * (1 + octave_error_threshold)))
            % /* current_value is too high, change set */
            set_index = set_index + 1; 
        end
        % IF (current_F0_value < (preceding_F0_value * (octave_error_threshold))
        if (x(i-1) > (x(i) * (1+octave_error_threshold)))
            %/* current_value is too low, change set */
            set_index = set_index - 1;
        end
    else
        if (x(i) > (x(i-1) + 12*log2(1 + octave_error_threshold)))
            % /* current_value is too high, change set */
            set_index = set_index + 1; 
        end        
        % IF (current_F0_value < (preceding_F0_value * (octave_error_threshold))
        if (x(i-1) > (x(i)+12 *log2 (1+octave_error_threshold)))
            %/* current_value is too low, change set */
            set_index = set_index - 1;
        end
    end
    % put current_F0_value into Set(set_index)
    Set(set_index,i)=x(i);
end
%  Compute the set with the most items  and assume that these values represent the true F0 values
%  true_pitch_set_index = the index of the set with most items
num_items=zeros(num_sets,1);
for i=1:num_sets
    num_items(i)=length(find(Set(i,:)>0));
end
[max_num_items, true_pitch_set_index] = max(num_items);
%FOR all Sets
for i=1:num_sets
    for j=1:len
        if(Set(i,j)>0 )
            raw_f0=Set(i,j);
            if (true_pitch_set_index == i)
                corrected_f0=raw_f0;
            else
                if (strcmp(hz_or_st , 'hz'))
                    corrected_f0=raw_f0*(2^(true_pitch_set_index - i)); %     correct the F0 values in each set by multiplying with 2^(true_pitch_set_index - set_index)
                    while(corrected_f0<f0_range(1))
                    	corrected_f0=corrected_f0*2;
                    end
                    while(corrected_f0>f0_range(2))
                    	corrected_f0=corrected_f0/2;
                    end
                    	
                    num_corrected=num_corrected+1;
                else
                    corrected_f0=raw_f0+12*(true_pitch_set_index - i); 
                    while(corrected_f0<f0_range(1))
                    	corrected_f0=corrected_f0+12;
                    end
                    while(corrected_f0>f0_range(2))
                    	corrected_f0=corrected_f0-12;
                    end
                    
                    num_corrected=num_corrected+1;
                end
            end
            y(j)=corrected_f0;
        end
    end
end
