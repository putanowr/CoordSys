function [ep] = orient2ep(M)
  epref = rotm2quat(M)';
  tol = 1e-8;
  tr = trace(M);
  trone = tr + 1.0;
  if trone < 0
    if trone > -1.0e-8
      trone = 0.0;
    else
      error('Internal error: orient2ep : trone is negative')
    end
  end
  ep = [0;0;0;0];
  w = sqrt((trone)) / 2.0;
  ep(1) = w;
  if w >  1.454441038201999e-04 
    f = 4 * w;
    x = (M(3,2) - M(2,3)) / f;
    y = (M(1,3) - M(3,1)) / f;
    z = (M(2,1) - M(1,2)) / f;
    ep(2) = x;
    ep(3) = y;
    ep(4) = z;
  else
    xx = (1 + 2 * M(1,1) - tr) / 4.0;
    if xx > 1e-10
      x = sqrt(xx);
      y = (M(1,2) + M(2,1)) / (4 * x);
      z = (M(1,3) + M(3,1)) / (4 * x);
      ep(2) = x;
      ep(3) = y;
      ep(4) = z;
      assert(norm(ep-epref)<tol)
      return;
    end
    yy = (1 + 2 * M(2,2) - tr) / 4.0;
    if yy > 1e-10
      y = sqrt(yy);
      x = (M(1,2) + M(2,1)) / (4 * y);
      z = (M(2,3) + M(3,2)) / (4 * y);
          ep(2) = x;
          ep(3) = y;
          ep(4) = z;
          assert(norm(ep-epref)<tol)
          
      return;
    end
    zz = (1 + 2 * M(3,3) - tr) / 4.0;
    if (zz > 1e-10)
      z = sqrt(zz);
      x = (M(1,3) + M(3,1)) / (4 * z);
      y = (M(2,3) + M(3,2)) / (4 * z);
         ep(2) = x;
    ep(3) = y;
    ep(4) = z; 
    assert(norm(ep-epref)<tol)
      return;
    end
    error('Internal error: Cannot convert to Euler parameters')
  end
  assert(norm(ep-epref)<tol)
end

