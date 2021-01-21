%% Successive rotations demo

%% Motivation 
% 
% The purpose of this demo is to build intution behind the proces of
% constructing so called 'slave' coordinate system from 'master' coordinate
% by applying succesive rotations to the master and its derivatives.
% This demo shows explictly how the rotation matrix is build as the product
% of rotation matrices of successive rotations, and what is its relation
% to the matrix that allows to map coordinates from slave coordinate system
% to master coordinate system.
%
% In this demo we will use four coordinate systems:
%   
% * csG -- global coordinate system
% * csA -- master coordinate system
% * csB -- intermediate coordinate system
% * csC -- slave coordinate system


%% General script setup
clear variables;

%% Create coordinate systems 
% Global coordinate sysstem
csG = cs.CoordSys3D(struct('name', 'master', 'color', 'red'));

%%
% Master coordinate system is created from global one by rotation about 10 degees
csA = cs.make_rotated_3D([40, 0, 0], csG);
csA.params.name = 'intermediate_1';
csA.params.color = 'yellow';

%%
% Intermediate coordinate system is created from master by rotation about 20 degrees
csB = cs.make_rotated_3D([0,30,0], csA);
csB.params.name = 'intermediate_2';
csB.params.color = 'green';

%%
% Finally slave coordinate system is created from intermediate by rotation about 30 degrees
csC = cs.make_rotated_3D([0,0,45], csB);
csC.params.name = 'slave';
csC.params.color = 'blue';


csG.params.armsLength = 4;
csA.params.armsLength = 3;
csB.params.armsLength = 2.5;
csC.params.armsLength = 2;

%% Create viewer and draw coordinate systems
% The simplest way to visualize coordinate transformations is to use Viewer class.
viewer = cs.Viewer3D();

viewer.showCoordSys(csG);
viewer.showCoordSys(csA);
viewer.showCoordSys(csB);
viewer.showCoordSys(csC);

%% Illustrate coordinate transformation from slave to master
% To illustrate coordinate transformation from slave to master
% we are going to pick a point in slave coordinate frame.
tpC = [1.2;1.2;1.2]

%%
% We show it in slave coordsys (the blue one)
viewer.showPoint(tpC, csC, struct('filled', true, 'size', 15));
viewer.showPointProjections(tpC, csC);

%%
% Then we find matrix transforming from slvave (C) to master (G)
Q_c_g = cs.get_transformation_matrix(csC, csG)

%%
% Using this matrix we can find coordinates of test point in coordinate system A
tpG = Q_c_g * tpC

%% 
% We can mark this point in coordinate system A
viewer.showPoint(tpG, csG, struct('filled', false, 'size', 40));
viewer.showPointProjections(tpG, csG);

%%
% As it can be seen from the above image the matrix |Q_c_g| properly describes
% transformation of coordinates from system C to system G.

%% Rotation matrix versus coordinate transformation matrix
% In this section we will show relation between matrix that rotates coordinate
% system G to generate system C and the matrix that translates from coordinate system C
% to coordinate system G

%%
% Firstly we will show one of the versors of coordinate system A
viewer.clearAll();
viewer.showCoordSys(csG);
viewer.showCoordSys(csC);
e1G = [0;0;1];
viewer.showVector(e1G, [0;0;0], csG)

view(viewer.myAX(), 125, 45)
zoom(viewer.myAX(), 2)
viewer.myAX().Clipping = 'off';

%%
% Then we calcuate the rotation matrix that rotates G to C, using
% orientation matrices of the resective coordinate systems. We get
R_g_c = cs.get_rotation_matrix(csG, csC);

%%
% We show the action of this matrix using it to rotate the versor of A
e1G_rot = R_g_c* e1G;

%%
% Now if we plot the rotated versor we can see that it takes the orientation
% that coincides with the orientation of coordinate axis of system C
viewer.showVector(e1G_rot, [0;0;0], csG);

view(viewer.myAX(), 125, 45)
zoom(viewer.myAX(), 2)
viewer.myAX().Clipping = 'off';


%%
% Finaly we can show that the the matrices side by side
R_g_c
Q_c_g

%%
% What is more we will show that the above matrices are the product
% of rotation matrices multiplied with appropriate order

Rx_40 = cs_rotation_3D([40,0,0])
Ry_30 = cs_rotation_3D([0,30,0])
Rz_45 = cs_rotation_3D([0,0,45])


%%
% Calculate rotation matrix by correct order of multiplication of successive
% rotation matrices. CAUTION: this order comes from the fact that successive
% rotations are done with respect to axes that change their position after each
% rotation. Here we are using intrinsic convention for Euler angles.

R = Rx_40 * Ry_30 * Rz_45


%%
% Finally we can compare matrices calculated previously with the rotation matrix R
R - Q_c_g
R - R_g_c


%% Calculating rotation angles 
% Having the rotation matrix we can calculate the rotation angles back. Please
% note that we need to explicitly specify convention for rotation angles as it
% is not the default one.

rotm2eul(R, 'XYZ')*180/pi

%%
% Demo managemet
cs_manage_demos('report', 'successive_rotations_3D', true);
