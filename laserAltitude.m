%data = dlmread('19D021_67100_5425_25.txt', ' ');

myTrackData = dlmread('converted.csv', ';', 1, 0);
myTrack = myTrackData(2:2:end,1:2);

data(1, :)

%	Correct class  +  In coordinate bounding box
% visa hela berget
ind = data(:,4) == 2 & data(:,2) < 6710634 & data(:,2) > 6710000 & data(:,1) > 543750 & data(:,1) < 544539;

% visa syd östra slänten
%ind = data(:,4) == 2 & data(:,2) < 6710634 & data(:,2) > 6710000 & data(:,1) > 544100 & data(:,1) < 544400;

filterData = data(ind, :, :, :);

plotData = filterData(1:floor(size(filterData, 1)/ 10)*10, :, :, :);

plotData = plotData(repmat([1==1 ; 0==1 ; 0==1 ; 0==1 ; 0==1 ; 0==1 ; 0==1 ; 0==1 ; 0==1 ; 0==1], size(plotData, 1)/10, 1), :, :, :);


%hold off;
figure(1);
% Plot slope map
%x= linspace(min(filterData(:,1))+10, 544400, 150);
%y= linspace(min(filterData(:,2))+10, max(filterData(:,2))-10, 150);
%[xx,yy]=meshgrid(x,y);
%zz = zeros(size(xx));
%zzTopography = zeros(size(xx));
%for i = 1:size(xx, 1)
%	for j = 1:size(xx, 2)
%		g = grad(filterData, [xx(i,j) yy(i,j)], 40);
%		zz(i,j) = sqrt(g(1)^2 + g(2)^2);
%		
%		[m, index] = min((filterData(:,1)-xx(i,j)).^2 + (filterData(:,2)-yy(i,j)).^2);
%		zzTopography(i,j) = filterData(index, 3);
%	end
%end
imagesc(xx, yy, zz);
hold on;

% Plot topography map
figure(4);
imagesc(xx, yy, zzTopography);
hold on;

%scatter3(plotData(:, 1), plotData(:, 2), plotData(:, 3), [], plotData(:, 3), '.');

% Plot my track
figure(1);
plot(myTrack(:,2), myTrack(:,1));
figure(4);
plot(myTrack(:,2), myTrack(:,1));

hold on;

figure(2);

%start point
start = [544365 6710010 200]; %'m'
%start =  [544150 6710400 240];
radius = 20;
trackSlope = 0.03;
%trackSlope = -0.03;
stepLength = 5;
direction = 1;

color = 'c';

track = zeros(1000, 3);

currentPoint = start;
for i = 1:1000
	track(i, :) = currentPoint;
	
	[nextPoint, gradient] = step(filterData, currentPoint, trackSlope, stepLength, radius, direction);
	figure(1);
	plot([currentPoint(1) nextPoint(1)], [currentPoint(2) nextPoint(2)], 'linewidth', 3, color);
	figure(4);
	hold on;
	plot([currentPoint(1) nextPoint(1)], [currentPoint(2) nextPoint(2)], 'linewidth', 3, color);

	pause(.001);
	
	% Plot path height curve
	figure(2);
	plot(i*stepLength, nextPoint(3), [color '*']);
	
	% Plot terrain slope at path
	figure(3);
	plot(i*stepLength, sqrt(gradient(1).^2 + gradient(2).^2), [color '*']);
	
	%if i*stepLength == 130 || i*stepLength == 200 || i*stepLength == 500 || i*stepLength == 560 || i*stepLength == 710 || i*stepLength == 1030 || i*stepLength == 1380 %'w'
	%if i*stepLength == 130 || i*stepLength == 200 || i*stepLength == 500 || i*stepLength == 560 || i*stepLength == 710 || i*stepLength == 1030 || i*stepLength == 1100 %'b'
	%if i*stepLength == 130 || i*stepLength == 200 || i*stepLength == 500 || i*stepLength == 560 || i*stepLength == 710 || i*stepLength == 1030 || i*stepLength == 1330 %'k'
	%if i*stepLength == 130 || i*stepLength == 200 || i*stepLength == 500 || i*stepLength == 560 || i*stepLength == 710 || i*stepLength == 1030 || i*stepLength == 1330 || i*stepLength == 1700 || i*stepLength == 2000 %'r'
	%if i*stepLength == 130 || i*stepLength == 200 || i*stepLength == 500 || i*stepLength == 560 || i*stepLength == 710 || i*stepLength == 1030 || i*stepLength == 1330 || i*stepLength == 1900 || i*stepLength == 2200 %'g'
	if i*stepLength == 130 || i*stepLength == 200 || i*stepLength == 500 || i*stepLength == 560 || i*stepLength == 710 || i*stepLength == 1030 || i*stepLength == 1330 || i*stepLength == 1800 || i*stepLength == 2300 %'c'
		direction *= -1
	endif
	
	if i*stepLength == 2400
		display("end point:");
		trackSlope = -0.03;
	endif
	
	if i*stepLength == 2700
		trackSlope = -0.01;
	endif
	
	currentPoint = nextPoint;
end