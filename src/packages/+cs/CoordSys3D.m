classdef CoordSys3D < handle
	properties(Access = public)
		params = struct('armsLength', 2, 'color', 'red', 'name', 'dummy', 'width', 1);
	end
  properties(SetAccess=public)
		center = [0.0; 0.0; 0.0];
		orientation = eye(3);
  end
	methods (Access=private)
    function setup(obj, params_)
      obj.params.armsLength = cs_get_option(params_, 'armsLength', obj.params.armsLength);
      obj.params.color = cs_get_option(params_, 'color', obj.params.color);
			obj.params.name = cs_get_option(params_, 'name', obj.params.name);
			obj.params.width = cs_get_option(params_, 'width', obj.params.width);
    end
	end

  methods
    function [obj] = CoordSys3D(params_)
			if nargin < 1
				params_ = struct();
			end
			if ~isempty(params_)
				obj.setup(params_)
			end
    end

		function ptOut = map(obj, ptIn)
      ptOut = obj.orientation * ptIn;
		end

	end
end
