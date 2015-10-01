function [dxyz,mxyz] = defineCommonGrid(XYZ, dxyz,stepsize)
  if nargin < 3
		stepsize = 0.25;
	end
  if nargin < 2
    if iscell(XYZ)
      dxyz = ones(1,size(XYZ{1},2));
    else
      dxyz = ones(1,size(XYZ,2));
    end
	end

	XYZ_adj = XYZ;
  if iscell(XYZ)
    mxyz = min(cell2mat(XYZ));
    XYZm = cellfun(@(x) bsxfun(@minus,x,min(x)), XYZ, 'unif', 0);;
    N = cellfun(@(x) size(x,1), XYZ);
    n = numel(XYZ);
  else
    mxyz = min(XYZ);
    XYZm = {bsxfun(@minus,XYZ,min(XYZ))};
    N = size(XYZ,1);
    n = 1;
  end
	ndim = length(dxyz);

	d = -1;
	breakloop = false;
  warning('off', 'DefineCommonGrid:roundto:duplicate');
	while true
		for i = 1:n
			xyz = XYZm{i};
			xyz = roundto(xyz, dxyz);
			xyz_u = unique(xyz,'rows');

			if size(xyz_u, 1) < N(i)
				breakloop = true;
				dxyz(dd) = dxyz(dd) - stepsize;
				break
			else
				dd = mod(d,ndim)+1;
				d = d + 1;
				dxyz(dd) = dxyz(dd) + stepsize;
			end
		end

		if breakloop
			break
		end

	end
  warning('on', 'DefineCommonGrid:roundto:duplicate');
end
