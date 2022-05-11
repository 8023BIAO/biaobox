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

import "android.media.MediaPlayer"

import "android.provider.Settings"
import "android.provider.MediaStore"
import "android.provider.Settings$Secure"

import "android.transition.Visibility"

import "android.util.Base64"
import "android.util.Config"
import "android.util.DisplayMetrics"

import "android.location.LocationManager"

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
import "SnakeBar"

destring=function()
  minicrypto = {}
  local insert, concat, modf, tostring, char = table.insert, table.concat, math.modf, tostring, string.char
  local function numberToBinStr(x)
    local ret = {}
    while x~=1 and x~=0 do
      insert(ret, 1, x%2)
      x=modf(x/2)
    end
    insert(ret, 1, x)
    for i = 1, 8 - #ret do
      insert(ret, 1, 0)
    end
    return concat(ret)
  end

  local function computeBinaryKey(str)
    local t = {}
    for i = #str, 1, -1 do
      insert(t, numberToBinStr(str:byte(i,i)))
    end
    return concat(t)
  end

  local binaryKeys = setmetatable({}, {__mode = "k"})

  local function binaryKey(key)
    local v = binaryKeys[key]
    if v == nil then
      v = computeBinaryKey(key)
      binaryKeys[key] = v
    end
    return v
  end

  local function initialize_state(key)
    local S = {}; for i = 0, 255 do S[i] = i end
    key = binaryKey(key)

    local j = 0
    for i = 0, 255 do
      local idx = (i % #key) +1
      j = (j + S[i] + tonumber(key:sub(idx, idx))) % 256
      S[i], S[j] = S[j], S[i]
    end
    S.i = 0
    S.j = 0
    return S
  end

  local function encrypt_one(state, byt)
    state.i = (state.i+1) % 256
    state.j = (state.j + state[state.i]) % 256
    state[state.i], state[state.j] = state[state.j], state[state.i]
    local K = state[(state[state.i] + state[state.j]) % 256]
    return K ~ byt
  end


  --加
  function minicrypto.encrypt(text, key)
    local state = initialize_state(key)
    local encrypted = {}
    for i = 1, #text do
      encrypted[i] = ("%02X"):format(encrypt_one(state, text:byte(i,i)))
    end
    return concat(encrypted)
  end
  --解
  function minicrypto.decrypt(text, key)
    local state = initialize_state(key)
    local decrypted = {}
    for i = 1, #text, 2 do
      insert(decrypted, char(encrypt_one(state, tonumber(text:sub(i, i+1), 16))))
    end
    return concat(decrypted)
  end

end




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

现在时间=os.date("%Y-%m-%d %H:%M:%S")

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


function 跳转应用设置界面(包名)
  intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
  intent.setData(Uri.parse("package:"..包名))--// 根据包名打开对应的设置界面
  activity.startActivity(intent)
end


function 复制文本(a)
  activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(tostring(a))
end

function 转0x(j)
  if #j==7 then
    return tonumber("0xff"..j:match("#(.+)"))
   else
    return tonumber("0x"..j:match("#(.+)"))
  end
end

function dp2px(dpValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return dpValue * scale + 0.5
end

function px2dp(pxValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return pxValue / scale + 0.5
end

function px2sp(pxValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity;
  return pxValue / scale + 0.5
end

function sp2px(spValue)
  local scale = activity.getResources().getDisplayMetrics().scaledDensity
  return spValue * scale + 0.5
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
function 文件下载(url,path,name)
  --调用系统下载
  downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
  url=Uri.parse(url);
  request=DownloadManager.Request(url);
  request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
  request.setDestinationInExternalPublicDir(path,name);
  request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
  downloadManager.enqueue(request);
end

function 网络判断(a,b)
  local wl=activity.getApplicationContext().getSystemService(Context.CONNECTIVITY_SERVICE).getActiveNetworkInfo();
  if not wl then
    a()
   else
    xpcall(function()b()end,function(e)    
      提示("发生错误(づ◡ど)\n"..e,3)
    end)
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
        pcall(function()
          activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
        end)
      end
      --提示("再按一次返回键退出",nil,"18dp")
      shijian=tonumber(os.time())
      return true
    end
  end
end


function 文字加密(text,key)
  destring()
  return minicrypto.encrypt(text, key)
end


function 文字解码(text,key)
  destring()
  return minicrypto.decrypt(text,key)
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


function 下载2(title,url,path,colour)
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
          typeface=Typeface.DEFAULT_BOLD,
          layout_margin="15dp",
          textColor="#ff000000",
          textSize="20sp",
        },
        {
          TextView,
          id="appdowninfo",
          text="已下载：0MB/0MB\n下载状态：准备下载",
          --id="显示信息",
          typeface=Typeface.MONOSPACE,
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
            typeface=Typeface.MONOSPACE,
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
  软件内下载(title,url,path,colour)
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

function 获取文件最后修改时间(path)
  f = File(path);
  cal = Calendar.getInstance();
  time = f.lastModified()
  cal.setTimeInMillis(time);
  return cal.getTime().toLocaleString()
end

function 高斯模糊(id,tp,radius1,radius2)
  function blur( context, bitmap, blurRadius)
    renderScript = RenderScript.create(context);
    blurScript = ScriptIntrinsicBlur.create(renderScript, Element.U8_4(renderScript));
    inAllocation = Allocation.createFromBitmap(renderScript, bitmap);
    outputBitmap = bitmap;
    outAllocation = Allocation.createTyped(renderScript, inAllocation.getType());
    blurScript.setRadius(blurRadius);
    blurScript.setInput(inAllocation);
    blurScript.forEach(outAllocation);
    outAllocation.copyTo(outputBitmap);
    inAllocation.destroy();
    outAllocation.destroy();
    renderScript.destroy();
    blurScript.destroy();
    return outputBitmap;
  end
  function zoomBitmap(bitmap,scale)
    w = bitmap.getWidth();
    h = bitmap.getHeight();
    matrix = Matrix();
    matrix.postScale(scale, scale);
    bitmap = Bitmap.createBitmap(bitmap, 0, 0, w, h, matrix, true);
    return bitmap;
  end
  function blurAndZoom(context,bitmap,blurRadius,scale)
    return zoomBitmap(blur(context,zoomBitmap(bitmap, 1 / scale), blurRadius), scale);
  end
  id.setImageBitmap(blurAndZoom(activity,tp,radius1,radius2))
end
--[[
高斯模糊(id,tp,radius1,radius2)
radius1 范围：1-25
radius2 范围：1-？(据图片而定太大报错)
]]

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

function web屏蔽(id,...)
  local s={...}
  local d=#s
  for i=1,d do
    local idd=s[i]
    local vdata=[[document.querySelector('.]]..idd..[[').style.display="none";]]
    id.loadUrl([[
      javascript:(function()
        { ]]..vdata..[[ })()
      ]]);
  end
end

function 模拟滑动(keyCode)
  xpcall(function()
    Runtime.getRuntime().exec("input swipe " .. keyCode)
  end,function(e)
    提示(e)
  end)
end

function 模拟输入(keyCode)
  xpcall(function()
    Runtime.getRuntime().exec("input text " .. keyCode)
  end,function(e)
    提示(e)
  end)
end

function 模拟点击(keyCode)
  xpcall(function()
    Runtime.getRuntime().exec("input tap " .. keyCode)
  end,function(e)
    提示(e)
  end)
end

function adb_shell(str,callback)
  local cmd=str
  local cmd=String(cmd)
  --local pbs= Runtime.getRuntime().exec(cmd)
  xpcall(function()

    local pbs= ProcessBuilder(cmd).start()

    xpcall(function()
      local br = BufferedReader(InputStreamReader(pbs.getInputStream()))

      BFRL=true
      while (BFRL) do
        local dbfr=br.readLine ()
        if dbfr then
          callback(dbfr)
          dbfr=nil
         else
          BFRL=nil
          dbfr=nil
        end
      end
      br.close();
    end,function(e)
      提示(e,3)
    end)

  end,function(e)
    提示(e,3)
  end)
end


--点击某一个视图
function 点击视图(view,ti, x, y)
  local downTime = SystemClock.uptimeMillis();--系统开机时间
  local downEvent = MotionEvent.obtain(downTime, downTime,MotionEvent.ACTION_DOWN, x, y, 0);
  local downTime =downTime+ti;
  local upEvent = MotionEvent.obtain(downTime, downTime,MotionEvent.ACTION_UP, x, y, 0);
  view.onTouchEvent(downEvent);--按下
  view.onTouchEvent(upEvent);--抬起
  downEvent,upEvent,downTime=nil
end
--点击视图(activity.getWindow().getDecorView(),100,50,50)


function 获取当前活动()
  pcall(function()
    local mam=activity.getSystemService(Context.ACTIVITY_SERVICE)
    local name=mam.getRunningTasks(1).get(0).topActivity.getClassName();
    return name
  end)
end


function 判断无障碍是否开启()
  local am = activity. getSystemService(Context.ACCESSIBILITY_SERVICE);
  --[[if (am.isEnabled()) then


   else
    --跳转无障碍
 --activity.startActivity( Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS));
  end]]
  return am.isEnabled()
end

function 设置窗口动画(a,b)
  return activity.overridePendingTransition(a,b)
end

function 悬浮窗(buj,bt,xbfbuj,str)
  -- 检查是否已经授予权限，大于6.0的系统适用，小于6.0系统默认打开，无需理会
  if Build.VERSION.SDK_INT >= 23 and Settings.canDrawOverlays(this)~=true then
    -- 没有权限，需要申请权限，因为是打开一个授权页面，所以拿不到返回状态的，所以建议是在onResume方法中从新执行一次校验
    --  intent=Intent()
    intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
    intent.setData(Uri.parse("package:" ..软件包名));
    activity.startActivity(Intent(intent))
   else
    if not XFC then
      XFC=true
      minlay={
        LinearLayout,
        layout_width="-2",
        layout_height="-2",
        {
          CardView,
          layout_width="35dp",
          layout_height="35dp",
          background="#66ccff",
          layout_margin="6dp",
          radius="50dp",
          CardElevation="3dp",
          id="Win_minWindow",
        },
      }

      centerView={
        RelativeLayout,
        id="win_centerview",
        layout_weight="1",
        layout_height="-1",
        buj;
      }

      winlay={
        LinearLayout,
        layout_width="-1",
        layout_height="-1",
        {
          CardView,
          id="win_mainview",
          layout_width=activity.getWidth()/1.5,
          layout_height=activity.getHeight()/2.5,
          layout_margin="5dp",
          CardElevation="5dp",
          {
            LinearLayout,
            layout_width="-1",
            layout_height="-1",
            orientation="vertical",
            {
              CardView,
              layout_width="-1",
              layout_height="30dp",
              background="#ffffff",
              radius=0,
              {
                LinearLayout,
                layout_width="-1",
                layout_height="-1",
                {
                  LinearLayout,
                  layout_weight="1",
                  layout_height="-1",
                  {
                    TextView,
                    text=bt,
                    id="win_move",
                    layout_width="-1",
                    layout_height="-1",
                    paddingLeft="5dp",
                    gravity="left|center",
                    textColor="#0",
                    singleLine=true,
                  },
                },

                {
                  RippleLayout,
                  layout_height="-1",
                  layout_width="-2",
                  rippleColor="#50555555",
                  {
                    TextView,
                    gravity="center",
                    layout_width="-1",
                    layout_height="-1",
                    padding="3dp",
                    textColor="#0",
                    text="焦点off",
                    id="win_focus",
                  },
                },
                {
                  RippleLayout,
                  layout_height="-1",
                  layout_width="-2",
                  rippleColor="#50555555",
                  {
                    TextView,
                    gravity="center",
                    layout_width="-1",
                    layout_height="-1",
                    padding="3dp",
                    textColor="#0",
                    text="最小化",
                    onClick="changeWindow",
                  },
                },
                {
                  RippleLayout,
                  layout_height="-1",
                  layout_width="30dp",
                  rippleColor="#50555555",
                  {
                    ImageView,
                    layout_width="-1",
                    layout_height="-1",
                    scaleType="centerCrop",
                    padding="3dp",
                    src="res/icon/close.png",
                    ColorFilter="#0",
                    onClick="close",
                  },
                },
              },
            },
            centerView, --这里是悬浮窗中间的布局
            {
              CardView,
              layout_width="-1",
              layout_height="30dp",
              background="#ffffff",
              radius=0,
              {
                LinearLayout,
                layout_width="-1",
                layout_height="-1",
                {
                  LinearLayout,
                  layout_height="-1",
                  layout_weight="1",
                },
                xbfbuj;
                {
                  ImageView,
                  id="win_worh",
                  layout_width="30dp",
                  layout_height="-1",
                  paddingBottom="6dp",
                  paddingRight="6dp",
                  scaleType="centerCrop",
                  src="res/icon/horw.png",
                  ColorFilter="#0",
                },
              },
            },
          },
        },
      }


      wmManager=activity.getSystemService(Context.WINDOW_SERVICE) --获取窗口管理器
      HasFocus=false --是否有焦点
      wmParams =WindowManager.LayoutParams() --对象
      wmParams.type =WindowManager.LayoutParams.TYPE_SYSTEM_ALERT --设置悬浮窗方式

      wmParams.format =PixelFormat.RGBA_8888 --设置背景
      wmParams.flags=WindowManager.LayoutParams().FLAG_NOT_FOCUSABLE--焦点设置
      wmParams.gravity = Gravity.LEFT| Gravity.TOP --重力设置
      wmParams.x = activity.getWidth()/6
      wmParams.y = activity.getHeight()/5
      wmParams.width =WindowManager.LayoutParams.WRAP_CONTENT
      wmParams.height =WindowManager.LayoutParams.WRAP_CONTENT

      mainWindow=loadlayout(winlay)
      minWindow=loadlayout(minlay)

      function showWindow() --显示
        if HasLaunch==true then
          return
         else
          HasLaunch=true
          pcall(function()
            wmManager.addView(mainWindow,wmParams)
          end)
        end
      end

      function close(v) --关闭
        HasLaunch=false
        wmManager.removeView(mainWindow)
        wmParams=nil
        mainWindow=nil
        wmManager=nil
        XFC=nil
      end

      isMax=true --状态

      function changeWindow()
        if isMax==false then
          isMax=true
          wmManager.removeView(minWindow)
          wmManager.addView(mainWindow,wmParams)
         else
          isMax=false
          wmManager.removeView(mainWindow)
          wmManager.addView(minWindow,wmParams)
        end
      end

      function Win_minWindow.onClick(v)
        changeWindow()
      end


      function Win_minWindow.OnTouchListener(v,event) --移动
        if event.getAction()==MotionEvent.ACTION_DOWN then
          firstX=event.getRawX()
          firstY=event.getRawY()
          wmX=wmParams.x
          wmY=wmParams.y
         elseif event.getAction()==MotionEvent.ACTION_MOVE then
          wmParams.x=wmX+(event.getRawX()-firstX)
          wmParams.y=wmY+(event.getRawY()-firstY)
          wmManager.updateViewLayout(minWindow,wmParams)
         elseif event.getAction()==MotionEvent.ACTION_UP then
          --changeWindow()
        end
        return false
      end

      --移动
      function win_move.OnTouchListener(v,event) --移动
        if event.getAction()==MotionEvent.ACTION_DOWN then
          firstX=event.getRawX()
          firstY=event.getRawY()
          wmX=wmParams.x
          wmY=wmParams.y
         elseif event.getAction()==MotionEvent.ACTION_MOVE then
          wmParams.x=wmX+(event.getRawX()-firstX)
          wmParams.y=wmY+(event.getRawY()-firstY)
          wmManager.updateViewLayout(mainWindow,wmParams)
         elseif event.getAction()==MotionEvent.ACTION_UP then
        end
        return true
      end


      --放大缩小
      winParams=win_mainview.getLayoutParams() --获取params
      function win_worh.OnTouchListener(v,event) --放大缩小
        if event.getAction()==MotionEvent.ACTION_DOWN then
          firstX=event.getRawX()
          firstY=event.getRawY()
          wmX=winParams.width
          wmY=winParams.height
         elseif event.getAction()==MotionEvent.ACTION_MOVE then

          winParams.width=wmX+(event.getRawX()-firstX)
          winParams.height=wmY+(event.getRawY()-firstY)
          win_mainview.setLayoutParams(winParams)

         elseif event.getAction()==MotionEvent.ACTION_UP then
        end
        return true
      end


      function win_focus.onClick() --焦点开关
        if HasFocus==false then
          HasFocus=true
          win_focus.Text="焦点on"
          wmParams.flags=WindowManager.LayoutParams().FLAG_NOT_TOUCH_MODAL
          wmManager.updateViewLayout(mainWindow,wmParams) --用于刷新
         else
          HasFocus=false
          win_focus.Text="焦点off"
          wmParams.flags=WindowManager.LayoutParams().FLAG_NOT_FOCUSABLE
          wmManager.updateViewLayout(mainWindow,wmParams)
        end
      end

      showWindow() --显示

      if str then
        str()
      end
    end
  end
end




通知栏=function(bt,xbt)
  mBuilder = Notification.Builder(this);
  --设置状态栏通知图标
  mBuilder.setSmallIcon(R.drawable.icon)--设置图标
  --设置通知栏图标
  --  mBuilder.setLargeIcon(BitmapFactory.decodeResource(activity.getResources(),R.drawable.welcome))
  mBuilder.setContentTitle(bt)--大标
  mBuilder.setContentText(xbt)--小标

  mBuilder.setAutoCancel(true);--设置这个标志当用户单击面板就可以让通知将自动取消
  --        mBuilder.setDefaults( Notification.DEFAULT_SOUND | Notification.DEFAULT_VIBRATE) --使用默认震动
  notificationManager =activity.getSystemService(Context.NOTIFICATION_SERVICE)
  notificationIntent = Intent("android.intent.action.VIEW");
  notificationIntent.setClassName(this.getPackageName(),"com.androlua.Welcome")
  pendingIntent = PendingIntent.getActivity(activity.getApplicationContext(), 0, notificationIntent, Intent.FLAG_ACTIVITY_NEW_TASK);
  mBuilder.setContentIntent(pendingIntent).setAutoCancel(false)
  notificationManager.notify(1, mBuilder.build()) --发送通知
  --notificationManager.cancel(1);                       --关闭通知
end


function getactivity()--获取当前活动
  xpcall(function()
    local activityManager=activity.getSystemService(Context.ACTIVITY_SERVICE);
    local runningActivity=activityManager.getRunningTasks(1).get(0).topActivity.getClassName();
    return runningActivity
  end,function(e)
    return "nil"
  end)
end


--旋转bitmap(bitmap,角度)
function rotateBitmap(origin, alpha)
  local width = origin.getWidth();
  local height = origin.getHeight();
  local matrix = Matrix();
  matrix.setRotate(alpha);
  -- 围绕原地进行旋转
  local newBM = Bitmap.createBitmap(origin, 0, 0, width, height, matrix, false);
  if (newBM.equals(origin)) then
    return newBM;
  end
  origin.recycle();
  return newBM;
end
--按比例缩放
function scaleBitmap( origin, ratio)
  local width = origin.getWidth();
  local height = origin.getHeight();
  local matrix = Matrix();
  matrix.preScale(ratio, ratio);
  local newBM = Bitmap.createBitmap(origin, 0, 0, width, height, matrix, false);
  if (newBM.equals(origin)) then
    return newBM;
  end
  origin.recycle();
  return newBM;
end

function 自动检测键盘()
  pcall( function()--关闭就打开，打开就关闭
    activity. getSystemService(activity.getBaseContext().INPUT_METHOD_SERVICE).toggleSoftInput(0, InputMethodManager.HIDE_NOT_ALWAYS);
  end)
end

function 判断程序是否在白名单()
  local powerManager = activity.getSystemService(Context.POWER_SERVICE);
  if powerManager then
    local isIgnoring = powerManager.isIgnoringBatteryOptimizations(activity.getPackageName());
    return isIgnoring;
   else
    return false
  end
end

function 程序申请白名单()
  pcall(function()
    intent = Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS);
    intent.setData(Uri.parse("package:" .. tostring(activity.getPackageName())));
    activity.startActivity(intent);
  end)
end

function 翻译(str,cl)
  local str=tostring(str)
  local systenTime=System.currentTimeMillis();
  local data="from=auto&to=zh-CHS&text="..str.."&fr=fanyiapp_android_text&index="..systenTime.."&uuid=&requestId="..systenTime.."&isReturnPhonetic=on"
  Http.post("http://fanyi.sogou.com/reventondc/multiLangTranslate",tostring(data),function(code,con)
    if code==200 and con then
      local jieg=con:match([[dit":"(.-)","]])
      cl(jieg)
    end
  end)
end

function ping(ipAddress,ci,callback)
  local pro = Runtime.getRuntime().exec("ping -c "..ci.." " .. ipAddress)
  local buf = BufferedReader( InputStreamReader(pro.getInputStream()))
  local ege = Runtime.getRuntime().exec("ping -c 3 "..ipAddress)
  local bfo=ege.waitFor(); --0正常，其他异常
  callback(buf.readLine ().." "..bfo)
  BFRL=true
  while (BFRL) do
    local dbfr=buf.readLine ()
    if dbfr then
      callback(dbfr)
      dbfr=nil
     else
      BFRL=nil
      dbfr=nil
    end
  end
  buf.close();
end

function 使用系统TTS语音播报(yd,ys,str)
  import "android.speech.tts.*"
  mTextSpeech = TextToSpeech(activity, TextToSpeech.OnInitListener{
    onInit=function(status)
      --如果装载TTS成功
      if (status == TextToSpeech.SUCCESS)
        result = mTextSpeech.setLanguage(Locale.CHINESE);
        --[[LANG_MISSING_DATA-->语言的数据丢失
          LANG_NOT_SUPPORTED-->语言不支持]]
        if (result == TextToSpeech.LANG_MISSING_DATA or result == TextToSpeech.LANG_NOT_SUPPORTED)
          --不支持中文
          提示("您的手机不支持中文语音播报功能。");
          result = mTextSpeech.setLanguage(Locale.ENGLISH);
          if (result == TextToSpeech.LANG_MISSING_DATA or result == TextToSpeech.LANG_NOT_SUPPORTED)
            --不支持中文和英文
            提示("您的手机不支持语音播报功能。");
           else
            --不支持中文但支持英文
            --语调,1.0默认
            mTextSpeech.setPitch(yd);
            --语速,1.0默认
            mTextSpeech.setSpeechRate(ys);
            mTextSpeech.speak(str, TextToSpeech.QUEUE_FLUSH, nil);
          end
         else
          --支持中文
          --语调,1.0默认
          mTextSpeech.setPitch(yd);
          --语速,1.0默认
          mTextSpeech.setSpeechRate(ys);
          mTextSpeech.speak(str, TextToSpeech.QUEUE_FLUSH, nil);
        end
      end
    end
  });
end

function 颜色字体(t,c)
  local sp = SpannableString(t)
  sp.setSpan(ForegroundColorSpan(c),0,#sp,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
  return sp
end

--自动主题
function switchtheme(pattern,layout,statusBarColor)--主题模式(不填则自动)、布局表(aly文件路径或表)
  local h=tonumber(os.date("%H"))

  if Build.VERSION.SDK_INT >= 21 then

    if pattern == "白天" then
      activity.setTheme(android.R.style.Theme_DeviceDefault_Light_NoActionBar)

     elseif pattern == "夜间" then
      activity.setTheme(android.R.style.Theme_Material_NoActionBar)
     else

      if h<=6 or h>=22 then--夜间
        activity.setTheme(android.R.style.Theme_Material_NoActionBar)
       else
        activity.setTheme(android.R.style.Theme_DeviceDefault_Light_NoActionBar)

      end

    end

   else

    if pattern == "白天" then
      activity.setTheme(android.R.style.Theme_Holo_Light)

     elseif pattern == "夜间" then
      activity.setTheme(android.R.style.Theme_Holo)
     else
      if h<=6 or h>=22 then
        activity.setTheme(android.R.style.Theme_Holo)
       else
        activity.setTheme(android.R.style.Theme_Holo_Light)

      end
    end
  end

  if layout~=nil then
    activity.setContentView(loadlayout(layout))
  end


end

--分享
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

graph={}
function graph.Ripple(id,color,t)
  local ripple
  if t=="圆" or t==nil then
    if not(RippleCircular) then
      RippleCircular=activity.obtainStyledAttributes({android.R.attr.selectableItemBackgroundBorderless}).getResourceId(0,0)
    end
    ripple=RippleCircular
   elseif t=="方" then
    if not(RippleSquare) then
      RippleSquare=activity.obtainStyledAttributes({android.R.attr.selectableItemBackground}).getResourceId(0,0)
    end
    ripple=RippleSquare
  end
  local Pretend=activity.Resources.getDrawable(ripple)
  if id then
    id.setBackground(Pretend.setColor(ColorStateList(int[0].class{int{}},int{color})))
   else
    return Pretend.setColor(ColorStateList(int[0].class{int{}},int{color}))
  end
end

function 打开程序(app)
  lan = activity.getPackageManager().getLaunchIntentForPackage(app);
  intent = Intent(Intent.ACTION_MAIN);
  intent.addCategory(Intent.CATEGORY_LAUNCHER);
  intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
  intent.setComponent(lan.getComponent());
  activity.startActivity(intent);
end

