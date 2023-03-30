pad={}
pad.Sn=0
pad.Tn=0
pad.On=0
pad.Xn=0
pad.Un=0
pad.Dn=0
pad.Ln=0
pad.Rn=0
pad.LSn=0
pad.RSn=0
pad.SLn=0
pad.STn=0

function pad:S(o)
 if pge.controls.pressed(PGE_CTRL_SQUARE)then
 pressS=true
 end
 if not o then
  if pressS then
   return true
  end
 elseif o=="h" then
  if pge.controls.held(PGE_CTRL_SQUARE)then
   return true
  end
 elseif o=="r" then
  if pge.controls.held(PGE_CTRL_SQUARE)then
  releaseS=true
  else
   if releaseS then
   releaseS=nil
    return true
   end
  end
 elseif tonumber(o)then
  if pressS then
  pad.Sn=o-15
   if pad.Sn>0 then
   pad.Sn=0
   end
   return true
  end
  if pge.controls.held(PGE_CTRL_SQUARE)then
  pad.Sn=pad.Sn+1
   if pad.Sn>o then
   pad.Sn=0
    return true
   end
  end
 end
end

function pad:T(o)
 if pge.controls.pressed(PGE_CTRL_TRIANGLE)then
 pressT=true
 end
 if not o then
  if pressT then
   return true
  end
 elseif o=="h" then
  if pge.controls.held(PGE_CTRL_TRIANGLE)then
   return true
  end
 elseif o=="r" then
  if pge.controls.held(PGE_CTRL_TRIANGLE)then
  releaseT=true
  else
   if releaseT then
   releaseT=nil
    return true
   end
  end
 elseif tonumber(o)then
  if pressT then
  pad.Tn=o-15
   if pad.Tn>0 then
   pad.Tn=0
   end
   return true
  end
  if pge.controls.held(PGE_CTRL_TRIANGLE)then
  pad.Tn=pad.Tn+1
   if pad.Tn>o then
   pad.Tn=0
    return true
   end
  end
 end
end

function pad:O(o)
 if pge.controls.pressed(PGE_CTRL_CIRCLE)then
 pressO=true
 end
 if not o then
  if pressO then
   return true
  end
 elseif o=="h" then
  if pge.controls.held(PGE_CTRL_CIRCLE)then
   return true
  end
 elseif o=="r" then
  if pge.controls.held(PGE_CTRL_CIRCLE)then
  releaseO=true
  else
   if releaseO then
   releaseO=nil
    return true
   end
  end
 elseif tonumber(o)then
  if pressO then
  pad.On=o-15
   if pad.On>0 then
   pad.On=0
   end
   return true
  end
  if pge.controls.held(PGE_CTRL_CIRCLE)then
  pad.On=pad.On+1
   if pad.On>o then
   pad.On=0
    return true
   end
  end
 end
end

function pad:X(o)
 if pge.controls.pressed(PGE_CTRL_CROSS)then
 pressX=true
 end
 if not o then
  if pressX then
   return true
  end
 elseif o=="h" then
  if pge.controls.held(PGE_CTRL_CROSS)then
   return true
  end
 elseif o=="r" then
  if pge.controls.held(PGE_CTRL_CROSS)then
  releaseX=true
  else
   if releaseX then
   releaseX=nil
    return true
   end
  end
 elseif tonumber(o)then
  if pressX then
  pad.Xn=o-15
   if pad.Xn>0 then
   pad.Xn=0
   end
   return true
  end
  if pge.controls.held(PGE_CTRL_CROSS)then
  pad.Xn=pad.Xn+1
   if pad.Xn>o then
   pad.Xn=0
    return true
   end
  end
 end
end

function pad:U(o)
 if pge.controls.pressed(PGE_CTRL_UP)then
 pressU=true
 end
 if not o then
  if pressU then
   return true
  end
 elseif o=="h" then
  if pge.controls.held(PGE_CTRL_UP)then
   return true
  end
 elseif o=="r" then
  if pge.controls.held(PGE_CTRL_UP)then
  releaseU=true
  else
   if releaseU then
   releaseU=nil
    return true
   end
  end
 elseif tonumber(o)then
  if pressU then
  pad.Un=o-15
   if pad.Un>0 then
   pad.Un=0
   end
   return true
  end
  if pge.controls.held(PGE_CTRL_UP)then
  pad.Un=pad.Un+1
   if pad.Un>o then
   pad.Un=0
    return true
   end
  end
 end
end

function pad:D(o)
 if pge.controls.pressed(PGE_CTRL_DOWN)then
 pressD=true
 end
 if not o then
  if pressD then
   return true
  end
 elseif o=="h" then
  if pge.controls.held(PGE_CTRL_DOWN)then
   return true
  end
 elseif o=="r" then
  if pge.controls.held(PGE_CTRL_DOWN)then
  releaseD=true
  else
   if releaseD then
   releaseD=nil
    return true
   end
  end
 elseif tonumber(o)then
  if pressD then
  pad.Dn=o-15
   if pad.Dn>0 then
   pad.Dn=0
   end
   return true
  end
  if pge.controls.held(PGE_CTRL_DOWN)then
  pad.Dn=pad.Dn+1
   if pad.Dn>o then
   pad.Dn=0
    return true
   end
  end
 end
end

function pad:L(o)
 if pge.controls.pressed(PGE_CTRL_LEFT)then
 pressL=true
 end
 if not o then
  if pressL then
   return true
  end
 elseif o=="h" then
  if pge.controls.held(PGE_CTRL_LEFT)then
   return true
  end
 elseif o=="r" then
  if pge.controls.held(PGE_CTRL_LEFT)then
  releaseL=true
  else
   if releaseL then
   releaseL=nil
    return true
   end
  end
 elseif tonumber(o)then
  if pressL then
  pad.Ln=o-15
   if pad.Ln>0 then
   pad.Ln=0
   end
   return true
  end
  if pge.controls.held(PGE_CTRL_LEFT)then
  pad.Ln=pad.Ln+1
   if pad.Ln>o then
   pad.Ln=0
    return true
   end
  end
 end
end

function pad:R(o)
 if pge.controls.pressed(PGE_CTRL_RIGHT)then
 pressR=true
 end
 if not o then
  if pressR then
   return true
  end
 elseif o=="h" then
  if pge.controls.held(PGE_CTRL_RIGHT)then
   return true
  end
 elseif o=="r" then
  if pge.controls.held(PGE_CTRL_RIGHT)then
  releaseR=true
  else
   if releaseR then
   releaseR=nil
    return true
   end
  end
 elseif tonumber(o)then
  if pressR then
  pad.Rn=o-15
   if pad.Rn>0 then
   pad.Rn=0
   end
   return true
  end
  if pge.controls.held(PGE_CTRL_RIGHT)then
  pad.Rn=pad.Rn+1
   if pad.Rn>o then
   pad.Rn=0
    return true
   end
  end
 end
end

function pad:LS(o)
 if pge.controls.pressed(PGE_CTRL_LTRIGGER)then
 pressLS=true
 end
 if not o then
  if pressLS then
   return true
  end
 elseif o=="h" then
  if pge.controls.held(PGE_CTRL_LTRIGGER)then
   return true
  end
 elseif o=="r" then
  if pge.controls.held(PGE_CTRL_LTRIGGER)then
  releaseLS=true
  else
   if releaseLS then
   releaseLS=nil
    return true
   end
  end
 elseif tonumber(o)then
  if pressLS then
  pad.LSn=o-15
   if pad.LSn>0 then
   pad.LSn=0
   end
   return true
  end
  if pge.controls.held(PGE_CTRL_LTRIGGER)then
  pad.LSn=pad.LSn+1
   if pad.LSn>o then
   pad.LSn=0
    return true
   end
  end
 end
end

function pad:RS(o)
 if pge.controls.pressed(PGE_CTRL_RTRIGGER)then
 pressRS=true
 end
 if not o then
  if pressRS then
   return true
  end
 elseif o=="h" then
  if pge.controls.held(PGE_CTRL_RTRIGGER)then
   return true
  end
 elseif o=="r" then
  if pge.controls.held(PGE_CTRL_RTRIGGER)then
  releaseRS=true
  else
   if releaseRS then
   releaseRS=nil
    return true
   end
  end
 elseif tonumber(o)then
  if pressRS then
  pad.RSn=o-15
   if pad.RSn>0 then
   pad.RSn=0
   end
   return true
  end
  if pge.controls.held(PGE_CTRL_RTRIGGER)then
  pad.RSn=pad.RSn+1
   if pad.RSn>o then
   pad.RSn=0
    return true
   end
  end
 end
end

function pad:SL(o)
 if pge.controls.pressed(PGE_CTRL_SELECT)then
 pressSL=true
 end
 if not o then
  if pressSL then
   return true
  end
 elseif o=="h" then
  if pge.controls.held(PGE_CTRL_SELECT)then
   return true
  end
 elseif o=="r" then
  if pge.controls.held(PGE_CTRL_SELECT)then
  releaseSL=true
  else
   if releaseSL then
   releaseSL=nil
    return true
   end
  end
 elseif tonumber(o)then
  if pressSL then
  pad.SLn=o-15
   if pad.SLn>0 then
   pad.SLn=0
   end
   return true
  end
  if pge.controls.held(PGE_CTRL_SELECT)then
  pad.SLn=pad.SLn+1
   if pad.SLn>o then
   pad.SLn=0
    return true
   end
  end
 end
end

function pad:ST(o)
 if pge.controls.pressed(PGE_CTRL_START)then
 pressST=true
 end
 if not o then
  if pressST then
   return true
  end
 elseif o=="h" then
  if pge.controls.held(PGE_CTRL_START)then
   return true
  end
 elseif o=="r" then
  if pge.controls.held(PGE_CTRL_START)then
  releaseST=true
  else
   if releaseST then
   releaseST=nil
    return true
   end
  end
 elseif tonumber(o)then
  if pressST then
  pad.STn=o-15
   if pad.STn>0 then
   pad.STn=0
   end
   return true
  end
  if pge.controls.held(PGE_CTRL_START)then
  pad.STn=pad.STn+1
   if pad.STn>o then
   pad.STn=0
    return true
   end
  end
 end
end

function pressedany(o)
 if not o then
  if pad:S()or pad:T()or pad:O()or pad:X()or pad:U()or pad:D()or pad:L()or pad:R()or pad:LS()or pad:RS()or pad:SL()or pad:ST()then
   return true
  end
 elseif o=="h" then
  if pad:S("h")or pad:T("h")or pad:O("h")or pad:X("h")or pad:U("h")or pad:D("h")or pad:L("h")or pad:R("h")or pad:LS("h")or pad:RS("h")or pad:SL("h")or pad:ST("h")then
   return true
  end
 elseif o=="r" then
  if pad:S("r")or pad:T("r")or pad:O("r")or pad:X("r")or pad:U("r")or pad:D("r")or pad:L("r")or pad:R("r")or pad:LS("r")or pad:RS("r")or pad:SL("r")or pad:ST("r")then
   return true
  end
 end
end

function updatepress()
pressS=nil
pressT=nil
pressO=nil
pressX=nil
pressU=nil
pressD=nil
pressL=nil
pressR=nil
pressLS=nil
pressRS=nil
pressSL=nil
pressST=nil
end
