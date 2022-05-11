require "import"
import "mod"
layout= {
  LinearLayout;
  layout_height="-1";
  fitsSystemWindows="true";
  layout_width="-1";
  {
    LuaWebView;
    layout_width="-1";
    id="wv";
    layout_height="-1";
  };
};
activity.setTitle("GGScript")
pcall(activity.getWindow().setStatusBarColor(int(0xff000000)))
--activity.setTitle('html代码运行')
设置视图(layout)

local datacss=luajava.luadir.."/ggdoc.html"
pcall(function()
  if 读取缓存("主题")=="白天" then
    local css= 读取文件(datacss)
    local css=string.gsub(css,"#303030","#FFFFFF",1)
    写入文件(datacss,css)
   else
    local css= 读取文件(datacss)
    local css=string.gsub(css,"#FFFFFF","#303030",1)
    写入文件(datacss,css)
  end
end)

--初始化,加载网页
wv.loadUrl("file:///"..luajava.luadir.."/ggdoc.html")
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

--优先缓存
settings.setCacheMode(WebSettings.LOAD_CACHE_ONLY);
--settings.setCacheMode(WebSettings.LOAD_NO_CACHE);--没有负载缓存
--[[缓存模式(5种)

LOAD_CACHE_ONLY:  不使用网络，只读取本地缓存数据
LOAD_DEFAULT:  根据cache-control决定是否从网络上取数据。
LOAD_CACHE_NORMAL: API level 17中已经废弃, 从API level 11开始作用同LOAD_DEFAULT模式
LOAD_NO_CACHE: 不使用缓存，只从网络获取数据.
LOAD_CACHE_ELSE_NETWORK，只要本地有，无论是否过期，或者no-cache，都使用缓存中的数据。
]]

--清除缓存
--clearCache(boolean)
--CacheManager.clear高版本中需要调用隐藏API。

-- 支持内容重新布局
settings.setLayoutAlgorithm(WebSettings.LayoutAlgorithm.SINGLE_COLUMN);
settings.supportMultipleWindows();
settings.setSupportMultipleWindows(true);
-- 设置可访问文件
settings.setAllowFileAccess(true);
settings.setNeedInitialFocus(true);
--设定编码格式
settings.setDefaultTextEncodingName("UTF-8");

--设置出现缩放工具
settings.setSupportZoom(true);
--设置出现缩放工具
settings.setBuiltInZoomControls(true);
--扩大比例的缩放
settings.setUseWideViewPort(true);

--隐藏滚动条
wv.setHorizontalScrollBarEnabled(false);
wv.setVerticalScrollBarEnabled(false);

wv.Settings.setLayoutAlgorithm(WebSettings.LayoutAlgorithm.SINGLE_COLUMN);
wv.Settings.setLoadWithOverviewMode(true);

appCaceDir = activity.getApplicationContext().getDir("cache", Context.MODE_PRIVATE).getPath();
wv.Settings.setAppCachePath(appCaceDir);

--设置UA
--APP_NAME_UA="netdisk;5.2.7;PC;PC-Windows;6.2.9200;WindowsBaiduYunGuanJia"
--wv.getSettings().setUserAgentString(APP_NAME_UA);


wv.setOnKeyListener(View.OnKeyListener{
  onKey=function (view,keyCode,event)
    if ((keyCode == event.KEYCODE_BACK) and view.canGoBack()) then
      view.goBack();
      return true;
    end
    return false
  end
})

--网页与返回键之间的交互
function onKeyDown(keyCode,event)
  if (keyCode == KeyEvent.KEYCODE_BACK && wv.canGoBack())then
    wv.goBack()
    return true
  end
  return false
end

界面退出()
