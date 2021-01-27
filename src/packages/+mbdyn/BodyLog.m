classdef BodyLog < handle
	properties(Access=public)
		linPos = [];
		linVel = [];
		angVel = []; 
        Qlg = [];
        pos = [];
        time = [];
        ep = [];
        bryan = [];
        testpos = [];
	end
	methods
		function [obj] = BodyLog()
		end
		function Allocate(obj, nSteps)
            n = nSteps+1;
			obj.linPos = zeros(3, n);
            obj.linVel = zeros(3, n);
            obj.angVel = zeros(3, n);
            obj.Qlg = zeros(3,3,n);
            obj.pos = zeros(3, n);
            obj.time = zeros(1, n);
            obj.ep = zeros(4, n);
            obj.bryan = zeros(3, n);
            obj.testpos = zeros(3, n);
        end
        function Plot(obj, what, titlemsg)
            figure();
            if strcmp(what, 'omega')
               t = sprintf('%s : Angular velocity. Step: %g', titlemsg, obj.time(2)-obj.time(1));
               plot(obj.time, obj.angVel(1,:), '-r', obj.time, obj.angVel(2,:), '-yellow', obj.time, obj.angVel(3,:), '-g') 
               title(t);
            elseif strcmp(what, 'testpos')
               plot(obj.time, obj.testpos(1,:), '-r', obj.time, obj.testpos(2,:), '-yellow', obj.time, obj.testpos(3,:), '-g') 
               title(titlemsg)
            end    
        end
    end
end
