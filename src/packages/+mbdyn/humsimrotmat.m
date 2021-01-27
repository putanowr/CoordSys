function [RMatrix] = humsimrotmat(vAngle)
	fSX = sin(vAngle(1));
    fCX = cos(vAngle(1));
	fSY = sin(vAngle(2)); 
    fCY = cos(vAngle(2));
	fSZ = sin(vAngle(3)); 
    fCZ = cos(vAngle(3));

	%// Bryant angles
	%//transposed and -angle
	RMatrix(1,1) = fCY * fCZ;
	RMatrix(1,2) = fSX * fSY * fCZ - fCX * fSZ;
	RMatrix(1,3) = fCX * fSY * fCZ + fSX * fSZ;
	RMatrix(2,1) = fCY * fSZ;
	RMatrix(2,2) = fSX * fSY * fSZ + fCX * fCZ;
	RMatrix(2,3) = fCX * fSY * fSZ - fSX * fCZ;
	RMatrix(3,1) = -fSY;
	RMatrix(3,2) = fSX * fCY;
	RMatrix(3,3) = fCX * fCY;
end

