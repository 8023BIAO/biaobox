

安装包提取=function()
  local MyAppListWindow={
    LinearLayout,
    layout_width="-1",
    layout_height="-1",
    id="Win_AppListWindow",
    orientation="vertical",
    background=背景颜色;
    {
      ListView,
      layout_width="-1",
      layout_height="-1",
      id="id_appList",
      DividerHeight=0,
      VerticalScrollBarEnabled=false;
    },
  }

  单对话框(MyAppListWindow,"安装包提取")

  pm=activity.getPackageManager() --全局pm对象

  local AppListItem={
    LinearLayout,
    layout_width="-1",
    layout_height="90dp",
    {
      CardView;
      CardElevation="0";
      CardBackgroundColor="#86cdcdcd";
      Radius="8dp";
      layout_width="-1";
      layout_height="-1";
      layout_marginTop="5dp",
      layout_marginBottom="5dp",
      layout_marginLeft="20dp",
      layout_marginRight="20dp",
      {
        CardView,
        layout_width="-1",
        layout_height="-1",
        CardBackgroundColor=背景颜色;
        Radius=dp2px(8)-4;
        layout_margin="4px";
        {
          LinearLayout,
          layout_width="-1",
          layout_height="-1",
          orientation="center",
          layout_margin="2dp";
          {
            ImageView,
            id="icon",
            layout_width="80dp",
            layout_height="-1",
            layout_margin="2dp",
          },
          {
            LinearLayout,
            layout_weight="1",
            layout_height="-1",
            orientation="vertical",
            {
              TextView,
              id="name",
              textSize="16sp",
              layout_width="-1",
              layout_weight="1",
              gravity="center|left",
              layout_marginBottom="2dp",
              textColor=圆图字体颜色;
            },
            {
              TextView,
              id="banb",
              --    layout_height="-2",
              layout_weight="1",
              gravity="center|left",
              layout_marginBottom="2dp",
              textColor=圆图字体颜色;
            },
            {
              TextView,
              id="packagename",
              layout_width="-1",
              --   layout_height="-2",
              gravity="center|left",
              layout_marginBottom="6dp",
              textColor=圆图字体颜色;
            },
          },
        },
      },
    },
  }

  function 备份(l,n,b)
    local t="sdcard/"
    if not File(t).exists()then
      os.execute('mkdir '..t)
      local zzlj=t..n..b..".apk"
      local zzlj=string.gsub(zzlj,"%s","")
      local zs=LuaUtil.copyDir(l,zzlj)
      if zs then
        提示("提取安装包成功\n保存在"..t,1)
      end

     else
      local zzlj=t..n..b..".apk"
      local zzlj=string.gsub(zzlj,"%s","")
      local zs=LuaUtil.copyDir(l,zzlj)
      if zs then
        提示("提取安装包成功\n保存在"..t,1)
      end
    end
  end


  function ShowAppOC()
    if tostring(Win_WindowInside)=="nil" then
      OpenAppList()
     else
      CloseAppList()
    end
  end

  function OpenAppList()
    id_MainWindow.addView(loadlayout(OutWindow)) --添加一个标准窗口
    win_wininthere.addView(loadlayout(MyAppListWindow)) --添加内容
    ShowAppList()
    function win_Close.onClick()
      CloseAppList()
    end
  end

  function CloseAppList() --AppList关闭
    id_MainWindow.removeView(Win_WindowInside)
    Win_WindowInside=nil
    Win_AppListWindow=nil
    win_wininthere=nil
    id_appList=nil
    AppListAdp=nil
    return
  end

  function ShowAppList() --AppList显示
    AppListAdp=LuaAdapter(activity,AppListItem) --新津适配器
    id_appList.setAdapter(AppListAdp) --设置Adp适配器
    id_appList.OnItemClickListener=function(l,v,i,p) --列表点击打开软件
      local pn=v.Tag.packagename.Text --包名
      local na=v.Tag.name.Text --名字
      local apkph=activity.getPackageManager().getApplicationInfo(pn, 0).sourceDir
      local apkph=tostring(apkph)
      --   local acti=GetActivities(pn)--主activity获取
      -- RunApp(pn,acti) --RunApp(包名,activity)
      备份(apkph,na,pn)
    end

    --
    id_appList.onItemLongClick=function(p,v,i,s)
      --列表项目被长按
      local pn=v.Tag.packagename.Text --包名
      local apkph=activity.getPackageManager().getApplicationInfo(pn, 0).sourceDir
      local apkph=tostring(apkph)
      --分享
      Sharing(apkph)
      --卸载
      --[[   包名=pn
    uri = Uri.parse("package:"..包名)
    intent = Intent(Intent.ACTION_DELETE,uri)
    activity.startActivity(intent)]]

      return true
    end

    id_appList.OnLongClickListener=function(l,v,i,p)
    end

    local res=GetAppList() --筛选可手动启动运行的app

    t1=thread(function(res,pm)
      for n=1,#res-1 do
        call("AddApp",res,n,pm)
        this.sleep(60)
      end
    end,res,pm)

  end

  function AddApp(res,n,pm) --添加App  (数组,循环数,PackageManager)
    pcall(function()
      AppListAdp.add{ --适配器是AppListAdp
        name=res[n].loadLabel(pm),
        icon=res[n].activityInfo.loadIcon(pm),
        packagename=res[n].activityInfo.packageName,
        banb=activity.getPackageManager().getPackageInfo(res[n].activityInfo.packageName, 0).versionName.."   "..GetFileSize(activity.getPackageManager().getApplicationInfo(res[n].activityInfo.packageName, 0).sourceDir)
      }
    end)
  end


  function RunApp(pn,acti) --RunApp(包名,activity)
    local intent = Intent(Intent.ACTION_MAIN)
    intent.addCategory(Intent.CATEGORY_LAUNCHER)
    intent.setComponent(ComponentName(pn, acti))
    isOk(pcall(function() activity.startActivity(intent) end))
    intent=nil
    return
  end


  function GetActivities(packaname) --GetActivities(包名)
    local localIntent = Intent("android.intent.action.MAIN",null)
    localIntent.addCategory("android.intent.category.LAUNCHER")
    local appList = pm.queryIntentActivities(localIntent,0)
    for i=1,#appList-1 do
      local resolveInfo = appList.get(i)
      local packageStr = resolveInfo.activityInfo.packageName
      if (packageStr==packaname) then
        return resolveInfo.activityInfo.name --返回activity
      end
    end
  end

  function GetAppList() --返回两个参数,  resapp列表
    local AppList=pm.getInstalledPackages(0)
    local intent = Intent(Intent.ACTION_MAIN,null)
    intent.addCategory(Intent.CATEGORY_LAUNCHER)
    local res = pm.queryIntentActivities(intent, 0)
    return res
  end

  function isOk(ret) --检查pcall
    rett={ret}
    if tostring(rett[1])=="false" then
      提示("出错!  .."..tostring(rett[2]))
      return
    end
    return
  end

  function Sharing(path)
    FileName=tostring(File(path).Name)
    ExtensionName=FileName:match("%.(.+)")
    Mime=MimeTypeMap.getSingleton().getMimeTypeFromExtension(ExtensionName)
    intent = Intent()
    intent.setAction(Intent.ACTION_SEND)
    intent.setType(Mime)
    file = File(path)
    uri = Uri.fromFile(file)
    intent.putExtra(Intent.EXTRA_STREAM,uri)
    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
    activity.startActivity(Intent.createChooser(intent, "分享到:"))
  end

  function GetFileSize(path)
    import "java.io.File"
    import "android.text.format.Formatter"
    size=File(tostring(path)).length()
    Sizes=Formatter.formatFileSize(activity, size)
    return Sizes
  end

  ShowAppList()
end


网页转应用=function()
  local yx=function()
    ---------
    软件包名=tostring(软件包名)
    if 软件包名 ~="com.biaolua" or 软件包名~="com.Androlua" then
      if not 读取缓存("第一次运行") or (File(luajava.luadir.."/res/project/data/main.lua").exists()==false) then
        写入路径工程=luajava.luadir.."/res/project/data/"
        File(写入路径工程).mkdirs()
        File(luajava.luadir.."/res/project/run").mkdirs()
        local main=[[
require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"

activity.setTitle("活动名称")
wv=LuaWebView(activity)

--初始化,加载网页
wv.loadUrl("网页路径")
--设置出现缩放工具
wv.getSettings().setSupportZoom(true);
--设置出现缩放工具
wv.getSettings().setBuiltInZoomControls(true);
--扩大比例的缩放
wv.getSettings().setUseWideViewPort(true);

wv.requestFocusFromTouch()--设置支持获取手势焦点
--支持JS(建议无论如何加上)
webSettings = wv.getSettings();

wv.Settings.setJavaScriptEnabled(true);

wv.setOnKeyListener(View.OnKeyListener{
  onKey=function (view,keyCode,event)
    if ((keyCode == event.KEYCODE_BACK) and view.canGoBack()) then
      view.goBack();
      return true;
    end
    return false
  end
})

activity.setContentView(wv)
--无广告UA
APP_NAME_UA="netdisk;5.2.7;PC;PC-Windows;6.2.9200;WindowsBaiduYunGuanJia"

--wv.getSettings().setUserAgentString(APP_NAME_UA);


--网页与返回键之间的交互

function onKeyDown(keyCode,event)
  if (keyCode == KeyEvent.KEYCODE_BACK && wv.canGoBack())then
    wv.goBack()
    return true
  end
  return false
end

    shijian=0
    function onKeyDown(code,event)
      if string.find(tostring(event),"KEYCODE_BACK") ~= nil then
        if shijian+2 > tonumber(os.time()) then
          activity.finish()--关闭当前页面
          activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
        end
        shijian=tonumber(os.time())
        return true
      end
    end
]]

        local init=[[
appname="应用名字"
appver="应用版本"
appcode="1"
appsdk="15"
path_pattern=""
packagename="应用包名"
theme="Theme_Material_NoActionBar"
app_key=""
app_channel=""
developer=""
description=""
debugmode=false
user_permission={
  "ACCESS_NETWORK_STATE",
  "ACCESS_WIFI_STATE",
  "INTERNET",
  "READ_EXTERNAL_STORAGE",
  "WRITE_EXTERNAL_STORAGE"
}
]]


        local lu1=写入路径工程.."main.lua"
        local lu2=写入路径工程.."init.lua"


        io.open(lu1,"w+"):write(main):close()
        io.open(lu2,"w+"):write(init):close()

        写入缓存("第一次运行","true")
      end
    end

    ---------------
    local layout={
      LinearLayout;
      layout_width="-1";
      layout_height="-1";
      {
        LinearLayout;
        layout_height="-1";
        layout_margin="4dp";
        orientation="center";
        layout_width="-1";

        {
          FrameLayout;
          layout_height="220dp";
          layout_width="100dp";
          layout_margin="2dp";
          {
            ImageView;
            layout_gravity="center";
            layout_height="200dp";
            layout_width="100dp";
            id="图标"
          };
          {
            TextView;
            textSize="15sp";
            layout_width="100dp";
            text="点击选择图标";
            id="xztb",
            gravity="center";
            layout_height="200dp";
            layout_gravity="center";
            textColor=圆图字体颜色;
          };
        };
        {
          LinearLayout;
          layout_marginTop="10dp";
          layout_height="-1";
          orientation="vertical";
          layout_weight="1";
          {
            LinearLayout;
            layout_width="fill";
            background="nil";
            {
              CardView;
              background=字体背景;
              radius="18dp";
              layout_margin="5dp";
              layout_weight="1";
              Elevation="2dp";
              {
                EditText;
                layout_width="-1";
                background="0";
                textSize="14sp";
                id="名字";
                Hint="应用名字",
                textColor=其他字体;
                singleLine=true,
                padding="10dp";
              };
            };
          };

          {
            LinearLayout;
            layout_width="fill";
            background="nil";
            {
              CardView;
              background=字体背景;
              radius="18dp";
              layout_margin="5dp";
              layout_weight="1";
              Elevation="2dp";
              {
                EditText;
                layout_width="-1";
                background="0";
                textSize="14sp";
                id="版本";
                Hint="版本号(例如:1.0.0)",
                textColor=其他字体;
                singleLine=true,
                padding="10dp";
              };
            };
          };
          {
            LinearLayout;
            layout_width="fill";
            background="nil";
            {
              CardView;
              background=字体背景;
              radius="18dp";
              layout_margin="5dp";
              layout_weight="1";
              Elevation="2dp";
              {
                EditText;
                layout_width="-1";
                background="0";
                textSize="14sp";
                id="包名";
                Hint="包名(例如:com.biao.myapp)",
                textColor=其他字体;
                singleLine=true,
                padding="10dp";
              };
            };
          };
          {
            LinearLayout;
            layout_width="fill";
            background="nil";
            {
              CardView;
              background=字体背景;
              radius="18dp";
              layout_margin="5dp";
              layout_weight="1";
              Elevation="2dp";
              {
                EditText;
                layout_width="-1";
                background="0";
                textSize="14sp";
                id="网址";
                hint="请输入网址(必须http或者https开头)";
                textColor=其他字体;
                singleLine=true,
                padding="10dp";
              };
            };
          };
        };
      };
    };


    local jji=function()
      if 名字.Text=="" or 版本.Text=="" or 包名.Text=="" or 网址.Text=="" then
        提示("请输入完整信息_(•̀ω•́ 」∠)_",3)
       else
        修改(名字.Text,版本.Text,包名.Text,网址.Text,图标路径)
      end
    end

    双对话框(layout,"网页转应用",nil,jji)

    local 路径=luajava.luadir.."/res/project/data"
    local init=luajava.luadir.."/res/project/data/init.lua"
    local main=luajava.luadir.."/res/project/data/main.lua"
    local 启动图=luajava.luadir.."/welcome.png"

    local 打包路径=luajava.luadir.."/res/project/run/"
    local 打包init=luajava.luadir.."/res/project/run/init.lua"
    local 打包main=luajava.luadir.."/res/project/run/main.lua"
    local 打包启动图=luajava.luadir.."/res/project/run/welcome.png"
    local 打包图标=luajava.luadir.."/res/project/run/icon.png"

    if 图标路径 then
      图标路径=nil
    end

    图标.onClick=function()
      local intent= Intent(Intent.ACTION_PICK)
      intent.setType("image/*")
      this.startActivityForResult(intent, 1)
    end

    --回调
    function onActivityResult(requestCode,resultCode,intent)

      if intent then
        --清空图片
        图标.setImageDrawable(nil);
        local cursor =this.getContentResolver ().query(intent.getData(), nil, nil, nil, nil)
        cursor.moveToFirst()
        local idx = cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA)
        fileSrc = cursor.getString(idx)
        图标路径=(fileSrc)
        bit=nil
        --fileSrc回调路径路径
        bit =BitmapFactory.decodeFile(fileSrc)
        图标.setImageBitmap(bit)
        xztb.setText("")
      end
    end


    function 修改(应用名字,应用版本,应用包名,网页路径,图标路径)

      if not 图标路径 then
        图标路径=luajava.luadir.."/icon.png"
      end

      local main=io.open(main):read("*a")
      local main=string.gsub(main,"活动名称",应用名字)
      local main=string.gsub(main,"网页路径",网页路径)
      local init=io.open(init):read("*a")
      local init=string.gsub(init,"应用名字",应用名字)
      local init=string.gsub(init,"应用版本",应用版本)
      local init=string.gsub(init,"应用包名",应用包名)

      if not File(打包启动图).exists() then
        LuaUtil.copyDir(启动图,打包启动图)
      end

      LuaUtil.copyDir(图标路径,打包图标)
      --写入

      io.open(打包init,"w+"):write(init):close()
      io.open(打包main,"w+"):write(main):close()


      bin(打包路径)
    end
  end
  local xx=function()
    提示("实验性功能开发者努力中\n非常抱歉(づ◡ど)")
  end
  xpcall(yx,xx)
end

图片取色=function()
  local w=activity.width
  local h=activity.height
  ys=nil

  local layout={
    LinearLayout,
    orientation="vertical",
    layout_height="fill",
    layout_width="fill",
    {
      FrameLayout,
      layout_height=h/2,
      layout_width="fill",
      {
        LinearLayout,
        layout_height=h/2,
        layout_width="fill",
        id="bj",
        background="#000000",
        {
          ImageView;
          layout_height=h/2,
          layout_width="fill",
          id="iv",
        },
      },
      {
        LinearLayout,
        layout_height=h/2,
        layout_width="fill",
        Gravity="center",
        id="ll",
        {
          TextView,
          layout_height="200",
          layout_width="200",
          id="tv",
        },
      },

    },
    --第二部分
    {
      LinearLayout,
      layout_height="fill",
      layout_width="fill",
      orientation="vertical",
      background="#000000",
      id="tv2",
      {
        SeekBar,
        layout_width="fill",
        layout_marginTop="20dp",
        id="sbx",
      },
      {
        SeekBar,
        layout_marginTop="20dp",
        layout_width="fill",
        id="sby",
      },
      {
        LinearLayout,
        layout_height="fill",
        layout_width="fill",
        orientation="vertical",
        layout_marginTop="20dp",
        {
          CardView;
          layout_width="-1";
          layout_height="-2";
          layout_margin="5dp";
          radius="18dp";
          background=字体背景;
          layout_marginTop="8dp";
          layout_marginBottom="8dp";
          Elevation="2dp";
          layout_weight="1";
          {
            TextView;
            layout_width="-1";
            layout_height="-1";
            textSize="14sp";
            paddingRight="21dp";
            paddingLeft="21dp";
            paddingTop="10dp";
            paddingBottom="10dp";
            textColor=圆图字体颜色;
            id="txt";
            Text="0xFF000000",
            gravity="center";
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
        {
          CardView;
          layout_width="-1";
          layout_height="-2";
          layout_margin="5dp";
          radius="18dp";
          background=字体背景;
          layout_marginTop="8dp";
          layout_marginBottom="8dp";
          Elevation="2dp";
          layout_weight="1";
          {
            TextView;
            layout_width="-1";
            layout_height="-1";
            textSize="14sp";
            paddingRight="21dp";
            paddingLeft="21dp";
            paddingTop="10dp";
            paddingBottom="10dp";
            textColor=圆图字体颜色;
            id="txt2";
            Text="#FF000000",
            gravity="center";
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
        {
          CardView;
          layout_width="-1";
          layout_height="-2";
          layout_margin="5dp";
          radius="18dp";
          background=字体背景;
          layout_marginTop="8dp";
          layout_marginBottom="8dp";
          Elevation="2dp";
          layout_weight="1";
          {
            TextView;
            layout_width="-1";
            layout_height="-1";
            textSize="14sp";
            paddingRight="21dp";
            paddingLeft="21dp";
            paddingTop="10dp";
            paddingBottom="10dp";
            textColor=圆图字体颜色;
            id="txt3";
            Text="#000000",
            gravity="center";
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
      };
    },
  }

  bmp=nil
  --初始化坐标
  local zbx=w/2
  local zby=h/4

  --bmp
  bmp=Bitmap.createBitmap(w,h/2,Bitmap.Config.ARGB_4444)

  单对话框(layout,"图片取色")

  function 调用图片()
    intent= Intent(Intent.ACTION_PICK)
    intent.setType("image/*")
    this.startActivityForResult(intent,1)
  end

  myLuaDrawable=LuaDrawable(function(mCanvas,mPaint,mDrawable)

    --画笔属性
    mPaint.setAntiAlias(true)--抗齿轮
    mPaint.setDither(true)--设定是否使用图像抖动处理，设置后图像更加清晰
    mPaint.setStyle(Paint.Style.STROKE)--设置画笔的风格,空心
    mPaint.setPathEffect(CornerPathEffect(50))--使路径的转角变得圆滑
    mPaint.setFilterBitmap(true); --//设置双线性过滤

    --圆
    mPaint.setStrokeWidth(5)
    mPaint.setColor(0xFF888888)
    mCanvas.drawCircle(100, 100, 67, mPaint);

    --十字架
    mPaint.setStrokeWidth(3)
    mPaint.setColor(0xFFA5A5A5)
    mCanvas.drawLine(100, 0+35, 100, 200-35,mPaint);
    mCanvas.drawLine(0+35, 100, 200-35, 100,mPaint);

  end)


  tv.background=myLuaDrawable


  --图片选择回调
  function onActivityResult(requestCode,resultCode,intent)

    if intent then
      cursor =activity.getContentResolver ().query(intent.getData(), nil, nil, nil, nil)
      cursor.moveToFirst()
      idx = cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA)
      fileSrc = cursor.getString(idx)

      --图片选择后的bitmap格式
      bitmap =BitmapFactory.decodeFile(fileSrc)

      --获取选择后的bitmap宽高
      bitw=bitmap.getWidth()
      bith=bitmap.getHeight()

      --图片如果过大,等比缩小到刚好适配
      function 等比无限缩小()
        while (true) do
          if bitw > w or bith > h/2 then
            bitw=bitw/1.1
            bith=bith/1.1
           else
            break
          end
        end
      end

      function 等比例无限放大()
        while (true) do
          if bitw <= w*0.9614 and bith <=h/2 then
            bitw=bitw*1.1
            bith=bith*1.1
           else
            break
          end
        end
      end

      等比例无限放大()

      --等比修改后,bitmap宽高适配
      等比无限缩小()

      --将图片绘制到bmp中心
      rect=Rect(w/2-bitw/2,h/4-bith/2,bitw + w/2-bitw/2,bith+h/4-bith/2)

      --创建画布
      bmp=Bitmap.createBitmap(w,h/2,Bitmap.Config.ARGB_4444)

      mCanvas=Canvas(bmp)
      mPaint=Paint()
      mCanvas.drawBitmap(bitmap,nil, rect, mPaint);
      if ys==true then
        iv.setImageDrawable(nil);
      end
      --显示
      iv.ImageBitmap=bmp

      --选择图片后取色
      pcall(function()
        local mColor = bmp.getPixel(zbx, zby)
        ys=Integer.toHexString(mColor)
        argb="0x"..ys
        txt.setText(argb)
        txt2.setText("#"..ys)
        txt3.setText("#"..string.sub(ys,3,8))
      end)

      ys=true
     else
      --  提示("未选择图片",3)
    end
  end

  --初始化x轴seekbar属性
  sbx.setMax(w-1);
  sbx.setProgress(w/2);

  --x轴seekbar监听
  sbx.setOnSeekBarChangeListener{

    onProgressChanged=function(SeekBar,progress)

      zbx=progress

      tv.setTranslationX(progress-w/2)

      local mColor = bmp.getPixel(zbx, zby)

      -- //将被替换色替换为需要替换成的颜色附近的值，都替换为相同的颜色略显单调
      --  Bitmap.setPixel(y, x, (newColor .. Math.random() * 100000));

      ys=Integer.toHexString(mColor)

      if ys=="0" then
        argb="0x".."FF000000"
        txt.setText(argb)
        txt2.setText("#FF000000")
        txt3.setText("#000000")

       else
        argb="0x"..ys
        txt.setText(argb)
        txt2.setText("#"..ys)
        txt3.setText("#"..string.sub(ys,3,8))
        ys=true
      end
      tv2.setBackgroundDrawable(nil)
      bj.setBackgroundDrawable(nil)

      tv2.setBackgroundDrawable(ColorDrawable(int(argb)))
      bj.setBackgroundDrawable(ColorDrawable(int(argb)))

      --zbx,mColor=nil,nil
    end
  }


  --初始化y轴seekbar属性
  sby.setMax((h/2)-1);
  sby.setProgress(h/4);


  --y轴seekbar监听
  sby.setOnSeekBarChangeListener{

    onProgressChanged=function(SeekBar,progress)

      zby=progress

      tv.setTranslationY(progress-h/4)

      local mColor = bmp.getPixel(zbx, zby)
      ys=Integer.toHexString(mColor)
      if ys=="0" then
        argb="0x".."FF000000"
        txt.setText(argb)
        txt2.setText("#FF000000")
        txt3.setText("#000000")


       else
        argb="0x"..ys
        txt.setText(argb)
        txt2.setText("#"..ys)
        txt3.setText("#"..string.sub(ys,3,8))
        ys=true
      end
      tv2.setBackgroundDrawable(nil)
      bj.setBackgroundDrawable(nil)

      tv2.setBackgroundDrawable(ColorDrawable(int(argb)))
      bj.setBackgroundDrawable(ColorDrawable(int(argb)))
      -- zby,mColor=nil,nil
    end
  }

  txt.onClick=function()
    if ys ~= true or ys==nil then
      local intent= Intent(Intent.ACTION_PICK)
      intent.setType("image/*")
      this.startActivityForResult(intent,1)
      intent=nil
     else
      local sz =txt.getText()
      复制文本(sz)
      提示("复制:"..sz,1)
      sz=nil
    end
  end

  txt2.onClick=function()
    if ys ~= true or ys==nil then
      local intent= Intent(Intent.ACTION_PICK)
      intent.setType("image/*")
      this.startActivityForResult(intent,1)
      intent=nil
     else
      local sz =txt2.getText()
      复制文本(sz)
      提示("复制:"..sz,1)
      sz=nil
    end
  end

  txt3.onClick=function()
    if ys ~= true or ys==nil then
      local intent= Intent(Intent.ACTION_PICK)
      intent.setType("image/*")
      this.startActivityForResult(intent,1)
      intent=nil
     else
      local sz =txt3.getText()
      复制文本(sz)
      提示("复制:"..sz,1)
      sz=nil
    end
  end


  --长按
  txt.onLongClick=function()
    调用图片()
    return true
  end
  txt2.onLongClick=function()
    调用图片()
    return true
  end
  txt3.onLongClick=function()
    调用图片()
    return true
  end

  iv.onClick=function()
    return true
  end


  --手动
  iv.onTouch=function(v,e)
    local yxx=function()

      local a=e.getAction()&255

      local moveX=e.getX()
      local moveY=e.getY()
      tv.setTranslationX(moveX-w/2)
      tv.setTranslationY(moveY-h/4)

      local zbx=tointeger(moveX)
      local zby=tointeger(moveY)

      local mColor = bmp.getPixel(zbx, zby)
      ys=Integer.toHexString(mColor)

      if ys=="0" then
        argb="0x".."FF000000"
        txt.setText(argb)
        txt2.setText("#FF000000")
        txt3.setText("#000000")
       else
        argb="0x"..ys
        txt.setText(argb)

        txt2.setText("#"..ys)
        txt3.setText("#"..string.sub(ys,3,8))
        ys=true
      end
      tv2.setBackgroundDrawable(nil)
      bj.setBackgroundDrawable(nil)

      tv2.setBackgroundDrawable(ColorDrawable(int(argb)))
      bj.setBackgroundDrawable(ColorDrawable(int(argb)))

      sby.setProgress(moveY);
      sbx.setProgress(moveX);

    end
    local yxxx=function()end
    xpcall(yxx,yxxx)
  end


  sby.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFF9E9E9E,PorterDuff.Mode.SRC_ATOP))
  sby.Thumb.setColorFilter(PorterDuffColorFilter(0xFF9E9E9E,PorterDuff.Mode.SRC_ATOP))

  sbx.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFF9E9E9E,PorterDuff.Mode.SRC_ATOP))
  sbx.Thumb.setColorFilter(PorterDuffColorFilter(0xFF9E9E9E,PorterDuff.Mode.SRC_ATOP))

end

文本去重=function()
  local layout={
    LinearLayout;
    layout_height="fill",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      orientation="vertical";
      layout_height="-2";
      layout_width="-1";
      {
        LinearLayout;
        background="nil";
        layout_width="-1";
        layout_weight="1";
        {
          CardView;
          layout_gravity="center";
          background=字体背景;
          CardElevation="2dp";
          layout_weight="1";
          layout_margin="5dp";
          radius="18dp";
          {
            EditText;
            textSize="14sp";
            id="t1";
            padding="10dp";
            layout_width="fill";
            Hint="要替换字符";
            gravity="center";
            textColor=其他字体;
            background="#00000000";
            SingleLine=true;
          };
        };
        {
          CardView;
          layout_gravity="center";
          background=字体背景;
          CardElevation="2dp";
          layout_weight="1";
          layout_margin="5dp";
          radius="18dp";
          {
            EditText;
            textSize="14sp";
            id="t2";
            padding="10dp";
            layout_width="fill";
            Hint="被替换字符";
            gravity="center";
            textColor=其他字体;
            background="#00000000";
            SingleLine=true;
          };
        };
        {
          CardView;
          id="car";
          layout_weight="1";
          Elevation="2dp";
          layout_height="-2";
          radius="18dp";
          layout_margin="6dp";
          background=字体背景;
          {
            TextView;
            textSize="14sp";
            text="替换";
            layout_width="fill";
            id="t";
            textColor=圆图字体颜色;
            layout_margin="-10dp";
            gravity="center";
            layout_height="56dp";
            BackgroundDrawable=activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
      };
    };
    {
      LinearLayout;
      background="nil";
      layout_width="-1";
      layout_weight="1";
      {
        CardView;
        CardElevation="2dp";
        layout_width="-1";
        layout_height="-2";
        radius="18dp";
        layout_margin="6dp";
        background=字体背景;
        {
          LinearLayout;
          layout_height="-2";
          background="nil";
          layout_width="-1";
          {
            EditText;
            textSize="14sp";
            Hint="请输入源字符串...";
            Text="";
            layout_width="-1";
            id="txt";
            layout_height="-2";
            gravity="left";
            background="0";
            textColor=其他字体;
          };
        };
      };
    };
  };

  local jji=function()
    if txt.Text~="" then
      复制文本(txt.Text)
      提示("已经复制文本",1)
     else
    end
  end
  双对话框(layout,"文本去重","复制",jji)

  local ztb=activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()
  if ztb then
    ztb=tostring(ztb)
    txt.setText(ztb)
  end
  ztb=nil

  t.onClick=function()
    if t1.Text=="" or txt.Text=="" then
      提示("请输入完整信息",3)
     else
      local cw=pcall(function()
        local str=tostring(txt.getText())
        local t1=tostring(t1.getText())
        local t2=tostring(t2.getText())
        local str,NN=string.gsub(str,t1,t2)
        txt.setText(str)
        if NN~=0 then
          提示("共替换"..NN.."次")
         else
          提示("找不到文本(づ◡ど)")
        end
        str,t1,t2=nil,nil,nil
      end)
      if not cw then
        提示("开发者努力中(づ◡ど)")
      end
    end
  end
end

图片圆角=function()
  if bit then
    wb.setImageBitmap(nil);
    bit=nil
    圆角图片后缀格式=nil
    bitmapback=nil
    bitmap=nil
  end
  --回调
  function onActivityResult(requestCode,resultCode,intent)
    if intent then
      yjtpxz=false
      local cursor =this.getContentResolver ().query(intent.getData(), nil, nil, nil, nil)
      cursor.moveToFirst()
      local idx = cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA)
      local fileSrc = cursor.getString(idx)
      --fileSrc回调路径路径
      if bit then
        wb.setImageDrawable(nil);
        bit=nil
        bitmapback=nil
        圆角图片后缀格式=nil
      end
      local gse=pcall(function()
        圆角图片后缀格式=fileSrc:match(".*/.-(%..-)$")
      end)
      if not gse then
        圆角图片后缀格式=".jpg"
      end
      --不能局部
      bit =BitmapFactory.decodeFile(fileSrc)
      fileSrc=nil

      if yj.Text=="" then
        cshyh=20
       else
        cshyh=tonumber(yj.Text)
      end

      bitmap=bit
      Width= bitmap.getWidth()
      Height= bitmap.getHeight()
      bitmapback=Bitmap.createBitmap(Width,Height, Bitmap.Config.ARGB_8888);
      canvas= Canvas(bitmapback);
      paint= Paint();
      rect= Rect(0, 0, Width, Height);
      rectf= RectF(rect);
      paint.setAntiAlias(true);
      canvas.drawRoundRect(rectf, cshyh, cshyh, paint); --先在这个画板上创建一个圆角矩形
      paint.setXfermode(PorterDuffXfermode(PorterDuff.Mode.SRC_IN)); --设置图像叠加模式，取两层图像交集部分，只显示上层图像
      canvas.drawBitmap(bitmap, rect, rect, paint); --将bitmap绘制在画板上
      wb.setImageBitmap(bitmapback)

     else
      yjtpxz=false
    end
  end

  制作圆图=function()
    if bit then
      if bitmapback then
        bitmapback=nil
      end
      wb.setImageDrawable(nil);
      cshyh=tonumber(yj.Text)
      bitmap=bit
      Width= bitmap.getWidth()
      Height= bitmap.getHeight()
      bitmapback=Bitmap.createBitmap(Width,Height, Bitmap.Config.ARGB_8888);
      canvas= Canvas(bitmapback);
      paint= Paint();
      rect= Rect(0, 0, Width, Height);
      rectf= RectF(rect);
      paint.setAntiAlias(true);
      canvas.drawRoundRect(rectf, cshyh, cshyh, paint); --先在这个画板上创建一个圆角矩形
      paint.setXfermode(PorterDuffXfermode(PorterDuff.Mode.SRC_IN)); --设置图像叠加模式，取两层图像交集部分，只显示上层图像
      canvas.drawBitmap(bitmap, rect, rect, paint); --将bitmap绘制在画板上
      wb.setImageBitmap(bitmapback)
     else
      return
    end
  end

  local layout={
    LinearLayout;
    layout_height="fill",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      layout_width="fill";
      background="nil";
      {
        CardView;
        layout_weight="1";
        Elevation="2dp";
        layout_height="-2";
        radius="18dp";
        layout_margin="6dp";
        background=字体背景;
        {
          TextView;
          textSize="14sp";
          text="选择图片";
          layout_width="fill";
          id="xztp";
          textColor=圆图字体颜色;
          layout_margin="-10dp";
          gravity="center";
          layout_height="56dp";
          BackgroundDrawable=activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
        };
      };
      {
        CardView;
        layout_gravity="center";
        background=字体背景;
        CardElevation="2dp";
        layout_weight="1";
        layout_margin="5dp";
        radius="18dp";
        {
          EditText;
          textSize="14sp";
          id="yj";
          padding="10dp";
          layout_width="fill";
          InputType="number",
          Text="20",
          gravity="center";
          Hint="圆角值",
          textColor=其他字体;
          background="#00000000";
          SingleLine=true;

        };
      };
      {
        CardView;
        layout_weight="1";
        Elevation="2dp";
        layout_height="-2";
        radius="18dp";
        layout_margin="6dp";
        background=字体背景;
        {
          TextView;
          textSize="14sp";
          text="制作";
          layout_width="fill";
          id="zz";
          textColor=圆图字体颜色;
          layout_margin="-10dp";
          gravity="center";
          layout_height="56dp";
          BackgroundDrawable=activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
        };
      };
    };
    {
      LinearLayout;
      layout_width="fill";
      background="nil";
      {
        ImageView;
        layout_width="-1";
        id="wb";
        layout_gravity="center";
        layout_height="-1";
        layout_margin="6dp";
      };
    };
  }

  local jji=function()
    yjtpxz=false
    if bitmapback then
      task(function(SavePicture,bit,bitmapback,圆角图片后缀格式)
        require "import"
        local 保存路径="/sdcard/"..tostring(bit)..圆角图片后缀格式
        SavePicture(保存路径,bitmapback)
        bit=nil
        保存路径=nil
        bitmapback=nil
        圆角图片后缀格式=nil
        return "已经保存在:\nsdcard/目录下",1
      end,SavePicture,bit,bitmapback,圆角图片后缀格式,提示)
     else
      提示("请选择图片后再保存",3)
    end
  end

  双对话框(layout,"图片圆角","保存",jji)

  zz.onClick=function()
    if yj.Text~="" then
      if bit then
        制作圆图()
       else
        if not yjtpxz then
          yjtpxz=true
          --调用图库选择图片
          local intent= Intent(Intent.ACTION_PICK)
          intent.setType("image/*")
          this.startActivityForResult(intent, 1)
          intent=nil
        end
      end

    end
  end

  xztp.onClick=function()
    if not yjtpxz then
      yjtpxz=true
      --调用图库选择图片
      local intent= Intent(Intent.ACTION_PICK)
      intent.setType("image/*")
      this.startActivityForResult(intent, 1)
      intent=nil
    end
  end

end

获取QQ头像=function()
  网络判断(function() 提示("没有网络_(•̀ω•́ 」∠)_",3) end,function()
    QJDJ=true
    local layout={
      LinearLayout;
      layout_height="fill",
      layout_width="fill",
      orientation="vertical";
      Focusable=true,
      FocusableInTouchMode=true,
      {
        LinearLayout;
        layout_width="fill";
        background="nil";
        {
          CardView;
          background=字体背景;
          radius="18dp";
          layout_margin="5dp";
          layout_weight="1";
          Elevation="2dp";
          {
            EditText;
            layout_width="fill";
            background="#00000000";
            textSize="14sp";
            id="edit";
            Hint="请输入要获取头像的QQ号",
            singleLine=true,
            textColor=其他字体;
            InputType="number",
            padding="10dp";
          };
        };
      };
    };

    local jji=function()
      if edit.Text~="" then
        local QQ号码=edit.Text
        QQ号码=tostring(QQ号码)
        local url="http://q1.qlogo.cn/g?b=qq&nk="..QQ号码.."&s=640"
        QQ头像(url,QQ号码)
       else
        提示("请输入后再重试",3)
      end
    end
    双对话框(layout,"获取QQ头像","开始",jji)
  end)
end

QQ头像=function(url,QQ号码)
  local layout={
    LinearLayout;
    layout_height="fill",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      layout_height="-2";
      layout_width="-1";
      gravity="center";
      background="0";
      {
        CardView;
        layout_height="-2";
        CardElevation="0";
        layout_width="-2";
        id="car";
        radius="18dp";
        layout_margin="6dp";
        background=圆图背景;
        Elevation="2dp";
        {
          TextView;
          layout_height="56dp";
          gravity="center";
          layout_margin="-10dp";
          text="浏览器打开";
          layout_width="150dp";
          id="llq";
          textColor=圆图字体颜色;
          textSize="14sp";
          BackgroundDrawable=activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
        };
      };

      {
        CardView;
        layout_height="-2";
        CardElevation="0";
        layout_width="-2";
        id="car";
        radius="18dp";
        layout_margin="6dp";
        background=圆图背景;
        Elevation="2dp";
        {
          TextView;
          layout_height="56dp";
          gravity="center";
          layout_margin="-10dp";
          text="保存图片";
          layout_width="150dp";
          id="xz";
          textColor=圆图字体颜色;
          textSize="14sp";
          BackgroundDrawable=activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
        };
      };

    };
    {
      ImageView;
      layout_width="-1";
      id="wb";
      layout_gravity="center";
      layout_height="-1";
      layout_margin="6dp";
      background="0";
    };
  };

  单对话框(layout,QQ号码)
  --清空图片
  wb.setImageDrawable(nil);
  --保存
  local bff=loadbitmap(url)
  ---按键事件
  wb.setImageBitmap(bff)

  xz.onClick=function()
    pcall(function()
      SavePicture(手机内置路径().."/"..QQ号码..".png",bff)
      提示("保存在:sdcard/目录下",1)
    end)
  end

  llq.onClick=function()
    activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
  end

end


短链接生成=function()
  网络判断(function() 提示("没有网络_(•̀ω•́ 」∠)_",3) end,function()
    QJDJ=true
    local layout={
      LinearLayout;
      layout_height="fill",
      layout_width="fill",
      orientation="vertical";
      Focusable=true,
      FocusableInTouchMode=true,
      {
        LinearLayout;
        layout_width="fill";
        background="nil";
        {
          CardView;
          background=字体背景;
          radius="18dp";
          layout_margin="5dp";
          layout_weight="1";
          Elevation="2dp";
          {
            EditText;
            layout_width="fill";
            background="0";
            textSize="14sp";
            id="edit";
            Hint="请输入需要需要缩短的网址",
            textColor=其他字体;
            singleLine=true,
            padding="10dp";
          };
        };
      };
    };

    local jji=function()
      pcall(function()
        if edit.Text~="" then
          local url="https://v1.alapi.cn/api/url"
          local data="url="..edit.Text.."&type=7"
          Http.post(url,data,function(a,b)
            if a==200 and b then
              local data=cjson.decode(b)
              local urls=data["data"]["short_url"]
              复制文本(urls)
              提示("已经复制短链接",1)
             else
              提示("连接错误 错误代码:"..a,3)
            end
          end)
         else
          提示("请输入后再重试",3)
        end
      end)
    end
    双对话框(layout,"短链接生成",nil,jji)

    local ztb=activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()
    --获取剪贴板
    if ztb then
      ztb=tostring(ztb)
      if string.sub(ztb,0,4)=="http"or string.sub(ztb,0,4)=="HTTP" then
        edit.setText(ztb)
      end
    end
    ztb=nil
  end)
end

魔方=function()
  local layout={
    LinearLayout;
    layout_height="fill",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      layout_width="fill";
      background="nil";
      {
        LuaWebView;
        layout_height=activity.getHeight()-activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen")().status_bar_height)-dp2px(56);
        layout_width=activity.getWidth();
        id="wv",
      };
    };
  };
  单对话框(layout,"魔方")
  wv.loadUrl("file:///"..luajava.luadir.."/res/mf/index.html")

  --删除加载
  wv.removeView(wv.getChildAt(0))

  settings = wv.getSettings();
  --关闭webview中缓存
  settings.setCacheMode(WebSettings.LOAD_CACHE_ELSE_NETWORK);
  wv.Settings.setDatabaseEnabled(true);
  --设置出现缩放工具
  wv.Settings.setSupportZoom(true);
  --设置出现缩放工具
  wv.Settings.setBuiltInZoomControls(true);
  --扩大比例的缩放
  wv.Settings.setUseWideViewPort(true);

  webSettings = wv.getSettings();
  wv.Settings.setDatabaseEnabled(true);

  webSettings.setLightTouchEnabled(true);--设置用鼠标激活被选项

  --通过Webview 创建出WebSettings
  settings = wv.getSettings();
  --关闭webview中缓存
  settings.setCacheMode(WebSettings.LOAD_CACHE_ELSE_NETWORK);
  --设置的WebView用户代理字符串
  --settings.setUserAgentString("");
  --启用JavaScript
  settings.setJavaScriptEnabled(true);
  --启用插件
  settings.setPluginState(WebSettings.PluginState.ON);
  --让JavaScript自动打开窗口
  settings.setJavaScriptCanOpenWindowsAutomatically(true);
  --设置DOM存储API是否已启用(设置自适应H5页面
  settings.setDomStorageEnabled(true);
  --设置是否从网络web视图不应加载图像资源（通过http和https URI方案访问的资源）
  settings.setBlockNetworkImage(true);
  --套的WebView是否应使用其内置的缩放机制
  settings.setBuiltInZoomControls(true);
  --设置的WebView是否应该保存的表单数据
  settings.setSaveFormData(true);
  --这种方法在API层面18.保存密码中的WebView不会在将来的版本中支持已被否决
  settings.setSavePassword(true);
  --设置使用内置变焦机制，当web视图是否应显示在屏幕缩放控制
  settings.setDisplayZoomControls(true);
  --设置是否WebView中是否支持多个窗口
  settings.setSupportMultipleWindows(true);
  --设置的WebView是否需要用户手势媒体播放
  settings.setMediaPlaybackRequiresUserGesture(true);
  --支持缓存
  settings.setAppCacheEnabled(true);
  appCaceDir = activity.getApplicationContext().getDir("cache", Context.MODE_PRIVATE).getPath();
  settings.setAppCachePath(appCaceDir);
  --支持自动加载图片
  settings.setLoadsImagesAutomatically(true);
  -- 支持内容重新布局
  settings.setLayoutAlgorithm(WebSettings.LayoutAlgorithm.SINGLE_COLUMN);
  settings.supportMultipleWindows();
  settings.setSupportMultipleWindows(true);
  -- 设置可访问文件
  settings.setAllowFileAccess(true);
  settings.setNeedInitialFocus(true);
  --设定编码格式
  settings.setDefaultTextEncodingName("UTF-8");

  --隐藏滚动条
  wv.setHorizontalScrollBarEnabled(false);
  wv.setVerticalScrollBarEnabled(false);

  wv.Settings.setLayoutAlgorithm(WebSettings.LayoutAlgorithm.SINGLE_COLUMN);
  wv.Settings.setLoadWithOverviewMode(true);

  appCaceDir = activity.getApplicationContext().getDir("cache", Context.MODE_PRIVATE).getPath();
  wv.Settings.setAppCachePath(appCaceDir);

  wv.getSettings().setBuiltInZoomControls(true);
  wv.getSettings().setDefaultFontSize(14);
  wv.getSettings().setDisplayZoomControls(false);
  wv.getSettings().setUseWideViewPort(true);
  wv.getSettings().setLoadWithOverviewMode(true);
  wv.getSettings().setJavaScriptEnabled(true);
  wv.getSettings().setCacheMode(WebSettings.LOAD_NO_CACHE);
  wv.getSettings().setAllowFileAccess(true);
  wv.getSettings().setAppCacheEnabled(true);
  wv.getSettings().setDomStorageEnabled(true);
  wv.getSettings().setDatabaseEnabled(true);

  --状态监听
  wv.setWebViewClient{
    shouldOverrideUrlLoading=function(view,url)
      --Url即将跳转
    end,
    onPageStarted=function(view,url,favicon)
      --网页加载
    end,
    onPageFinished=function(view,url)
      --网页加载完成
    end}

end


机器陪聊=function()
  网络判断(function() 提示("没有网络_(•̀ω•́ 」∠)_",3) end,function()
    QJDJ=true

    if 读取缓存("主题")=="白天" then
      信息背景=0xffF5F5F5
      信息字体颜色=0xff000000
      发送背景=0xffffffff
     else
      信息背景=0xff2f333e
      信息字体颜色=0xffFFFFFF
      发送背景=0xff2b2b2e
    end

    local layout={
      LinearLayout;
      layout_width="fill";
      orientation="vertical";
      -- layout_height=获取屏幕高-状态栏高度-dp2px(56);
      {
        ListView;
        layout_width="fill";
        id="list";
        dividerHeight="0";
        layout_height="fill";
        layout_weight="1";
        VerticalScrollBarEnabled=false;
      };

      --低栏
      {
        LinearLayout;
        layout_width="fill";
        layout_height="-2";
        background="nil";
        {
          LinearLayout;
          -- padding="4dp";
          layout_width="fill";
          background="nil";
          layout_height="-2";
          {
            CardView;
            radius="18dp";
            CardElevation="1dp";
            background=字体背景;
            layout_margin="5dp";
            layout_weight="1";
            layout_height="-2";
            {
              EditText;
              id="poin";
              textColor=对话框字体;
              textSize="14sp";
              layout_width="fill";
              Hint="输入点什么",
              background="0";
              padding="10dp";
              SingleLine=true,
            };
          };
          {
            CardView;
            radius="18dp";
            CardElevation="1dp";
            layout_margin="5dp";
            background=字体背景;
            layout_height="-2";
            id="fas";
            {
              Button;
              text="发送";
              layout_margin="-10dp";
              textColor=对话框字体;
              textSize="14sp";
              layout_width="80dp";
              layout_height="58dp";
              background="0";
              id="ppsn";
            };
          };
        };
      };
    }

    单对话框(layout,"机器陪聊")

    --去除阴影
    list.setOverScrollMode(ScrollView.OVER_SCROLL_NEVER);

    --载入列表
    item={
      LinearLayout;
      layout_height="fill";
      id="pi";
      background="0";
      layout_width="fill";
      {
        LinearLayout;
        id="piu";
        layout_weight="1";
        Gravity=5;
        {
          CardView,
          id="pin",
          layout_margin="10dp";
          CardElevation="2dp";
          radius="15";
          {
            LinearLayout;
            {
              TextView;
              id="ti1";
              textSize="14sp",
              layout_margin="10dp";
              text="内容";
            };
          };
        },
      },
    }


    local data={}
    local adp=LuaAdapter(activity,data,item)

    table.insert(data,{ji={Visibility=View.VISIBLE,},re={Visibility=View.GONE,},ti1={Text="主人欢迎回来！",TextColor=int(信息字体颜色)},piu={Gravity=int(0),},pin={BackgroundColor=int(信息背景)},})
    list.Adapter=adp
    list.onItemLongClick=function(l,v,p,i)
      activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(v.Tag.ti1.Text)
      提示("已复制:"..v.Tag.ti1.Text,1,"18dp")
    end

    b=nil
    --发送消息
    --RippleHelper(ppsn).RippleColor=

    ppsn.onClick=function()
      local wl=activity.getApplicationContext().getSystemService(Context.CONNECTIVITY_SERVICE).getActiveNetworkInfo();

      if wl== nil then
        table.insert(data,{ji={Visibility=View.GONE,},re={Visibility=View.VISIBLE,},ti1={Text=poin.Text,TextColor=int(信息字体颜色)},piu={Gravity=int(5),},pin={BackgroundColor=int(信息背景)},})
        adp.notifyDataSetChanged()
        list.setSelectionFromTop(list.getCount()+1, 0)
        table.insert(data,{ji={Visibility=View.VISIBLE,},re={Visibility=View.GONE,},ti1={Text="没有网络_(•̀ω•́ 」∠)_…",TextColor=int(信息字体颜色)},piu={Gravity=int(0),},pin={BackgroundColor=int(信息背景)},})
        adp.notifyDataSetChanged()
        list.setSelectionFromTop(list.getCount()+1, 0)
       else
        table.insert(data,{ji={Visibility=View.GONE,},re={Visibility=View.VISIBLE,},ti1={Text=poin.Text,TextColor=int(信息字体颜色)},piu={Gravity=int(5),},pin={BackgroundColor=int(信息背景)},})
        adp.notifyDataSetChanged()
        list.setSelectionFromTop(list.getCount()+1, 0)

        --转义
        bo=URLEncoder.encode(poin.Text,"utf-8")
        Http.get("http://api.qingyunke.com/api.php?key=free&appid=0&msg="..bo,function(aa,bb)
          if a==-1 then
            table.insert(data,{ji={Visibility=View.VISIBLE,},re={Visibility=View.GONE,},ti1={Text="网络带我去了很遥远的地方_(•̀ω•́ 」∠)_…",TextColor=int(信息字体颜色)},piu={Gravity=int(0),},pin={BackgroundColor=int(信息背景)},})
            adp.notifyDataSetChanged()
            list.setSelectionFromTop(list.getCount()+1, 0)
           else
            ptr=string.match(bb,".content\":\"(.-)\"}")
            table.insert(data,{ji={Visibility=View.VISIBLE,},re={Visibility=View.GONE,},ti1={Text=ptr,TextColor=int(信息字体颜色)},piu={Gravity=int(0),},pin={BackgroundColor=int(信息背景)},})
            adp.notifyDataSetChanged()
            list.setSelectionFromTop(list.getCount()+1, 0)
          end
        end)
      end
      poin.Text=""
    end

    --编辑框监听事件
    poin.addTextChangedListener{
      onTextChanged=function()
        if #poin.Text==0 then
          fas.setBackgroundColor(发送背景)
          ppsn.setEnabled(false)
         else
          fas.setBackgroundColor(0xFF2196F3)
          ppsn.setEnabled(true)
        end
      end}
    ppsn.setEnabled(false)
  end)

  --[[
EditText输入法右下角事件

必须先设置SingleLine属性为true。
SingleLine=true,
输入法右下角按钮文字默认为 完成
可通过imeOptions属性设置
imeOptions="actionDone",
actionNone  无
actionGo  前往
actionSend  发送
actionDone  完成
actionSearch  搜索
actionNext  下一个
actionPrevious  上一个


--键盘搜索按钮监听事件
poin.setOnEditorActionListener{
  onEditorAction=function(a,b)
    if b==3 then
      if a.Text=="" then
        print("你没有输入任何东西")
       else
        print(a.Text)
      end
    end
  end}
]]

end

UUID生成=function()
  local AppListItem={
    LinearLayout,
    layout_width="-1",
    layout_height="-2",
    {
      CardView;
      CardElevation="0";
      CardBackgroundColor="#86cdcdcd";
      Radius="8dp";
      layout_width="-1";
      layout_height="-2";
      layout_marginTop="5dp",
      layout_marginBottom="5dp",
      layout_marginLeft="20dp",
      layout_marginRight="20dp",
      {
        CardView,
        layout_width="-1",
        layout_height="-1",
        CardBackgroundColor=背景颜色;
        Radius=dp2px(8)-4;
        layout_margin="4px";
        {
          LinearLayout,
          layout_width="-1",
          layout_height="-2",
          orientation="center",
          layout_margin="6dp";
          {
            LinearLayout,
            layout_weight="1",
            layout_height="-2",
            orientation="vertical",
            {
              TextView,
              id="title",
              textSize="16sp",
              layout_width="-1",
              layout_weight="1",
              gravity="center",
              layout_marginBottom="2dp",
              textColor=圆图字体颜色;
            },
          },
        },
      },
    },
  }

  local layout={
    LinearLayout;
    layout_height="fill",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      layout_width="fill";
      background="nil";
      {
        CardView;
        layout_gravity="center";
        background=字体背景;
        CardElevation="2dp";
        layout_weight="1";
        layout_margin="5dp";
        radius="18dp";
        {
          EditText;
          textSize="14sp";
          id="edit";
          padding="10dp";
          layout_width="fill";
          InputType="number",
          gravity="center";
          Hint="请输入生成个数",
          textColor=其他字体;
          background="#00000000";
          SingleLine=true;
        };
      };
      {
        CardView;
        layout_weight="1";
        Elevation="2dp";
        layout_height="-2";
        radius="18dp";
        layout_margin="6dp";
        background=字体背景;
        {
          TextView;
          textSize="14sp";
          text="生成";
          layout_width="fill";
          id="zz";
          textColor=圆图字体颜色;
          layout_margin="-10dp";
          gravity="center";
          layout_height="56dp";
          BackgroundDrawable=activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
        };
      };
    };
    {
      ListView,
      layout_width="-1",
      layout_height="-1",
      id="id_appList",
      DividerHeight=0,
      VerticalScrollBarEnabled=false;
    },
  };

  local jji=function()
    if edit.Text~="" then
      复制文本(table.concat(datauuid))
      提示("已经复制全部信息",1)
     else
      提示("请输入生成数",3)
    end
  end

  双对话框(layout,"UUID生成","复制",jji)

  AppListAdp=LuaAdapter(activity,AppListItem)
  id_appList.setAdapter(AppListAdp)

  zz.onClick=function()
    AppListAdp.clear()
    if edit.Text~="" then
      local e=pcall(function()
        datauuid={}
        for i=1,tonumber(edit.Text) do
          local i=tostring(i)
          local n=tostring(UUID.randomUUID())
          local din="\n"..i..":"..n.."\n"
          AppListAdp.add{
            title=din
          }
          table.insert(datauuid,din)
        end
      end)

      if not e then
        提示("发生错误( •̥́ ˍ •̀ू )",3)
      end
     else
      提示("请输入生成数",3)
    end
  end

  id_appList.onItemClick=function(p,v,i,s)
    local title=v.Tag.title.Text
    复制文本(title)
    提示("已经复制文本内容",1)
  end
  id_appList.onItemLongClick=function(p,v,i,s)
    local title=v.Tag.title.Text
    local text=title
    local intent=Intent(Intent.ACTION_SEND);
    intent.setType("text/plain");
    intent.putExtra(Intent.EXTRA_SUBJECT, "分享");
    intent.putExtra(Intent.EXTRA_TEXT, text);
    intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    activity.startActivity(Intent.createChooser(intent,"分享到:"));
  end
end



油画=function()

  local layout={
    LinearLayout;
    layout_height="fill",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      layout_width="fill";
      background="nil";
      {
        LuaWebView;
        layout_height=activity.getHeight();
        layout_width=activity.getWidth();
        id="wv",
      };
    };
  };
  单对话框(layout,"油画")
  wv.loadUrl("file:///"..luajava.luadir.."/res/yh/index.html")

  --删除加载
  wv.removeView(wv.getChildAt(0))

  settings = wv.getSettings();
  --关闭webview中缓存
  settings.setCacheMode(WebSettings.LOAD_CACHE_ELSE_NETWORK);
  wv.Settings.setDatabaseEnabled(true);
  --设置出现缩放工具
  wv.Settings.setSupportZoom(true);
  --设置出现缩放工具
  wv.Settings.setBuiltInZoomControls(true);
  --扩大比例的缩放
  wv.Settings.setUseWideViewPort(true);

  webSettings = wv.getSettings();
  wv.Settings.setDatabaseEnabled(true);

  webSettings.setLightTouchEnabled(true);--设置用鼠标激活被选项

  --通过Webview 创建出WebSettings
  settings = wv.getSettings();
  --关闭webview中缓存
  settings.setCacheMode(WebSettings.LOAD_CACHE_ELSE_NETWORK);
  --设置的WebView用户代理字符串
  --settings.setUserAgentString("");
  --启用JavaScript
  settings.setJavaScriptEnabled(true);
  --启用插件
  settings.setPluginState(WebSettings.PluginState.ON);
  --让JavaScript自动打开窗口
  settings.setJavaScriptCanOpenWindowsAutomatically(true);
  --设置DOM存储API是否已启用(设置自适应H5页面
  settings.setDomStorageEnabled(true);
  --设置是否从网络web视图不应加载图像资源（通过http和https URI方案访问的资源）
  settings.setBlockNetworkImage(true);
  --套的WebView是否应使用其内置的缩放机制
  settings.setBuiltInZoomControls(true);
  --设置的WebView是否应该保存的表单数据
  settings.setSaveFormData(true);
  --这种方法在API层面18.保存密码中的WebView不会在将来的版本中支持已被否决
  settings.setSavePassword(true);
  --设置使用内置变焦机制，当web视图是否应显示在屏幕缩放控制
  settings.setDisplayZoomControls(true);
  --设置是否WebView中是否支持多个窗口
  settings.setSupportMultipleWindows(true);
  --设置的WebView是否需要用户手势媒体播放
  settings.setMediaPlaybackRequiresUserGesture(true);
  --支持缓存
  settings.setAppCacheEnabled(true);
  appCaceDir = activity.getApplicationContext().getDir("cache", Context.MODE_PRIVATE).getPath();
  settings.setAppCachePath(appCaceDir);
  --支持自动加载图片
  settings.setLoadsImagesAutomatically(true);
  -- 支持内容重新布局
  settings.setLayoutAlgorithm(WebSettings.LayoutAlgorithm.SINGLE_COLUMN);
  settings.supportMultipleWindows();
  settings.setSupportMultipleWindows(true);
  -- 设置可访问文件
  settings.setAllowFileAccess(true);
  settings.setNeedInitialFocus(true);
  --设定编码格式
  settings.setDefaultTextEncodingName("UTF-8");

  --隐藏滚动条
  wv.setHorizontalScrollBarEnabled(false);
  wv.setVerticalScrollBarEnabled(false);

  wv.Settings.setLayoutAlgorithm(WebSettings.LayoutAlgorithm.SINGLE_COLUMN);
  wv.Settings.setLoadWithOverviewMode(true);

  appCaceDir = activity.getApplicationContext().getDir("cache", Context.MODE_PRIVATE).getPath();
  wv.Settings.setAppCachePath(appCaceDir);
  --状态监听
  wv.setWebViewClient{
    shouldOverrideUrlLoading=function(view,url)
      --Url即将跳转
    end,
    onPageStarted=function(view,url,favicon)
      --网页加载
    end,
    onPageFinished=function(view,url)
      --网页加载完成
    end}

end



function 进制转换()
  local layout={
    LinearLayout;
    layout_height="fill";
    layout_width="fill";
    gravity="center";
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      layout_height="-2";
      layout_width="-1";
      {
        LinearLayout;
        layout_height="-2";
        background="nil";
        layout_width="fill";
        {
          CardView;
          layout_weight="1";
          radius="18dp";
          layout_height="-2";
          CardElevation="1dp";
          layout_margin="5dp";
          background=字体背景;
          {
            EditText;
            Hint="输入点什么";
            textSize="14sp";
            padding="10dp";
            background="0";
            id="a";
            textColor=其他字体;
            SingleLine=true;
            layout_width="fill";
            gravity="center";
          };
        };
        {
          Spinner;
          layout_weight="1";
          id="b";
        };
      };
    };
    {
      ListView;
      DividerHeight=0;
      layout_height="-2";
      id="id_appList";
      VerticalScrollBarEnabled=false;
      layout_width="-1";
    };
  };

  单对话框(layout,"进制转换")

  local 数据={}
  table.insert(数据,"请选择")
  for i=2,10 do
    table.insert(数据,i.."进制")
  end
  table.insert(数据,"16进制")
  --创建适配器
  local array_adp3=ArrayAdapter(activity,android.R.layout.simple_list_item_1,String(数据))
  --设置适配器
  b.setAdapter(array_adp3)

  import "jinz"
  function 计算添加(jz)
    local data={}
    local data2={}

    for i=jz,10 do
      local g=十进制以下互转(jz-1,i,a.Text)
      table.insert(data,g)
    end

    for i=jz-1, 2,-1 do
      local g=十进制以下互转(jz-1,i,a.Text)
      table.insert(data2,g)
    end

    local shi=data[10-jz+1]
    local HEX16=shitoHEX(shi)

    AppListAdp.clear()

    for i= 2,jz-2 do
      AppListAdp.add{
        title=i.."进制",
        poin=data2[jz-i]
      }
    end

    AppListAdp.add{
      title=jz-1 .."进制",
      poin=a.Text}

    for i= jz,10 do
      AppListAdp.add{
        title=i.."进制",
        poin=data[i-jz+1]
      }
    end
    AppListAdp.add{
      title="16进制",
      poin=HEX16
    }
  end

  b.onItemSelected=function(l,v,p,i)
    local e,ee= pcall(function()
      if a.Text=="" or a.Text==nil then

       else
        switch v.Text
         case "2进制"
          计算添加(3)
         case "3进制"
          计算添加(4)
         case "4进制"
          计算添加(5)
         case "5进制"
          计算添加(6)
         case "6进制"
          计算添加(7)
         case "7进制"
          计算添加(8)
         case "8进制"
          计算添加(9)
         case "9进制"
          计算添加(10)
         case "10进制"
          local data={}
          local data2={}
          for i=9,2 ,-1 do
            local g=十进制以下互转(10,i,a.Text)
            table.insert(data,g)
          end

          for i=#data,1,-1 do
            table.insert(data2,data[i])
          end

          local HEX16=shitoHEX(a.Text)

          AppListAdp.clear()

          for i= 2, 9 do
            AppListAdp.add{
              title=i.."进制",
              poin=data2[i-1]
            }
          end

          AppListAdp.add{
            title="10进制",
            poin=a.Text}

          AppListAdp.add{
            title="16进制",
            poin=HEX16
          }

         case "16进制"
          local jg=HEXtoshi(a.Text)

          local data={}
          local data2={}
          for i=9,2 ,-1 do
            local g=十进制以下互转(10,i,jg)
            table.insert(data,g)
          end

          for i=#data,1,-1 do
            table.insert(data2,data[i])
          end

          AppListAdp.clear()

          for i= 2, 9 do
            AppListAdp.add{
              title=i.."进制",
              poin=data2[i-1]
            }
          end

          AppListAdp.add{
            title="10进制",
            poin=jg}

          AppListAdp.add{
            title="16进制",
            poin=a.Text
          }

        end
      end
    end)
    if not e then
      提示("发生错误\n:"..ee)
    end
  end

  local AppListItem={
    LinearLayout,
    layout_width="-1",
    layout_height="-2",
    {
      CardView;
      CardElevation="0";
      CardBackgroundColor="#86cdcdcd";
      Radius="8dp";
      layout_width="-1";
      layout_height="-2";
      layout_marginTop="5dp",
      layout_marginBottom="5dp",
      layout_marginLeft="20dp",
      layout_marginRight="20dp",
      {
        CardView,
        layout_width="-1",
        layout_height="-1",
        CardBackgroundColor=背景颜色;
        Radius=dp2px(8)-4;
        layout_margin="4px";
        {
          LinearLayout,
          layout_width="-1",
          layout_height="-2",
          orientation="center",
          layout_margin="6dp";
          {
            LinearLayout,
            layout_weight="1",
            layout_height="-2",
            orientation="horizontal",
            {
              TextView,
              id="title",
              textSize="14sp",
              layout_width="-2",
              gravity="left",
              layout_marginBottom="2dp",
              textColor=圆图字体颜色;
            },
            {
              EditText;
              textSize="14sp";
              background="0";
              padding="10dp";
              id="poin";
              layout_width="-1";
              textColor=其他字体;
              SingleLine=true;
            };
          },
        },
      },
    },
  }
  AppListAdp=LuaAdapter(activity,AppListItem)
  id_appList.setAdapter(AppListAdp)
end


function QQ自动点赞()
  activity.startActivity(Intent().setAction(Settings.ACTION_ACCESSIBILITY_SETTINGS))
  提示("请检查本程序无障碍是否开启\n然后请手动跳到QQ点赞界面")
  function LuaAccessibilityService.onAccessibilityEvent(event)
    if tostring(event.getClassName())=="com.tencent.mobileqq.activity.VisitorsActivity" then--判断你是否打开了点赞页面
      --local view=event.getSource().findAccessibilityNodeInfosByViewId("com.demo:id/bt")
      --得到qq点赞视图中所有有(赞)字的列表项目表
      pcall(function()
        local view=event.getSource().findAccessibilityNodeInfosByText("赞")
        for x=0,#view do--遍历每个项目
          for n=1,20 do --每个项目点击二十下，16就是点击动作
            view[x].performAction(16)
          end
        end
      end)
    end
    if tostring(event.getClassName())=="com.tencent.mobileqq.activity.FriendProfileCardActivity" then--判断你是否打开了点赞页面
      pcall(function()
        local view=event.getSource().findAccessibilityNodeInfosByText("赞")
        for x=0,#view do--遍历每个项目
          for n=1,20 do --每个项目点击二下，16就是点击动作
            view[x].performAction(16)
          end
        end
      end)
    end
  end
end


ping1=function()
  local AppListItem={
    LinearLayout,
    layout_width="-1",
    layout_height="-2",
    {
      LinearLayout,
      layout_width="-1",
      layout_height="-2",
      orientation="center",
      layout_margin="6dp";
      {
        LinearLayout,
        layout_weight="1",
        layout_height="-2",
        orientation="vertical",
        {
          TextView,
          id="title",
          textSize="16sp",
          layout_width="-1",
          layout_weight="1",
          gravity="center",
          layout_marginBottom="2dp",
          textColor=圆图字体颜色;
        },
      },
    },
  }

  local layout={
    LinearLayout;
    layout_height="fill",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      layout_width="fill";
      background="nil";
      {
        CardView;
        layout_gravity="center";
        background=字体背景;
        CardElevation="2dp";
        layout_weight="1";
        layout_margin="5dp";
        radius="18dp";
        {
          EditText;
          textSize="14sp";
          id="edit";
          padding="10dp";
          layout_width="fill";
          gravity="center";
          Hint="ipAddress",
          textColor=其他字体;
          background="#00000000";
          SingleLine=true;
        };
      };
      {
        CardView;
        layout_gravity="center";
        background=字体背景;
        CardElevation="2dp";
        layout_weight="1";
        layout_margin="5dp";
        radius="18dp";
        {
          EditText;
          textSize="14sp";
          id="edit1";
          padding="10dp";
          layout_width="fill";
          InputType="number",
          gravity="center";
          Hint="time",
          textColor=其他字体;
          background="#00000000";
          SingleLine=true;
        };
      };
      {
        CardView;
        layout_weight="1";
        Elevation="2dp";
        layout_height="-2";
        radius="18dp";
        layout_margin="6dp";
        background=字体背景;
        {
          TextView;
          textSize="14sp";
          text="ping";
          layout_width="fill";
          id="zz";
          textColor=圆图字体颜色;
          layout_margin="-10dp";
          gravity="center";
          layout_height="56dp";
          BackgroundDrawable=activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
        };
      };
    };
    {
      ListView,
      layout_width="-1",
      layout_height="-1",
      id="id_appList",
      DividerHeight=0,
      VerticalScrollBarEnabled=false;
    },
  };

  local dataPing={}

  local jji=function()
    if edit.Text~="" and edit1.Text~="" and dataPing[1] then
      复制文本(table.concat(dataPing))
      提示("已经复制全部信息",1)
     else
      提示("发生错误")
    end
  end

  双对话框(layout,"Ping","复制",jji)

  local AppListAdp=LuaAdapter(activity,AppListItem)
  id_appList.setAdapter(AppListAdp)

  zz.onClick=function()
    AppListAdp.clear()
    if edit.Text~="" and edit1.Text ~="" then
      local e=pcall(function()

        ping(edit.Text,edit1.Text,function(a)
          AppListAdp.add{
            title=tostring(a)
          }
          table.insert(dataPing,a)
        end)
      end)

      if not e then
        提示("发生错误( •̥́ ˍ •̀ू )",3)
      end
     else
      提示("请填写完整",3)
    end
  end

  id_appList.onItemLongClick=function(p,v,i,s)
    local title=v.Tag.title.Text
    复制文本(title)
    提示("已经复制文本内容",1)
  end
end

TTS语音播报=function()
  local layout={
    LinearLayout;
    layout_height="fill",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      layout_width="fill";
      orientation="vertical";
      {
        GridLayout;
        layout_width="fill";
        layout_margin="10dp";
        columnCount="2";
        {
          TextView;
          text="语调";
          layout_height="35dp";
          TextColor=其他字体;
        };
        {
          SeekBar;
          id="seekbar";
          layout_width="-1";
          layout_height="30dp";
        };
        {
          TextView;
          text="语速";
          layout_height="35dp";
          TextColor=其他字体;
        };
        {
          SeekBar;
          layout_width="-1";
          id="seekbar2";
          layout_height="30dp";
        };
      };
    };
    {
      LinearLayout;
      orientation="vertical";
      layout_height="-2";
      layout_width="-1";
      {
        LinearLayout;
        background="nil";
        layout_width="-1";
        layout_weight="1";
        {
          CardView;
          id="car";
          layout_weight="1";
          Elevation="2dp";
          layout_height="-2";
          radius="18dp";
          layout_margin="6dp";
          background=字体背景;
          {
            TextView;
            textSize="14sp";
            text="播报";
            layout_width="fill";
            id="t";
            textColor=圆图字体颜色;
            layout_margin="-10dp";
            gravity="center";
            layout_height="56dp";
            BackgroundDrawable=activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
      };
    };
    {
      LinearLayout;
      background="nil";
      layout_width="-1";
      layout_weight="1";
      {
        CardView;
        CardElevation="2dp";
        layout_width="-1";
        layout_height="-2";
        radius="18dp";
        layout_margin="6dp";
        background=字体背景;
        {
          LinearLayout;
          layout_height="-2";
          background="nil";
          layout_width="-1";
          {
            EditText;
            textSize="14sp";
            Hint="请输入字符串...";
            Text="";
            layout_width="-1";
            id="txt";
            layout_height="-2";
            gravity="left";
            background="0";
            textColor=其他字体;
          };
        };
      };
    };
  };

  单对话框(layout,"TTS语音播报")

  seekbar.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFF9E9E9E,PorterDuff.Mode.SRC_ATOP))
  seekbar.Thumb.setColorFilter(PorterDuffColorFilter(0xFF9E9E9E,PorterDuff.Mode.SRC_ATOP))

  seekbar2.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFF9E9E9E,PorterDuff.Mode.SRC_ATOP))
  seekbar2.Thumb.setColorFilter(PorterDuffColorFilter(0xFF9E9E9E,PorterDuff.Mode.SRC_ATOP))

  local ztb=activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()
  if ztb then
    ztb=tostring(ztb)
    txt.setText(ztb)
  end
  ztb=nil

  YD,YS=1,1;

  seekbar.max=320
  seekbar2.max=320

  seekbar.progress=100
  seekbar2.progress=100

  seekbar.setOnSeekBarChangeListener{
    onProgressChanged=function(view,i)
      YD=i*0.01
    end}

  seekbar2.setOnSeekBarChangeListener{
    onProgressChanged=function(view,i)
      YS=i*0.01
    end}

  t.onClick=function()
    if txt.Text=="" then
      提示("请输入字符串",3)
     else
      使用系统TTS语音播报(YD,YS,txt.Text)
    end
  end
end

空白昵称=function()
  local layout={
    LinearLayout;
    layout_height="fill",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      background="nil";
      layout_width="-1";
      layout_weight="1";

      {
        CardView;
        layout_weight="1";
        Elevation="2dp";
        layout_height="-2";
        radius="18dp";
        layout_margin="6dp";
        background=字体背景;
        {
          TextView;
          textSize="14sp";
          text="空白昵称";
          layout_width="fill";
          id="a_a";
          textColor=圆图字体颜色;
          layout_margin="-10dp";
          gravity="center";
          layout_height="56dp";
          BackgroundDrawable=activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
        };
      };

      {
        CardView;
        layout_weight="1";
        Elevation="2dp";
        layout_height="-2";
        radius="18dp";
        layout_margin="6dp";
        background=字体背景;
        {
          TextView;
          textSize="14sp";
          text="微信空白昵称";
          layout_width="fill";
          id="a_b";
          textColor=圆图字体颜色;
          layout_margin="-10dp";
          gravity="center";
          layout_height="56dp";
          BackgroundDrawable=activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
        };
      };

    };
  };


  单对话框(layout,"空白昵称")

  a_a.onClick=function()
    复制文本("‭‭‭")
    提示("已经复制空白昵称",1)
    return true
  end

  a_b.onClick=function()
    复制文本(" ")
    提示("已经复制微信空白昵称",1)
    return true
  end

end

get_post=function()
  local layout= {
    LinearLayout;
    layout_height="fill",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      background="nil";
      layout_width="-1";
      layout_weight="1";
      {
        CardView;
        CardElevation="2dp";
        layout_width="-1";
        layout_height="-2";
        radius="18dp";
        layout_margin="6dp";
        background=字体背景;
        {
          LinearLayout;
          layout_height="-2";
          background="nil";
          layout_width="-1";
          {
            EditText;
            textSize="14sp";
            Hint="调试网址(http或http开头)";
            Text="";
            layout_width="-1";
            id="edit";
            layout_height="-2";
            gravity="left";
            background="0";
            textColor=其他字体;
            SingleLine=true;
          };
        };
      };
    };
    {
      LinearLayout;
      background="nil";
      layout_width="-1";
      layout_weight="1";
      {
        CardView;
        CardElevation="2dp";
        layout_width="-1";
        layout_height="-2";
        radius="18dp";
        layout_margin="6dp";
        background=字体背景;
        {
          LinearLayout;
          layout_height="-2";
          background="nil";
          layout_width="-1";
          {
            EditText;
            textSize="14sp";
            Hint="data(输入为post模式，留空为get模式)";
            Text="";
            layout_width="-1";
            id="data";
            layout_height="-2";
            gravity="left";
            background="0";
            textColor=其他字体;
            SingleLine=true;
          };
        };
      };
    };
    {
      LinearLayout;
      background="nil";
      layout_width="-1";
      layout_weight="1";
      {
        CardView;
        CardElevation="2dp";
        layout_width="-1";
        layout_height="-2";
        radius="18dp";
        layout_margin="6dp";
        background=字体背景;
        {
          LinearLayout;
          layout_height="-2";
          background="nil";
          layout_width="-1";
          {
            EditText;
            textSize="14sp";
            Hint="cookie(身份辨认信息)";
            Text="";
            layout_width="-1";
            id="cookie";
            layout_height="-2";
            gravity="left";
            background="0";
            textColor=其他字体;
            SingleLine=true;
          };
        };
      };
    };
    {
      LinearLayout;
      background="nil";
      layout_width="-1";
      layout_weight="1";
      {
        CardView;
        CardElevation="2dp";
        layout_width="-1";
        layout_height="-2";
        radius="18dp";
        layout_margin="6dp";
        background=字体背景;
        {
          LinearLayout;
          layout_height="-2";
          background="nil";
          layout_width="-1";
          {
            EditText;
            textSize="14sp";
            Hint="charset(编码)";
            Text="";
            layout_width="-1";
            id="charset";
            layout_height="-2";
            gravity="left";
            background="0";
            textColor=其他字体;
            SingleLine=true;
          };
        };
      };
    };
    {
      LinearLayout;
      background="nil";
      layout_width="-1";
      layout_weight="1";
      {
        CardView;
        CardElevation="2dp";
        layout_width="-1";
        layout_height="-2";
        radius="18dp";
        layout_margin="6dp";
        background=字体背景;
        {
          LinearLayout;
          layout_height="-2";
          background="nil";
          layout_width="-1";
          {
            EditText;
            textSize="14sp";
            Hint="header(请求头，格式为:{名称=值}{名称=值}…) ";
            Text="";
            layout_width="-1";
            id="header";
            layout_height="-2";
            gravity="left";
            background="0";
            textColor=其他字体;
            SingleLine=true;
          };
        };
      };
    };
  }

  local jji=function()
    if edit.Text=="" then
      提示("调试网址不能留空",3)
     else

      if cookie.Text=="" then
        cookie1=nil
       else
        cookie1=cookie.Text
      end

      if data.Text=="" then
        data1=nil
       else
        data1=data.Text
      end

      if charset.Text=="" then
        charset1=nil
       else
        charset1=charset.Text
      end

      if header.Text=="" then
        header1=nil
       else
        header1=header.Text
        hm=HashMap{}
        for i,v in header1:gmatch("{(.-)=(.-)}") do
          hm[i]=v
        end

        if hm~=HashMap{} then
          header1=hm
         else
          header1=nil
        end

      end

      if data.Text=="" then--get
        Http.get(edit.Text,cookie1,charset1,header1,function(code,content,cookie,header)
          local callback={}
          callback[1]="code:\n"..tostring(code).."(2xx表示成功，4xx表示请求错误，5xx表示服务器错误，-1表示出错)"
          callback[2]="content:\n"..tostring(content)
          callback[3]="cookie:\n"..tostring(cookie)
          callback[4]="header:\n"..tostring(header)
          文字显示("get callback",callback)
        end)
       else--post
        Http.post(edit.Text,data1,cookie1,charset1,header1,function(code,content,cookie,header)
          local callback={}
          callback[1]="code:\n"..tostring(code).."(2xx表示成功，4xx表示请求错误，5xx表示服务器错误，-1表示出错)"
          callback[2]="content:\n"..tostring(content)
          callback[3]="cookie:\n"..tostring(cookie)
          callback[4]="header:\n"..tostring(header)
          文字显示("post callback",callback)
        end)
      end

    end
  end
  双对话框(layout,"get/post 调试","调试",jji)
end

文字显示=function(bt,str)
  QJDJ=true
  local bt=tostring(bt)

  local AppListItem={
    LinearLayout,
    layout_width="-1",
    layout_height="-2",
    {
      LinearLayout,
      layout_width="-1",
      layout_height="-2",
      orientation="center",
      layout_margin="6dp";
      {
        LinearLayout,
        layout_weight="1",
        layout_height="-2",
        orientation="vertical",
        {
          TextView,
          id="title",
          textSize="16sp",
          layout_width="-1",
          layout_weight="1",
          gravity="center",
          layout_marginBottom="2dp",
          textColor=圆图字体颜色;
        },
      },
    },
  }


  local layout={
    LinearLayout;
    layout_height="fill",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      ListView,
      layout_width="-1",
      layout_height="-1",
      id="id_appList",
      DividerHeight=0,
      VerticalScrollBarEnabled=false;
    },
  }
  单对话框(layout,bt)

  local AppListAdp=LuaAdapter(activity,AppListItem)
  id_appList.setAdapter(AppListAdp)

  for i=1, #str do
    AppListAdp.add{
      title=tostring(str[i])
    }
  end

  id_appList.onItemLongClick=function(p,v,i,s)
    local title=v.Tag.title.Text
    复制文本(title)
    提示("已经复制文本内容",1)
  end

end