classdef Viewer3D < handle
  % Allow to plot in different coordinate systesm 
  properties(Access=private)
      fig;
      handles;
      stacked;
  end
  properties(Access=public)
    pointColor = 'red';
    lineColor = 'yellow';
  end
  methods
    function [obj] = Viewer(myaxes)
        if nargin < 1
          obj.fig = figure('Name', 'CoordSys Viewer');
        else
          obj.fig = myaxes;
        end
        obj.stacked = {};
    end
    function ax = myAX(obj)
      if cs.Viewer.isAxes(obj.fig)
        ax=obj.fig;
      else
        ax = gca;
      end
    end
		function clearAll(obj)
			cla(obj.myAX())
		end
    function grid(obj, how)
      ax = myAX(obj)
      grid(ax, how)
    end
    function unstackFigure(obj, n)
      if n > length(obj.stacked)
        error('Invalid index n=%d for stacked figure', n);
      end
      if ~cs.Viewer.isAxes(obj.fig)
        close(obj.fig)
      end
      obj.fig = obj.stacked{n}{1};
      obj.handles = obj.stacked{n}{2};
      obj.stacked(n) = [];
    end
    function [n] = stackFigure(obj)
       n = length(obj.stacked)+1;
       obj.stacked{n} = {obj.fig, obj.handles};
       obj.fig = figure('Name', 'CoordSys Viewer');
       obj.handles = struct();
    end
    function makeCurrent(obj)
      if ~cs.Viewer.isAxes(obj.fig)
        figure(obj.fig);
      end
    end
    function showLine(obj, point1, point2, varargin)
      obj.makeCurrent();
      hold(obj.myAX, 'on');
      if nargin > 3
        opts = varargin{1};
      else
        opts = struct();
      end
      x = [point1(1), point2(1)];
      y = [point1(2), point2(2)];
			z = [point1(3), point2(3)];
      color = cs_get_option(opts, 'Color', obj.lineColor);
      line(x,y,z,'Color', color);
      axis(obj.myAX(), 'equal');
    end
		function h = showCoordSys(obj, cs)
			h = hggroup(obj.myAX());
      aL = cs.params.armsLength;
			ptX = cs.map([aL;0;0]);
			ptY = cs.map([0; aL;0]);
			ptZ = cs.map([0; 0; aL]);
      color = cs.params.color;
			width = cs.params.width;
			line(h, [0, ptX(1)], [0, ptX(2)], [0, ptX(3)], 'Color', color, 'LineWidth', width);
			line(h, [0, ptY(1)], [0, ptY(2)], [0, ptY(3)], 'Color', color, 'LineWidth', width);
			line(h, [0, ptZ(1)], [0, ptZ(2)], [0, ptZ(3)], 'Color', color, 'LineWidth', width);
      axis(obj.myAX(), 'equal');
		end
		function h = showPointProjections(obj, pt, cs, varargin)
    		hold(obj.myAX(), 'on')
      	if nargin > 3
        		opts = varargin{1};
        else
            opts = struct();
        end
        color = cs_get_option(opts, 'color', cs.params.color);
			  h = hggroup(obj.myAX());
			  ptP = cs.map(pt);
			  ptXZ = cs.map([pt(1); 0; pt(3)]);
				ptYZ = cs.map([0; pt(2); pt(3)]);
				ptXY = cs.map([pt(1); pt(2); 0]);
			  line(h, [ptXZ(1), ptP(1)], [ptXZ(2), ptP(2)], [ptXZ(3), ptP(3)], 'LineStyle','--', 'Color', color);
			  line(h, [ptYZ(1), ptP(1)], [ptYZ(2), ptP(2)], [ptYZ(3), ptP(3)], 'LineStyle','--', 'Color', color);
			  line(h, [ptXY(1), ptP(1)], [ptXY(2), ptP(2)], [ptXY(3), ptP(3)], 'LineStyle','--', 'Color', color);
		end
		function h = showVector(obj, vec, at, cs, varargin)
            hold(obj.myAX(), 'on')
            if nargin > 4
                opts = varargin{1};
            else
                opts = struct();
            end
            color = cs_get_option(opts, 'color', cs.params.color);
						width = cs_get_option(opts, 'width', 2);
						atG = cs.map(at);
						toG = cs.map(at+vec);
						vecG = toG-atG;
						h = quiver3(obj.myAX(), atG(1), atG(2), atG(3), vecG(1), vecG(2), vecG(3), 'LineWidth', width, 'Color', color, 'MaxHeadSize', 0.5);
		end


		function h = showPoint(obj, pt, cs, varargin)
            hold(obj.myAX(), 'on')
            if nargin > 3
                opts = varargin{1};
            else
                opts = struct();
            end
            color = cs_get_option(opts, 'color', cs.params.color);
			ptsize = cs_get_option(opts, 'size', 20);
			globPt = cs.map(pt);
            marker = cs_get_option(opts, 'marker', 'o');
            if cs_get_option(opts, 'filled', false)
            	h = scatter3(obj.myAX(), globPt(1), globPt(2), globPt(3), ptsize, marker, color,'filled');
            else
                h = scatter3(obj.myAX(), globPt(1), globPt(2), globPt(3), ptsize, marker, color);
            end
		end

    function saveas(obj, filename)
      saveas(obj.fig, filename);
    end
    function clear(obj)
      clf(obj.fig)
    end
    function turn(obj, what, how)
      if ischar(how)
        if ~find(contains({'on', 'off'}, how))
          error('Invalid Vierer turn switch: %s', how);
        end
      else
        if how
          how = 'on';
        else
          how = 'off';
        end
      end
      if isfield(obj.handles, what)
        set(obj.handles.(what), 'Visible', how)
      end
    end
	end
  methods(Static)
    function [status] = isAxes(handle)
      try
        status = strcmp(get(handle, 'type'), 'axes');
      catch
        status = false;
      end
    end
  end
end
