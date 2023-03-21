% Spatial calibration and PM2.5 mapping 
% Step-2  ploting and RMSE evaluation 
% by Hone-Jay Chu

clear all;
grid=0.05;
neigh=30;

%plot GWR or LR result
%  1: run GWR maps
%  others: run LR maps
plotGWR=0; 

SS = shaperead('.\Data\TWN_shp\gadm36_TWN_0.shp');
[num1, text1, rawData1] =xlsread('.\Data\Newcase\1\EPA.csv');
load result;


% Showing original data, yhat by GWR, yhat0 by LR
if (plotGWR==1)
PM=yhat;
else
PM=yhat0;    
end


% data clearing
loc=find( isnan(PM));
PM(loc)=[];
xx(loc)=[];
yy(loc)=[];

loc=find ((PM<0)|(PM>180));
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
loc=find ((xx==121.491)&(yy==23.846));
PM(loc)=[];
xx(loc)=[];
yy(loc)=[];

  
xmin=min(xx);
xmax=max(xx);
ymin=min(yy);
ymax=max(yy);
[x] =(xmin:grid:xmax)';
[y] =(ymax:-grid:ymin)';

% IDW
z0=IDW(xx,yy,PM,x,y,-2,'ng',neigh); 


  for i=1:length(SS)
    XX{i}=SS(i,1).X;
    YY{i}=SS(i,1).Y;
  end;
  [X00,Y00] = meshgrid(x,y);
  in = inpolygon(X00,Y00,SS(i,1).X',SS(i,1).Y');
  z0((in~=1))=nan;
figure;
h=imagesc(z0);
set(h,'alphadata',~isnan(z0));
axis equal;axis off; 
colorbar;



%[num1, text1, rawData1] =xlsread('.\Newcase\1\EPA.csv');
row=size(num1,1);

loc=find( isnan(num1(:,1)));
num1(loc,:)=[];
%
% Mapping error
for k=1:length(num1)
X0(k,1)=num1(k,23);
Y0(k,1)=num1(k,18);
Z0(k,1)=num1(k,1); 
row1(k,1)=ceil((Y00(1,1)-Y0(k,1))/grid+1);
col1(k,1)=ceil((X0(k,1)-X00(1,1))/grid);
end
E=0;
loc1=find(row1<0|col1<0);
row1(loc1)=[];
col1(loc1)=[];
Z0(loc1)=[];X0(loc1)=[];Y0(loc1)=[];
loc1=find(row1>size(z0,1)|col1>size(z0,2));
row1(loc1)=[];
col1(loc1)=[];
Z0(loc1)=[];X0(loc1)=[];Y0(loc1)=[];

loc1=find(isnan(row1)==1);
row1(loc1)=[];
col1(loc1)=[];
Z0(loc1)=[];X0(loc1)=[];Y0(loc1)=[];

loc1=find(isnan(col1)==1);
row1(loc1)=[];
col1(loc1)=[];
Z0(loc1)=[];X0(loc1)=[];Y0(loc1)=[];

for k=1: length(col1)
%  Error
  E(k,1)=z0((row1(k)),(col1(k)))-Z0(k);
end

loc1=find(E<-100);
E(loc1)=[];
% RMSE 
RMSE = sqrt(nanmean((E).^2));


