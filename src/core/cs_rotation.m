function R = cs_rotation(angle)
	a = angle*pi/180;
	c = cos(a);
	s = sin(a);
	R = [c, -s; s, c];
end
