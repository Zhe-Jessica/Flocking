%scenario_new.mat;

sum_test = [];
count_sum = 1;
sensor_y =[];
population_x =[];
sensor_x =['2000';'3000'];
 
file_name2_count = 1
    sensor_count = 0;
for  file_name1 = 1:2:3
    sensor_count = sensor_count+1;
    file_name2_base = [4,6,9,12];
%     population_x(file_name2_count) = file_name2_base(file_name2_count);
    

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
    sensor_y(sensor_count,:) = period_ave(:,12)';
    
%     boxplot(period_ave,box_time);
%     xlabel('time[s]')
%     ylabel('distance[m]') 
%     title(sprintf('%s robots in scenario %s', num2str(file_name2_base(file_name2_count)),num2str(file_name1)))

%       ylim([0 0.06])
    
%     saveas(gcf,sprintf('%s robots in scenario %s.jpg', num2str(file_name2_base(file_name2_count)),num2str(file_name1)))

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
 subplot(1,4,file_name2_count);
 sum_test = sum_test';
 boxplot(sensor_y',sensor_x);
 ylim([0 0.06])
 title(sprintf('%s robots', num2str(file_name2_base(file_name2_count))))
for  file_name2_count = 2:4
    sensor_count = 0;
for  file_name1 = 1:2:3
    sensor_count = sensor_count+1;
    file_name2_base = [4,6,9,12];
%     population_x(file_name2_count) = file_name2_base(file_name2_count);
    

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
    sensor_y(sensor_count,:) = period_ave(:,12)';
    
%     boxplot(period_ave,box_time);
%     xlabel('time[s]')
%     ylabel('distance[m]') 
%     title(sprintf('%s robots in scenario %s', num2str(file_name2_base(file_name2_count)),num2str(file_name1)))

%       ylim([0 0.06])
    
%     saveas(gcf,sprintf('%s robots in scenario %s.jpg', num2str(file_name2_base(file_name2_count)),num2str(file_name1)))

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
 subplot(1,4,file_name2_count);
 sum_test = sum_test';
 boxplot(sensor_y',sensor_x);
 ylim([0 0.06]);
 set(gca,'YTickLabel',[]);
 title(sprintf('%s robots', num2str(file_name2_base(file_name2_count))))
end
xlabel('Goal force', 'Units', 'normalized', 'Position', [-1.9, -0.05, 0],'FontSize',15); % Set Title with correct Position
ylabel('Average distance [m]', 'Units', 'normalized', 'Position', [-3.8, 0.5, 0],'FontSize',15);
% suplabel('super X label');
% suplabel('super Y label','y');
%    [ax3,h2]=suplabel('super Y label (right)','yy');
%    [ax4,h3]=suplabel('super Title'  ,'t');
%  xlabel('sensor')
%  ylabel('distance[m]') 
%  sgtitle
%  title(sprintf('%s robots in scenario %s', num2str(file_name2_base(file_name2_count)),num2str(file_name1)))

%  close all
%  filename = 'ANOVA.xlsx';
%  xlswrite(filename,sum_test)