function newCS = make_rotated(angle, parentCS, varargin)
	opts = struct();
  if ~isempty(varargin)
    opts = varargin{1};
  end
  params.name = cs_get_option(opts, 'name', sprintf("%s_rotated_by_%4.1f", parentCS.params.name, angle));
	params.color = cs_get_option(opts, 'color', parentCS.params.color);
	params.armsLength = cs_get_option(opts, 'armsLenght', parentCS.params.armsLength);
  newCS = cs.CoordSys(params);
	R = cs_rotation(angle);
	newCS.orientation = R * parentCS.orientation;
end
