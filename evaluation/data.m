%%%%%%%%%%% modify amount, group_sum+group number
%%%%%%%%%%% 
% [xlsfile,path2xls] = uigetfile('1.csv', 'Import-Daten');
% import = xlsread(fullfile(path2xls,xlsfile));
for scenario = 1:4
    scenario_name = num2str(scenario);
    scenario_name = 9;
    import = fileread([num2str(scenario_name) '_' num2str(scenario_name) '.csv'])

    scenario_name = 9;
%     import = fileread(['D:/Course19/Dissertation/matlab/raw_data/1/' num2str(scenario_name) '/' num2str(scenario_name) '.csv'])
    import = fileread(['D:/backup/MSc/2/matlab/raw_data/1/' num2str(scenario_name) '/' num2str(scenario_name) '.csv'])
%(scenario_name '_' scenario_name '.csv')
% import = xlsread(scenario_name '.csv');
%('D:/Course19/Dissertation/matlab/raw_data/1/' '9' '/9.csv')
name=import(:,1);
time=import(:,2);
x=import(:,3);
y=import(:,4);


% for i = 1:12
%     tracex = [];
%     tracey = [];
%     for index = 1:size(name)
%      if name(index)==i
%           tracex=[tracex x(index)]
%           tracey=[tracey y(index)]
%           plot(tracex, tracey);
%           hold on
%      end
%     end
% end
% hold off

% calculate group distance
amount = 9;
(amount*(amount-1)/2)
group_sum10 = [];
time_print = [];
loop_number = 0;
distance = [];
    dis_i = 0;

for count = 1:amount:size(time)
    dis_i = dis_i+1;
    loop_number = loop_number+1;
    sum = 0;
    number =0;

    for i = count:count+amount-2
        
        distance_ij = 0;
        for j= i+1 : count+amount-1
            number = number +1;
            a=i+1;
            b=j+1;
            dij =(x(i)-x(j))^2+(y(i)-y(j))^2;
%              if(dij<9000)
            dij = sqrt(dij);
            if dis_i<10
             distance(number,dis_i)= dij;
            end
            distance_ij = distance_ij + dij; %for i
%              end
            
        end 
        sum = distance_ij/(amount*(amount+1)/2);
    end
    number;
    group_sum10 = [group_sum10 sum/1000];         %print
%     save('nine','group_sum3')
    time_print = [time_print time(count)/1000];
end
end
% plot(time_print, group_sum10);
% ylim([0 0.01])
% title('robot distance')
% xlabel('time/s') 
% ylabel('distance/m') 
% loop_number


% 2
% group_sum = [];
% time_print = [];
% for i =  1:2:size(time)
%     
%      dij = 0;
%      dij = sqrt((x(i)-x(i+1))^2+(y(i)-y(i+1))^2)
% 
%     group_sum = [group_sum dij];         %print
%     time_print = [time_print time(i)];
%    
% end
% plot(time_print, group_sum);
% title('total distance')
% xlabel('time') 
% ylabel('distance') 