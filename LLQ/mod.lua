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


--????????????
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

--?????????
pcall(function()
  import "android.hardware.*"
  import "android.hardware.Sensor"
  import "android.hardware.SensorEventListener"
  import "android.hardware.SensorManager"
end)
import "base64"
--java???

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

--???????????????
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


  --???
  function minicrypto.encrypt(text, key)
    local state = initialize_state(key)
    local encrypted = {}
    for i = 1, #text do
      encrypted[i] = ("%02X"):format(encrypt_one(state, text:byte(i,i)))
    end
    return concat(encrypted)
  end
  --???
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
????????????=activity.getPackageName()
--?????????
???????????????=activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen")().status_bar_height)
--?????????,???????????????
statusBarHeight=activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen").status_bar_height)

???????????????=activity.getResources().getDimensionPixelSize(luajava.bindClass("com.android.internal.R$dimen").navigation_bar_height)
--??????
?????? = Build.MODEL
--SDK??????
SDK?????? = tonumber(Build.VERSION.SDK)
--????????????
???????????? = Build.VERSION.RELEASE
--ROM??????
ROM?????? = string.upper(Build.MANUFACTURER)
--?????????
???????????????=activity.getWidth()
--???????????????
???????????????=activity.getHeight()

????????????=os.date("%Y-%m-%d %H:%M:%S")

function ????????????()
  imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
  isOpen=imm.isActive()
  return isOpen==true or false
end

function ????????????()
  activity.getSystemService(INPUT_METHOD_SERVICE).hideSoftInputFromWindow(WidgetSearchActivity.this.getCurrentFocus().getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS)
end

function ????????????(id)
  activity.getSystemService(INPUT_METHOD_SERVICE).showSoftInput(id, 0)
end

function toast(str)
  str=tostring(str)
  --??????Toast
  Toast.makeText(activity,str,Toast.LENGTH_SHORT).show()
end

function ????????????(layout)
  return activity.setContentView(loadlayout(layout))
end

--??????IMEI
function ??????IMEI()
  return activity.getSystemService(Context.TELEPHONY_SERVICE).getDeviceId()
end
function ??????????????????()
  return (Environment.getExternalStorageDirectory().toString())
end

function ??????????????????()
  --?????????????????????setContentView()?????????????????????????????????????????????????????????
  --??????????????????
  return activity.getWindow().setFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON, WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
end


function ????????????(??????)
  local ????????????=io.open(??????):read("*a")
  return ????????????--return???????????????
end
--?????????????????????
function ????????????(??????,??????)
  f=File(tostring(File(tostring(??????)).getParentFile())).mkdirs()
  io.open(tostring(??????),"w+b"):write(tostring(??????)):close()
end

function ????????????2(????????????,??????)
  --  f=File(tostring(File(tostring(??????)).getParentFile())).mkdirs()
  io.open(????????????,"w"):write(??????):close()
end

function ????????????(name,str)
  return this.setSharedData(name,str)
end

function ????????????(name)
  return this.getSharedData(name)
end

function ?????????????????????()
  -- ???????????????????????????????????????6.0????????????????????????6.0?????????????????????????????????
  if Build.VERSION.SDK_INT >= 23 and Settings.canDrawOverlays(this)~=true then
    -- ???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????onResume?????????????????????????????????
    --  intent=Intent()
    intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
    intent.setData(Uri.parse("package:" .. ????????????));
    activity.startActivity(Intent(intent))
  end
end

function ??????????????????(name)
  --????????????,0?????????-1??????
  permission = ActivityCompat.checkSelfPermission(activity, Manifest.permission.WRITE_EXTERNAL_STORAGE);
  --???????????????????????????
  if permission~=0 then
    intent=Intent()
    intent.setAction(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
    intent.setData(Uri.parse("package:" .. name));
    activity.startActivity(Intent(intent))
  end

end

--??????????????????
function ??????????????????()
  mTelephonyManager = activity.getSystemService(Context.TELEPHONY_SERVICE);
  phoneNumber = mTelephonyManager.getLine1Number();
  return phoneNumber
end

function ??????????????????()
  dm = DisplayMetrics();
  activity.getWindowManager().getDefaultDisplay().getMetrics(dm);
  diagonalPixels = Math.sqrt(Math.pow(dm.widthPixels, 2) + Math.pow(dm.heightPixels, 2));
  return diagonalPixels / (160 * dm.density);
end


?????????????????????=function()
  return Secure.getString(activity.getContentResolver(), Secure.ANDROID_ID)
end

????????????????????????=function()

  data = Environment.getDataDirectory();
  sf = StatFs(data.getPath());

  availableBlocks = sf.getAvailableBlocks();
  ?????????????????????=availableBlocks

  blockCount = sf.getBlockCount();
  ??????????????????=blockCount

  --????????????
  size = sf.getBlockSize();
  ???????????????=size

  --????????????
  totalSize = blockCount * size;
  ?????????=totalSize

  --????????????
  availableSize = availableBlocks * size;
  ????????????=availableSize

  --?????????
  ???????????????GB=tointeger(?????????/1024/1024/1024)--GB
  ??????????????????GB=tointeger(????????????/1024/1024)--MB

  --[[???
???1. ??????Environment??????????????????????????????????????????

??????2. ??????StatFs?????????

??????3. ????????????????????????

??????4. ????????????????????????

??????5. ???????????????????????????]]
end


function ????????????????????????(??????)
  intent = Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
  intent.setData(Uri.parse("package:"..??????))--// ???????????????????????????????????????
  activity.startActivity(intent)
end


function ????????????(a)
  activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(tostring(a))
end

function ???0x(j)
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


function ??????????????????(archiveFilePath)
  pm = activity.getPackageManager()
  info = pm.getPackageInfo(archiveFilePath, PackageManager.GET_ACTIVITIES);
  if info ~= nil then
    appInfo = info.applicationInfo;
    appName = tostring(pm.getApplicationLabel(appInfo))
    packageName = appInfo.packageName; --???????????????
    version=info.versionName; --????????????
    icon = pm.getApplicationIcon(appInfo);--??????
  end
  return packageName,version,icon
end

--??????
function ????????????(t)
  return Typeface.createFromFile(File(activity.getLuaDir().."/res/ttf/"..t..".ttf"))
end

--??????
function ?????????(?????????,?????????)
  return math.random(?????????,?????????)
end

--?????????
function ???????????????(pageurl)
  viewIntent = Intent("android.intent.action.VIEW",Uri.parse(pageurl))
  activity.startActivity(viewIntent)
end

--????????????
function ????????????(??????)
  -- ActivityCompat.requestPermissions(this,??????,1)
  ActivityCompat.requestPermissions(this,String({Manifest.permission.??????}),1)
end
--????????????({Manifest.permission.WRITE_EXTERNAL_STORAGE})--?????????

function ???????????????()
  intent = Intent();
  intent.setComponent( ComponentName("com.tencent.mm", "com.tencent.mm.ui.LauncherUI"));
  intent.putExtra("LauncherUI.From.Scaner.Shortcut", true);
  intent.setFlags(335544320);
  intent.setAction("android.intent.action.VIEW");
  activity.startActivity(intent);
end

function ??????????????????()
  uri = Uri.parse("alipayqr://platformapi/startapp?saId=10000007");
  intent = Intent(Intent.ACTION_VIEW, uri);
  activity.startActivity(intent);
end

function QQ???(h)
  url="mqqapi://card/show_pslcard?src_type=internal&version=1&uin="..h.."&card_type=group&source=qrcode"
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
end

function QQ(h)
  url="mqqapi://card/show_pslcard?src_type=internal&source=sharecard&version=1&uin="..h
  activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
end

function ??????????????????(ym,cs)
  if cs then
    activity.newActivity(ym,android.R.anim.fade_in,android.R.anim.fade_out,cs)
   else
    activity.newActivity(ym,android.R.anim.fade_in,android.R.anim.fade_out)
  end
end


function ????????????(ym,cs)
  if cs then
    activity.newActivity(ym,cs)
   else
    activity.newActivity(ym)
  end
end

--??????
function ????????????(url,path,name)
  --??????????????????
  downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
  url=Uri.parse(url);
  request=DownloadManager.Request(url);
  request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
  request.setDestinationInExternalPublicDir(path,name);
  request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
  downloadManager.enqueue(request);
end

function ????????????(a,b)
  local wl=activity.getApplicationContext().getSystemService(Context.CONNECTIVITY_SERVICE).getActiveNetworkInfo();
  if not wl then
    a()
   else
    xpcall(function()b()end,function(e)    
      ??????("????????????(?????????)\n"..e,3)
    end)
  end
end

function ??????(t,c,bs)
  t=tostring(t)

  if c==nil then
    c="#A3212121"
   elseif c==3 then
    c="#A3E57373"--???
   elseif c==1 then
    c="#A390CAF9"--???
   elseif c==2 then
    c="#A3FBC02D"--???
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



--MD5??????
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
    --????????????????????????
    local fillSize = (448 - mod512) // 8
    if mod512 > 448 then
      fillSize = (960 - mod512) // 8
    end

    local rTab = {}

    --????????????byte???4??????????????????
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
    --??????????????????????????????4????????????
    --??????0x80???????????????
    local b0x80 = false
    local tLen = #rTab
    if byteIndex ~= 1 then
      rTab[tLen] = rTab[tLen] | 0x80 << (byteIndex - 1) * 8
      b0x80 = true
    end

    --????????????????????????
    for i = 1,fillSize // 4 do
      if not b0x80 and i == 1 then
        rTab[tLen + i] = 0x80
       else
        rTab[tLen + i] = 0x0
      end
    end

    --?????????????????????bit??????
    local bitLen = math.floor(len * 8)
    tLen = #rTab
    rTab[tLen + 1] = bitLen & 0xffffffff
    rTab[tLen + 2] = bitLen >> 32

    return rTab
  end

  --	Func:	??????MD5
  --	Param:	string
  --	Return:	string
  ---------------------------------------------

  function string.md5(s)
    --??????
    local fillTab = MD5StringFill(s)
    local result = {A,B,C,D}

    for i = 1,#fillTab // 16 do
      local a = result[1]
      local b = result[2]
      local c = result[3]
      local d = result[4]
      local offset = (i - 1) * 16 + 1
      --?????????
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

      --?????????
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

      --?????????
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

      --?????????
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

      --????????????????????????????????????
      result[1] = result[1] + a
      result[2] = result[2] + b
      result[3] = result[3] + c
      result[4] = result[4] + d
      result[1] = result[1] & 0xffffffff
      result[2] = result[2] & 0xffffffff
      result[3] = result[3] & 0xffffffff
      result[4] = result[4] & 0xffffffff
    end

    --???Hash????????????????????????????????????
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

function ??????(id,ti,...)
  view=id

  if ti==nil then
    ti=614614--?????????2??????
  end

  if {...}==nil then
    colorAnim = ObjectAnimator.ofInt(view,"backgroundColor",{...})
   else
    Color1=0xFFF44236--????????????
    Color2=0xFFEC407A--????????????
    Color3=0xFFFFC107--????????????
    Color4=0xFF2196F3--????????????
    Color5=0xFF8BC24A--????????????
    Color6=0xFF9C28B1--????????????
    Color7=0xffFFFF82--??????
    Color8=0xff000001--??????
    colorAnim = ObjectAnimator.ofInt(view,"backgroundColor",{Color1,Color2,Color3,Color4,Color5,Color6,Color7,Color8})
  end
  colorAnim.setDuration(ti)
  colorAnim.setEvaluator(ArgbEvaluator())
  colorAnim.setRepeatCount(ValueAnimator.INFINITE)
  colorAnim.setRepeatMode(ValueAnimator.REVERSE)
  colorAnim.start()
end


function ????????????(x)
  if x=="????????????"then
    activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_SENSOR)
   elseif x=="????????????"then
    activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_USER);
   elseif x=="????????????"then
    activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_SENSOR)
   elseif x=="????????????"then
    activity.setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_USER);
   elseif x=="??????"then
    activity.setRequestedOrientation(0);
   elseif x=="??????"
    activity.setRequestedOrientation(1);
   else
    ??????("??????",3)
  end
end

????????????=function()
  activity.startActivity(Intent().setAction(Settings.ACTION_ACCESSIBILITY_SETTINGS))
end

--???Biemap???????????????base64
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

--base64??????bitmap
function Base64ToBitmap(base64Data)
  bytes = Base64.decode(base64Data, Base64.DEFAULT);
  bit=BitmapFactory.decodeByteArray(bytes, 0, #bytes);
  return bit
end


------------------------------------------------------------------------------------------------------------------

????????????=function()
  local shijian=0
  function onKeyDown(code,event)
    if string.find(tostring(event),"KEYCODE_BACK") ~= nil then
      if shijian+2 > tonumber(os.time()) then
        activity.finish()--??????????????????
        pcall(function()
          activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
        end)
      end
      --??????("???????????????????????????",nil,"18dp")
      shijian=tonumber(os.time())
      return true
    end
  end
end


function ????????????(text,key)
  destring()
  return minicrypto.encrypt(text, key)
end


function ????????????(text,key)
  destring()
  return minicrypto.decrypt(text,key)
end

function ??????(id,lx,zdy)

  xpcall(function()
    for index,content in pairs(id) do
      if lx=="??????" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff})))
      end
      if lx=="??????" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3fffffff})))
      end
      if lx=="??????" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000})))
      end
      if lx=="??????" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{0x3f000000})))
      end
      if lx=="?????????" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{bwz})))
      end
      if lx=="?????????" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz})))
      end
      if lx=="????????????" then
        content.setBackgroundDrawable(activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{zdy})))
      end
      if lx=="????????????" then
        content.backgroundDrawable=(activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{zdy})))
      end
    end
  end,function(e)end)
end


function activity????????????(color2)

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



--?????????0??????0.5?????????1?????????
function setStatusBar(opacity)
  -- //api>21,??????????????????????????????;api>19,??????????????????????????????,opacity???0?????????0.5????????????1????????????
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

--?????????
function setNavBar(opacity)
  --  //api>21,??????????????????????????????;api>19,??????????????????????????????
  if (Build.VERSION.SDK_INT >= 21)then
    if(opacity==0)then
      window = activity.getWindow();
      window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
      window.getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_STABLE|View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN|View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION)--//???????????????????????????activity???????????????????????????????????????
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

function ???????????????()
  setNavBar(0)
end

function ???????????????()
  setStatusBar(0)
end


--//????????????????????????????????????????????????????????????????????????
function ???????????????()
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



function ????????????()
  --sdk19
  pcall(function()
    activity.setTheme(android.R.style.Theme_Material_Light_NoActionBar)
    activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
  end)
end


function ??????()
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
      --??????
      activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_FULLSCREEN)
      --???????????????
      activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION);

     elseif Build.VERSION.SDK_INT>24 then
      pcall(function()
        --???????????????????????????(sdk19?????????)
        activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION)
        --????????????
        activity.getWindow().setStatusBarColor(Color.TRANSPARENT)--??????????????????????????????
        activity.getWindow().setNavigationBarColor(Color.TRANSPARENT)--??????????????????????????????
        --???????????????
        activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION);
      end)
    end
  end)
end


function ????????????????????????????????????(a)
  if Build.VERSION.SDK_INT >= 21 then
    activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(a);
  end
end



function ?????????????????????()
  pcall(function()
    if SDK??????>=19 then
      ????????????()
      setStatusBar(0)
      setNavBar(0)
    end
  end)
end

function ???????????????()
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
end

function ?????????????????????(a)
  activity.getWindow().setNavigationBarColor(int(a));
end


function ??????(t)
  return Typeface.createFromFile(File(activity.getLuaDir().."/res/ttf/"..t..".ttf"))
end

function ????????????(id,ttf)
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

function ????????????(view,??????,??????,??????,??????,InsideColor)
  --  import "android.graphics.drawable.GradientDrawable"
  drawable = GradientDrawable()
  drawable.setShape(GradientDrawable.RECTANGLE)
  drawable.setColor(InsideColor)
  drawable.setCornerRadii({??????,??????,??????,??????,??????,??????,??????,??????});
  view.setBackgroundDrawable(drawable)
end

function ??????2(??????,??????)
  RippleHelper(??????).RippleColor=??????
end

function ????????????(??????,a,b,c,d,??????)
  import "android.animation.ObjectAnimator"
  ObjectAnimator().ofFloat(??????,"rotation",{a,b,c,d}).setDuration(??????).start()
end

function ????????????(??????,??????)
  import "android.animation.ObjectAnimator"
  ObjectAnimator().ofFloat(??????,"scaleX",{1,.8,1.3,.9,1}).setDuration(??????).start()
  ObjectAnimator().ofFloat(??????,"scaleY",{1,.8,1.3,.9,1}).setDuration(??????).start()
end

function ??????(col)
  --activity.supportActionBar.hide()
  activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
  activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LAYOUT_STABLE);
  --View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(col);
end

function ?????????(col)
  -- activity.supportActionBar.hide()
  activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
  activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN | View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR);
  activity.getWindow().addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS).setStatusBarColor(col);
end

????????????=function(bitmap)
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

function ????????????(bitmap,roundPx)
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
  canvas.drawRoundRect(rectf, roundPx, roundPx, paint); --?????????????????????????????????????????????
  paint.setXfermode(PorterDuffXfermode(PorterDuff.Mode.SRC_IN)); --??????????????????????????????????????????????????????????????????????????????
  canvas.drawBitmap(bitmap, rect, rect, paint); --???bitmap??????????????????
  return bitmapback;
end


function ??????2(title,url,path,colour)
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

  function ???????????????(title,url,path,colour)
    pcall(function()
      local ts=true
      appDownload(url,path)
      local ??????={
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
          text="????????????0MB/0MB\n???????????????????????????",
          --id="????????????",
          typeface=Typeface.MONOSPACE,
          layout_marginRight="15dp",
          layout_marginLeft="15dp",
          layout_marginBottom="15dp",
          textSize="15sp",
        },
        {
          ProgressBar,
          id="?????????",
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
            text="????????????",
            typeface=Typeface.MONOSPACE,
            id="????????????"
          },

        }
      }
      local dldown=AlertDialog.Builder(activity)
      .setView(loadlayout(??????))
      .show()
      .setCancelable(false)

      function ding(a,b)--?????????????????????(byte)
        appdowninfo.Text=string.format("%0.2f",a/1024/1024).."MB/"..string.format("%0.2f",b/1024/1024).."MB".."\n??????????????????????????????"
        ?????????.progress=(a/b*100)
      end

      function dstop(c)--?????????
        if ts then
          appdowninfo.Text="????????????????????????"..string.format("%0.2f",c/1024/1024).."MB"
          ????????????.setText("??????")
          luajava.clear(ts)
         else
          ??????("???????????????",1)
          luajava.clear(ts)
        end
      end

      ????????????.onClick=function()
        dldown.dismiss()
        luajava.clear(dldown,??????)
        ts=nil
        if ????????????.getText()=="????????????" then
          ??????("????????????...")
        end
      end

      if colour=="?????????" then
        appdownbg.setBackgroundColor(0xff424242)
        appdownsong.setTextColor(0xfffafafa)
        appdowninfo.setTextColor(0xffE0E0E0)
        ????????????.setTextColor(0xffE0E0E0)
      end
    end)
  end
  ???????????????(title,url,path,colour)
end

--bitmap??????,bitmap,1-25?????????,1-7???
--??????????????????
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

--bitmap??????,bitmap,1-25?????????
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

--bitmap??????
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

function ????????????(path)
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
  activity.startActivity(Intent.createChooser(intent, "?????????:"))
end

function ???????????????(a)
  intent = Intent()
  intent.setAction(Intent.ACTION_WEB_SEARCH)
  intent.putExtra(SearchManager.QUERY,a)
  activity.startActivity(intent)
end

function ??????????????????????????????(path)
  f = File(path);
  cal = Calendar.getInstance();
  time = f.lastModified()
  cal.setTimeInMillis(time);
  return cal.getTime().toLocaleString()
end

function ????????????(id,tp,radius1,radius2)
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
????????????(id,tp,radius1,radius2)
radius1 ?????????1-25
radius2 ?????????1-???(???????????????????????????)
]]

function ??????????????????(path)
  size=File(tostring(path)).length()
  Sizes=Formatter.formatFileSize(activity, size)
  return Sizes
end

function ????????????(str)
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

function web??????(id,...)
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

function ????????????(keyCode)
  xpcall(function()
    Runtime.getRuntime().exec("input swipe " .. keyCode)
  end,function(e)
    ??????(e)
  end)
end

function ????????????(keyCode)
  xpcall(function()
    Runtime.getRuntime().exec("input text " .. keyCode)
  end,function(e)
    ??????(e)
  end)
end

function ????????????(keyCode)
  xpcall(function()
    Runtime.getRuntime().exec("input tap " .. keyCode)
  end,function(e)
    ??????(e)
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
      ??????(e,3)
    end)

  end,function(e)
    ??????(e,3)
  end)
end


--?????????????????????
function ????????????(view,ti, x, y)
  local downTime = SystemClock.uptimeMillis();--??????????????????
  local downEvent = MotionEvent.obtain(downTime, downTime,MotionEvent.ACTION_DOWN, x, y, 0);
  local downTime =downTime+ti;
  local upEvent = MotionEvent.obtain(downTime, downTime,MotionEvent.ACTION_UP, x, y, 0);
  view.onTouchEvent(downEvent);--??????
  view.onTouchEvent(upEvent);--??????
  downEvent,upEvent,downTime=nil
end
--????????????(activity.getWindow().getDecorView(),100,50,50)


function ??????????????????()
  pcall(function()
    local mam=activity.getSystemService(Context.ACTIVITY_SERVICE)
    local name=mam.getRunningTasks(1).get(0).topActivity.getClassName();
    return name
  end)
end


function ???????????????????????????()
  local am = activity. getSystemService(Context.ACCESSIBILITY_SERVICE);
  --[[if (am.isEnabled()) then


   else
    --???????????????
 --activity.startActivity( Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS));
  end]]
  return am.isEnabled()
end

function ??????????????????(a,b)
  return activity.overridePendingTransition(a,b)
end

function ?????????(buj,bt,xbfbuj,str)
  -- ???????????????????????????????????????6.0????????????????????????6.0?????????????????????????????????
  if Build.VERSION.SDK_INT >= 23 and Settings.canDrawOverlays(this)~=true then
    -- ???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????onResume?????????????????????????????????
    --  intent=Intent()
    intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
    intent.setData(Uri.parse("package:" ..????????????));
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
                    text="??????off",
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
                    text="?????????",
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
            centerView, --?????????????????????????????????
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


      wmManager=activity.getSystemService(Context.WINDOW_SERVICE) --?????????????????????
      HasFocus=false --???????????????
      wmParams =WindowManager.LayoutParams() --??????
      wmParams.type =WindowManager.LayoutParams.TYPE_SYSTEM_ALERT --?????????????????????

      wmParams.format =PixelFormat.RGBA_8888 --????????????
      wmParams.flags=WindowManager.LayoutParams().FLAG_NOT_FOCUSABLE--????????????
      wmParams.gravity = Gravity.LEFT| Gravity.TOP --????????????
      wmParams.x = activity.getWidth()/6
      wmParams.y = activity.getHeight()/5
      wmParams.width =WindowManager.LayoutParams.WRAP_CONTENT
      wmParams.height =WindowManager.LayoutParams.WRAP_CONTENT

      mainWindow=loadlayout(winlay)
      minWindow=loadlayout(minlay)

      function showWindow() --??????
        if HasLaunch==true then
          return
         else
          HasLaunch=true
          pcall(function()
            wmManager.addView(mainWindow,wmParams)
          end)
        end
      end

      function close(v) --??????
        HasLaunch=false
        wmManager.removeView(mainWindow)
        wmParams=nil
        mainWindow=nil
        wmManager=nil
        XFC=nil
      end

      isMax=true --??????

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


      function Win_minWindow.OnTouchListener(v,event) --??????
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

      --??????
      function win_move.OnTouchListener(v,event) --??????
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


      --????????????
      winParams=win_mainview.getLayoutParams() --??????params
      function win_worh.OnTouchListener(v,event) --????????????
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


      function win_focus.onClick() --????????????
        if HasFocus==false then
          HasFocus=true
          win_focus.Text="??????on"
          wmParams.flags=WindowManager.LayoutParams().FLAG_NOT_TOUCH_MODAL
          wmManager.updateViewLayout(mainWindow,wmParams) --????????????
         else
          HasFocus=false
          win_focus.Text="??????off"
          wmParams.flags=WindowManager.LayoutParams().FLAG_NOT_FOCUSABLE
          wmManager.updateViewLayout(mainWindow,wmParams)
        end
      end

      showWindow() --??????

      if str then
        str()
      end
    end
  end
end




?????????=function(bt,xbt)
  mBuilder = Notification.Builder(this);
  --???????????????????????????
  mBuilder.setSmallIcon(R.drawable.icon)--????????????
  --?????????????????????
  --  mBuilder.setLargeIcon(BitmapFactory.decodeResource(activity.getResources(),R.drawable.welcome))
  mBuilder.setContentTitle(bt)--??????
  mBuilder.setContentText(xbt)--??????

  mBuilder.setAutoCancel(true);--????????????????????????????????????????????????????????????????????????
  --        mBuilder.setDefaults( Notification.DEFAULT_SOUND | Notification.DEFAULT_VIBRATE) --??????????????????
  notificationManager =activity.getSystemService(Context.NOTIFICATION_SERVICE)
  notificationIntent = Intent("android.intent.action.VIEW");
  notificationIntent.setClassName(this.getPackageName(),"com.androlua.Welcome")
  pendingIntent = PendingIntent.getActivity(activity.getApplicationContext(), 0, notificationIntent, Intent.FLAG_ACTIVITY_NEW_TASK);
  mBuilder.setContentIntent(pendingIntent).setAutoCancel(false)
  notificationManager.notify(1, mBuilder.build()) --????????????
  --notificationManager.cancel(1);                       --????????????
end


function getactivity()--??????????????????
  xpcall(function()
    local activityManager=activity.getSystemService(Context.ACTIVITY_SERVICE);
    local runningActivity=activityManager.getRunningTasks(1).get(0).topActivity.getClassName();
    return runningActivity
  end,function(e)
    return "nil"
  end)
end


--??????bitmap(bitmap,??????)
function rotateBitmap(origin, alpha)
  local width = origin.getWidth();
  local height = origin.getHeight();
  local matrix = Matrix();
  matrix.setRotate(alpha);
  -- ????????????????????????
  local newBM = Bitmap.createBitmap(origin, 0, 0, width, height, matrix, false);
  if (newBM.equals(origin)) then
    return newBM;
  end
  origin.recycle();
  return newBM;
end
--???????????????
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

function ??????????????????()
  pcall( function()--?????????????????????????????????
    activity. getSystemService(activity.getBaseContext().INPUT_METHOD_SERVICE).toggleSoftInput(0, InputMethodManager.HIDE_NOT_ALWAYS);
  end)
end

function ??????????????????????????????()
  local powerManager = activity.getSystemService(Context.POWER_SERVICE);
  if powerManager then
    local isIgnoring = powerManager.isIgnoringBatteryOptimizations(activity.getPackageName());
    return isIgnoring;
   else
    return false
  end
end

function ?????????????????????()
  pcall(function()
    intent = Intent(Settings.ACTION_REQUEST_IGNORE_BATTERY_OPTIMIZATIONS);
    intent.setData(Uri.parse("package:" .. tostring(activity.getPackageName())));
    activity.startActivity(intent);
  end)
end

function ??????(str,cl)
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
  local bfo=ege.waitFor(); --0?????????????????????
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

function ????????????TTS????????????(yd,ys,str)
  import "android.speech.tts.*"
  mTextSpeech = TextToSpeech(activity, TextToSpeech.OnInitListener{
    onInit=function(status)
      --????????????TTS??????
      if (status == TextToSpeech.SUCCESS)
        result = mTextSpeech.setLanguage(Locale.CHINESE);
        --[[LANG_MISSING_DATA-->?????????????????????
          LANG_NOT_SUPPORTED-->???????????????]]
        if (result == TextToSpeech.LANG_MISSING_DATA or result == TextToSpeech.LANG_NOT_SUPPORTED)
          --???????????????
          ??????("????????????????????????????????????????????????");
          result = mTextSpeech.setLanguage(Locale.ENGLISH);
          if (result == TextToSpeech.LANG_MISSING_DATA or result == TextToSpeech.LANG_NOT_SUPPORTED)
            --????????????????????????
            ??????("??????????????????????????????????????????");
           else
            --??????????????????????????????
            --??????,1.0??????
            mTextSpeech.setPitch(yd);
            --??????,1.0??????
            mTextSpeech.setSpeechRate(ys);
            mTextSpeech.speak(str, TextToSpeech.QUEUE_FLUSH, nil);
          end
         else
          --????????????
          --??????,1.0??????
          mTextSpeech.setPitch(yd);
          --??????,1.0??????
          mTextSpeech.setSpeechRate(ys);
          mTextSpeech.speak(str, TextToSpeech.QUEUE_FLUSH, nil);
        end
      end
    end
  });
end

function ????????????(t,c)
  local sp = SpannableString(t)
  sp.setSpan(ForegroundColorSpan(c),0,#sp,Spannable.SPAN_EXCLUSIVE_INCLUSIVE)
  return sp
end

--????????????
function switchtheme(pattern,layout,statusBarColor)--????????????(???????????????)????????????(aly??????????????????)
  local h=tonumber(os.date("%H"))

  if Build.VERSION.SDK_INT >= 21 then

    if pattern == "??????" then
      activity.setTheme(android.R.style.Theme_DeviceDefault_Light_NoActionBar)

     elseif pattern == "??????" then
      activity.setTheme(android.R.style.Theme_Material_NoActionBar)
     else

      if h<=6 or h>=22 then--??????
        activity.setTheme(android.R.style.Theme_Material_NoActionBar)
       else
        activity.setTheme(android.R.style.Theme_DeviceDefault_Light_NoActionBar)

      end

    end

   else

    if pattern == "??????" then
      activity.setTheme(android.R.style.Theme_Holo_Light)

     elseif pattern == "??????" then
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

--??????
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
  activity.startActivity(Intent.createChooser(intent, "?????????:"))
end

graph={}
function graph.Ripple(id,color,t)
  local ripple
  if t=="???" or t==nil then
    if not(RippleCircular) then
      RippleCircular=activity.obtainStyledAttributes({android.R.attr.selectableItemBackgroundBorderless}).getResourceId(0,0)
    end
    ripple=RippleCircular
   elseif t=="???" then
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

function ????????????(app)
  lan = activity.getPackageManager().getLaunchIntentForPackage(app);
  intent = Intent(Intent.ACTION_MAIN);
  intent.addCategory(Intent.CATEGORY_LAUNCHER);
  intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
  intent.setComponent(lan.getComponent());
  activity.startActivity(intent);
end

