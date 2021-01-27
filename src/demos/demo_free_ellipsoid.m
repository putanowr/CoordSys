%% Successive rotations demo

%% General script setup
clear variables;

nSteps = 8000;
dt = 1e-3;

bodyA = mbdyn.Body();
bodyB = mbdyn.Body();
bodyH = mbdyn.Body();
bodyA.variant = 'ep';
bodyB.variant = 'bryan';
bodyH.variant = 'humsim';

bodyA.angVel = [pi/10; pi/10; 0];
bodyA.J(1,1) = 3;
bodyA.J(2,2) = 4;


bodyB.angVel = bodyA.angVel;
bodyB.J = bodyA.J

bodyH.angVel = bodyA.angVel;
bodyH.J = bodyA.J;

bodyA.log.Allocate(nSteps)
bodyA.LogState(bodyA.currentStateId)
bodyB.log.Allocate(nSteps)
bodyB.LogState(bodyB.currentStateId)
bodyH.log.Allocate(nSteps)
bodyH.LogState(bodyH.currentStateId)

for i=1:nSteps
    bodyA.Step(dt)
    bodyB.Step(dt)
    bodyH.Step(dt)
end

bodyA.log.Plot('omega', bodyA.variant)
%bodyB.log.Plot('omega', bodyB.variant)
%bodyA.log.Plot('testpos', bodyA.variant)
%bodyB.log.Plot('testpos', bodyB.variant)
%bodyH.log.Plot('testpos', bodyH.variant)
disp(bodyA.ep)
disp(bodyB.ep)

figure()
t = bodyA.log.time;
xA = bodyA.log.testpos(1, :);
xB = bodyB.log.testpos(1, :);
xH = bodyH.log.testpos(1, :);
hold on
plot(t, xA, 'DisplayName', bodyA.variant)
plot(t, xB, 'DisplayName', bodyB.variant)
plot(t, xH, 'DisplayName', bodyH.variant);
legend
title('Coordinate X');
figure()
t = bodyA.log.time;
xA = bodyA.log.testpos(2, :);
xB = bodyB.log.testpos(2, :);
xH = bodyH.log.testpos(2, :);
hold on
plot(t, xA, 'DisplayName', bodyA.variant)
plot(t, xB, 'DisplayName', bodyB.variant)
plot(t, xH, 'DisplayName', bodyH.variant);
legend
title('Coordinate Y')
figure()
t = bodyA.log.time;
xA = bodyA.log.testpos(3, :);
xB = bodyB.log.testpos(3, :);
xH = bodyH.log.testpos(3, :);
hold on
plot(t, xA, 'DisplayName', bodyA.variant)
plot(t, xB, 'DisplayName', bodyB.variant)
plot(t, xH, 'DisplayName', bodyH.variant);
legend
title('Coordinate Z');
%body.log.time
%body.log.angVel
%%
% Demo management
cs_manage_demos('report', 'free_ellipsoid', true);
