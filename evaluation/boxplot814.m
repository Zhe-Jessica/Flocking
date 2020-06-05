sum_test = [];
count_sum = 1;
population =[];
population_x =[];
%  ha = tight_subplot(1,4,[.1 .01],[.01 .01],[.05 .01])
 
for  file_name1 = 3
     sum_test(2,count_sum)= file_name1;
for  file_name2_count = 4
    file_name2_base = [4,6,9,12];
%     population_x(file_name2_count) = file_name2_base(file_name2_count);
    
    sum_test(3,count_sum)= file_name2_base(file_name2_count);

%     file_name1 = num2str(file_name1);
%     file_name2 = num2str(file_name2_base(file_name2_count));
%     load([file_name1 '_' file_name2 '.mat']);
    
%     twelve_mix = [group_sum1;group_sum2;group_sum3;group_sum4;group_sum5;group_sum6;group_sum7;group_sum8;group_sum9;group_sum10];
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
            box_time(count) = floor(time_print(i));
%             if count == 12; 
%                 
        end
    end
    population(file_name2_count,:) = period_ave(:,12)';

%       subplot(1,4,file_name2_count);

%       axes(ha(file_name2_count)); 
%         plot(randn(10,3));
      boxplot(period_ave,box_time);
      
%     ylim([0 0.06])
    
    if file_name2_count >1
        
%     yticklabels({})
    end 
% figure;
%     axes('Color','none','XColor','none');
%     axis off ; 
%     xlabel('time[s]')
%     ylabel('distance[m]') 
%     title(sprintf('%s robots in scenario %s', num2str(file_name2_base(file_name2_count)),num2str(file_name1)))
    title(sprintf('%s robots', num2str(file_name2_base(file_name2_count))))   


%     figure
% (file_name1*file_name2_count-1)*10
%     clear;

%     for i = 1:10
%         sum_test(1,count_sum) = 0;
%         for j = 1:12  
%             sum_test(1,count_sum) = sum_test(1,count_sum) + period_ave(i,j);
%         end
%         sum_test(1,count_sum) = sum_test(1,count_sum)/12;
%         count_sum = count_sum +1;
%     end 
end
% set(ha(2:4),'YTickLabel','')
end
    xlabel('Time[s]', 'Units', 'normalized','FontSize',12); % Set Title with correct Position
    ax = gca;
    ax.FontSize = 12;
    ylabel('Average distance[m]', 'Units', 'normalized','FontSize',12);
%      saveas(gcf,sprintf('%s robots in scenario %s.jpg', num2str(file_name2_base(file_name2_count)),num2str(file_name1)))
     saveas(gcf,sprintf('%s.jpg', num2str(file_name1)))

 sum_test = sum_test';
 
%  boxplot(population',file_name2_base);
%  xlabel('population')
%  ylabel('distance[m]') 
%  title(sprintf('%s robots in scenario %s', num2str(file_name2_base(file_name2_count)),num2str(file_name1)))

%  close all
%  filename = 'ANOVA.xlsx';
%  xlswrite(filename,sum_test)