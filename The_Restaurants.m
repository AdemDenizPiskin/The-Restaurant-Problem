%% Parameters
delta_t = 1; % 1 time tick (min)
t_dur = 60*8; %simulation duration (8 hours)
t = linspace(0,t_dur,t_dur/delta_t);

N = 6; % number of restaurants
k = linspace(2,12,N);%ones(1,N);
mu = ones(1,N);
c = zeros(1,N); % Customers
c_t = zeros(t_dur/delta_t,N);
c_max = 25; %maximum capacity of restaurants

%Parameters of people
avg_people_time = 5; %a new customers comes about every 5 minitues.
pa  = 1/avg_people_time;
avg_stay = 40; % average time a customer group stays
pl = 1/avg_stay;

%Ca = B(max_group_size,avg_group_size/max_group_size)
avg_group_size = 4;
max_group_size = 10;

%people that come in time i
group = zeros(1,t_dur/delta_t);
%Customer matrix
cust_mtx = [];
%% Simulation

for i=1:t_dur/delta_t
    
   %Did a group came?
   toss = rand();
   if toss<=pa
       group(i) = binornd(max_group_size,avg_group_size/max_group_size);
   end
   %Choose Restaurant
   if group(i)~=0

   toss = sum(k+mu.*c)*rand();
   disp([toss sum(k+mu.*c)])
   %Decide which restaurant
       for j=1:N
           if toss<k(j)+mu(j)*c(j)
               c(j)=c(j)+group(i);
               cust_mtx = [cust_mtx;[group(i) j]];
               break
           else
               toss = toss-k(j)+mu(j)*c(j);
           end    
       end
   end
   %Leaving Customers
   mtx_size = size(cust_mtx);
   remove_list= [];
   for j = 1:mtx_size(1)
       toss = rand();
       if toss<=pl 
           c(cust_mtx(j,2)) = c(cust_mtx(j,2))-cust_mtx(j,1);
           remove_list = [remove_list j];
       end
   end
   cust_mtx(remove_list,:) = [];
   c_t(i,:) = c;
end

%% Plot
figure(1)
for i = 1:N
subplot(2,3,i)
plot(t,c_t(:,i))
xlabel('time (min)')
ylabel('Customers')
title(strcat('Restaurant ',int2str(i)))
grid on
end
% figure(2),
% stem(t,group)
% xlabel('time (min)')
% ylabel('Group Size')
% title('Groups coming')
% grid on

