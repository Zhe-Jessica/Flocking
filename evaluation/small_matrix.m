sum_test = [];
count_sum = 1;
for  file_name1 = 3%:4
     sum_test(2,count_sum)= file_name1;
for  file_name2_count = 3%:4
    file_name2_base = [4,6,9,12];
    

    sum_test(3,count_sum)= file_name2_base(file_name2_count);

    file_name1 = num2str(file_name1);
    file_name2 = num2str(file_name2_base(file_name2_count));
    load([file_name1 '_' file_name2 '.mat']);
    
    twelve_mix = [group_sum1;group_sum2;group_sum3;group_sum4;group_sum5;group_sum6;group_sum7;group_sum8;group_sum9;group_sum10];
    interrupt = 28;
    period_ave = [];
    for experiment = 1:10
        count = 0;
        for i=1:interrupt:336
            count= count+1;
            ave_ele = 0;
            for j = i:i+interrupt-1
            ave_ele = ave_ele + twelve_mix(experiment,j);
            end
            ave_ele = ave_ele/interrupt;
            period_ave(experiment,count) = ave_ele;
            box_time(count) = floor(time_print(i));
        end
    end
    
    boxplot(period_ave,box_time);
    xlabel('time[s]')
    ylabel('distance[m]') 
    title(sprintf('%s robots in scenario %s', file_name2,file_name1))
    ylim([0 0.04])
    
    saveas(gcf,sprintf('%s robots in scenario %s.jpg', file_name2,file_name1))

%     figure
%     clear;

    for i = 1:10
        sum_test(1,count_sum) = 0;
        for j = 1:12  
            sum_test(1,count_sum) = sum_test(1,count_sum) + period_ave(i,j);
        end
        sum_test(1,count_sum) = sum_test(1,count_sum)/12;
        count_sum = count_sum +1;
    end 
end
end
 sum_test = sum_test'
 close all
%  filename = 'ANOVA.xlsx';

%  xlswrite(filename,sum_test)