function g = grad(data, point, radius)
	% get local data
	filter = ((data(:,1) - point(1)).^2 + (data(:,2) - point(2)).^2) < radius.^2;
	filterData = data(filter,:);
	
	if length(filterData) == 0
		g = "NO DATA"
		g = [0 0 0];
		return
	endif
	% Plot filtered data
	%figure(1);
	%scatter3(filterData(:,1), filterData(:,2), filterData(:,3), [], filterData(:,3), '.');
	hold on;

	%[beta, sigma, r] = ols(filterData(:,3), filterData(:,1:2));
	[n,V,p] = affine_fit(filterData(:,1:3));
	
	% Plot fitted surface
	%x= point(1)-radius : point(1)+radius;
	%y= point(2)-radius : point(2)+radius;
	%[xx,yy]=meshgrid(x,y);
	%mesh(xx,yy,beta(1)*xx+beta(2)*yy);
	%if n ~= 0
	%	mesh(xx, yy, (p(1:3)*n(1:3) - n(1)*xx - n(2)*yy)/n(3));
	%endif

	%g = beta;
	g = n;
end