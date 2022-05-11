data = {}
import"layout2"

adp=LuaMultiAdapter(this,data,layout2)

function 注册功能(n)
  local name=namedata[n]
  adp.add{
    __type=1,
    title={Text=name,
      BackgroundDrawable=activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{bwz}))
    };
  }
end


local function 线程执行(namedata,_Nn)
  require "import"
 -- this.sleep(50)
  local func_nu=#namedata
  for n=1,func_nu do
    call("注册功能",n)
    _Nn=_Nn+1
    if _Nn>func_nu then
      print("发生错误(づ◡ど)\n请重新打开软件")
      activity.finish()
      pcall(function()
        activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
      end)
    end
   -- this.sleep(50)
  end
  _Nn=nil
end

grid.setAdapter(adp)
grid.setOverScrollMode(ScrollView.OVER_SCROLL_NEVER);--去除阴影

_Nn=0
table.sort(namedata)

xpcall(function()
  收藏与全部()
end,function()
  收藏与全部()
end)

thread(线程执行,namedata,_Nn)