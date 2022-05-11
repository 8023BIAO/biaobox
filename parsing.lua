require "import"
import "My bag"

stf={...}

if stf[3] then
  --横屏
  local yx1=function()
    屏幕方向("自动旋转")
  end
  local yx2=function()
    --横屏模式
    activity.setRequestedOrientation(0);
  end
  xpcall(yx1,yx2)
 else
  activity.setRequestedOrientation(0);
end

防止屏幕休眠()

activity.setTitle(stf[2])
--避免输入法界面弹出后遮挡输入光标的问题
activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE | WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN);
activity.getWindow().setFlags(WindowManager.LayoutParams.FLAG_HARDWARE_ACCELERATED,WindowManager.LayoutParams.FLAG_HARDWARE_ACCELERATED);
--网页中的视频，上屏幕的时候，可能出现闪烁的情况，需要如下设置
activity.getWindow().setFormat(PixelFormat.TRANSLUCENT);

全屏()

wv=LuaWebView(activity)
wv.setBackgroundColor(0xff000000);
activity.setContentView(wv)

--自定义颜色主题(stf[3])
--初始化,加载网页
wv.loadUrl(stf[1])

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


wv.setOnKeyListener(View.OnKeyListener{
  onKey=function (view,keyCode,event)
    if ((keyCode == event.KEYCODE_BACK) and view.canGoBack()) then
      view.goBack();
      return true;
    end
    return false
  end
})


--无广告UA
APP_NAME_UA="netdisk;5.2.7;PC;PC-Windows;6.2.9200;WindowsBaiduYunGuanJia"

--手机ua(有广告哦
UA3="Mozilla/5.0 (Linux; Android 10; oppo1000 Build/HUAWEICOL-AL10; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/74.0.3729.186 Mobile Safari/537.36"

acua="	Mozilla/5.0 (Linux; Android 4.2.1; M040 Build/JOP40D) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.59 Mobile Safari/537.36"

wv.getSettings().setUserAgentString(APP_NAME_UA);


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
--删除加载
--wv.removeView(wv.getChildAt(0))

--网页与返回键之间的交互

function onKeyDown(keyCode,event)

  if (keyCode == KeyEvent.KEYCODE_BACK && wv.canGoBack())then

    wv.goBack()

    return true

  end

  return false

end

设置全透明主题()

--界面退出()

--别问为什么怎么写，问就是个人菜笨懒……