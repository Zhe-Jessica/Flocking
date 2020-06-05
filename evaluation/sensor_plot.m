%scenario_new.mat;

sum_test = [];
count_sum = 1;
sensor_y =[];
sensor_x =['120';'150'];
%% 1 
file_name2_count = 1;
    sensor_count = 0;
for  file_name1 = 3:4
    sensor_count = sensor_count+1;
    file_name2_base = [4,6,9,12];
    interrupt = 28;
    period_ave = [];
    for experiment = 1:10
        count = 0;
        for i=1:interrupt:336
            count= count+1;
            ave_ele = 0;
            for j = i:i+interrupt-1
            ave_ele = ave_ele + group_sum((4*(file_name1-1)+file_name2_count-1)*10+experiment,j);
            end
            ave_ele = ave_ele/interrupt;
            period_ave(experiment,count) = ave_ele;
            box_time(count) = floor(time_print(i));                
        end
    end
    sensor_y(sensor_count,:) = period_ave(:,12)';
end
h1 = subplot(1,4,file_name2_count);
sum_test = sum_test';
boxplot(sensor_y',sensor_x);
box on
ylim([0 0.06])
title(sprintf('%s robots', num2str(file_name2_base(file_name2_count))))
h1_pos = get(h1,'Position');
 %% 2
file_name2_count = 2;
sensor_count = 0;
for  file_name1 = 3:4
    sensor_count = sensor_count+1;
    file_name2_base = [4,6,9,12];
    interrupt = 28;
    period_ave = [];
    for experiment = 1:10
        count = 0;
        for i=1:interrupt:336
            count= count+1;
            ave_ele = 0;
            for j = i:i+interrupt-1
            ave_ele = ave_ele + group_sum((4*(file_name1-1)+file_name2_count-1)*10+experiment,j);
            end
            ave_ele = ave_ele/interrupt;
            period_ave(experiment,count) = ave_ele;
            box_time(count) = floor(time_print(i));               
        end
    end
    sensor_y(sensor_count,:) = period_ave(:,12)';
end
 h2 = subplot(1,4,file_name2_count);
 sum_test = sum_test';
 boxplot(sensor_y',sensor_x);
 box on 
 ylim([0 0.06]);
 set(gca,'YTickLabel',[]);
 title(sprintf('%s robots', num2str(file_name2_base(file_name2_count))))
h2_pos = get(h2,'Position');
set(h2,'Position',[h1_pos(1)+h1_pos(3) h1_pos(2) h1_pos(3:end)]) %using position of subplot1 put subplot2next to it.
 %% 3
file_name2_count = 3;
sensor_count = 0;
for  file_name1 = 3:4
    sensor_count = sensor_count+1;
    file_name2_base = [4,6,9,12];
    interrupt = 28;
    period_ave = [];
    for experiment = 1:10
        count = 0;
        for i=1:interrupt:336
            count= count+1;
            ave_ele = 0;
            for j = i:i+interrupt-1
            ave_ele = ave_ele + group_sum((4*(file_name1-1)+file_name2_count-1)*10+experiment,j);
            end
            ave_ele = ave_ele/interrupt;
            period_ave(experiment,count) = ave_ele;
            box_time(count) = floor(time_print(i));               
        end
    end
    sensor_y(sensor_count,:) = period_ave(:,12)';
end
 h3 = subplot(1,4,file_name2_count);
 sum_test = sum_test';
 boxplot(sensor_y',sensor_x);
 box on 
 ylim([0 0.06]);
 set(gca,'YTickLabel',[]);
 title(sprintf('%s robots', num2str(file_name2_base(file_name2_count))))
h3_pos = get(h3,'Position');
set(h3,'Position',[h2_pos(1)+h2_pos(3)-0.041 h2_pos(2) h3_pos(3:end)]) %using position of subplot1 put subplot2next to it.

 %% 4
file_name2_count = 4;
sensor_count = 0;
for  file_name1 = 3:4
    sensor_count = sensor_count+1;
    file_name2_base = [4,6,9,12];
    interrupt = 28;
    period_ave = [];
    for experiment = 1:10
        count = 0;
        for i=1:interrupt:336
            count= count+1;
            ave_ele = 0;
            for j = i:i+interrupt-1
            ave_ele = ave_ele + group_sum((4*(file_name1-1)+file_name2_count-1)*10+experiment,j);
            end
            ave_ele = ave_ele/interrupt;
            period_ave(experiment,count) = ave_ele;
            box_time(count) = floor(time_print(i));               
        end
    end
    sensor_y(sensor_count,:) = period_ave(:,12)';
end
 h4 = subplot(1,4,file_name2_count);
 sum_test = sum_test';
 boxplot(sensor_y',sensor_x);
 box on 
 ylim([0 0.06]);
 set(gca,'YTickLabel',[]);
 title(sprintf('%s robots', num2str(file_name2_base(file_name2_count))))
h4_pos = get(h4,'Position');
set(h4,'Position',[h3_pos(1)+h3_pos(3)-0.078 h3_pos(2) h4_pos(3:end)]) %using position of subplot1 put subplot2next to it.
%% 
xlabel('Desired distance', 'Units', 'normalized', 'Position', [-1, -0.05, 0],'FontSize',15); % Set Title with correct Position
ylabel('Average distance [m]', 'Units', 'normalized', 'Position', [-3.2, 0.5, 0],'FontSize',15);