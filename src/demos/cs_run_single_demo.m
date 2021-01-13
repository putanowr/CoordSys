function cs_run_single_demo(demoName)
  sep = filesep();
  mypath = mfilename('fullpath');
  [mydir,~,~] = fileparts(mypath);
  
  coordsys_environ();
  
  scriptName = ['demo_', demoName];
  
  cs_manage_demos('register', demoName);
  run(scriptName);
  end
