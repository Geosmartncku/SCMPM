% Spatial calibration and PM2. 5 mapping 
% Step-1   Spatial and nonSpatial calibration 
% by Hone-Jay Chu
close all;
clear all;
SS = shaperead('.\Data\TWN_shp\gadm36_TWN_0.shp');
[num1, text1, rawData1] =xlsread('.\Data\Newcase\1\EPA.csv');
[num, text, rawData] =xlsread('.\Data\Newcase\1\airbox.csv');
outlier=90;

Index = count(text, 's_d0');
loc = find(Index(1,:));
PM=num(:,loc);

Index = count(text, 'gps_lat');
loc = find(Index(1,:));
yy=num(:,loc);

Index = count(text, 'gps_lon');
loc = find(Index(1,:));
xx=num(:,loc);


% Data clearing
loc=find ((PM<=0)|(PM>outlier));
PM(loc)=[];
xx(loc)=[];
yy(loc)=[];
loc=find ((xx<120)|(xx>130));
PM(loc)=[];
xx(loc)=[];
yy(loc)=[];
loc=find ((yy<20)|(yy>25.5));
PM(loc)=[];
xx(loc)=[];
yy(loc)=[];
loc=find ((xx==121.4930)&(yy==22.6740));
PM(loc)=[];
xx(loc)=[];
yy(loc)=[];
loc=find ((xx==120.368)&(yy==22.337));
PM(loc)=[];
xx(loc)=[];
yy(loc)=[];
loc=find ((xx==120.369)&(yy==22.335));
PM(loc)=[];
xx(loc)=[];
yy(loc)=[];

% Original Airbox
figure
%histogram(PM);

s=6;
c=PM;
 scatter(xx,yy,s,c,'fill');
 axis equal; axis off;
 hold on;
  for i=1:length(SS)
    x{i}=SS(i,1).X;
    y{i}=SS(i,1).Y;
    plot(x{i},y{i},'k-');
  end;
colorbar;
xlim([120, 122]);ylim([21.5, 25.5]);
title('Original Airbox Data')

% EPA data 
PM2=num1(:,1); 
xx2=num1(:,23);
yy2=num1(:,18);

loc=find ((PM2>outlier));
PM2(loc)=[];
xx2(loc)=[];
yy2(loc)=[];

loc=find( isnan(PM2));
PM2(loc)=[];
xx2(loc)=[];
yy2(loc)=[];

loc=find ((xx2<120)|(xx2>130));
PM2(loc)=[];
xx2(loc)=[];
yy2(loc)=[];
loc=find ((yy2<20)|(yy2>25.5));
PM2(loc)=[];
xx2(loc)=[];
yy2(loc)=[];
loc=find( isnan(yy2)|isnan(xx2));
PM2(loc)=[];
xx2(loc)=[];
yy2(loc)=[];

% EPA data 
 figure
 %histogram(PM2,15);
 s=6;
 c2=PM2;
 scatter(xx2,yy2,s,c2,'fill');
 axis equal; axis off;
 hold on;
  for i=1:length(SS)
    x{i}=SS(i,1).X;
    y{i}=SS(i,1).Y;
    plot(x{i},y{i},'k-');
  end;
 colorbar;
 xlim([120, 122]);ylim([21.5, 25.5]);
 %
 X(:,1)=xx;X(:,2)=yy;
 Y(:,1)=xx2;Y(:,2)=yy2;
 title('EPA Data')

 % Find the nearest distance
[Idx,D] = knnsearch(X,Y);
YY=PM2;
XX=PM(Idx);
XX(:,2)=1;
XXX=PM2; XXX(:,2)=PM(Idx);
D=D*100*1000;  % to cm
loc=find ((D>2000));
D(loc)=[];
dd=mean(D);
%figure;histogram(D);

%figure;
%corrplot(XXX);

% nonSpatial calibration using LR regression
[b,bint,r,rint,stats] = regress(YY,XX);

% nonSpatial calibration  Mapping
yhat0 =   b(1).*PM+b(2); 
yhat00 =  b(1).*XX(:,1)+b(2); 

% Spatial calibration using GWR regression
result = gwr(YY,XX,xx2,yy2);
mm=mean(result.beta);
xxx=xx;yyy=yy;
XXXX(:,1)=PM;
XXXX(:,2)=1;

result1 = gwre(YY,XX,xx2,yy2,xxx,yyy,XXXX);
yhat=result1.yhat1;
 

 RMSE00 =  sqrt(mean((PM2 - PM(Idx)).^2));
 RMSE0 =  sqrt(mean((PM2 - yhat00).^2));
 RMSE = sqrt(mean((PM2 - result.yhat).^2));



% Airbox data adjusting by LR
 figure
 s=6; 
 c2=yhat0;
 scatter(xx,yy,s,c2,'fill');

 axis equal; axis off;
 hold on;
  for i=1:length(SS)
    x{i}=SS(i,1).X;
    y{i}=SS(i,1).Y;
    plot(x{i},y{i},'k-');
  end;
  colorbar;
  xlim([120, 122]);ylim([21.5, 25.5]);
  title('Airbox data adjusting by LR')

 
loc=find (yhat<0|yhat>160);
yhat(loc)=[]; yhat0(loc)=[];
xx(loc)=[];
yy(loc)=[];


% Airbox data adjusting by GWR
 figure
 s=6;
 c2=yhat;
 scatter(xx,yy,s,c2,'fill');
%  c2=PM2-result.yhat;
%  scatter(xx2,yy2,s,c2,'fill');
 axis equal;axis off;
 hold on;
  for i=1:length(SS)
    x{i}=SS(i,1).X;
    y{i}=SS(i,1).Y;
    plot(x{i},y{i},'k-');
  end;
  xlim([120, 122]);ylim([21.5, 25.5]);
  colorbar;
  title('Airbox data adjusting by GWR')
% output for step 2
save ('result.mat', 'xx', 'yy', 'yhat', 'yhat0')
