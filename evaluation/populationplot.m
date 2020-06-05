load('scenario_new.mat');
count_sum = 1;
population =[];
population_x =[];

% choose the scenario here  
file_name1 = 3;
file_name2_base = [4,6,9,12];     
for  file_name2_count = 1:4
    file_name2_count
    interrupt = 28;
    period_ave = [];
    for experiment = 1:10
        count = 0;
        for i=1:interrupt:336
            count= count+1;
            ave_ele = 0;
            for j = i:i+interrupt-1
%                 (file_name1*file_name2_count-1)*10+experiment
            ave_ele = ave_ele + group_sum((4*(file_name1-1)+file_name2_count-1)*10+experiment,j);
            end
            ave_ele = ave_ele/interrupt;
            period_ave(experiment,count) = ave_ele;
%             box_time(count) = floor(time_print(i));
%             if count == 12; 
%                 
        end
    end
    population(file_name2_count,:) = period_ave(:,12)';

    file_name2_count = 1 + file_name2_count;
    
    
end
boxplot(population',file_name2_base);
xlabel('Population')
ylabel('d_{s}[m]') 