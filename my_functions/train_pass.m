function train_pass
Month = input('Which month? (as a string, so with single quotes around it): ');
Days_off = input('Number of days absent from lab? *weekdays only*: ');

possible_months = {'January'; 'February';'March';'April';'May';'June'; ...
    'July';'August';'September';'October';'November';'December'};

number_of_days = [31;28;31;30;31;30;31;31;30;31;30;31];
month_no = [01;02;03;04;05;06;07;08;09;10;11;12];
year = 2014;

% ticket prices
monthly_pass = 222+11; % goTrain discount + $11 difference for martinez-davis monthly
daily = 16*2; % round-trip cost for a single martinez-davis trip
ten_ride = 98; % martinez-davis ten_ride cost

mon_find = strcmp(Month,possible_months);
days = number_of_days(mon_find==1);
mon = month_no(mon_find==1);

NumberDays = wrkdydif([num2str(mon) '/01/' num2str(year)], [num2str(mon) '/' num2str(days) '/' num2str(year)],Days_off);
ten_ride_nr = NumberDays/10;

price(1) = monthly_pass/NumberDays; % monthly
price(2) = (daily*NumberDays)/NumberDays; % daily
if NumberDays > 10 % 10 ride if going more than 10 days that month
    if ten_ride_nr<round(ten_ride_nr)
       price(3) = ((round(ten_ride_nr)-1)*ten_ride + ((ten_ride_nr-((round(ten_ride_nr)-1)))*10)*daily)/NumberDays; %ten ride        
    else
        price(3) = (round(ten_ride_nr)*ten_ride + ((ten_ride_nr-((round(ten_ride_nr))))*10)*daily)/NumberDays; %ten ride
    end
else
    price(3) = NaN;
end

if find(min(price)==price)==1;
    disp([char(10) '>>Buy monthly pass'])
elseif find(min(price)==price)==2;
    disp([char(10) '>>Buy daily passes'])
elseif NumberDays > 10 & find(min(price)==price)==3;
    disp([char(10) '>>Buy 10 ride passes + dailies'])
end

disp([char(10) '>Monthly pass will cost $' num2str(price(1)) ' per day']);
disp(['>Daily passes will cost $' num2str(price(2)) ' per day']);
if NumberDays > 10
    disp(['>Ten ride passes will cost $' num2str(price(3)) ' per day' char(10)]);
else
    disp(['>Not enough days for 10-ride pass' char(10)])
end

end