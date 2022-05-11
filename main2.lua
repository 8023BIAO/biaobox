width=activity.width
height=activity.height
w=activity.width
h=activity.height
ripple = activity.obtainStyledAttributes({android.R.attr.selectableItemBackgroundBorderless}).getResourceId(0,0)
ripples = activity.obtainStyledAttributes({android.R.attr.selectableItemBackground}).getResourceId(0,0)

收藏文件路径=luajava.luadir.."/res/srat.txt"

local 设置软件主题=function()

  xpcall(function()
    状态栏透明()
    --导航栏透明()
  end,function(e)
    ztlgd.setVisibility(View.GONE)
  end)

  if 读取缓存("主题") == nil then
    写入缓存("主题","夜间")
  end

  if 读取缓存("主题") then
    if 读取缓存("主题") =="夜间" then

      pcall(function()
        activity.getWindow().setNavigationBarColor(int(0xff202125));
        -- activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION);
      end)

      xpcall(function()
        activity.setTheme(android.R.style.Theme_Material_NoActionBar)
      end,function(e)
        activity.setTheme(android.R.style.Theme_Holo)
        ztlgd.setVisibility(View.GONE)
      end)

      bwz=0xff000000
      提示背景=0xff202125

      BIAO.setTextColor(int("0xCDFFFFFF"))
      toolbar.setBackgroundColor(0xff202125)
      grid.setBackgroundColor(0xff202125)
      grid3.setBackgroundColor(0xff202125)
      --  menu_id.setColorFilter(0xFFFFFFFF)
      search.setColorFilter(0xFFFFFFFF)

      theme_1.setImageBitmap(loadbitmap(luajava.luadir.."/res/icon/sun.png"))
      theme_1.setColorFilter(0xFFFFFFFF)

      star.setColorFilter(0xFFFFFFFF)

      圆图背景="#2f333e"
      圆图字体颜色="#FFFFFF"
      其他字体="#FFFFFF"
      字体背景="#2B2B2E"
      对话框字体="#FFFFFF"
      文字字体颜色="#FFFFFF"
      背景颜色="#202125"

     elseif 读取缓存("主题")=="白天" then
      pcall(function()
        --activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION);
        activity.getWindow().setNavigationBarColor(int(0xffFFFFFF));
      end)
      --白天黑底白字
      if not pcall(function()
          activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR)
        end)then
        --半沉浸
        local ee= pcall(function()
          if Build.VERSION.SDK_INT >= 19 then
            pcall(activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS))
          end
        end)
        --真.黑底
        if not ee then
          pcall(activity.getWindow().setStatusBarColor(int(0xff000000)))
        end
      end

      xpcall(function()
        设置主题()
      end,function(e)
        activity.setTheme(android.R.style.Theme_Holo_Light)
        ztlgd.setVisibility(View.GONE)
      end)

      bwz=0x86000000
      提示背景=0xffFFFFFF

      BIAO.setTextColor(int("0xff606060"))
      toolbar.setBackgroundColor(0xffFFFFFF)
      grid.setBackgroundColor(0xffFFFFFF)
      grid3.setBackgroundColor(0xffFFFFFF)
      --   menu_id.setColorFilter(0x86cdcdcd)
      search.setColorFilter(0xff6e6e6e)

      theme_1.setImageBitmap(loadbitmap(luajava.luadir.."/res/icon/lua.png"))
      theme_1.setColorFilter(0xff6e6e6e)

      star.setColorFilter(0xff6e6e6e)

      圆图背景="#F5F5F5"
      圆图字体颜色="#5A5A5A"
      其他字体="#000000"
      字体背景="#FFFFFF"
      对话框字体="#000000"
      文字字体颜色="#000000"
      背景颜色="#FFFFFF"

    end
  end
end


BIAO.getPaint().setFakeBoldText(true)
设置软件主题()

if activity.ActionBar then
  activity.ActionBar.hide()
end

波纹({search,theme_1,star,BIAO},"圆主题")

function 列表加载()

  data_sc = {}
  adp3=LuaMultiAdapter(this,data_sc,layout2)
  --清空
  adp3.clear()

  function 注册功能2(n)
    local name=sc_table[n]
    adp3.add{
      __type=1,
      title={Text=name,
        BackgroundDrawable=activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{bwz}))
      },
    }
  end

  function endss2()
    adp3.add{__type=2}
    adp3.add{__type=2}
  end

  function 线程执行2(sc_table,_Nn)
    local func_nu=#sc_table
    for n=1,func_nu do
      call("注册功能2",n)
      _Nn=_Nn+1
      if _Nn>func_nu then
        print("发生错误(づ◡ど)\n请重新打开软件")
        activity.finish()
        pcall(function()
          activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
        end)
      end
      --this.sleep(50)
    end
    _Nn=nil
    call("endss2")
  end

  grid3.setAdapter(adp3)
  grid3.setOverScrollMode(ScrollView.OVER_SCROLL_NEVER);--去除阴影

  _Nn=0

  sc_table={}

  if File(收藏文件路径).exists() then
    local read=io.open(收藏文件路径):read("*a")
    for v in read:gmatch("(.-)\n") do
      table.insert(sc_table,v)
    end
  end

  table.sort(sc_table)

  xpcall(function()
    thread(线程执行2,sc_table,_Nn)
  end,function()
    thread(线程执行2,sc_table,_Nn)
  end)
end

function 收藏与全部()
  if _A_S then--收藏
    _A_S=nil
    BIAO.setText("收藏")
    --隐藏
    grid.setVisibility(View.GONE)
    --控件不可视
    --    grid.setVisibility(View.INVISIBLE)
    --控件可视
    grid3.setVisibility(View.VISIBLE)
    star.setImageBitmap(loadbitmap(luajava.luadir.."/res/icon/apps.png"))

    pcall(function()
      if File(收藏文件路径).exists() then
        local list_star=io.open(收藏文件路径):read("*a")
        if list_star=="" then
          os.remove (收藏文件路径)
          list_star=nil
        end
      end
    end)

    xpcall(function()
      列表加载()
    end,function(e)
      列表加载()
    end)

   else--全部
    _A_S=true
    BIAO.setText("小工具")
    --隐藏
    grid3.setVisibility(View.GONE)
    --控件不可视
    --    grid3.setVisibility(View.INVISIBLE)
    --控件可视
    grid.setVisibility(View.VISIBLE)
    star.setImageBitmap(loadbitmap(luajava.luadir.."/res/icon/star.png"))
  end
end

star.onClick=function()
  xpcall(function()
    收藏与全部()
  end,function()
    收藏与全部()
  end)
  return true
end

star.onLongClick=function()
  提示("列表切换")
  return true
end


---------------------------------------------
pcall(function()
  --删除遗留文件
  local yiliu2="sdcard/空文件夹.txt"

  if File(yiliu1).exists() then
    os.remove (yiliu1)
  end

end)

--[==[获取软件启动屏幕方向
local orientation = activity.getWindowManager().getDefaultDisplay().getRotation();
if orientation==0 then
  --竖屏


 else
  --横屏


end

--当屏幕方向发生变化时监听手机屏幕方向
function onConfigurationChanged(newConfig)
  pcall(function()
    if(newConfig.orientation == Configuration.ORIENTATION_LANDSCAPE)then--横屏
      --   Toast.makeText(activity.getApplicationContext(), "横屏", Toast.LENGTH_SHORT).show();

     else--竖屏
      --    Toast.makeText(activity.getApplicationContext(), "竖屏", Toast.LENGTH_SHORT).show();

    end
  end)
end
--[[Configuration.ORIENTATION_LANDSCAPE 横屏
Configuration.ORIENTATION_PORTRAIT 竖屏]]
]==]




