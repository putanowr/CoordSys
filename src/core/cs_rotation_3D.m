function R = cs_rotation_3D(angles)
	a = angles*pi/180;
  cx = cos(a(1));
	sx = sin(a(1));
	cy = cos(a(2));
	sy = sin(a(2));
	cz = cos(a(3));
	sz = sin(a(3));

	Rx = [1, 0, 0;
		    0, cx, -sx;
		    0, sx, cx];
  Ry = [cy, 0, sy;
		    0,  1, 0;
				-sy, 0, cy];
	Rz = [cz, -sz, 0;
		    sz, cz,0;
				0, 0, 1];
	R = Rz*Ry*Rx;
end
