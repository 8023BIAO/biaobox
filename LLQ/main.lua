require "import"
function MainActivity()
  xpcall(function()
    ----------------------------

    import "mod"

    --安卓5.0以上点击效果参数设置
    ripple = activity.obtainStyledAttributes({android.R.attr.selectableItemBackgroundBorderless}).getResourceId(0,0)
    ripples = activity.obtainStyledAttributes({android.R.attr.selectableItemBackground}).getResourceId(0,0)

    bwz=0x5000000-0xde000000

    主题背景色=0x00ffffff

    import "my_bag"

    import "keep"


    activity.setTitle('悬浮浏览器')

    if activity.ActionBar then
      activity.ActionBar.hide()
    end

    layout={
      LinearLayout,
      layout_width="fill",
      layout_height="fill",
      orientation="vertical";
      {
        ListView,
        id="listView",
        DividerHeight=0;
        layout_width="fill",
        layout_height="fill",
      }
    }
    activity.setContentView(loadlayout(layout))




    data = {}
    import "setting"
    adp=LuaMultiAdapter(this,data,setting)

    adp.add{__type=1,title="功能"}
    adp.add{__type=2,subtitle="开始",message="开启悬浮窗浏览器"}
    adp.add{__type=2,subtitle="防止被kill",message="通过无障碍让app防止被kill"}
    adp.add{__type=2,subtitle="关闭悬浮窗",message="结束悬浮窗运行"}

    adp.add{__type=1,title="应用"}
    adp.add{__type=2,subtitle="分享软件",message="将软件分享给朋友"}
    adp.add{__type=2,subtitle="删除缓存",message="删除本软件缓存并关闭"}
    adp.add{__type=2,subtitle="关闭应用",message="结束程序运行"}

    adp.add{__type=1,title="关于"}
    adp.add{__type=2,subtitle="beta",message="测试版"}
    adp.add{__type=2,subtitle="BIAO",message="软件开发者"}
    listView.setAdapter(adp)


    --列表点击事件
    listView.setOnItemClickListener(AdapterView.OnItemClickListener{
      onItemClick=function(id,v,zero,one)
        if v.Tag.subtitle then
          switch tostring(v.Tag.subtitle.Text)
           case "开始"
            import "fun"
            悬浮窗浏览器()
           case "防止被kill"
            activity.startActivity(Intent().setAction(Settings.ACTION_ACCESSIBILITY_SETTINGS))
           case "关闭悬浮窗"
            if wmManager then
              close()
              collectgarbage("collect")
            end
           case "关闭应用"
            intent = Intent(Intent.ACTION_MAIN);
            intent.addCategory(Intent.CATEGORY_HOME);
            intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
            activity.startActivity(intent);
            os.exit()
           case "分享软件"
            local apkph=activity.getPackageManager().getApplicationInfo(软件包名, 0).sourceDir
            local apkph=tostring(apkph)
            --分享app
            Sharing(apkph)
           case "删除缓存"
            local layout={
              TextView;
              layout_height="-2";
              layout_width="-1";
              textSize="14sp";
              id="txt",
              Text="您确定删除APP缓存和数据吗？",
              textIsSelectable=true,
              layout_margin="20dp";
            };

            双对话框(layout,"删除缓存","确定",function()
              --强制结束自身并清除自身数据
              os.execute("pm clear "..软件包名)
            end)
           case "BIAO"
            QQ(2222048023)
          end
        end
      end})


    ------------------
  end,function(e)

    翻译(e,function(s)
      local layout= {
        LinearLayout,
        layout_width="-1",
        layout_height="-1",
        orientation="center",
        {
          ScrollView;
          layout_width="-1";
          layout_weight="1";
          VerticalScrollBarEnabled=false;
          OverScrollMode=2;
          {
            LinearLayout,
            layout_width="-1",
            layout_height="-1",
            orientation="center",
            layout_margin="6dp",
            {
              TextView,
              Text=e.."\n\n "..s,
              textSize="16sp",
              layout_width="-1",
              layout_weight="1",
              gravity="center",
              layout_marginBottom="2dp",
              textIsSelectable=true,
            };
          };
        };
      };

      双对话框(layout,"发现错误","反馈",function()
        复制文本(e.."\n\n"..s)
        提示("已复制错误信息",1)
        QQ(2222048023)
      end)

    end)


  end)
end

function onCreate()
  thread(function()
    call("MainActivity")
  end)
end


--监听返回
local shijian= 0
function onKeyDown(code,event)
  local now = os.time()
  if string.find(tostring(event),"KEYCODE_BACK") ~= nil then

    if not wmManager then
      if shijian+2 > tonumber(os.time()) then
        intent = Intent(Intent.ACTION_MAIN);
        intent.addCategory(Intent.CATEGORY_HOME);
        intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);

        if 软件包名=="com.biao.xfcllq" then
          activity.startActivity(intent);
          os.exit()
         else
          activity.finish()
        end

      end
      shijian=tonumber(os.time())
      return true
     else
      intent = Intent();--创建Intent对象
      intent.setAction(Intent.ACTION_MAIN);-- 设置Intent动作
      intent.addCategory(Intent.CATEGORY_HOME);--设置Intent种类
      intent.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
      activity.startActivity(intent);--将Intent传递给Activity
      return true
    end
  end

end

