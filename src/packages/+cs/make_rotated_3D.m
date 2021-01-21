function newCS = make_rotated(angles, parentCS, varargin)
	opts = struct();
  if ~isempty(varargin)
    opts = varargin{1};
  end
  params.name = cs_get_option(opts, 'name',  sprintf("%s_rotated_by", parentCS.params.name));
	params.color = cs_get_option(opts, 'color', parentCS.params.color);
	params.armsLength = cs_get_option(opts, 'armsLenght', parentCS.params.armsLength);
  newCS = cs.CoordSys3D(params);
	R = cs_rotation_3D(angles);
	newCS.orientation = parentCS.orientation * R;
end
