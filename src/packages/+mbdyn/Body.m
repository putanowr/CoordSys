classdef Body < handle
	properties(Access=public)
		linPos = [0.0; 0.0; 0.0];
		linVel = [0.0; 0.0; 0.0];
		angVel = [0.0; 0.0; 0.0];
		Qlg = eye(3); % orientation matrix
        J = eye(3); % inertia tensor
        Jinv = eye(3);
		moment = [0;0;0];
		force = [0;0;0];
        log = []
        currentStateId = 1;
        currentTime = 0.0;
        ep = [1; 0; 0; 0];
        variant = 'bryan';
        testpos = []
        locpos = [1; 0.5;0.8];
        bryan = [0;0;0];
	end
	methods (Access=private)
    	function setup(obj, params_)
      		obj.linPos = cs_get_option(params_, 'linPos', obj.linPos);
      		obj.linVel = cs_get_option(params_, 'linVel', obj.linVel);
			obj.angVel = cs_get_option(params_, 'angVel', obj.angVel);
			obj.Qlg = cs_get_option(params_, 'orientation', obj.Qlg);
			obj.J = cs_get_option(params_, '', obj.J);
            objJinv = inv(obj.J)
            obj.ep = mbdyn.orient2ep(obj.Qlg);
            obj.bryan = rotm2eul(obj.Qlg, 'xyz')';
            obj.log = mbdyn.BodyLog();
            obj.testpos = obj.locpos;
    	end
	end
	methods
		function [obj] = Body(params_)
			if nargin < 1
				params_ = struct();
			end
			if ~isempty(params_)
				obj.setup(params_)
			end
        end
        
        function LogState(obj, stateId)
            obj.log.angVel(:, stateId) = obj.angVel;
            obj.log.linPos(:, stateId) = obj.linPos;
            obj.log.linVel(:, stateId) = obj.linVel;
            obj.log.Qlg(:,:, stateId) = obj.Qlg;
            obj.log.time(stateId) = obj.currentTime;
            obj.log.ep(:, stateId) = obj.ep;
            obj.log.bryan(:, stateId) = obj.bryan;
            obj.log.testpos(:, stateId) = obj.testpos;
        end
        function Step(obj, dt)
            i = obj.currentStateId;
            %fprintf('Perform step %d -> %d by dt=%f\r', i,i+1,dt)
            d_angVel = -obj.Jinv*mbdyn.skew(obj.angVel)*obj.J*obj.angVel;
            new_angVel = obj.angVel + dt * d_angVel;           
            if strcmp(obj.variant, 'ep')
                epdt = mbdyn.omega2epdt(obj.ep, obj.angVel);   
                new_ep = obj.ep + dt * epdt;
                delta = dot(new_ep, new_ep) -1;
                new_ep = 1/sqrt(1+delta) * new_ep;
                obj.Qlg = mbdyn.ep2orient(new_ep);
                obj.ep = new_ep;
                obj.testpos = obj.Qlg * obj.locpos;
            elseif strcmp(obj.variant, 'bryan')
                bryandt = mbdyn.omega2bryandt(obj.bryan, obj.angVel);
                new_bryan = obj.bryan + bryandt * dt;
                obj.bryan = new_bryan;
                obj.Qlg = eul2rotm(obj.bryan', 'xyz');
                obj.testpos = obj.Qlg * obj.locpos;
            elseif strcmp(obj.variant, 'humsim')
                anglesInc = obj.angVel * dt;
                rotMatInc = mbdyn.humsimrotmat(anglesInc);
                obj.Qlg = obj.Qlg * rotMatInc;
                obj.testpos = obj.Qlg * obj.locpos;                
            end
            obj.angVel = new_angVel;            
            obj.currentTime = obj.currentTime + dt;
            obj.currentStateId = i + 1;
            obj.LogState(obj.currentStateId);
        end
	end
end
