function cs_demo_to_pdf(demoName)
  sep = filesep();
  mypath = mfilename('fullpath');
  [mydir,~,~] = fileparts(mypath);
  
  coordsys_environ();
  
  scriptName = ['demo_', demoName];
  
  cs_manage_demos('register', demoName);
  publish(scriptName, 'pdf');
  end
