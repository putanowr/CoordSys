function [epdt] = omega2epdt(ep, omega)
 L = [-ep(2),  ep(1), ep(4), -ep(3);
      -ep(3), -ep(4), ep(1), ep(2);
      -ep(4),  ep(3), -ep(2), ep(1)];
 epdt = L'*omega/2; 
end

