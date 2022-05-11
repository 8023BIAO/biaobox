require "import"
import "android.*"
import "android.app.*"
import "android.os.*"
import "android.os.Bundle"
import "android.widget.*"

import "android.app.Activity"
import "android.app.AlertDialog"
import "android.app.Dialog"


import "android.animation.*"
import "android.animation.ObjectAnimator"
import "android.animation.ArgbEvaluator"
import "android.animation.Animator"
import "android.animation.ValueAnimator"


import "android.net.*"
import "android.net.Uri"
import "android.net.ConnectivityManager"


import "android.text.*"
import "android.text.style.*"
import "android.text.method.*"
import "android.text.Spannable"
import "android.text.SpannableString"
import "android.text.format.Formatter"
import "android.text.style.ClickableSpan"
import "android.text.method.LinkMovementMethod"
import "android.text.style.ForegroundColorSpan"



import "android.content.*"
import "android.content.res.*"
import "android.content.Context"
import "android.content.ContentResolver"
import "android.content.pm.PackageManager"
import "android.content.pm.ApplicationInfo"


import "android.graphics.*"
import "android.graphics.Rect"
import "android.graphics.RectF"
import "android.graphics.Color"
import "android.graphics.Paint"
import "android.graphics.Canvas"
import "android.graphics.Matrix"
import "android.graphics.Bitmap"
import "android.graphics.Typeface"
import "android.graphics.drawable.*"
import "android.graphics.PorterDuff"
import "android.graphics.PixelFormat"
import "android.graphics.BitmapFactory"
import "android.graphics.PorterDuff$Mode"
import "android.graphics.drawable.Drawable"
import "android.graphics.PorterDuffXfermode"
import "android.graphics.PorterDuffColorFilter"
import "android.graphics.drawable.ColorDrawable"
import "android.graphics.drawable.BitmapDrawable"

import "android.renderscript.*"
import "android.renderscript.Element"
import "android.renderscript.Allocation"
import "android.renderscript.RenderScript"
import "android.renderscript.ScriptIntrinsicBlur"


import "android.content.Intent"
import "android.content.pm.PackageManager"
import "android.content.pm.ActivityInfo"
import "android.content.res.ColorStateList"
import "android.content.ComponentName"

import "androidx.*"
import "androidx.core.app.*"
import "androidx.appcompat.*"


import "android.view.*"
import "android.view.View"
import "android.view.Gravity"
import "android.view.KeyEvent"
import "android.view.MotionEvent"
import "android.view.animation.*"
import "android.view.WindowManager"
import "android.view.animation.ScaleAnimation"
import "android.view.inputmethod.InputMethodManager"
import "android.view.accessibility.AccessibilityEvent"
import "android.view.accessibility.AccessibilityNodeInfo"
import "android.view.animation.Animation$AnimationListener"
import "android.view.animation.AccelerateDecelerateInterpolator"



import "android.widget.Toast"
import "android.widget.Button"
import "android.widget.TextView"
import "android.widget.CardView"
import "android.widget.TextView"
import "android.widget.EditText"
import "android.widget.ScrollView"
import "android.widget.FrameLayout"
import "android.widget.LinearLayout"
import "android.webkit.WebViewClient"
import "android.widget.CircleImageView"
import "android.webkit.WebChromeClient"
import "android.webkit.WebSettings"
import "android.webkit.MimeTypeMap"


--其他杂类
import "android.opengl.Visibility"

import "org.w3c.dom.Text"

import "android.Manifest"

import "android.provider.Settings"
import "android.provider.MediaStore"
import "android.provider.Settings$Secure"

import "android.transition.Visibility"

import "android.util.Base64"
import "android.util.Config"
import "android.util.DisplayMetrics"
--传感器
pcall(function()
  import "android.hardware.*"
  import "android.hardware.Sensor"
  import "android.hardware.SensorEventListener"
  import "android.hardware.SensorManager"
end)
import "base64"
--java包

import "java.io.*"
import "java.io.File"
import "java.io.InputStream"
import "java.io.FileOutputStream"
import "java.util.*"

import "java.lang.Math"
import "java.lang.Integer"
import "java.security.*"

import "java.net.URL"
import "java.net.URLEncoder"
import "java.net.InetAddress"

--IDE
import "http"
import "com.androlua.*"
import "com.androlua.Http"
import "com.androlua.LuaAdapter"
import "com.androlua.LuaDrawable"

--自定义导包
import "bmob"
import "cjson"
import "console"
import "bin"
--import "destring"




--------------------------------------------------
软件包名=activity.getPackageName()
--状态栏
状态栏高度=activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen")().status_bar_height)
--状态栏,导航栏高度
statusBarHeight=activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen").status_bar_height)

导航栏高度=activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen").navigation_bar_height)
--型号
型号 = Build.MODEL
--SDK版本
SDK版本 = tonumber(Build.VERSION.SDK)
--安卓版本
安卓版本 = Build.VERSION.RELEASE
--ROM类型
ROM类型 = string.upper(Build.MANUFACTURER)
--屏幕宽
获取屏幕宽=activity.getWidth()
--获取屏幕高
获取屏幕高=activity.getHeight()

ripple = activity.obtainStyledAttributes({android.R.attr.selectableItemBackgroundBorderless}).getResourceId(0,0)
ripples = activity.obtainStyledAttributes({android.R.attr.selectableItemBackground}).getResourceId(0,0)

function 检测键盘()
  imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
  isOpen=imm.isActive()
  return isOpen==true or false
end

function 隐藏键盘()
  activity.getSystemService(INPUT_METHOD_SERVICE).hideSoftInputFromWindow(WidgetSearchActivity.this.getCurrentFocus().getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS)
end

function 显示键盘(id)
  activity.getSystemService(INPUT_METHOD_SERVICE).showSoftInput(id, 0)
end

function toast(str)
  str=tostring(str)
  --默认Toast
  Toast.makeText(activity,str,Toast.LENGTH_SHORT).show()
end

function 设置视图(layout)
  return activity.setContentView(loadlayout(layout))
end

--获取IMEI
function 获取IMEI()
  return activity.getSystemService(Context.TELEPHONY_SERVICE).getDeviceId()
end
function 手机内置路径()
  return (Environment.getExternalStorageDirectory().toString())
end

function 防止屏幕休眠()
  --这段代码要加在setContentView()之前，这种方法，在安装时不会弹出提示框
  --防止屏幕休眠
  return activity.getWindow().setFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON, WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
end


function 读取文件(路径)
  local 文件内容=io.open(路径):read("*a")
  return 文件内容--return用来返回值
end
--注意是重新写入
function 写入文件(路径,内容)
  f=File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
  io.open(tostring(路径),"w+b"):write(tostring(内容)):close()
end

function 写入文件2(文件路径,内容)
  --  f=File(tostring(File(tostring(路径)).getParentFile())).mkdirs()
  io.open(文件路径,"w"):write(内容):close()
end

function 写入缓存(name,str)
  return this.setSharedData(name,str)
end

function 读取缓存(name)
  return this.getSharedData(name)
end

function 申请悬浮窗界面()
  -- 检查是否已经授予权限，大于6.0的系统适用，小于6.0系统默认打开，无需理会
  if Build.VERSION.SDK_INT >= 23 and Settings.canDrawOverlays(this)~=true then
    -- 没有权限，需要申请权限，因为是打开一个授权页面，所以拿不到返回状态的，所以建议是在onResume方法中从新执行一次校验
    --  intent=Intent()
    intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
    intent.setData(Uri.parse("package:" .. 软件包名));
    activity.startActivity(Intent(intent))
  end
end

function 检测储存权限(name)
  --检测储存,0授权，-1没有
  permission = ActivityCompat.checkSelfPermission(activity, Manifest.permission.WRITE_EXTERNAL_STORAGE);
  --没有就打开储存界面
  if permission~=0 then
    intent=Intent()
    intent.setAction(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
    intent.setData(Uri.parse("package:" .. name));
    activity.startActivity(Intent(intent))
  end

end

--获取手机号码
function 获取手机号码()
  mTelephonyManager = activity.getSystemService(Context.TELEPHONY_SERVICE);
  phoneNumber = mTelephonyManager.getLine1Number();
  return phoneNumber
end

function 屏幕精确尺寸()
  dm = DisplayMetrics();
  activity.getWindowManager().getDefaultDisplay().getMetrics(dm);
  diagonalPixels = Math.sqrt(Math.pow(dm.widthPixels, 2) + Math.pow(dm.heightPixels, 2));
  return diagonalPixels / (160 * dm.density);
end

function 页面主题自动设置()

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

  return activity.setTheme(autotheme())

end


获取设备标识码=function()
  return Secure.getString(activity.getContentResolver(), Secure.ANDROID_ID)
end

获取手机内置储存=function()

  data = Environment.getDataDirectory();
  sf = StatFs(data.getPath());

  availableBlocks = sf.getAvailableBlocks();
  可用存储块数量=availableBlocks

  blockCount = sf.getBlockCount();
  总存储块数量=blockCount

  --单位字节
  size = sf.getBlockSize();
  存储块大小=size

  --单位字节
  totalSize = blockCount * size;
  总空间=totalSize

  --单位字节
  availableSize = availableBlocks * size;
  可用空间=availableSize

  --转整数
  手机总空间GB=tointeger(总空间/1024/1024/1024)--GB
  手机可用空间GB=tointeger(可用空间/1024/1024)--MB

  --[[　
　1. 通过Environment获取需要检测容量的文件对象。

　　2. 构建StatFs对象。

　　3. 获取存储块数量。

　　4. 获取存储块大小。

　　5. 计算得出容量大小。]]
end

号码归属地=function(str,bbb)
  if #str==11 then
    --搜狗号码归属地
    url="https://wap.sogou.com/web/sl?keyword="..str
    Http.get(url,function(a,b)
      if a==200 then
        local 运行=function()
          h=b:match("<div.class=\"ellipsis.rowheight\".>(.-)</em></div>")
          h=string.gsub(h,"<em>","\n")
          bbb(h)
        end
        local 错误=function()
          提示("发生错误_(•̀ω•́ 」∠)_",3,"18dp")
        end
        xpcall(运行,错误)
      end
    end)
   else
    提示("号码错误",3)
  end
end

现在时间=os.date("%Y-%m-%d %H:%M:%S")

function 跳转应用设置界面(包名)
  if 包名 ==false then
    包名="com.biao.layout"
  end
  intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
  intent.setData(Uri.parse("package:"..包名))--// 根据包名打开对应的设置界面
  activity.startActivity(intent)
end


function 复制文本(a)
  activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(tostring(a))
end

--转dp
function dp2px(dpValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return dpValue * scale
end

function px2dp(pxValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return pxValue / scale
end

function px2sp(pxValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity;
  return pxValue / scale
end

function sp2px(spValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return spValue * scale
end


function 获取应用信息(archiveFilePath)
  pm = activity.getPackageManager()
  info = pm.getPackageInfo(archiveFilePath, PackageManager.GET_ACTIVITIES);
  if info ~= nil then
    appInfo = info.applicationInfo;
    appName = tostring(pm.getApplicationLabel(appInfo))
    packageName = appInfo.packageName; --安装包名称
    version=info.versionName; --版本信息
    icon = pm.getApplicationIcon(appInfo);--图标
  end
  return packageName,version,icon
end

--字体
function 设置字体(t)
  return Typeface.createFromFile(File(activity.getLuaDir().."/res/ttf/"..t..".ttf"))
end

--随机
function 随机数(最小值,最大值)
  return math.random(最小值,最大值)
end

--浏览器
function 浏览器打开(pageurl)
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(pageurl))
  activity.startActivity(viewIntent)
end

--申请权限
function 申请权限(权限)
  -- ActivityCompat.requestPermissions(this,权限,1)
  ActivityCompat.requestPermissions(this,String({Manifest.permission.权限}),1)
end
--申请权限({Manifest.permission.WRITE_EXTERNAL_STORAGE})--不可用

function 微信扫一扫()
  intent = Intent();
  intent.setComponent( ComponentName("com.tencent.mm", "com.tencent.mm.ui.LauncherUI"));
  intent.putExtra("LauncherUI.From.Scaner.Shortcut", true);
  intent.setFlags(335544320);
  intent.setAction("android.intent.action.VIEW");
  activity.startActivity(intent);
end

function 支付宝扫一扫()
  uri = Uri.parse("alipayqr://platformapi/startapp?saId=10000007");
  intent = Intent(Intent.ACTION_VIEW, uri);
  activity.startActivity(intent);
end

function QQ群(h)
  url="mqqapi://card/show_pslcard?src_type=internal&version=1&uin="..h.."&card_type=group&source=qrcode"
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
end

function QQ(h)
  url="mqqapi://card/show_pslcard?src_type=internal&source=sharecard&version=1&uin="..h
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
end

function 渐变跳转页面(ym,cs)
  if cs then
    activity.newActivity(ym,android.R.anim.fade_in,android.R.anim.fade_out,cs)
   else
    activity.newActivity(ym,android.R.anim.fade_in,android.R.anim.fade_out)
  end
end


function 跳转页面(ym,cs)
  if cs then
    activity.newActivity(ym,cs)
   else
    activity.newActivity(ym)
  end
end

--下载
function 文件下载(lj,luj,m)
  --调用系统下载
  downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
  url=Uri.parse(lj);
  request=DownloadManager.Request(url);
  request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
  request.setDestinationInExternalPublicDir(luj,m);
  request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
  downloadManager.enqueue(request);
end

function 网络判断(a,b)
  local wl=activity.getApplicationContext().getSystemService(Context.CONNECTIVITY_SERVICE).getActiveNetworkInfo();
  if wl==nil then
    a()
   else
    local e=pcall(function()b()end)
    if not e then
      提示("发生错误(づ◡ど)",3)
    end
  end
end

function 提示(t,c,bs)
  t=tostring(t)

  if c==nil then
    c="#A3212121"
   elseif c==3 then
    c="#A3E57373"--红
   elseif c==1 then
    c="#A390CAF9"--蓝
   elseif c==2 then
    c="#A3FBC02D"--黄
  end

  if bs==nil then
    bs="18dp"
  end

  local tsbj={
    LinearLayout;
    layout_width="-2";
    layout_height="-2";
    gravity="center";
    background="0";
    {
      CardView;
      layout_width="-2";
      layout_height="-2";
      Elevation="0";
      layout_margin="6dp";
      radius=bs;
      background=c;
      {
        LinearLayout;
        -- layout_width=activity.getWidth()-100;
        layout_width=="-2";
        layout_height="-2";
        {
          TextView;
          layout_width="-1";
          layout_height="-1";
          textSize="14sp";
          paddingRight="16dp";
          paddingLeft="16dp";
          paddingTop="12dp";
          paddingBottom="12dp";
          gravity="center";
          Text=t;
          textColor="#ffffffff";
        };
      };
    };
  };
  Toast.makeText(activity,t,Toast.LENGTH_LONG).setGravity(Gravity.BOTTOM|Gravity.CENTER, 0, 0).setView(loadlayout(tsbj)).show()
end



--MD5加密
function MD5(str)

  local HexTable = {"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"}
  local A = 0x67452301
  local B = 0xefcdab89
  local C = 0x98badcfe
  local D = 0x10325476

  local S11 = 7
  local S12 = 12
  local S13 = 17
  local S14 = 22
  local S21 = 5
  local S22 = 9
  local S23 = 14
  local S24 = 20
  local S31 = 4
  local S32 = 11
  local S33 = 16
  local S34 = 23
  local S41 = 6
  local S42 = 10
  local S43 = 15
  local S44 = 21

  local function F(x,y,z)
    return (x & y) | ((~x) & z)
  end
  local function G(x,y,z)
    return (x & z) | (y & (~z))
  end
  local function H(x,y,z)
    return x ~ y ~ z
  end
  local function I(x,y,z)
    return y ~ (x | (~z))
  end
  local function FF(a,b,c,d,x,s,ac)
    a = a + F(b,c,d) + x + ac
    a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
    return a & 0xffffffff
  end
  local function GG(a,b,c,d,x,s,ac)
    a = a + G(b,c,d) + x + ac
    a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
    return a & 0xffffffff
  end
  local function HH(a,b,c,d,x,s,ac)
    a = a + H(b,c,d) + x + ac
    a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
    return a & 0xffffffff
  end
  local function II(a,b,c,d,x,s,ac)
    a = a + I(b,c,d) + x + ac
    a = (((a & 0xffffffff) << s) | ((a & 0xffffffff) >> 32 - s)) + b
    return a & 0xffffffff
  end



  local function MD5StringFill(s)
    local len = s:len()
    local mod512 = len * 8 % 512
    --需要填充的字节数
    local fillSize = (448 - mod512) // 8
    if mod512 > 448 then
      fillSize = (960 - mod512) // 8
    end

    local rTab = {}

    --记录当前byte在4个字节的偏移
    local byteIndex = 1
    for i = 1,len do
      local index = (i - 1) // 4 + 1
      rTab[index] = rTab[index] or 0
      rTab[index] = rTab[index] | (s:byte(i) << (byteIndex - 1) * 8)
      byteIndex = byteIndex + 1
      if byteIndex == 5 then
        byteIndex = 1
      end
    end
    --先将最后一个字节组成4字节一组
    --表示0x80是否已插入
    local b0x80 = false
    local tLen = #rTab
    if byteIndex ~= 1 then
      rTab[tLen] = rTab[tLen] | 0x80 << (byteIndex - 1) * 8
      b0x80 = true
    end

    --将余下的字节补齐
    for i = 1,fillSize // 4 do
      if not b0x80 and i == 1 then
        rTab[tLen + i] = 0x80
       else
        rTab[tLen + i] = 0x0
      end
    end

    --后面加原始数据bit长度
    local bitLen = math.floor(len * 8)
    tLen = #rTab
    rTab[tLen + 1] = bitLen & 0xffffffff
    rTab[tLen + 2] = bitLen >> 32

    return rTab
  end

  --	Func:	计算MD5
  --	Param:	string
  --	Return:	string
  ---------------------------------------------

  function string.md5(s)
    --填充
    local fillTab = MD5StringFill(s)
    local result = {A,B,C,D}

    for i = 1,#fillTab // 16 do
      local a = result[1]
      local b = result[2]
      local c = result[3]
      local d = result[4]
      local offset = (i - 1) * 16 + 1
      --第一轮
      a = FF(a, b, c, d, fillTab[offset + 0], S11, 0xd76aa478)
      d = FF(d, a, b, c, fillTab[offset + 1], S12, 0xe8c7b756)
      c = FF(c, d, a, b, fillTab[offset + 2], S13, 0x242070db)
      b = FF(b, c, d, a, fillTab[offset + 3], S14, 0xc1bdceee)
      a = FF(a, b, c, d, fillTab[offset + 4], S11, 0xf57c0faf)
      d = FF(d, a, b, c, fillTab[offset + 5], S12, 0x4787c62a)
      c = FF(c, d, a, b, fillTab[offset + 6], S13, 0xa8304613)
      b = FF(b, c, d, a, fillTab[offset + 7], S14, 0xfd469501)
      a = FF(a, b, c, d, fillTab[offset + 8], S11, 0x698098d8)
      d = FF(d, a, b, c, fillTab[offset + 9], S12, 0x8b44f7af)
      c = FF(c, d, a, b, fillTab[offset + 10], S13, 0xffff5bb1)
      b = FF(b, c, d, a, fillTab[offset + 11], S14, 0x895cd7be)
      a = FF(a, b, c, d, fillTab[offset + 12], S11, 0x6b901122)
      d = FF(d, a, b, c, fillTab[offset + 13], S12, 0xfd987193)
      c = FF(c, d, a, b, fillTab[offset + 14], S13, 0xa679438e)
      b = FF(b, c, d, a, fillTab[offset + 15], S14, 0x49b40821)

      --第二轮
      a = GG(a, b, c, d, fillTab[offset + 1], S21, 0xf61e2562)
      d = GG(d, a, b, c, fillTab[offset + 6], S22, 0xc040b340)
      c = GG(c, d, a, b, fillTab[offset + 11], S23, 0x265e5a51)
      b = GG(b, c, d, a, fillTab[offset + 0], S24, 0xe9b6c7aa)
      a = GG(a, b, c, d, fillTab[offset + 5], S21, 0xd62f105d)
      d = GG(d, a, b, c, fillTab[offset + 10], S22, 0x2441453)
      c = GG(c, d, a, b, fillTab[offset + 15], S23, 0xd8a1e681)
      b = GG(b, c, d, a, fillTab[offset + 4], S24, 0xe7d3fbc8)
      a = GG(a, b, c, d, fillTab[offset + 9], S21, 0x21e1cde6)
      d = GG(d, a, b, c, fillTab[offset + 14], S22, 0xc33707d6)
      c = GG(c, d, a, b, fillTab[offset + 3], S23, 0xf4d50d87)
      b = GG(b, c, d, a, fillTab[offset + 8], S24, 0x455a14ed)
      a = GG(a, b, c, d, fillTab[offset + 13], S21, 0xa9e3e905)
      d = GG(d, a, b, c, fillTab[offset + 2], S22, 0xfcefa3f8)
      c = GG(c, d, a, b, fillTab[offset + 7], S23, 0x676f02d9)
      b = GG(b, c, d, a, fillTab[offset + 12], S24, 0x8d2a4c8a)

      --第三轮
      a = HH(a, b, c, d, fillTab[offset + 5], S31, 0xfffa3942)
      d = HH(d, a, b, c, fillTab[offset + 8], S32, 0x8771f681)
      c = HH(c, d, a, b, fillTab[offset + 11], S33, 0x6d9d6122)
      b = HH(b, c, d, a, fillTab[offset + 14], S34, 0xfde5380c)
      a = HH(a, b, c, d, fillTab[offset + 1], S31, 0xa4beea44)
      d = HH(d, a, b, c, fillTab[offset + 4], S32, 0x4bdecfa9)
      c = HH(c, d, a, b, fillTab[offset + 7], S33, 0xf6bb4b60)
      b = HH(b, c, d, a, fillTab[offset + 10], S34, 0xbebfbc70)
      a = HH(a, b, c, d, fillTab[offset + 13], S31, 0x289b7ec6)
      d = HH(d, a, b, c, fillTab[offset + 0], S32, 0xeaa127fa)
      c = HH(c, d, a, b, fillTab[offset + 3], S33, 0xd4ef3085)
      b = HH(b, c, d, a, fillTab[offset + 6], S34, 0x4881d05)
      a = HH(a, b, c, d, fillTab[offset + 9], S31, 0xd9d4d039)
      d = HH(d, a, b, c, fillTab[offset + 12], S32, 0xe6db99e5)
      c = HH(c, d, a, b, fillTab[offset + 15], S33, 0x1fa27cf8)
      b = HH(b, c, d, a, fillTab[offset + 2], S34, 0xc4ac5665)

      --第四轮
      a = II(a, b, c, d, fillTab[offset + 0], S41, 0xf4292244)
      d = II(d, a, b, c, fillTab[offset + 7], S42, 0x432aff97)
      c = II(c, d, a, b, fillTab[offset + 14], S43, 0xab9423a7)
      b = II(b, c, d, a, fillTab[offset + 5], S44, 0xfc93a039)
      a = II(a, b, c, d, fillTab[offset + 12], S41, 0x655b59c3)
      d = II(d, a, b, c, fillTab[offset + 3], S42, 0x8f0ccc92)
      c = II(c, d, a, b, fillTab[offset + 10], S43, 0xffeff47d)
      b = II(b, c, d, a, fillTab[offset + 1], S44, 0x85845dd1)
      a = II(a, b, c, d, fillTab[offset + 8], S41, 0x6fa87e4f)
      d = II(d, a, b, c, fillTab[offset + 15], S42, 0xfe2ce6e0)
      c = II(c, d, a, b, fillTab[offset + 6], S43, 0xa3014314)
      b = II(b, c, d, a, fillTab[offset + 13], S44, 0x4e0811a1)
      a = II(a, b, c, d, fillTab[offset + 4], S41, 0xf7537e82)
      d = II(d, a, b, c, fillTab[offset + 11], S42, 0xbd3af235)
      c = II(c, d, a, b, fillTab[offset + 2], S43, 0x2ad7d2bb)
      b = II(b, c, d, a, fillTab[offset + 9], S44, 0xeb86d391)

      --加入到之前计算的结果当中
      result[1] = result[1] + a
      result[2] = result[2] + b
      result[3] = result[3] + c
      result[4] = result[4] + d
      result[1] = result[1] & 0xffffffff
      result[2] = result[2] & 0xffffffff
      result[3] = result[3] & 0xffffffff
      result[4] = result[4] & 0xffffffff
    end

    --将Hash值转换成十六进制的字符串
    local retStr = ""
    for i = 1,4 do
      for _ = 1,4 do
        local temp = result[i] & 0x0F
        local str = HexTable[temp + 1]
        result[i] = result[i] >> 4
        temp = result[i] & 0x0F
        retStr = retStr .. HexTable[temp + 1] .. str
        result[i] = result[i] >> 4
      end
    end

    return retStr
  end

  return string.md5(str)

end




------------------------------------------------------------------------------------------------------------------

function 渐变(id,ti,...)
  view=id

  if ti==nil then
    ti=614614--每一个2分钟
  end

  if {...}==nil then
    colorAnim = ObjectAnimator.ofInt(view,"backgroundColor",{...})
   else
    Color1=0xFFF44236--姨妈红色
    Color2=0xFFEC407A--清新粉色
    Color3=0xFFFFC107--咸蛋黄色
    Color4=0xFF2196F3--胖次蓝色
    Color5=0xFF8BC24A--咸蛋黄色
    Color6=0xFF9C28B1--真基佬紫
    Color7=0xffFFFF82--橙色
    Color8=0xff000001--橙色
    colorAnim = ObjectAnimator.ofInt(view,"backgroundColor",{Color1,Color2,Color3,Color4,Color5,Color6,Color7,Color8})
  end
  colorAnim.setDuration(ti)
  colorAnim.setEvaluator(ArgbEvaluator())
  colorAnim.setRepeatCount(ValueAnimator.INFINITE)
  colorAnim.setRepeatMode(ValueAnimator.REVERSE)
  colorAnim.start()
end


function 屏幕方向(x)
  if x=="自动旋转"then
    activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_SENSOR)
   elseif x=="取消旋转"then
    activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_USER);
   elseif x=="自动横屏"then
    activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_SENSOR)
   elseif x=="强制竖屏"then
    activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_USER);
   elseif x=="横屏"then
    activity.setRequestedOrientation(0);
   elseif x=="竖屏"
    activity.setRequestedOrientation(1);
   else
    提示("错误",3)
  end
end

打开辅助=function()
  activity.startActivity(Intent().setAction(Settings.ACTION_ACCESSIBILITY_SETTINGS))
end


--将Biemap图片转换成base64
function bitmapToBase64(bitmap,zx,YESUO)
  if bitmap then
    if not YESUO then
      YESUO=100
    end
    baos = ByteArrayOutputStream();
    bitmap.compress(Bitmap.CompressFormat.JPEG, YESUO, baos);

    baos.flush();
    baos.close();
    bitmapBytes = baos.toByteArray();
    encode = Base64.encode(bitmapBytes,Base64.DEFAULT);
    -- result =(Base64.encodeToString(bitmapBytes, Base64.DEFAULT));
    encodeString=String(encode)
    zx(encodeString)
    encodeString=nil
  end

end

--base64转为bitmap
function Base64ToBitmap(base64Data)
  bytes = Base64.decode(base64Data, Base64.DEFAULT);
  bit=BitmapFactory.decodeByteArray(bytes, 0, #bytes);
  return bit
end


------------------------------------------------------------------------------------------------------------------

界面退出=function()
  local shijian=0
  function onKeyDown(code,event)
    if string.find(tostring(event),"KEYCODE_BACK") ~= nil then
      if shijian+2 > tonumber(os.time()) then
        activity.finish()--关闭当前页面
        activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
      end
      --提示("再按一次返回键退出",nil,"18dp")
      shijian=tonumber(os.time())
      return true
    end
  end
end

--获取文件列表
function ChoiceFile(StartPath,callback)
  buj={
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
        TextView,
        id="cp",
        layout_marginLeft="24dp";
      },
      {
        ListView,
        id="lv",
        layout_width="fill";
        DividerHeight=0,
      }
    }
  }
  单对话框(buj,"获取文件MD5")
  adp=ArrayAdapter(activity,android.R.layout.simple_list_item_1)
  lv.setAdapter(adp)

  function SetItem(path)
    path=tostring(path)
    adp.clear()--清空适配器
    cp.Text=tostring(path)--设置当前路径
    if path~="/" then--不是根目录则加上../
      adp.add("../")
    end
    ls=File(path).listFiles()
    if ls~=nil then
      ls=luajava.astable(File(path).listFiles()) --全局文件列表变量
      table.sort(ls,function(a,b)
        return (a.isDirectory()~=b.isDirectory() and a.isDirectory()) or ((a.isDirectory()==b.isDirectory()) and a.Name<b.Name)
      end)
     else
      ls={}
    end
    for index,c in pairs(ls) do
      if c.isDirectory() then--如果是文件夹则
        adp.add(c.Name.."/")
       else--如果是文件则
        adp.add(c.Name)
      end
    end
  end

  lv.onItemClick=function(l,v,p,s)--列表点击事件
    项目=tostring(v.Text)
    if tostring(cp.Text)=="/" then
      路径=ls[p+1]
     else
      路径=ls[p]
    end

    if 项目=="../" then
      SetItem(File(cp.Text).getParentFile())
     elseif 路径.isDirectory() then
      SetItem(路径)
     elseif 路径.isFile() then
      callback(tostring(路径))
      --  ChoiceFile_dialog.hide()
    end

  end
  SetItem(StartPath)
end


--获取文件列表
function ChoiceFile2(StartPath,callback)
  buj={
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
        TextView,
        id="cp",
        layout_marginLeft="24dp";
      },
      {
        ListView,
        id="lv",
        layout_width="fill";
        DividerHeight=0,
      }
    }
  }
  单对话框(buj,"修改文件MD5")
  adp=ArrayAdapter(activity,android.R.layout.simple_list_item_1)
  lv.setAdapter(adp)

  function SetItem(path)
    path=tostring(path)
    adp.clear()--清空适配器
    cp.Text=tostring(path)--设置当前路径
    if path~="/" then--不是根目录则加上../
      adp.add("../")
    end
    ls=File(path).listFiles()
    if ls~=nil then
      ls=luajava.astable(File(path).listFiles()) --全局文件列表变量
      table.sort(ls,function(a,b)
        return (a.isDirectory()~=b.isDirectory() and a.isDirectory()) or ((a.isDirectory()==b.isDirectory()) and a.Name<b.Name)
      end)
     else
      ls={}
    end
    for index,c in pairs(ls) do
      if c.isDirectory() then--如果是文件夹则
        adp.add(c.Name.."/")
       else--如果是文件则
        adp.add(c.Name)
      end
    end
  end

  lv.onItemClick=function(l,v,p,s)--列表点击事件
    项目=tostring(v.Text)
    if tostring(cp.Text)=="/" then
      路径=ls[p+1]
     else
      路径=ls[p]
    end

    if 项目=="../" then
      SetItem(File(cp.Text).getParentFile())
     elseif 路径.isDirectory() then
      SetItem(路径)
     elseif 路径.isFile() then
      callback(tostring(路径))
      --  ChoiceFile_dialog.hide()
    end

  end
  SetItem(StartPath)

end


function 文字加密(text,key)
  destring()
  return minicrypto.encrypt(text, key)
end


function 文字解码(text,key)
  destring()
  return minicrypto.decrypt(text,key)
end

-----------------

--动画设置___从下往上平移动画
Translate_up_down=TranslateAnimation(0, 0,获取屏幕高,0 )
Translate_up_down.setDuration(300)
Translate_up_down.setFillAfter(true)

--动画设置___从上往下平移动画
Translate_up_down2=TranslateAnimation(0, 0, 0,获取屏幕高+状态栏高度 )
Translate_up_down2.setDuration(300)
Translate_up_down2.setFillAfter(true)


function 单对话框3(buj,bt,str,gb,stt)
  if not bt then
    bt="Title"
  end
  local gd3 = GradientDrawable()
  gd3.setColor(提示背景)--填充
  local radius=dp2px(18)
  gd3.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
  gd3.setShape(0)--形状，0矩形，1圆形，2线，3环形
  local dann3={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    background="#00000000";
    id="dc3",
    {
      LinearLayout;
      layout_width="-1";
      layout_height="-1";
      background="#00000000";
      orientation="vertical";
      gravity="bottom";
      {
        LinearLayout;
        layout_height=activity.getHeight();
        layout_width="fill";
        layout_weight="1";
        background="#00000000";
        onClick=function()
          if not dukfh then
            dukfh=true
            pcall(function()
              imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE);
              imm.hideSoftInputFromWindow(an.getWindow().getDecorView().getWindowToken(), 0);
            end)
            dc3.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
              onAnimationEnd=function()
                an3.hide()
                QJDJ=false
                dukfh=false
                pcall(function()
                  an=nil
                  stt()
                end)
              end}))
          end
        end,
      },
      {
        LinearLayout;
        layout_width="-1";
        layout_height="wrap_content";
        layout_gravity="bottom";
        orientation="vertical";
        background="#00000000";
        id="ll",
        {
          LinearLayout;
          orientation="vertical";
          layout_width="-1";
          layout_height="-2";
          Elevation="4dp";
          BackgroundDrawable=gd3;
          id="ztbj3";
          {
            RelativeLayout;
            layout_width="-1";
            layout_height="-2";
            {
              TextView;
              layout_width="-1";
              layout_height="-2";
              textSize="18sp";
              layout_marginTop="24dp";
              layout_marginLeft="24dp";
              layout_marginRight="24dp";
              Text=bt;
              textColor=圆图字体颜色;
            };
            {
              LinearLayout;
              layout_width="-1";
              layout_height="-2";
              layout_marginTop="56dp";
              -- padding="4dp";
              buj;
            },
            {
              LinearLayout;
              layout_width="-1";
              layout_height="-2";
              gravity="bottom|center";
              layout_marginTop="16dp";
              layout_marginLeft="24dp";
              {
                LinearLayout;
                orientation="horizontal";
                layout_width="-1";
                layout_height="-2";
                gravity="right|center";
                layout_marginBottom="24dp";
                {
                  CardView;
                  layout_width="-2";
                  layout_height="-2";
                  radius="2dp";
                  background="#00000000";
                  layout_marginTop="8dp";
                  layout_marginLeft="8dp";
                  layout_marginRight="24dp";
                  layout_marginBottom="24dp";
                  Elevation="0";
                  onClick=function()
                    if not dukfh then
                      dukfh=true
                      pcall(function()
                        imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE);
                        imm.hideSoftInputFromWindow(an.getWindow().getDecorView().getWindowToken(), 0);
                      end)
                      dc3.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
                        onAnimationEnd=function()
                          an3.hide()
                          QJDJ=false
                          dukfh=false
                          pcall(function()
                            an=nil
                            stt()
                          end)
                        end}))
                    end
                  end;
                  {
                    TextView;
                    layout_width="-1";
                    layout_height="-2";
                    textSize="14sp";
                    paddingRight="16dp";
                    paddingLeft="16dp";
                    paddingTop="8dp";
                    paddingBottom="8dp";
                    Text="取消";
                    textColor=圆图字体颜色;
                    BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
                  };
                };
              };
            };
          };
        };
      };
    };
  };
  dl3=AlertDialog.Builder(activity)
  dl3.setView(loadlayout(dann3))
  if gb then
    dl3.setCancelable(false)
  end
  dukfh=false
  --AlertDialog监听返回
  dl3.setOnKeyListener(function(id,k,t)
    if k==4 then
      local dlt=t.getAction()
      if dlfh and dlt==1 then
        dlfh=nil
        --输入法消失
        return true
       else--布局消失
        if dlt==0 || not dlfh then
          dlfh=true
        end
        if dlt==0 then
          if not dukfh then
            dukfh=true
            dc3.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
              onAnimationEnd=function()
                an3.hide()
                QJDJ=false
                dukfh=false
                pcall(function()
                  an=nil
                  stt()
                end)
              end}))
            return true
          end
        end
      end
    end
  end)

  --点击空白事件
  dl3.setOnCancelListener(function(...)
    QJDJ=false
    pcall(function()
      an3=nil
      stt()
    end)
  end)

  an3=dl3.show()
  window3 = an3.getWindow();
  window3.setBackgroundDrawable(ColorDrawable(0x00000000));
  wlp3 = window3.getAttributes();
  wlp3.gravity = Gravity.BOTTOM;
  wlp3.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp3.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window3.setAttributes(wlp3);
  an3.getWindow().setSoftInputMode(0x20)
  -- an.getWindow().setSoftInputMode(0x10)
  dc3.startAnimation(Translate_up_down)
  手势滑动(an3,ztbj3,500)
  if str then
    str()
  end
end


function 双对话框(buj,bt,ksn,ks,str,gb)
  if not bt then
    bt="Title"
  end
  if not ksn then
    ksn="开始"
  end
  local gd2 = GradientDrawable()
  gd2.setColor(提示背景)--填充
  local radius=dp2px(18)
  gd2.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形

  local dann={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    background="#00000000";
    id="dc",
    {
      LinearLayout;
      layout_width="-1";
      layout_height="-1";
      background="#00000000";
      orientation="vertical";
      gravity="bottom";
      id="ll2",
      {
        LinearLayout;
        layout_height=activity.getHeight();
        layout_width="fill";
        layout_weight="1";
        background="#00000000";
        onClick=function()
          if not dukfh then
            dukfh=true
            pcall(function()
              imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE);
              imm.hideSoftInputFromWindow(an.getWindow().getDecorView().getWindowToken(), 0);
            end)
            dc.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
              onAnimationEnd=function()
                an.hide()
                QJDJ=false
                dukfh=false
              end}))
          end
        end,
      },
      {
        LinearLayout;
        layout_width="-1";
        layout_height="wrap_content";
        layout_gravity="bottom";
        background="#00000000";
        id="ll",
        {
          LinearLayout;
          orientation="vertical";
          layout_width="-1";
          layout_height="-2";
          Elevation="4dp";
          BackgroundDrawable=gd2;
          id="ztbj";
          {
            RelativeLayout;
            layout_width="-1";
            layout_height="-2";
            {
              TextView;
              layout_width="-1";
              layout_height="-2";
              textSize="18sp";
              layout_marginTop="24dp";
              layout_marginLeft="24dp";
              layout_marginRight="24dp";
              Text=bt;
              textColor=圆图字体颜色;
            };
            {
              LinearLayout;
              layout_width="-1";
              layout_height="-2";
              layout_marginTop="56dp";
              -- padding="4dp";
              buj;
            },
            {
              LinearLayout;
              layout_width="-1";
              layout_height="-2";
              gravity="bottom|center";
              layout_marginTop="16dp";
              layout_marginLeft="24dp";
              {
                LinearLayout;
                orientation="horizontal";
                layout_width="-1";
                layout_height="-2";
                gravity="right|center";
                layout_marginBottom="24dp";
                {
                  CardView;
                  layout_width="-2";
                  layout_height="-2";
                  radius="2dp";
                  background="#00000000";
                  layout_marginTop="8dp";
                  layout_marginLeft="8dp";
                  layout_marginBottom="24dp";
                  Elevation="0";
                  onClick=function()
                    if not dukfh then
                      dukfh=true
                      pcall(function()
                        imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE);
                        imm.hideSoftInputFromWindow(an.getWindow().getDecorView().getWindowToken(), 0);
                      end)
                      dc.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
                        onAnimationEnd=function()
                          an.hide()
                          QJDJ=false
                          dukfh=false
                        end}))
                    end
                  end;
                  {
                    TextView;
                    layout_width="-1";
                    layout_height="-2";
                    textSize="14sp";
                    paddingRight="16dp";
                    paddingLeft="16dp";
                    paddingTop="8dp";
                    paddingBottom="8dp";
                    Text="取消";
                    textColor=圆图字体颜色;
                    BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
                  };
                };
                {
                  CardView;
                  layout_width="-2";
                  layout_height="-2";
                  radius="4dp";
                  layout_marginTop="8dp";
                  layout_marginLeft="8dp";
                  layout_marginRight="24dp";
                  layout_marginBottom="24dp";
                  background=字体背景,
                  Elevation="1dp";
                  onClick=function()
                    if not dukfh then
                      dukfh=true
                      pcall(function()
                        imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE);
                        imm.hideSoftInputFromWindow(an.getWindow().getDecorView().getWindowToken(), 0);
                      end)
                      dc.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
                        onAnimationEnd=function()
                          an.hide()
                          QJDJ=false
                          dukfh=false
                          local e2,erro2= pcall(function()
                            ks()
                          end)
                          if not e2 then
                            提示(erro2)
                          end
                        end}))
                    end
                  end;
                  {
                    TextView;
                    layout_width="-1";
                    layout_height="-2";
                    textSize="14sp";
                    paddingRight="16dp";
                    paddingLeft="16dp";
                    paddingTop="8dp";
                    paddingBottom="8dp";
                    Text=ksn;
                    textColor=圆图字体颜色;
                    BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
                  };
                };
              };
            };
          };
        };
      };
    };
  };
  dl=AlertDialog.Builder(activity)
  dl.setView(loadlayout(dann))
  if gb then
    dl.setCancelable(false)
  end
  dukfh=false
  --AlertDialog监听返回
  dl.setOnKeyListener(function(id,k,t)
    if k==4 then
      local dlt=t.getAction()
      if dlfh and dlt==1 then
        dlfh=nil
        --输入法消失
        return true
       else--布局消失
        if dlt==0 || not dlfh then
          dlfh=true
        end
        if dlt==0 then
          if not dukfh then
            dukfh=true
            dc.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
              onAnimationEnd=function()
                an.hide()
                QJDJ=false
                dukfh=false
              end}))
            return true
          end
        end
      end
    end

  end)


  --点击空白
  dl.setOnCancelListener(function(...)QJDJ=false end)
  an=dl.show()
  window = an.getWindow();
  window.setBackgroundDrawable(ColorDrawable(0x00ffffff));
  wlp = window.getAttributes();
  wlp.gravity = Gravity.BOTTOM;
  wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window.setAttributes(wlp);
  an.getWindow().setSoftInputMode(0x20)
  --  an.getWindow().setSoftInputMode(0x10)
  dc.startAnimation(Translate_up_down)
  手势滑动(an,ztbj,500)
  if str then
    str()
  end
end


function 双对话框2(buj,bt,ksn,ks,str,gb)
  if not bt then
    bt="Title"
  end
  if not ksn then
    ksn="开始"
  end
  local gd2 = GradientDrawable()
  gd2.setColor(提示背景)--填充
  local radius=dp2px(18)
  gd2.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形

  local dann1={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    background="#00000000";
    id="dc2",
    {
      LinearLayout;
      layout_width="-1";
      layout_height="-1";
      background="#00000000";
      orientation="vertical";
      gravity="bottom";
      id="ll2",
      {
        LinearLayout;
        layout_height=activity.getHeight();
        layout_width="fill";
        layout_weight="1";
        background="#00000000";
        onClick=function()
          if not dukfh then
            dukfh=true
            pcall(function()
              imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE);
              imm.hideSoftInputFromWindow(an1.getWindow().getDecorView().getWindowToken(), 0);
            end)
            dc2.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
              onAnimationEnd=function()
                an1.hide()
                QJDJ=false
                dukfh=false
              end}))
          end
        end,
      },
      {
        LinearLayout;
        layout_width="-1";
        layout_height="wrap_content";
        layout_gravity="bottom";
        background="#00000000";
        id="ll1",
        {
          LinearLayout;
          orientation="vertical";
          layout_width="-1";
          layout_height="-2";
          Elevation="4dp";
          BackgroundDrawable=gd2;
          id="ztbj";
          {
            RelativeLayout;
            layout_width="-1";
            layout_height="-2";
            {
              TextView;
              layout_width="-1";
              layout_height="-2";
              textSize="18sp";
              layout_marginTop="24dp";
              layout_marginLeft="24dp";
              layout_marginRight="24dp";
              Text=bt;
              textColor=圆图字体颜色;
            };
            {
              LinearLayout;
              layout_width="-1";
              layout_height="-2";
              layout_marginTop="56dp";
              -- padding="4dp";
              buj;
            },
            {
              LinearLayout;
              layout_width="-1";
              layout_height="-2";
              gravity="bottom|center";
              layout_marginTop="16dp";
              layout_marginLeft="24dp";
              {
                LinearLayout;
                orientation="horizontal";
                layout_width="-1";
                layout_height="-2";
                gravity="right|center";
                layout_marginBottom="24dp";
                {
                  CardView;
                  layout_width="-2";
                  layout_height="-2";
                  radius="2dp";
                  background="#00000000";
                  layout_marginTop="8dp";
                  layout_marginLeft="8dp";
                  layout_marginBottom="24dp";
                  Elevation="0";
                  onClick=function()
                    if not dukfh then
                      dukfh=true
                      pcall(function()
                        imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE);
                        imm.hideSoftInputFromWindow(an1.getWindow().getDecorView().getWindowToken(), 0);
                      end)
                      dc2.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
                        onAnimationEnd=function()
                          an1.hide()
                          QJDJ=false
                          dukfh=false
                        end}))
                    end
                  end;
                  {
                    TextView;
                    layout_width="-1";
                    layout_height="-2";
                    textSize="14sp";
                    paddingRight="16dp";
                    paddingLeft="16dp";
                    paddingTop="8dp";
                    paddingBottom="8dp";
                    Text="取消";
                    textColor=圆图字体颜色;
                    BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
                  };
                };
                {
                  CardView;
                  layout_width="-2";
                  layout_height="-2";
                  radius="4dp";
                  layout_marginTop="8dp";
                  layout_marginLeft="8dp";
                  layout_marginRight="24dp";
                  layout_marginBottom="24dp";
                  background=字体背景,
                  Elevation="1dp";
                  onClick=function()
                    if not dukfh then
                      dukfh=true
                      pcall(function()
                        imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE);
                        imm.hideSoftInputFromWindow(an1.getWindow().getDecorView().getWindowToken(), 0);
                      end)
                      dc2.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
                        onAnimationEnd=function()
                          an1.hide()
                          QJDJ=false
                          dukfh=false
                          local e2,error2= pcall(function()
                            ks()
                          end)
                          if not e2 then
                            提示(error2)
                          end
                        end}))
                    end
                  end;
                  {
                    TextView;
                    layout_width="-1";
                    layout_height="-2";
                    textSize="14sp";
                    paddingRight="16dp";
                    paddingLeft="16dp";
                    paddingTop="8dp";
                    paddingBottom="8dp";
                    Text=ksn;
                    textColor=圆图字体颜色;
                    BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
                  };
                };
              };
            };
          };
        };
      };
    };
  };
  dl1=AlertDialog.Builder(activity)
  dl1.setView(loadlayout(dann1))
  if gb then
    dl1.setCancelable(false)
  end
  dukfh=false
  --AlertDialog监听返回
  dl1.setOnKeyListener(function(id,k,t)
    if k==4 then
      local dlt=t.getAction()
      if dlfh and dlt==1 then
        dlfh=nil
        --输入法消失
        return true
       else--布局消失
        if dlt==0 || not dlfh then
          dlfh=true
        end
        if dlt==0 then
          if not dukfh then
            dukfh=true
            dc2.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
              onAnimationEnd=function()
                an1.hide()
                QJDJ=false
                dukfh=false
              end}))
            return true
          end
        end
      end
    end
  end)

  --点击空白
  dl1.setOnCancelListener(function(...)QJDJ=false end)

  an1=dl1.show()
  window1 = an1.getWindow();
  window1.setBackgroundDrawable(ColorDrawable(0x00ffffff));
  wlp1 = window1.getAttributes();
  wlp1.gravity = Gravity.BOTTOM;
  wlp1.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp1.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window1.setAttributes(wlp1);
  an1.getWindow().setSoftInputMode(0x20)
  --  an1.getWindow().setSoftInputMode(0x10)
  dc2.startAnimation(Translate_up_down)
  手势滑动(an1,ztbj,500)
  if str then
    str()
  end
end


function 单对话框(buj,bt,str,gb)
  if not bt then
    bt="Title"
  end
  local gd2 = GradientDrawable()
  gd2.setColor(提示背景)--填充
  local radius=dp2px(18)
  gd2.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形
  local dann={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    background="#00000000";
    id="dc",
    {
      LinearLayout;
      layout_width="-1";
      layout_height="-1";
      background="#00000000";
      orientation="vertical";
      gravity="bottom";
      id="ll2",
      {
        LinearLayout;
        layout_height=activity.getHeight();
        layout_width="fill";
        layout_weight="1";
        background="#00000000";
        onClick=function()
          if not dukfh then
            dukfh=true
            pcall(function()
              imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE);
              imm.hideSoftInputFromWindow(an.getWindow().getDecorView().getWindowToken(), 0);
            end)
            dc.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
              onAnimationEnd=function()
                an.hide()
                QJDJ=false
                dukfh=false
              end}))
          end
        end,
      },
      {
        LinearLayout;
        layout_width="-1";
        layout_height="wrap_content";
        layout_gravity="bottom";
        orientation="vertical";
        background="#00000000";
        id="ll",
        {
          LinearLayout;
          orientation="vertical";
          layout_width="-1";
          layout_height="-2";
          Elevation="4dp";
          BackgroundDrawable=gd2;
          id="ztbj";
          {
            RelativeLayout;
            layout_width="-1";
            layout_height="-2";
            {
              TextView;
              layout_width="-1";
              layout_height="-2";
              textSize="18sp";
              layout_marginTop="24dp";
              layout_marginLeft="24dp";
              layout_marginRight="24dp";
              Text=bt;
              textColor=圆图字体颜色;
            };
            {
              LinearLayout;
              layout_width="-1";
              layout_height="-2";
              layout_marginTop="56dp";
              -- padding="4dp";
              buj;
            },
            {
              LinearLayout;
              layout_width="-1";
              layout_height="-2";
              gravity="bottom|center";
              layout_marginTop="16dp";
              layout_marginLeft="24dp";
              {
                LinearLayout;
                orientation="horizontal";
                layout_width="-1";
                layout_height="-2";
                gravity="right|center";
                layout_marginBottom="24dp";
                {
                  CardView;
                  layout_width="-2";
                  layout_height="-2";
                  radius="2dp";
                  background="#00000000";
                  layout_marginTop="8dp";
                  layout_marginLeft="8dp";
                  layout_marginRight="24dp";
                  layout_marginBottom="24dp";
                  Elevation="0";
                  onClick=function()
                    if not dukfh then
                      dukfh=true
                      pcall(function()
                        imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE);
                        imm.hideSoftInputFromWindow(an.getWindow().getDecorView().getWindowToken(), 0);
                      end)
                      dc.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
                        onAnimationEnd=function()
                          an.hide()
                          QJDJ=false
                          dukfh=false
                        end}))
                    end
                  end;
                  {
                    TextView;
                    layout_width="-1";
                    layout_height="-2";
                    textSize="14sp";
                    paddingRight="16dp";
                    paddingLeft="16dp";
                    paddingTop="8dp";
                    paddingBottom="8dp";
                    Text="取消";
                    textColor=圆图字体颜色;
                    BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
                  };
                };
              };
            };
          };
        };
      };
    };
  };
  dl=AlertDialog.Builder(activity)
  dl.setView(loadlayout(dann))
  if gb then
    dl.setCancelable(false)
  end
  dukfh=false
  --AlertDialog监听返回
  dl.setOnKeyListener(function(id,k,t)
    if k==4 then
      local dlt=t.getAction()
      if dlfh and dlt==1 then
        dlfh=nil
        --输入法消失
        return true
       else--布局消失
        if dlt==0 || not dlfh then
          dlfh=true
        end
        if dlt==0 then
          if not dukfh then
            dukfh=true
            dc.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
              onAnimationEnd=function()
                an.hide()
                QJDJ=false
                dukfh=false
              end}))
            return true
          end
        end
      end
    end
  end)

  --点击空白事件
  dl.setOnCancelListener(function(...)
    QJDJ=false
  end)

  an=dl.show()
  window = an.getWindow();
  window.setBackgroundDrawable(ColorDrawable(0x00000000));
  wlp = window.getAttributes();
  wlp.gravity = Gravity.BOTTOM;
  wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window.setAttributes(wlp);
  an.getWindow().setSoftInputMode(0x20)
  -- an.getWindow().setSoftInputMode(0x10)
  dc.startAnimation(Translate_up_down)
  手势滑动(an,ztbj,500)
  if str then
    str()
  end
end

function 单对话框2(buj,bt,str,gb)

  if not bt then
    bt="Title"
  end
  local gd2 = GradientDrawable()
  gd2.setColor(提示背景)--填充
  local radius=dp2px(18)
  gd2.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
  gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形

  local dann1={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    background="#00000000";
    id="dc2",
    {
      LinearLayout;
      layout_width="-1";
      layout_height="-1";
      background="#00000000";
      orientation="vertical";
      gravity="bottom";
      id="ll2",
      {
        LinearLayout;
        layout_height=activity.getHeight();
        layout_width="fill";
        layout_weight="1";
        background="#00000000";
        onClick=function()
          if not dukfh then
            dukfh=true
            pcall(function()
              imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE);
              imm.hideSoftInputFromWindow(an1.getWindow().getDecorView().getWindowToken(), 0);
            end)
            dc2.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
              onAnimationEnd=function()
                an1.hide()
                QJDJ=false
                dukfh=false
              end}))
          end
        end,
      },
      {
        LinearLayout;
        layout_width="-1";
        layout_height="wrap_content";
        layout_gravity="bottom";
        background="#00000000";
        id="ll1",
        {
          LinearLayout;
          orientation="vertical";
          layout_width="-1";
          layout_height="-2";
          Elevation="4dp";
          BackgroundDrawable=gd2;
          id="ztbj";
          {
            RelativeLayout;
            layout_width="-1";
            layout_height="-2";
            {
              TextView;
              layout_width="-1";
              layout_height="-2";
              textSize="18sp";
              layout_marginTop="24dp";
              layout_marginLeft="24dp";
              layout_marginRight="24dp";
              Text=bt;
              textColor=圆图字体颜色;
            };
            {
              LinearLayout;
              layout_width="-1";
              layout_height="-2";
              layout_marginTop="56dp";
              --  padding="4dp";
              buj;
            },
            {
              LinearLayout;
              layout_width="-1";
              layout_height="-2";
              gravity="bottom|center";
              layout_marginTop="16dp";
              layout_marginLeft="24dp";
              {
                LinearLayout;
                orientation="horizontal";
                layout_width="-1";
                layout_height="-2";
                gravity="right|center";
                layout_marginBottom="24dp";
                {
                  CardView;
                  layout_width="-2";
                  layout_height="-2";
                  radius="2dp";
                  background="#00000000";
                  layout_marginTop="8dp";
                  layout_marginLeft="8dp";
                  layout_marginRight="24dp";
                  layout_marginBottom="24dp";
                  Elevation="0";
                  onClick=function()
                    if not dukfh then
                      dukfh=true
                      pcall(function()
                        imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE);
                        imm.hideSoftInputFromWindow(an1.getWindow().getDecorView().getWindowToken(), 0);
                      end)
                      dc2.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
                        onAnimationEnd=function()
                          an1.hide()
                          QJDJ=false
                          dukfh=false
                        end}))
                    end
                  end;
                  {
                    TextView;
                    layout_width="-1";
                    layout_height="-2";
                    textSize="14sp";
                    paddingRight="16dp";
                    paddingLeft="16dp";
                    paddingTop="8dp";
                    paddingBottom="8dp";
                    Text="取消";
                    textColor=圆图字体颜色;
                    BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
                  };
                };
              };
            };
          };
        };
      };
    };
  };
  dl1=AlertDialog.Builder(activity)
  dl1.setView(loadlayout(dann1))
  if gb then
    dl1.setCancelable(false)
  end

  dukfh=false
  --AlertDialog监听返回
  dl1.setOnKeyListener(function(id,k,t)
    if k==4 then
      local dlt=t.getAction()
      if dlfh and dlt==1 then
        dlfh=nil
        --输入法消失
        return true
       else--布局消失
        if dlt==0 || not dlfh then
          dlfh=true
        end
        if dlt==0 then
          if not dukfh then
            dukfh=true
            dc2.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
              onAnimationEnd=function()
                an1.hide()
                QJDJ=false
                dukfh=false
              end}))
            return true
          end
        end
      end
    end
  end)

  --点击空白
  dl1.setOnCancelListener(function(...)
    QJDJ=false
  end)

  an1=dl1.show()
  window1 = an1.getWindow();
  window1.setBackgroundDrawable(ColorDrawable(0x00ffffff));
  wlp1 = window1.getAttributes();
  wlp1.gravity = Gravity.BOTTOM;
  wlp1.width = WindowManager.LayoutParams.MATCH_PARENT;
  wlp1.height = WindowManager.LayoutParams.WRAP_CONTENT;
  window1.setAttributes(wlp1);
  an1.getWindow().setSoftInputMode(0x20)
  --  an.getWindow().setSoftInputMode(0x10)
  dc2.startAnimation(Translate_up_down)
  手势滑动(an1,ztbj,500)
  if str then
    str()
  end
end


function 波纹(id,lx,zdy)

  xpcall(function()
    for index,content in pairs(id) do
      if lx=="圆白" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff})))
      end
      if lx=="方白" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff})))
      end
      if lx=="圆黑" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000})))
      end
      if lx=="方黑" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000})))
      end
      if lx=="圆主题" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{bwz})))
      end
      if lx=="方主题" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz})))
      end
      if lx=="圆自定义" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{zdy})))
      end
      if lx=="方自定义" then
        content.backgroundDrawable=(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{zdy})))
      end
    end
  end,function(e)end)
end


function activity背景颜色(color2)

  pcall(function()
    _window = activity.getWindow();
    if color2 then
      _window.setBackgroundDrawable(ColorDrawable(color));
     else
      local e=pcall(function()
        color2=WallpaperManager.getInstance(this).getDrawable()
        _window.setBackgroundDrawable(color2)
      end)
      if not e then
        _window.setBackgroundDrawable(ColorDrawable(0x0));
      end
    end
    _wlp = _window.getAttributes();
    --  _wlp.gravity = Gravity.BOTTOM;
    _wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
    _wlp.height = WindowManager.LayoutParams.MATCH_PARENT;--WRAP_CONTENT
    _window.setAttributes(_wlp);
  end)
end



--状态栏0透明0.5半透明1不透明
function setStatusBar(opacity)
  -- //api>21,全透明状态栏和导航栏;api>19,半透明状态栏和导航栏,opacity为0透明，0.5半透明，1不透明。
  if (Build.VERSION.SDK_INT >= 21)then
    if(opacity==0)then
      window = activity.getWindow();
      window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
      window.setStatusBarColor(Color.TRANSPARENT);
      window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN| View.SYSTEM_UI_FLAG_LAYOUT_STABLE);
     elseif(opacity==0.5)then
      activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
      activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
     else
      activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
      activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
    end
   elseif (Build.VERSION.SDK_INT >= 19)then
    if(opacity~=1) then
      activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
     else
      activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
    end
  end
end

--导航栏
function setNavBar(opacity)
  --  //api>21,全透明状态栏和导航栏;api>19,半透明状态栏和导航栏
  if (Build.VERSION.SDK_INT >= 21)then
    if(opacity==0)then
      window = activity.getWindow();
      window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
      window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_STABLE|View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN|View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION)--//导航栏不会被隐藏但activity布局会扩展到导航栏所在位置
      window.setNavigationBarColor(Color.TRANSPARENT);
     elseif(opacity==0.5) then
      activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
      activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION);
     else
      activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION);
      activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
    end
   elseif (Build.VERSION.SDK_INT >= 19)then
    if(opacity~=1) then
      activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION);
     else
      activity.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION);
    end
  end
end

function 导航栏透明()
  setNavBar(0)
end

function 状态栏透明()
  setStatusBar(0)
end


--//状态栏、导航栏都透明，这个会把布局添加到两栏里面
function 两栏全透明()
  if (Build.VERSION.SDK_INT >= 21) then
    window = activity.getWindow();
    window.clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS | WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION);
    window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION | View.SYSTEM_UI_FLAG_LAYOUT_STABLE);
    window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
    window.setStatusBarColor(Color.TRANSPARENT);
    window.setNavigationBarColor(Color.TRANSPARENT);
    return;
  end
  if (Build.VERSION.SDK_INT >= 21) then
    activity.getWindow().addFlags( WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
    activity. getWindow().addFlags( WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION);
  end
end



function 设置主题()
  --sdk19
  pcall(function()
    activity.setTheme(android.R.style.Theme_Material_Light_NoActionBar)
    activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
  end)
end


function 全屏()
  pcall(function()
    window = activity.getWindow();
    window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_FULLSCREEN|View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN);
    window.setFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN,WindowManager.LayoutParams.FLAG_FULLSCREEN);

    if pcall(function()
        lp = window.getAttributes();
        lp.layoutInDisplayCutoutMode = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES;
        window.setAttributes(lp);
      end)then
     else

    end
    if Build.VERSION.SDK_INT<=24 then
      --全面
      activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
      --隐藏导航栏
      activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION);

     elseif Build.VERSION.SDK_INT>24 then
      pcall(function()
        --设置导航栏和状态栏(sdk19及以上)
        activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION)
        --设置颜色
        activity.getWindow().setStatusBarColor(Color.TRANSPARENT)--将状态栏设置成透明色
        activity.getWindow().setNavigationBarColor(Color.TRANSPARENT)--将导航栏设置为透明色
        --隐藏导航栏
        activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION);
      end)
    end
  end)
end


function 自定义状态栏背景颜色主题(a)
  if Build.VERSION.SDK_INT >= 21 then
    activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(a);
  end
end



function 设置全透明主题()
  pcall(function()
    if SDK版本>=19 then
      设置主题()
      setStatusBar(0)
      setNavBar(0)
    end
  end)
end

function 沉浸状态栏()
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
end

function 设置导航栏颜色(a)
  activity.getWindow().setNavigationBarColor(int(a));
end


function 字体(t)
  return Typeface.createFromFile(File(activity.getLuaDir().."/res/ttf/"..t..".ttf"))
end

function 设置字体(id,ttf)
  local bf=File(luajava.luadir.."/res/ttf/"..ttf..".ttf");
  local tf=Typeface.createFromFile(bf)
  return id.setTypeface(tf);
end

function getwh(view)
  view.measure(View.MeasureSpec.makeMeasureSpec(0,View.MeasureSpec.UNSPECIFIED),View.MeasureSpec.makeMeasureSpec(0,View.MeasureSpec.UNSPECIFIED));
  height =view.getMeasuredHeight();
  width =view.getMeasuredWidth();
  return width,height
end

function 控件圆角(view,左上,右上,左下,右下,InsideColor)
  --  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setColor(InsideColor)
  drawable.setCornerRadii({左上,左上,右上,右上,左下,左下,右下,右下});
  view.setBackgroundDrawable(drawable)
end

function 波纹2(控件,颜色)
  RippleHelper(控件).RippleColor=颜色
end

function 旋转动画(控件,a,b,c,d,时间)
  import "android.animation.ObjectAnimator"
  ObjectAnimator().ofFloat(控件,"rotation",{a,b,c,d}).setDuration(时间).start()
end

function 水珠动画(控件,时间)
  import "android.animation.ObjectAnimator"
  ObjectAnimator().ofFloat(控件,"scaleX",{1,.8,1.3,.9,1}).setDuration(时间).start()
  ObjectAnimator().ofFloat(控件,"scaleY",{1,.8,1.3,.9,1}).setDuration(时间).start()
end

function 沉浸(col)
  --activity.supportActionBar.hide()
  activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
  activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_STABLE);
  --View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(col);
end

function 沉浸二(col)
  -- activity.supportActionBar.hide()
  activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
  activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(col);
end

设置壁纸=function(bitmap)
  wallpaperManager = WallpaperManager.getInstance(this);
  wallpaperManager.setBitmap(bitmap);
end

function 手势滑动(dialog,id,yy)
  --速度跟踪器
  velocityTracker = VelocityTracker.obtain();

  id.onTouch=function(v,e)
    lee=e
    aa=e.getAction()&255

    switch aa

     case MotionEvent.ACTION_DOWN

      velocityTracker.addMovement(lee)

      downY=lee.getY()

     case MotionEvent.ACTION_MOVE

      velocityTracker.addMovement(lee)

      velocityTracker.computeCurrentVelocity(1000);

      moveY=lee.getY()

      Y=math.abs(moveY - downY)

      vsd = velocityTracker.getYVelocity()

      if Y>0 then
        --设置平移Y
        v.setTranslationY(Y/2)
        pcall(function()
          ObjectAnimator().ofFloat(v,"Y",{Y/2,0}).setDuration(500).start()
        end)
      end

     case MotionEvent.ACTION_UP

      upY=lee.getY()
      --设置绝对值
      upY=math.abs(upY-downY)

      if upY>0 then

        if upY>yy || vsd>5000 then
          --ObjectAnimator.ofFloat(icon_down_box,"translationY",{upY/2,activity.getWidth()}).setDuration(300).start()
          --ObjectAnimator().ofFloat(v,"Y",{upY/2,activity.getHeight()}).setDuration(500).start()

          if not dukfh then
            dukfh=true
            id.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
              onAnimationEnd=function()
                dialog.hide()
                QJDJ=false
                dukfh=false
                pcall(function()
                  velocityTracker.recycle()
                end)
              end}))
          end

         else
          --  ObjectAnimator.ofFloat(icon_down_box,"translationY",{upY/2,0}).setDuration(300).start()
          ObjectAnimator().ofFloat(v,"Y",{upY/2,0}).setDuration(500).start()

        end

      end

    end

    return true
  end

end


function BIAO1(id,yy)
  --速度跟踪器
  velocityTracker = VelocityTracker.obtain();

  id.onTouch=function(v,e)
    qjee=e
    qja=e.getAction()&255

    switch qja

     case MotionEvent.ACTION_DOWN

      velocityTracker.addMovement(qjee)

      downY=qjee.getY()

     case MotionEvent.ACTION_MOVE

      velocityTracker.addMovement(qjee)

      velocityTracker.computeCurrentVelocity(1000);

      moveY=qjee.getY()

      Y=(moveY - downY)

      vsd = velocityTracker.getYVelocity()
      if Y>0 then
        Y=math.abs(Y)
        --设置平移Y
        v.setTranslationY(Y/2)
        v.setAlpha(状态栏高度/Y)
        控件圆角(toolbar,Y/12,Y/12,0,0,提示背景)
        pcall(function()
          ObjectAnimator().ofFloat(v,"Y",{Y/2,0}).setDuration(500).start()
        end)
      end

     case MotionEvent.ACTION_UP

      upY=qjee.getY()

      upY=(upY-downY)

      if upY>0 then
        upY=math.abs(upY)
        if upY>yy || vsd>5000 then
          -- ObjectAnimator.ofFloat(icon_down_box,"translationY",{upY/2,activity.getWidth()}).setDuration(300).start()
          -- ObjectAnimator().ofFloat(v,"Y",{upY/2,获取屏幕高}).setDuration(500).start()
          --不接受触摸
          activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE)
          id.startAnimation(Translate_up_down2.setDuration(800).setFillAfter(true).setAnimationListener(AnimationListener{
            onAnimationEnd=function()
              pcall(function()
                velocityTracker.recycle()
              end)
              activity.finish()
              pcall(function()
                activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
              end)
            end}))

         else
          --ObjectAnimator.ofFloat(icon_down_box,"translationY",{upY/2,0}).setDuration(300).start()
          ObjectAnimator().ofFloat(v,"Y",{upY/2,0}).setDuration(500).start()
          v.setAlpha(255)
          控件圆角(toolbar,0,0,0,0,提示背景)
        end

      end

    end

    return true
  end

end


function SavePicture(name,bm)

  if bm then
    name=tostring(name)
    f = File(name)
    out = FileOutputStream(f)
    bm.compress(Bitmap.CompressFormat.PNG,100, out)
    out.flush()
    out.close()
    return true
   else
    return false
  end
end

function 图片圆角(bitmap,roundPx)
  bitmap=bitmap
  if not roundPx then
    roundPx=20;
  end
  Width= bitmap.getWidth()
  Height= bitmap.getHeight()
  bitmapback=Bitmap.createBitmap(Width,Height, Bitmap.Config.ARGB_8888);
  canvas= Canvas(bitmapback);
  paint= Paint();
  rect= Rect(0, 0, Width, Height);
  rectf= RectF(rect);
  paint.setAntiAlias(true);
  canvas.drawRoundRect(rectf, roundPx, roundPx, paint); --先在这个画板上创建一个圆角矩形
  paint.setXfermode(PorterDuffXfermode(PorterDuff.Mode.SRC_IN)); --设置图像叠加模式，取两层图像交集部分，只显示上层图像
  canvas.drawBitmap(bitmap, rect, rect, paint); --将bitmap绘制在画板上
  return bitmapback;
end


function 文件下载2(title,url,path)
  function xdc(url,path)
    local ur =URL(url)
    file =File(path);
    local con = ur.openConnection();
    local co = con.getContentLength();
    local is = con.getInputStream();
    local bs = byte[1024]
    local len,read=0,0

    local wj= FileOutputStream(path);
    len = is.read(bs)
    while len~=-1 do
      wj.write(bs, 0, len);
      read=read+len
      pcall(call,"ding",read,co)
      len = is.read(bs)
    end
    wj.close();
    is.close();
    pcall(call,"dstop",co)
  end

  function appDownload(url,path)
    thread(xdc,url,path)
  end

  function 软件内下载(title,url,path,colour)
    pcall(function()
      local ts=true
      appDownload(url,path)
      local 布局={
        LinearLayout,
        id="appdownbg",
        layout_width="fill",
        layout_height="fill",
        orientation="vertical",
        {
          TextView,
          id="appdownsong",
          text=title,
          --  typeface=Typeface.DEFAULT_BOLD,
          layout_margin="15dp",
          textColor="#ff000000",
          textSize="20sp",
        },
        {
          TextView,
          id="appdowninfo",
          text="已下载：0MB/0MB\n下载状态：准备下载",
          --id="显示信息",
          --  typeface=Typeface.MONOSPACE,
          layout_marginRight="15dp",
          layout_marginLeft="15dp",
          layout_marginBottom="15dp",
          textSize="15sp",
        },
        {
          ProgressBar,
          id="进度条",
          style="?android:attr/progressBarStyleHorizontal",
          layout_width="fill",
          progress=60,
          layout_marginRight="15dp",
          layout_marginLeft="15dp",
          layout_marginBottom="15dp",
        },
        {
          LinearLayout,
          layout_marginRight="15dp",
          layout_marginLeft="15dp",
          layout_marginBottom="15dp",
          --  orientation="horizontal",
          layout_width="fill",
          gravity="right",
          {
            TextView,
            textSize="15sp",
            --    layout_gravity="right",
            textColor="#EC407A",
            text="后台下载",
            --   typeface=Typeface.MONOSPACE,
            id="后台下载"
          },

        }
      }
      local dldown=AlertDialog.Builder(activity)
      .setView(loadlayout(布局))
      .show()
      .setCancelable(false)

      function ding(a,b)--已下载，总长度(byte)
        appdowninfo.Text=string.format("%0.2f",a/1024/1024).."MB/"..string.format("%0.2f",b/1024/1024).."MB".."\n下载状态：正在下载！"
        进度条.progress=(a/b*100)
      end

      function dstop(c)--总长度
        if ts then
          appdowninfo.Text="下载完成，总长度"..string.format("%0.2f",c/1024/1024).."MB"
          后台下载.setText("完成")
          luajava.clear(ts)
         else
          提示("下载完成！",1)
          luajava.clear(ts)
        end
      end

      后台下载.onClick=function()
        dldown.dismiss()
        luajava.clear(dldown,布局)
        ts=nil
        if 后台下载.getText()=="后台下载" then
          提示("正在下载...")
        end
      end

      if colour=="深空黑" then
        appdownbg.setBackgroundColor(0xff424242)
        appdownsong.setTextColor(0xfffafafa)
        appdowninfo.setTextColor(0xffE0E0E0)
        后台下载.setTextColor(0xffE0E0E0)
      end
    end)
  end
end

--bitmap模糊,bitmap,1-25模糊值,1-7值
--这个较占内存
function rsBlur2(source, radius, scale)
  width = Math.round(source.getWidth() * scale);
  height = Math.round(source.getHeight() * scale);
  inputBmp = Bitmap.createScaledBitmap(source,width,height,false);
  renderScript = RenderScript.create(activity.Context);
  input = Allocation.createFromBitmap(renderScript,inputBmp);
  output = Allocation.createTyped(renderScript,input.getType());
  scriptIntrinsicBlur = ScriptIntrinsicBlur.create(renderScript, Element.U8_4(renderScript));
  scriptIntrinsicBlur.setInput(input);
  scriptIntrinsicBlur.setRadius(radius);
  scriptIntrinsicBlur.forEach(output);
  output.copyTo(inputBmp);
  renderScript.destroy();
  return inputBmp;
end

--bitmap模糊,bitmap,1-25模糊值
function rsBlur(source, radius)
  inputBmp = source;
  renderScript = RenderScript.create(activity.Context());
  input = Allocation.createFromBitmap(renderScript,inputBmp);
  output = Allocation.createTyped(renderScript,input.getType());
  scriptIntrinsicBlur = ScriptIntrinsicBlur.create(renderScript, Element.U8_4(renderScript));
  scriptIntrinsicBlur.setInput(input);
  scriptIntrinsicBlur.setRadius(radius);
  scriptIntrinsicBlur.forEach(output);
  output.copyTo(inputBmp);
  renderScript.destroy();
  return inputBmp;
end

--bitmap黑白
function toGrayscale( bmpOriginal)
  local width, height;
  height = bmpOriginal.getHeight();
  width = bmpOriginal.getWidth();
  local bmpGrayscale = Bitmap.createBitmap(width, height,Bitmap.Config.RGB_565);
  local c = Canvas(bmpGrayscale);
  local paint = Paint();
  local cm = ColorMatrix();
  cm.setSaturation(0);
  local f = ColorMatrixColorFilter(cm);
  paint.setColorFilter(f);
  c.drawBitmap(bmpOriginal, 0, 0, paint);
  return bmpGrayscale;
end


--[[
根据ip自动获取ip地址天气api(返回json

local url="https://free-api.heweather.net/s6/weather/now?location=auto_ip&key=db86a5196f304e52a4369818c5182e60"
Http.get(url,function(a,b)
  if a==200||b then
    
    local b=cjson.decode(b)
    
    local 更新时间=b["HeWeather6"][1]["update"]["loc"]
  
    local 地址=b["HeWeather6"][1]["basic"]
    local 经度=地址["lon"]
    local 纬度=地址["lat"]
    local 标准时间=地址["tz"]
    local 国家=地址["cnty"]
    local 省份=地址["admin_area"]
    local 市=地址["admin_area"]
    local CID=地址["cid"]
    
    local 天气=b["HeWeather6"][1]["now"]
    local 风力等级=天气["wind_spd"]
    local 风角度=天气["wind_deg"]
    local 湿度=天气["hum"]
    local 气压=天气["pres"]
       
    print(dump(b))
    
  end
end)
]]

function 分享文件(path)
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

function 浏览器搜索(a)
  intent = Intent()
  intent.setAction(Intent.ACTION_WEB_SEARCH)
  intent.putExtra(SearchManager.QUERY,a)
  activity.startActivity(intent)
end


function 百度百科搜索(ljljlj)
  网络判断(function() 提示("没有网络（ '▿ ' ）",3)end,function()
    local buj={
      LinearLayout;
      layout_height="fill",
      layout_width="fill",
      orientation="vertical";
      Focusable=true,
      FocusableInTouchMode=true,
      {
        LuaWebView;
        layout_width="-1";
        layout_height="-1";
        id="wb"
      };
    }

    bt="百度搜索"

    local gd2 = GradientDrawable()
    gd2.setColor(提示背景)--填充
    local radius=dp2px(18)
    gd2.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
    gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形

    local dann1={
      LinearLayout;
      layout_width="-1";
      layout_height="-1";
      background="#00000000";
      id="dc2",
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        background="#00000000";
        orientation="vertical";
        gravity="bottom";
        id="ll2",
        {
          LinearLayout;
          layout_height=activity.getHeight();
          layout_width="fill";
          layout_weight="1";
          background="#00000000";
          onClick=function()
            if not dukfh then
              dukfh=true
              pcall(function()
                imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE);
                imm.hideSoftInputFromWindow(an1.getWindow().getDecorView().getWindowToken(), 0);
              end)
              dc2.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
                onAnimationEnd=function()
                  an1.hide()
                  QJDJ=false
                  dukfh=false
                end}))
            end
          end,
        },
        {
          LinearLayout;
          layout_width="-1";
          layout_height="wrap_content";
          layout_gravity="bottom";
          background="#00000000";
          id="ll1",
          {
            LinearLayout;
            orientation="vertical";
            layout_width="-1";
            layout_height="-2";
            Elevation="4dp";
            BackgroundDrawable=gd2;
            id="ztbj";
            {
              RelativeLayout;
              layout_width="-1";
              layout_height="-2";
              {
                TextView;
                layout_width="-1";
                layout_height="-2";
                textSize="18sp";
                layout_marginTop="24dp";
                layout_marginLeft="24dp";
                layout_marginRight="24dp";
                Text=bt;
                textColor=圆图字体颜色;
              };
              {
                LinearLayout;
                layout_width="-1";
                layout_height="-2";
                layout_marginTop="56dp";
                --  padding="4dp";
                buj;
              },
              {
                LinearLayout;
                layout_width="-1";
                layout_height="-2";
                gravity="bottom|center";
                layout_marginTop="16dp";
                layout_marginLeft="24dp";
                {
                  LinearLayout;
                  orientation="horizontal";
                  layout_width="-1";
                  layout_height="-2";
                  gravity="right|center";
                  layout_marginBottom="24dp";
                  {
                    CardView;
                    layout_width="-2";
                    layout_height="-2";
                    radius="2dp";
                    background="#00000000";
                    layout_marginTop="8dp";
                    layout_marginLeft="8dp";
                    layout_marginRight="24dp";
                    layout_marginBottom="24dp";
                    Elevation="0";
                    onClick=function()
                      if not dukfh then
                        dukfh=true
                        pcall(function()
                          imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE);
                          imm.hideSoftInputFromWindow(an1.getWindow().getDecorView().getWindowToken(), 0);
                        end)
                        dc2.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
                          onAnimationEnd=function()
                            an1.hide()
                            QJDJ=false
                            dukfh=false
                          end}))
                      end
                    end;
                    {
                      TextView;
                      layout_width="-1";
                      layout_height="-2";
                      textSize="14sp";
                      paddingRight="16dp";
                      paddingLeft="16dp";
                      paddingTop="8dp";
                      paddingBottom="8dp";
                      Text="取消";
                      textColor=圆图字体颜色;
                      BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
    dl1=AlertDialog.Builder(activity)
    dl1.setView(loadlayout(dann1))
    if gb then
      dl1.setCancelable(false)
    end

    dukfh=false


    --点击空白
    dl1.setOnCancelListener(function(...)
      QJDJ=false
    end)

    an1=dl1.show()
    window1 = an1.getWindow();
    window1.setBackgroundDrawable(ColorDrawable(0x00ffffff));
    wlp1 = window1.getAttributes();
    wlp1.gravity = Gravity.BOTTOM;
    wlp1.width = WindowManager.LayoutParams.MATCH_PARENT;
    wlp1.height = WindowManager.LayoutParams.WRAP_CONTENT;
    window1.setAttributes(wlp1);
    an1.getWindow().setSoftInputMode(0x20)
    --  an.getWindow().setSoftInputMode(0x10)
    dc2.startAnimation(Translate_up_down)

    local ljljlj=URLEncoder.encode(ljljlj,"utf-8")
    wb.loadUrl("http://www.baidu.com/s?wd="..ljljlj)--加载网页
    --设置出现缩放工具
    wb.getSettings().setSupportZoom(true);
    --设置出现缩放工具
    wb.getSettings().setBuiltInZoomControls(true);
    --扩大比例的缩放
    wb.getSettings().setUseWideViewPort(true);

    wb.requestFocusFromTouch()--设置支持获取手势焦点
    --支持JS(建议无论如何加上)
    webSettings = wb.getSettings();

    wb.Settings.setJavaScriptEnabled(true);

    --状态监听
    wb.setWebViewClient{
      shouldOverrideUrlLoading=function(view,url)
        --Url即将跳转
      end,
      onPageStarted=function(view,url,favicon)
        --网页加载
      end,
      onPageFinished=function(view,url)
        --网页加载完成
      end}

    --网页与返回键之间的交互
    function onKeyDown(keyCode,event)
      if (keyCode == KeyEvent.KEYCODE_BACK && wv.canGoBack())then
        wv.goBack()
        return true
       else
        --AlertDialog监听返回
        dl1.setOnKeyListener(function(id,k,t)
          if k==4 then
            local dlt=t.getAction()
            if dlfh and dlt==1 then
              dlfh=nil
              --输入法消失
              return true
             else--布局消失
              if dlt==0 || not dlfh then
                dlfh=true
              end
              if dlt==0 then
                if not dukfh then
                  dukfh=true
                  dc2.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
                    onAnimationEnd=function()
                      an1.hide()
                      QJDJ=false
                      dukfh=false
                    end}))
                  return true
                end
              end
            end
          end
        end)
      end
      return false
    end

    手势滑动(an1,ztbj,500)
    if str then
      str()
    end
  end)
end


function 局部浏览器(BT,LJ)
  网络判断(function() 提示("没有网络（ '▿ ' ）",3)end,function()
    QJDJ=true
    local buj={
      LinearLayout;
      layout_height="fill",
      layout_width="fill",
      orientation="vertical";
      Focusable=true,
      FocusableInTouchMode=true,
      {
        LuaWebView;
        layout_width="fill";
        layout_height=获取屏幕高-状态栏高度;
        id="wb"
      };
    }

    bt=BT

    local gd2 = GradientDrawable()
    gd2.setColor(提示背景)--填充
    local radius=dp2px(18)
    gd2.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
    gd2.setShape(0)--形状，0矩形，1圆形，2线，3环形

    local dann1={
      LinearLayout;
      layout_width="-1";
      layout_height="-1";
      background="#00000000";
      id="dc2",
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        background="#00000000";
        orientation="vertical";
        gravity="bottom";
        id="ll2",
        {
          LinearLayout;
          layout_height=activity.getHeight();
          layout_width="fill";
          layout_weight="1";
          background="#00000000";
          onClick=function()
            if not dukfh then
              dukfh=true
              pcall(function()
                imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE);
                imm.hideSoftInputFromWindow(an1.getWindow().getDecorView().getWindowToken(), 0);
              end)
              dc2.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
                onAnimationEnd=function()
                  an1.hide()
                  QJDJ=false
                  dukfh=false
                end}))
            end
          end,
        },
        {
          LinearLayout;
          layout_width="-1";
          layout_height="wrap_content";
          layout_gravity="bottom";
          background="#00000000";
          id="ll1",
          {
            LinearLayout;
            orientation="vertical";
            layout_width="-1";
            layout_height="-2";
            Elevation="4dp";
            BackgroundDrawable=gd2;
            id="ztbj";
            {
              RelativeLayout;
              layout_width="-1";
              layout_height="-2";
              {
                TextView;
                layout_width="-1";
                layout_height="-2";
                textSize="18sp";
                layout_marginTop="24dp";
                layout_marginLeft="24dp";
                layout_marginRight="24dp";
                Text=bt;
                textColor=圆图字体颜色;
              };
              {
                LinearLayout;
                layout_width="-1";
                layout_height="-2";
                layout_marginTop="56dp";
                --  padding="4dp";
                buj;
              },
              {
                LinearLayout;
                layout_width="-1";
                layout_height="-2";
                gravity="bottom|center";
                layout_marginTop="16dp";
                layout_marginLeft="24dp";
                {
                  LinearLayout;
                  orientation="horizontal";
                  layout_width="-1";
                  layout_height="-2";
                  gravity="right|center";
                  layout_marginBottom="24dp";
                  {
                    CardView;
                    layout_width="-2";
                    layout_height="-2";
                    radius="2dp";
                    background="#00000000";
                    layout_marginTop="8dp";
                    layout_marginLeft="8dp";
                    layout_marginRight="24dp";
                    layout_marginBottom="24dp";
                    Elevation="0";
                    onClick=function()
                      if not dukfh then
                        dukfh=true
                        pcall(function()
                          imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE);
                          imm.hideSoftInputFromWindow(an1.getWindow().getDecorView().getWindowToken(), 0);
                        end)
                        dc2.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
                          onAnimationEnd=function()
                            an1.hide()
                            QJDJ=false
                            dukfh=false
                          end}))
                      end
                    end;
                    {
                      TextView;
                      layout_width="-1";
                      layout_height="-2";
                      textSize="14sp";
                      paddingRight="16dp";
                      paddingLeft="16dp";
                      paddingTop="8dp";
                      paddingBottom="8dp";
                      Text="取消";
                      textColor=圆图字体颜色;
                      BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
    dl1=AlertDialog.Builder(activity)
    dl1.setView(loadlayout(dann1))
    if gb then
      dl1.setCancelable(false)
    end

    dukfh=false


    --点击空白
    dl1.setOnCancelListener(function(...)
      QJDJ=false
    end)

    an1=dl1.show()
    window1 = an1.getWindow();
    window1.setBackgroundDrawable(ColorDrawable(0x00ffffff));
    wlp1 = window1.getAttributes();
    wlp1.gravity = Gravity.BOTTOM;
    wlp1.width = WindowManager.LayoutParams.MATCH_PARENT;
    wlp1.height = WindowManager.LayoutParams.WRAP_CONTENT;
    window1.setAttributes(wlp1);
    an1.getWindow().setSoftInputMode(0x20)
    --  an.getWindow().setSoftInputMode(0x10)
    dc2.startAnimation(Translate_up_down)
    wb.loadUrl(LJ)--加载网页
    --设置出现缩放工具
    wb.getSettings().setSupportZoom(true);
    --设置出现缩放工具
    wb.getSettings().setBuiltInZoomControls(true);
    --扩大比例的缩放
    wb.getSettings().setUseWideViewPort(true);

    wb.requestFocusFromTouch()--设置支持获取手势焦点
    --支持JS(建议无论如何加上)
    webSettings = wb.getSettings();

    wb.Settings.setJavaScriptEnabled(true);

    --状态监听
    wb.setWebViewClient{
      shouldOverrideUrlLoading=function(view,url)
        --Url即将跳转
      end,
      onPageStarted=function(view,url,favicon)
        --网页加载
      end,
      onPageFinished=function(view,url)
        --网页加载完成
      end}

    --网页与返回键之间的交互
    function onKeyDown(keyCode,event)
      if (keyCode == KeyEvent.KEYCODE_BACK && wv.canGoBack())then
        wv.goBack()
        return true
       else
        --AlertDialog监听返回
        dl1.setOnKeyListener(function(id,k,t)
          if k==4 then
            local dlt=t.getAction()
            if dlfh and dlt==1 then
              dlfh=nil
              --输入法消失
              return true
             else--布局消失
              if dlt==0 || not dlfh then
                dlfh=true
              end
              if dlt==0 then
                if not dukfh then
                  dukfh=true
                  dc2.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
                    onAnimationEnd=function()
                      an1.hide()
                      QJDJ=false
                      dukfh=false
                    end}))
                  return true
                end
              end
            end
          end
        end)
      end
      return false
    end

    手势滑动(an1,ztbj,500)
    if str then
      str()
    end
  end)
end


function 自动扒站(url,str)
  网络判断(function()提示("没有网络（ '▿ ' ）",3)end,function()
    local u="https://api.handsl.cn/app/api.php?api=dedecms&web="..url
    Http.get(u,function(a,b)
      if a==200 then
        if not pcall(function()
            local d=cjson.decode(b)
            local 链接=d["url"]
            str(链接)
          end) then
          提示("发生错误ヾ(❀╹◡╹)ﾉ~",3)
        end
      end
    end)
  end)
end


function 获取文件最后修改时间(path)
  f = File(path);
  cal = Calendar.getInstance();
  time = f.lastModified()
  cal.setTimeInMillis(time);
  return cal.getTime().toLocaleString()
end

function 获取文件大小(path)
  size=File(tostring(path)).length()
  Sizes=Formatter.formatFileSize(activity, size)
  return Sizes
end

function 统计字符(str)
  local len = #str;
  local left = len;
  local cnt = 0;
  local arr={0,0xc0,0xe0,0xf0,0xf8,0xfc};
  while left ~= 0 do
    local tmp=string.byte(str,-left);
    local i=#arr;
    while arr[i] do
      if tmp>=arr[i] then left=left-i;break
      end
      i=i-1;
    end
    cnt=cnt+1;
  end
  return cnt;
end