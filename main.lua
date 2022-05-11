require "import"
import "My bag"

local permission_ = ActivityCompat.checkSelfPermission(activity, Manifest.permission.WRITE_EXTERNAL_STORAGE);
if permission_~=0 then
  print("请给予储存权限")
  local intent=Intent()
  intent.setAction(Settings.ACTION_APPLICATION_DETAILS_SETTINGS);
  intent.setData(Uri.parse("package:"..软件包名));
  activity.startActivity(Intent(intent))
  activity.finish()
end

import "mod"
import "fun"
import "fun2"
import "layout"
activity.setTitle('小工具')

function onCreate()
  --接受回调
  mAdDownLoadReceiver=function(context,intent)
    local bundle = intent.getExtras();
    local resource = bundle.getString("resource"); --Intent 取值，发送广播时候传递的
    xpcall(function()
      loadstring(resource)()
    end,function(e)
      提示(e)
    end)
  end

  --注册
  intentFilter = IntentFilter();
  intentFilter.addAction("biao.box.loadstring"); --监听的事件key
  activity.registerReceiver(mAdDownLoadReceiver, intentFilter); --调用广播回调方法

  activity.setContentView(loadlayout(layout))
  import "main2"
  import "name"
  import "MENU"
  import "listadd"
end

function onKeyDown(code,event)
  if string.find(tostring(event),"KEYCODE_BACK") ~= nil then

    if wm and wm2 then
      wm.removeView(awm)
      wm2.removeView(tp)
     elseif wm then
      wm.removeView(awm)
     elseif wm2 then
      wm2.removeView(tp)
    end

    if wmManager then
      if isMax then
        wmManager.removeView(mainWindow)
       elseif isMax==false
        wmManager.removeView(minWindow)
       elseif isMax==nil then
      end
    end

    if wyti then
      wyti.stop()
      wyti=nil
    end

    activity.finish()
    pcall(function()
      activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
    end)
  end
end

function onDestroy()
  pcall(function()
    if File("/sdcard/空文件夹.txt").exists() then
      os.remove ("/sdcard/空文件夹.txt")
    end
  end)
end

--[[
--发送广播 可以在其他页面发送
intents = Intent("biao.box.loadstring"); --发送的目标
intents.putExtra("resource", "print(8023)");--发送的数据　
activity.sendBroadcast(intents)]]
