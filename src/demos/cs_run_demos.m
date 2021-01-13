function cs_run_demos(options)
  sep = filesep();
  mypath = mfilename('fullpath');

  [pth,~,~] = fileparts(mypath);
  srcFolder = fullfile(pth,'..');
  addpath(srcFolder);

  coordsys_environ()
 
  exitOnFinish=cs_get_option(options, 'exitAfter', true);
  outputdir = cs_get_option(options, 'demodir', pth);

  demos =  {'successive_rotations', true; 
           }; 
  publishOptions = struct('format','html','outputDir', outputdir); 
  for i=1:size(demos,1)
    name = demos{i, 1};
    showcode = demos{i, 2};
    fname = ['demo_', name, '.m'];
    close all
    cs_manage_demos('register', name);
    publishOptions.showCode = showcode;
    if exist(fname, 'file') == 2
      publish(fname, publishOptions)
    else 
      fprintf(1, 'File %s not found', fname);
      cs_manage_demos('report', name, false);
    end
    cs_manage_demos('cleanup', name);
  end

  publishOptions.showCode = false;
  publish('list_of_demos.m', publishOptions)
  
  if exitOnFinish
    if ~cs_manage_demos('status') 
      exit(22)
    else
      exit(0)
    end
  end  
end
