require "import"
import "My bag"

w=获取屏幕宽
h=获取屏幕高

page_1={
  LinearLayout;
  id="hd1";
  layout_width="fill";
  gravity="center";
  orientation="vertical";
  layout_height="fill";
  {
    LuaWebView;
    layout_width="-1";
    layout_height="-1";
    background="#000000";
    id="wb1"
  };
};
page_2={
  LinearLayout;
  id="hd2";
  layout_width="fill";
  gravity="center";
  orientation="vertical";
  layout_height="fill";
  {
    LuaWebView;
    layout_width="-1";
    layout_height="-1";
    background="#000000";
    id="wb2"
  };
};
page_3={
  LinearLayout;
  id="hd3";
  layout_width="fill";
  gravity="center";
  orientation="vertical";
  layout_height="fill";
  {
    LuaWebView;
    layout_width="-1";
    layout_height="-1";
    background="#000000";
    id="wb3"
  };
};
page_4={
  LinearLayout;
  id="hd4";
  layout_width="fill";
  gravity="center";
  orientation="vertical";
  layout_height="fill";
  {
    LuaWebView;
    layout_width="-1";
    layout_height="-1";
    background="#000000";
    id="wb4"
  };
};
page_5={
  LinearLayout;
  id="hd5";
  layout_width="fill";
  gravity="center";
  orientation="vertical";
  layout_height="fill";
  {
    LuaWebView;
    layout_width="-1";
    layout_height="-1";
    background="#000000";
    id="wb5"
  };
};
page_6={
  LinearLayout;
  id="hd6";
  layout_width="fill";
  gravity="center";
  orientation="vertical";
  layout_height="fill";
  {
    LuaWebView;
    layout_width="-1";
    layout_height="-1";
    background="#000000";
    id="wb6"
  };
};

layout={
  DrawerLayout;
  id="dr";
  background="#ff202125",
  {
    LinearLayout;
    id="zqq",
    layout_height="fill",
    layout_width="fill";
    orientation="vertical";
    background="#ff202125",
    {
      LinearLayout;
      layout_height="-2";
      layout_width="-1";
      id="toolbar";
      orientation="vertical";
      background="#ff202125",
      {---状态栏
        -- fitsSystemWindows="true";这个也可以
        LinearLayout;--状态栏沉浸后内容会上升到状态栏，顶状态栏位置--
        layout_height=activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen")().status_bar_height);
        layout_width="-1";
        background="#ff202125",
      };
      {--标题
        LinearLayout;
        -- fitsSystemWindows="true";
        layout_width="fill",
        background="0",
        elevation=10;
        layout_height="wrap";
        background="#ff202125",
        {
          LinearLayout;
          layout_width="-2";
          orientation="horizontal";
          layout_height="50dp";
          background="0",
          gravity="center";
          background="#ff202125",

          {
            TextView;
            layout_marginLeft="20dp";
            TextColor="0xffffffff";
            id="BIAO";
            Gravity="center_vertical";
            layout_width="-2";
            layout_height="-2";
            textSize="18sp";
            text="视频解析";
          };
        };
        {
          LinearLayout;
          layout_width="-1";
          orientation="horizontal";
          layout_height="50dp";
          background="0",
          gravity="right|center";
          layout_marginRight="4dp";
          background="#ff202125",
          {
            ImageView;
            src="res/icon/icon_menu_white.png";
            id="menu_id";
            layout_width="-2";
            padding="10dp";
          };
        };
      };
      --项目
      {
        LinearLayout,
        layout_width="fill",
        layout_height="3.9%h",
        background="#ff202125",
        id="zti2",
        elevation=10,
        {
          TextView,
          textSize=px2sp(dp2px(14)),
          layout_weight="1",
          text="腾讯",
          gravity="center",
          layout_height="fill",
          id="tab_1",
          layout_width="fill",
          textColor="#FFFFFFFF",
        },
        {
          TextView,
          textSize=px2sp(dp2px(14)),
          layout_weight="1",
          text="优酷",
          gravity="center",
          layout_height="fill",
          id="tab_2",
          layout_width="fill",
          textColor="#FFFFFFFF",
        },
        {
          TextView,
          textSize=px2sp(dp2px(14)),
          layout_weight="1",
          text="爱奇艺",
          gravity="center",
          layout_height="fill",
          id="tab_3",
          layout_width="fill",
          textColor="#FFFFFFFF",
        },
        {
          TextView,
          textSize=px2sp(dp2px(14)),
          layout_weight="1",
          text="搜狐",
          gravity="center",
          layout_height="fill",
          id="tab_4",
          layout_width="fill",
          textColor="#FFFFFFFF",
        },

        {
          TextView,
          textSize=px2sp(dp2px(14)),
          layout_weight="1",
          text="PPTV",
          gravity="center",
          layout_height="fill",
          id="tab_5",
          layout_width="fill",
          textColor="#FFFFFFFF",
        },
        {
          TextView,
          textSize=px2sp(dp2px(14)),
          layout_weight="1",
          text="乐视",
          gravity="center",
          layout_height="fill",
          id="tab_6",
          layout_width="fill",
          textColor="#FFFFFFFF",
        },
      };
    };

    {
      RelativeLayout;
      layout_width="fill";
      layout_height="fill";
      background="0";
      id="dhua",
      --主页面
      {
        LinearLayout;
        layout_height="match";
        --fitsSystemWindows="true";
        layout_width="match";
        {
          PageView,
          id="page",
          layout_width="match",
          layout_up="lay_tab",
          layout_height="match",
          pages={
            page_1,
            page_2,
            page_3,
            page_4,
            page_5,
            page_6,
            page_7,
          },
        };

      };
      --悬浮
      {
        ImageButton;
        id="bt";
        layout_width="-2";
        layout_height="-2";
        layout_marginRight="40dp";
        background="nil";
        src="res/icon/bof.png",
        layout_alignParentRight="true";
        layout_alignParentBottom="true";
        layout_marginBottom="40dp";
      };

    };
  };

};


-------------------------------
activity.setTitle('视频解析')
activity.setContentView(loadlayout(layout))
波纹({menu_id},"圆主题")
--导航栏透明()

BIAO.getPaint().setFakeBoldText(true)
menu_id.setColorFilter(0xFFFFFFFF)

设置全透明主题()
pcall(function()
  activity.setTheme(android.R.style.Theme_Material)
end)

--悬浮球

function CircleButton (InsideColor,radiu,...)
  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setColor(InsideColor)
  drawable.setCornerRadii({radiu,radiu,radiu,radiu,radiu,radiu,radiu,radiu});
  for k,v in ipairs({...}) do
    v.setBackgroundDrawable(drawable)
  end
end

CircleButton(0x00eeeeee,"18dp,",bt)

浏览器=function(wv,url)

  --初始化,加载网页
  wv.loadUrl(url)
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

  wv.setOnKeyListener(View.OnKeyListener{
    onKey=function (view,keyCode,event)
      if ((keyCode == event.KEYCODE_BACK) and view.canGoBack()) then
        view.goBack();
        return true;
      end
      return false
    end
  })
  --电脑ua
  APP_NAME_UA="netdisk;5.2.7;PC;PC-Windows;6.2.9200;WindowsBaiduYunGuanJia"
  --手机ua(有广告哦
  UA="netdisk;5.2.7;PC;PC-Windows;6.2.9200;WindowsBaiduYunGuanJia"
  wv.getSettings().setUserAgentString(APP_NAME_UA);

  --网页与返回键之间的交互
  function onKeyDown(keyCode,event)
    if (keyCode == KeyEvent.KEYCODE_BACK && wv.canGoBack())then
      wv.goBack()
      return true
    end
    return false
  end
end

网络判断(function()提示("没有网络",3,"18dp") activity.finish() end,function()
  浏览器(wb1,"https://m.v.qq.com")
  浏览器(wb2,"https://www.youku.com")
  浏览器(wb3,"https://m.iqiyi.com")
  浏览器(wb4,"https://m.tv.sohu.com")
  浏览器(wb5,"https://m.pptv.com")
  浏览器(wb6,"http://m.le.com")
end)

function 当前页面()
  if htb==0.0 then
    aurl=wb1.getUrl()--获取当前Url
   elseif htb==1.0 then
    aurl=wb2.getUrl()--获取当前Url
   elseif htb==2.0 then
    aurl=wb3.getUrl()--获取当前Url
   elseif htb==3.0 then
    aurl=wb4.getUrl()--获取当前Url
   elseif htb==4.0 then
    aurl=wb5.getUrl()--获取当前Url
   elseif htb==5.0 then
    aurl=wb6.getUrl()--获取当前Url
   elseif htb==6.0 then
    aurl=wb7.getUrl()--获取当前Url
  end
end

------------接口
接口文件路径=(luajava.luadir.."/res/data/jiex.txt")


local 源接口库=[[
https://z1.m1907.cn/?jx=
https://jx.rdhk.net/?v=
https://www.kpezp.cn/jlexi.php?url=
https://jx.ivito.cn/?url=
https://www.ckmov.vip/api.php?url=
https://okjx.cc/?url=
http://17kyun.com/api.php?url=
]]


local 接口库table={}
for k,v in 源接口库:gmatch("(.-)\n") do
  if k~=nil and k~="" then
    table.insert(接口库table,k)
  end
end

table.sort(接口库table)

if File(接口文件路径).exists()==false then
  写入文件(接口文件路径,接口库table[13])
  接口data=读取文件(接口文件路径)
 else
  接口data=读取文件(接口文件路径)
end


if not 读取缓存("解析屏幕旋转") then
  写入缓存("解析屏幕旋转",true)
  解析屏幕旋转=读取缓存("解析屏幕旋转")
 else
  解析屏幕旋转=读取缓存("解析屏幕旋转")
end

popmenu=PopupMenu(activity,menu_id)
menu=popmenu.Menu

menu.add("外部打开当前链接").onMenuItemClick=function(a)
  当前页面()
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(aurl)))
end

menu.add("复制当前页面链接").onMenuItemClick=function(a)
  当前页面()
  复制文本(aurl)
  提示("已复制:"..aurl,1,"18dp")
end

menu.add("复制页面解析链接").onMenuItemClick=function(a)
  当前页面()
  local dqwj=读取文件(接口文件路径)
  复制文本(dqwj..aurl)
  提示("已复制:"..dqwj..aurl,1,"18dp")
end

menu.add("外部解析当前链接").onMenuItemClick=function(a)
  当前页面()
  local dqwj=读取文件(接口文件路径)
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(dqwj..aurl)))
end

menu.add("外部打开解析接口").onMenuItemClick=function(a)
  local dqwj=读取文件(接口文件路径)
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(dqwj)))
end


menu.add("刷新当前页面").onMenuItemClick=function(a)
  if htb ==0.0 then
    aurl=wb1.getUrl()--获取当前Url
    wb1.stopLoading()--停止加载网页
    wb1.loadUrl(aurl)
   elseif htb==1.0 then
    aurl=wb2.getUrl()--获取当前Url
    wb2.stopLoading()--停止加载网页
    wb2.loadUrl(aurl)
   elseif htb==2.0 then
    aurl=wb3.getUrl()--获取当前Url
    wb3.stopLoading()--停止加载网页
    wb3.loadUrl(aurl)
   elseif htb==3.0 then
    aurl=wb4.getUrl()--获取当前Url
    wb4.stopLoading()--停止加载网页
    wb4.loadUrl(aurl)
   elseif htb==4.0 then
    aurl=wb5.getUrl()--获取当前Url
    wb5.stopLoading()--停止加载网页
    wb5.loadUrl(aurl)
   elseif htb==5.0 then
    aurl=wb6.getUrl()--获取当前Url
    wb6.stopLoading()--停止加载网页
    wb6.loadUrl(aurl)
  end
end

menu.add("更换解析接口").onMenuItemClick=function(a)

  local AppListItem={
    LinearLayout,
    layout_width="-1",
    layout_height="-2",
    {
      CardView;
      CardElevation="0";
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
              gravity="center|left",
              layout_marginBottom="2dp",
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
      ListView,
      layout_width="-1",
      layout_height="-1",
      id="id_appList",
      DividerHeight=0,
      VerticalScrollBarEnabled=false;
    },
  };


  AlertDialog.Builder(this)
  .setTitle("选择解析接口")
  .setView(loadlayout(layout))
  .setNegativeButton("取消",nil)
  .show()


  AppListAdp=LuaAdapter(activity,AppListItem)
  id_appList.setAdapter(AppListAdp)

  AppListAdp.add{
    title="当前接口:"..读取文件(接口文件路径)
  }

  for k,v in ipairs(接口库table) do
    AppListAdp.add{
      title=k..":"..v
    }
  end

  id_appList.onItemLongClick=function(p,v,i,s)
    local title=v.Tag.title.Text
    复制文本(title)
    提示("已经复制文本内容",1)
    return true
  end

  id_appList.onItemClick=function(p,v,i,s)
    local title=v.Tag.title.Text
    local title=title:match("%d+%p(.*)")
    写入文件(接口文件路径,title)
    提示("已更改为所选接口",1)
    return true
  end


end

menu.add("设置屏幕旋转").onMenuItemClick=function(a)
  if 读取缓存("解析屏幕旋转") then
    写入缓存("解析屏幕旋转",false)
    解析屏幕旋转=读取缓存("解析屏幕旋转")
    提示("固定横屏",1)
   else
    写入缓存("解析屏幕旋转",true)
    解析屏幕旋转=读取缓存("解析屏幕旋转")
    提示("自动旋转",1)
  end
end

menu.add("退出解析功能").onMenuItemClick=function(a)
  activity.finish()--关闭当前页面
end


menu_id.onClick=function()
  popmenu.show()--显示
end


--绑定页面事件
--绑定tab与pageview
tabs={tab_1,tab_2,tab_3,tab_4,tab_5,tab_6}
for k,v in pairs(tabs) do

  v.onClick=function()
    page.showPage(k-1)

  end

end
local width=activity.getWidth()/6
page.setOnPageChangeListener(PageView.OnPageChangeListener{

  onPageScrolled=function(a,b,c)
    htb=(b+a)
  end,

  --监听滑动页面，目的是为了改变tab
  onPageSelected=function(a)
    for k,v in pairs(tabs) do
      v.setTextColor(Color.parseColor("#ff000000"))
      v.textSize=px2sp(dp2px(14))

    end
    tabs[a+1].setTextColor(Color.parseColor("#ffffff"))
    tabs[a+1].textSize=px2sp(dp2px(16))
  end

})


--避免输入法界面弹出后遮挡输入光标的问题
activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE | WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN);

--网页中的视频，上屏幕的时候，可能出现闪烁的情况，需要如下设置
activity.getWindow().setFormat(PixelFormat.TRANSLUCENT);

bt.onClick=function()
  网络判断(function()提示("没有网络",3,"18dp")end,function()
    if htb ==0.0 then
      aurl=wb1.getUrl()--获取当前Url
     elseif htb==1.0 then
      aurl=wb2.getUrl()--获取当前Url
     elseif htb==2.0 then
      aurl=wb3.getUrl()--获取当前Url
     elseif htb==3.0 then
      aurl=wb4.getUrl()--获取当前Url
     elseif htb==4.0 then
      aurl=wb5.getUrl()--获取当前Url
     elseif htb==5.0 then
      aurl=wb6.getUrl()--获取当前Url
    end
    local dqwj=读取文件(接口文件路径)
    activity.newActivity("parsing",android.R.anim.fade_in,android.R.anim.fade_out,{dqwj..aurl,"视频解析",解析屏幕旋转} )
  end)
end

界面退出()

