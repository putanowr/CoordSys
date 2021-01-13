function [mypathstr] = coordsys_environ(params)
% coordsys_environ - set environment to make possible running tests.
% This account to adding paths for Matlab to find required m-files
% of CoordSys code.
% 
% Arguments: 
%     params - structure with run time configuration parameters
%              The following fields can be set:
%        'forced'  (bool) - if true it forces reinitialization of CoordSys 
%                  environment.
%        'verbose' (bool) - if ture echo some actions e.g. inform about
%                  generation of source code 
% Return value:
%   Return the path to the folder in which source code of this 
%   function is located.
  persistent pth
  if nargin < 1
    params = struct;
  end
  if isfield(params, 'forced')
    forced = params.forced;
  else
    forced = false;
  end
  if forced
    pth = [];
  end
  if isempty(pth)
    sep = filesep();
    mypath = mfilename('fullpath');
    [pth,~,~] = fileparts(mypath);
  else
    mypathstr = pth; 
    return
  end
  mypathstr = pth;  
 
  % Path to coordsys_environ folder
  addpath(mypathstr);
  % Essential bootstrap code
  codeFolders = {'packages';
		             'core';
                 'tests';
								 'demos'
                };
									 
  codeFolders = strcat(mypathstr, sep, codeFolders);
	addpath(codeFolders{:})
end
