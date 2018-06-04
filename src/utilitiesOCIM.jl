module utilitiesOCIM

# package code goes here
"""
    Iabove, Ibelow = buildIndexMatrices()

Build the matrices of indices above and below.

These are shifted-diagonal matrices that allow for
easy construction of the particle flux divergence `PFD` operator.
"""
function buildIaboveIbelow()
  n = nlon * nlat * (ndepth+1)
  In = speye(n)
  idx = zeros(nlat,nlon,ndepth+1)
  idx[:] = 1:n
  idxabove = idx[:,:,[ndepth+1; 1:ndepth]] # use a periodic upward shift
  idxbelow = idx[:,:,[2:ndepth+1; 1]]      # use a periodic downward shift
  Iabove = In[idxabove[:],:]
  Ibelow = In[idxbelow[:],:]
  # keep only indices of wet boxes
  Iabove = Iabove[iwet,iwet]
  Ibelow = Ibelow[iwet,iwet]
  return Iabove, Ibelow
end
const Iabove, Ibelow = buildIaboveIbelow()

"""
    Iabove = buildIabove(wet3d)

Build the shifted-diagonal sparse matrix of the indices of above neighbours.

Iabove[i,j] = 1 if the box represented by the linear index i
lies directly above the box represented by the linear index j.
"""
function buildIabove(wet3d)
  nlat, nlon, ndepth = size(wet3d)
  iwet = find(wet3d)
  n = nlon * nlat * (ndepth + 1)
  In = speye(n)
  idx = zeros(nlat, nlon, ndepth + 1)
  idx[:] = 1:n
  idx .= idx[:, :, [ndepth + 1 ; 1:ndepth]] # shift
  return In[idx[:], :][iwet, iwet]
end

function buildIabove(wet3d)

end





end # module
