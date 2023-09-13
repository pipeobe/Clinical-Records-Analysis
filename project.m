%% step 1
dataseto = xlsread("clinicalrecords.csv");%original dataset
datasetr = xlsread("H_F_R_D.csv"); %reprocessed dataset

%% step 2
%reprocessing data
%Check for missing numbers and outliers 
%Checking cells that arent numbers
isnan(dataseto);

%Checking for missing data
ismissing(dataseto);

%Check for outliers in certain subset data using isoutlier and boxplots

%34 outliers found in total in the creatinine_phosphokinase column
boxplot(dataseto(:,3)) %29 outliers found 
sum(isoutlier(dataseto(:,3))==1) %34 outliers found

%2outliers found in total in the Ejection Fraction column
boxplot(dataseto(:,5)); %2 outliers found
sum(isoutlier(dataseto(:,5))==1) %1 outlier found

%20 outliers found in total in the Ejection Fraction column
boxplot(dataseto(:,7)); % 20 outliers found
sum(isoutlier(dataseto(:,7))==1)% 14 outliers found

%35 outliers found in total in the Ejection Fraction column
boxplot(dataseto(:,8)) %30 outliers found
sum(isoutlier(dataseto(:,8))==1) %35 outliers found

%4 outliers found in total in serum sodium column
boxplot(dataseto(:,9)) %4 outliers found
sum(isoutlier(dataseto(:,9))==1) %3 outliers found

% mean,median and mode of grouped data
mean(dataseto(:,3))%581
median(dataseto(:,3))%250
mode(dataseto(:,3))%582
mean(dataseto(:,5))%38
median(dataseto(:,5))%38
mode(dataseto(:,5)) %35
mean(dataseto(:,7))%263360
median(dataseto(:,7))% 262000
mode(dataseto(:,7))%263360
mean(dataseto(:,8))%1.3939
median(dataseto(:,8))%1.1
mode(dataseto(:,8))%1
mean(dataseto(:,9))%136.6254
median(dataseto(:,9))%137
mode(dataseto(:,9))%136

%Group data
age = (datasetr(:,1));
anaemia = (dataseto(:,2));
CPK = (datasetr(:,3));
diabetes = (dataseto(:,4));
EF = (datasetr(:,5));
HBP = (dataseto(:,6));
platelets= (datasetr(:,7));
SC = (datasetr(:,8));
SS = (datasetr(:,9));
gender = (datasetr(:,10));
smoking = (datasetr(:,11));
Time = (datasetr(:,12));
Death = (datasetr(:,13));

%Create table
T= readtable('H_F_R_D.csv');
T(:,:);


%% step 3
%visualize data
histogram(age) %Patients between the ages of 60-65 had the most cases of heart failure. 
xlabel('Age (Years)');
ylabel('Number of Patients');
title('Age Distribution');

sum(anaemia == 1)% 129 had anaemia
sum(diabetes == 1)% 125 patients out of 299 had diabetes
sum(HBP == 1) % 105 patients out of 299 had diabetes
sum(smoking ==1)% 96 out of 299 patients smoke
sum(gender ==0)% 194 out of 299 patients were males 105 females

Death= categorical(Death);
summary(Death)%96 patients died during follow up period

%Histogram shows most patients fell below the ideal ejection fraction
%percentage after heart failure (55%-75%)
histogram(EF)
xlabel('Ejection fraction (%)');
ylabel('Number of Patients');
title('Ejection fraction Distribution');

%Histogram confirms heart failure can cause low level of sodium in blood.
histogram(SS)
xlabel('Serum sodium (mEq/L)');
ylabel('Number of Patients');
title('Serum sodium Distribution');

%Histogram shows majority of patient had a normal level of SC.
histogram(SC)
xlabel('Serum creatinine(mg/dL)');
ylabel('Number of Patients');
title('Serum creatininie Distribution');

%Histogram shows majority of patient had a normal level of CPK 
%although a number of patients were above normal which is not surprising considering heart failure can cayse high levels of cpk.
histogram(CPK)
xlabel('creatinine phosphokinase (mcg/L)');
ylabel('Number of Patients');
title('creatinine phosphokinase Distribution');

%Histogram shows majority of patients had a normal level of platelets
histogram(platelets)
xlabel('platelets (kiloplatelets/mL)');
ylabel('Number of Patients');
title('platelets Distribution');


%Histogram explored whether there is a relationship between smoking and ejection fraction in this group of patients
% No relationship
tf = (T.smoking == false);
h1 = histogram(T.ejection_fraction(tf),'BinMethod','integers');
hold on
tf = (T.smoking == true);
h2 = histogram(T.ejection_fraction(tf),'BinMethod','integers');
xlabel('Ejection fraction (%)');
ylabel('Number of Patients');
legend('Nonsmokers','Smokers');
title('Ejection fraction Distributions for Smokers and Nonsmokers');
hold off

%Histogram explored whether there is a relationship between smoking and serum sodium in this group of patients
% No relationship
tf = (T.smoking == false);
h1 = histogram(T.serum_sodium(tf),'BinMethod','integers');
hold on
tf = (T.smoking == true);
h2 = histogram(T.serum_sodium(tf),'BinMethod','integers');
xlabel('Serum sodium (mEq/L)');
ylabel('Number of Patients');
legend('Nonsmokers','Smokers');
title('serum sodium Distributions for Smokers and Nonsmokers');
hold off


%Histogram explored Death Event in relation to time (days)
%The disrubtiition shows most death events occured within the first 60-70 days
tf = (T.DEATH_EVENT == false);
h1 = histogram(T.time(tf),'BinMethod','integers');
hold on
tf = (T.DEATH_EVENT == true);
h2 = histogram(T.time(tf),'BinMethod','integers');
xlabel('Time (Days)');
ylabel('Number of Patients');
legend('Alive','Dead');
title('Time in comparison to Death Event ');
hold off


%Histogram explored Death Event in relation to Ejection Fraction.
%The disrubtiition shows one is more likely to die if EF is below normal
tf = (T.DEATH_EVENT == false);
h1 = histogram(T.ejection_fraction(tf),'BinMethod','integers');
hold on
tf = (T.DEATH_EVENT == true);
h2 = histogram(T.ejection_fraction(tf),'BinMethod','integers');
xlabel('Ejection Fraction (%)');
ylabel('Number of Patients');
legend('Alive','Dead');
title('Ejection Fraction comparison to Death Event ');
hold off


