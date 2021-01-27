function [M] = ep2orient(ep)
  M = quat2rotm(ep');
  return
  w = ep(1);
  x = ep(2);
  y = ep(3);
  z = ep(4);
  ww = w * w;
  M(1,1) = 2 * (ww + x*x) - 1;
  M(1,2) = 2 * (x*y - w*z);
  M(1,3) = 2 * (x*z + w*y);
  M(2,1) = 2 * (x*y + w*z);
  M(2,2) = 2 * (ww + y*y) - 1;
  M(2,3) = 2 * (y*z - w*x);
  M(3,1) = 2 * (x*z - w*y);
  M(3,2) = 2 * (y*z + w*x);
  M(3,3) = 2 * (ww + z*z) - 1;
end

