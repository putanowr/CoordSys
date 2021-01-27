function [bryandt] = omega2bryandt(bryanAngles, omega)
   c =  cos(bryanAngles);
   s =  sin(bryanAngles);
   M = [c(3), -s(3), 0;
        s(3)*c(2), c(3)*c(2), 0;
        -c(3)*s(2), s(3)*s(2), c(2)] / c(2);
   if (abs(c(2)) < 1e-12)
       warning('To close to zero')
   end
   bryandt = M * omega;
end

