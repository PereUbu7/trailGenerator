function [nextPoint, gradient] = step(data, start, slope, stepLength, radius, gamma)
	origStepLength = stepLength;
	count = 0;
	
	slopeSign = slope/abs(slope);
	
	do
		gradient = grad(data, start, radius);
		
		if sqrt(gradient(1)^2 + gradient(2)^2) < abs(slope)
			direction = [-slopeSign*gamma*gradient(1) -slopeSign*gamma*gradient(2) slope/abs(slope)*gradient(3)]
			c = 'm';
			r = -1;
		elseif gradient(2) != 0 && gradient(1) > 0
			display("positive grad(1)");
			sign = 1;
			if gradient(2) > 0
				display("positive grad(2)");
				c = 'r';
			else
				display("negative grad(2)");
				c = 'b';
				%sign *= -1;
				%gamma *= -1;
			endif
			
			direction = [sign*(-gradient(3)*slope-gradient(2)*gamma)/gradient(1), sign*gamma slope];
			r = 1;
		else
			display("negative grad(1)");
			sign = 1;
			if gradient(2) > 0
				display("positive grad(2)");
				c = 'g';
			else
				display("negative grad(2)");
				c = 'y';
				%sign *= -1;
				%gamma *= -1;
			endif
			
			direction = [sign*gamma sign*(-gradient(3)*slope-gradient(1)*gamma)/gradient(2) slope];
			r = 0;
		endif
		
		% normalize and make into correct length
		direction = direction/hypot(direction(1), direction(2), direction(3))*stepLength;
		
		stepLength -= origStepLength/20;
		radius *= 2;
		count += 1
		
	until(abs(direction(3)) > abs(stepLength*slope*0.5) && direction(3)*stepLength*slope*0.5 > 0 || stepLength <= 0)
	
	[value index] = min((data(:,1) - start(1)).^2 + (data(:,2) - start(2)).^2); 
	
	nextPoint = start + direction;
		
	nextPoint(3) = data(index, 3);
	
	figure(5);
	plot3([start(1) start(1)+gradient(1)*10], [start(2) start(2)+gradient(2)*10], [start(3) start(3)+gradient(3)*10], 'b');
	
	if slopeSign < 0
		plot3([start(1) start(1)+direction(1)], [start(2) start(2)+direction(2)], [start(3) start(3)+direction(3)], c);
	else
		plot3([start(1) start(1)+direction(1)], [start(2) start(2)+direction(2)], [start(3) start(3)+direction(3)], c, 'linewidth', 3);
	endif
	hold on;
end
