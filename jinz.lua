
local HexTable2 = {"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"}

--16进制转10进制
function HEXtoshi(str)
  local str=string.upper(str)
  local len=utf8.len(str)
  local jg={}
  for i=1,len,1 do
    local ee=string.sub(str,i,i)
    switch ee
     case "A"
      ee=10
     case "B"
      ee=11
     case "C"
      ee=12
     case "D"
      ee=13
     case "E"
      ee=14
     case "F"
      ee=15
    end
    local cf=len-i
    table.insert(jg,{ee,ee*16^cf})
  end
  local jc=#jg
  local zz=0
  for j=1,jc do
    local z=jg[j][2]
    zz=zz+z
  end
  return tointeger(zz)--返回十进制结果
end

--十进制转十六进制
function shitoHEX(str)
  local data={}
  xh=function(s)
    local y=tointeger(s%16)
    local z=tointeger((s-y)/16)

    if y<9 then
      table.insert(data,y)
     else
      table.insert(data,HexTable2[y+1])
    end

    if z>16 then
      xh(z)
     else
      if (z<9 ) then
        table.insert(data,z)
       else
        table.insert(data,HexTable2[z+1])
      end
    end
  end

  xh(str)
  local data2={}
  local ii=#data
  for i=ii,1,-1 do
    table.insert(data2,data[i])
  end
  local da=table.concat(data2)
  return da
end

--二进制转十进制
function ertoshi(str)
  local str=string.upper(str)
  local len=utf8.len(str)
  local jg={}

  for i=1,len,1 do
    local ee=string.sub(str,i,i)
    local cf=len-i
    table.insert(jg,{ee,ee*2^cf})
  end

  local jc=#jg
  local zz=0

  for j=1,jc do
    local z=jg[j][2]
    zz=zz+z
  end

  return tointeger(zz)
end

--十进制转二进制
function shitoer(str)
  local data={}
  xh=function(s)
    local y=tointeger(s%2)
    local z=tointeger((s-y)/2)
    print(y,z)
    if y <2 then
      table.insert(data,y)
    end

    if z<=2 then
      if z==2 then
        table.insert(data,10)
       elseif z==1 then
        table.insert(data,1)
       elseif z==0 then
        table.insert(data,0)
      end
     elseif z>2 then
      xh(z)
    end

  end
  xh(str)
  local data2={}
  local ii=#data
  for i=ii,1,-1 do
    table.insert(data2,data[i])
  end
  local da=table.concat(data2)
  return da
end

function 十进制以下互转(aa,bb,str)--数字,数字,数字 
  --十进制转十以下进制
  local tox=function(bb,str)
    local data={}
    xh=function(s)
      local y=tointeger(s%bb)
      local z=tointeger((s-y)/bb)
      if y <bb then
        table.insert(data,y)
      end
      if z<=bb then
        if bb==2 then
          if z==2 then
            table.insert(data,10)
           elseif z==1 then
            table.insert(data,1)
           elseif z==0 then
            table.insert(data,0)
          end
         else
          if z==bb then
            table.insert(data,10)
           elseif zz==0 then
            table.insert(data,0)
           else
            table.insert(data,z)
          end
        end
       elseif z>bb then
        xh(z)
      end
    end
    xh(str)
    local data2={}
    local ii=#data
    for i=ii,1,-1 do
      table.insert(data2,data[i])
    end
    local da=table.concat(data2)
    return da
  end

  --进制转十进制
  local tod=function(aa,str)

    local str=string.upper(str)
    local len=utf8.len(str)
    local jg={}

    for i=1,len,1 do
      local ee=string.sub(str,i,i)
      local cf=len-i
      table.insert(jg,{ee,ee*aa^cf})
    end

    local jc=#jg
    local zz=0

    for j=1,jc do
      local z=jg[j][2]
      zz=zz+z
    end
    return tointeger(zz)
  end
  ---------
  if aa>bb then
    local jgg2=tod(aa,str) --转十进制
    local jgg=tox(bb,jgg2)--10进制转xx进制结果
    return jgg--返回进制结果
   else
    local jgg=tod(aa,str)--先转10进制结果
    local jgg2=tox(bb,jgg)--10进制转xx进制结果
    return jgg2,jgg--返回进制结果,返回aa十进制结果
  end
end

--[[
算法自己瞎写的，自己去百度查的，如果不对去原谅
别问为什么没有32,64的进制，因为懒，笨
感谢百度，感谢CSDN，
校验地址：https://www.sojson.com/hexconvert/2to10.html

BIAO.2020.21

]]


