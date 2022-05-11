require "import"
import "My bag"
local version = luajava.bindClass("android.os.Build").VERSION.SDK_INT;

local function autotheme()
  if version >= 21 then
    if this.getSharedData("主题")=="夜间" then
      return (android.R.style.Theme_Material)
     else
      return (android.R.style.Theme_Material_Light)
    end
   else
    if this.getSharedData("主题")=="夜间" then
      return (android.R.style.Theme_Holo)
     else
      return (android.R.style.Theme_Holo_Light)
    end
  end
end

activity.setTitle('LUA代码运行')
activity.setTheme(autotheme())

local str={...}

biaoluayx=function()
  local str=str[1]
  loadstring(str)()
end

biaoluaxx=function(a)
  local a=tostring(a)
  local a=string.match(a,":(%d+:.*)")
  print(a)
  翻译(a,function(c)
    print(c)    
    end)
end

xpcall(biaoluayx,biaoluaxx)


