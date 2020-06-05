%%%% you can do it
robots_number_base = [4,6,9,12];
of_sixteen = 0;
group_sum = [];
for scenario = 2%1:4
    for robots_number = 4%1:4
        for repeat_times = 1:10
%             scenario = 1;
%             robots_number = 2;
%             robots_number_base = [4,6,9,12];
%             [num2str(scenario) '/' num2str(robots_number_base(robots_number))]
import = xlsread(['D:/Course19/Dissertation/matlab/raw_data/' num2str(scenario) '/' num2str(robots_number_base(robots_number)) '/' num2str(repeat_times) '.csv']);
name=import(:,1);
time=import(:,2);
x=import(:,3);
y=import(:,4);

% calculate group distance
amount = robots_number_base(robots_number);


time_print = [];
loop_number = 0;
distance = [];
    dis_i = 0;
    number =0;
    for count = 1:amount:size(time)
        dis_i = dis_i+1;
        loop_number = loop_number+1;
        sum = 0;   
        number = number +1;
        for i = count:count+amount-2
            distance_ij = 0;
            
            for j= i+1 : count+amount-1
                
                a=i+1;
                b=j+1;
                dij =(x(i)-x(j))^2+(y(i)-y(j))^2;
    %              if(dij<9000)
                dij = sqrt(dij);
%                 if dis_i<10
%                  distance(number,dis_i)= dij;
%                 end
                distance_ij = distance_ij + dij; %for i
    %              end
            end 
            
            sum = distance_ij/(amount*(amount-1)/2);
        end
        number;
        group_sum(of_sixteen*10+repeat_times,number) = sum/1000;    %print
    %     save('nine','group_sum3')
        time_print = [time_print time(count)/1000];
    end
        end
    of_sixteen = of_sixteen+1
    end
end