
悬浮窗浏览器=function()
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
          layout_width="30dp",
          layout_height="30dp",
          --     background="#66ccff",
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
        {
          RelativeLayout;
          layout_height="-1";
          layout_width="-1";
          {
            LuaWebView;
            layout_width="-1";
            id="wv";
            layout_height="-1";
            VerticalScrollBarEnabled=false;
            OverScrollMode=2;
          };
          {
            FrameLayout;
            layout_height="-1";
            layout_width="-1";
            id="f1";
          },

          {
            LinearLayout;
            layout_height="-1";
            layout_width="-1";
            id="home_",


            {
              LinearLayout;
              layout_width="fill";
              layout_weight="1";
              layout_gravity="center";
              orientation="vertical";

              {
                LinearLayout;
                layout_height="-2";
                layout_width="-1";
                layout_margin="6dp";

                {
                  CardView;
                  radius="50dp";
                  Elevation="2dp";
                  layout_weight="1";
                  background="#ffffffff";
                  layout_marginLeft="12dp";
                  {
                    EditText;
                    layout_width="-1";
                    layout_height="-1";
                    padding="10dp";
                    id="edit";
                    singleLine=true;
                    textSize="14sp";
                    TextColor="#0";
                    background="0";
                    imeOptions="actionSearch";
                  };
                };

                {
                  RippleLayout,
                  layout_height="-1",
                  layout_width="30dp",
                  rippleColor="#50555555",
                  layout_marginRight="10dp";
                  layout_marginLeft="2dp";
                  {
                    ImageView,
                    layout_width="-1",
                    layout_height="-1",
                    scaleType="centerCrop",
                    padding="7dp",
                    src="res/search.png",
                    ColorFilter="#ff000000",
                    id="ucc",
                    onClick="go",
                  },
                },
              };




              {
                GridView;
                id="lv";
                layout_marginTop="10dp";
                layout_marginRight="10dp";
                layout_margin="6dp";
                --两行之间的边距
                verticalSpacing="10dp";
                --两列之间的边距
                horizontalSpacing="5dp";
                --去除拖动条
                VerticalScrollBarEnabled=false;
                --设置拖动条颜色
                --cacheColorHint="#ff000000";
                --点击某条记录不放，颜色会在记录的后面成为背景色,内容的文字可见(缺省为false)
                --  drawSelectorOnTop=true;
                --定义的衰落(褪去)边缘的长度
                --fadingEdgeLength="10dp" ;
                OverScrollMode=2;
                background="0";
                layout_height="-2";
                layout_width="-1";
                gravity="center";
                --设置每行个数
                numColumns="4";
              };



            };
          };
        };
      }



      winlay={
        LinearLayout,
        layout_width="-1",
        layout_height="-1",
        {
          CardView,
          id="win_mainview",
          layout_height="-1",
          layout_width="300dp",
          layout_height="250dp",
          layout_margin="5dp",
          CardElevation="0",
          {
            LinearLayout,
            layout_width="-1",
            layout_height="-1",
            orientation="vertical",

            {
              CardView,
              layout_width="-1",
              layout_height="26dp",
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
                  layout_width="26dp",
                  rippleColor="#50555555",
                  {
                    ImageView,
                    --    gravity="center",
                    layout_width="-1",
                    layout_height="-1",
                    scaleType="centerCrop",
                    padding="4dp",
                    src="res/radiobox-blank.png",
                    ColorFilter="#0",
                    id="焦点";
                    onClick="win_focus",
                  },
                },

                {
                  RippleLayout,
                  layout_height="-1",
                  layout_width="26dp",
                  rippleColor="#50555555",
                  {
                    ImageView,
                    layout_width="-1",
                    layout_height="-1",
                    scaleType="centerCrop",
                    padding="3dp",
                    src="res/minimize.png",
                    ColorFilter="#0",
                    onClick="changeWindow",
                  },
                },
                {
                  RippleLayout,
                  layout_height="-1",
                  layout_width="26dp",
                  rippleColor="#50555555",
                  {
                    ImageView,
                    layout_width="-1",
                    layout_height="-1",
                    scaleType="centerCrop",
                    padding="3dp",
                    src="res/close.png",
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
              layout_height="26dp",
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

                {
                  RippleLayout,
                  layout_height="-1",
                  layout_width="26dp",
                  rippleColor="#50555555",
                  {
                    ImageView,
                    layout_width="-1",
                    layout_height="-1",
                    scaleType="centerCrop",
                    padding="5dp",
                    src="res/ic_pc.png",
                    ColorFilter="#0",
                    id="ucc",
                    onClick="uc",
                  },
                },


                {
                  RippleLayout,
                  layout_height="-1",
                  layout_width="26dp",
                  rippleColor="#50555555",
                  {
                    ImageView,
                    layout_width="-1",
                    layout_height="-1",
                    scaleType="centerCrop",
                    padding="3dp",
                    src="res/home.png",
                    ColorFilter="#0",
                    onClick="home",
                  },
                },

                {
                  RippleLayout,
                  layout_height="-1",
                  layout_width="26dp",
                  rippleColor="#50555555",
                  {
                    ImageView,
                    layout_width="-1",
                    layout_height="-1",
                    scaleType="centerCrop",
                    padding="3dp",
                    src="res/add.png",
                    ColorFilter="#0",
                    onClick="add",
                  },
                },


                {
                  RippleLayout,
                  layout_height="-1",
                  layout_width="26dp",
                  rippleColor="#50555555",
                  {
                    ImageView,
                    layout_width="-1",
                    layout_height="-1",
                    scaleType="centerCrop",
                    padding="1dp",
                    src="res/wb.png",
                    ColorFilter="#0",
                    onClick="wb",
                  },
                },

                {
                  RippleLayout,
                  layout_height="-1",
                  layout_width="26dp",
                  rippleColor="#50555555",
                  {
                    ImageView,
                    layout_width="-1",
                    layout_height="-1",
                    scaleType="centerCrop",
                    padding="3dp",
                    src="res/reload.png",
                    ColorFilter="#0",
                    onClick="reload",
                  },
                },

                {
                  RippleLayout,
                  layout_height="-1",
                  layout_width="26dp",
                  rippleColor="#50555555",
                  {
                    ImageView,
                    layout_width="-1",
                    layout_height="-1",
                    scaleType="centerCrop",
                    padding="3dp",
                    src="res/undo.png",
                    ColorFilter="#0",
                    onClick="undo",
                  },
                },
                {
                  RippleLayout,
                  layout_height="-1",
                  layout_width="26dp",
                  rippleColor="#50555555",
                  --      layout_marginRight="10dp";
                  {
                    ImageView,
                    layout_width="-1",
                    layout_height="-1",
                    scaleType="centerCrop",
                    padding="3dp",
                    src="res/redo.png",
                    ColorFilter="#0",
                    onClick="redo",
                  },
                },

                {
                  ImageView,
                  id="win_worh",
                  layout_width="30dp",
                  layout_height="-1",
                  paddingBottom="6dp",
                  paddingRight="6dp",
                  scaleType="centerCrop",
                  src="res/horw.png",
                  ColorFilter="#0",
                },


              },
            },
          },
        },

      }

      muen= {
        LinearLayout;
        layout_width="-1";
        gravity="center";
        layout_height="-2";
        orientation="vertical";
        {
          CardView;
          radius="24dp";
          layout_width="40dp";
          layout_height="40dp";
          -- layout_margin="16dp";
          elevation="1dp";
          background="#ff000000";
          {
            TextView;
            layout_width="-1";
            layout_height="-1";
            gravity="center";
            textSize="12sp",
            TextColor="#ffffffff",
            id="bt";

          };
        };

      };


      wmManager=activity.getSystemService(Context.WINDOW_SERVICE) --获取窗口管理器
      HasFocus=false --是否有焦点
      wmParams =WindowManager.LayoutParams() --对象
      wmParams.type =WindowManager.LayoutParams.TYPE_SYSTEM_ALERT --设置悬浮窗方式
      wmParams.format =PixelFormat.RGBA_8888 --设置背景
      wmParams.flags=WindowManager.LayoutParams().FLAG_NOT_FOCUSABLE--焦点设置
      wmParams.gravity = Gravity.LEFT| Gravity.TOP --重力设置
      wmParams.x = 0
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
        wv.destroy()
        HasLaunch=false
        pcall(function()
          wmManager.removeView(mainWindow)
        end)
        pcall(function()
          wmManager.removeView(minWindow)
        end)
        wmParams=nil
        mainWindow=nil
        wmManager=nil
        XFC=nil
        BF=nil
        LLQ=nil
      end

      isMax=true --状态

      function changeWindow()
        if isMax==false then
          isMax=true
          wmManager.removeView(minWindow)
          wmManager.addView(mainWindow,wmParams)
          BF=true
         else
          isMax=false

          wmParams.flags=WindowManager.LayoutParams().FLAG_NOT_FOCUSABLE
          wmManager.updateViewLayout(mainWindow,wmParams)

          HasFocus=false
          焦点.setImageBitmap(loadbitmap(luajava.luadir.."/res/radiobox-blank.png"))
          焦点.setColorFilter(0xFF000000)

          wmManager.removeView(mainWindow)
          wmManager.addView(minWindow,wmParams)
          BF=false
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

          local mx=wmX+(event.getRawX()-firstX)
          local my=wmY+(event.getRawY()-firstY)

          winParams.width=mx
          winParams.height=my
          --[[
          if (mx<W*0.95) then
            winParams.width=mx
           else
            winParams.width=W*0.95
          end

          if (my<H*0.95) then
            winParams.height=my
           else
            winParams.height=H*0.95
          end

          if (my<H*0.24)then
            winParams.height=H*0.24
          end

          if (mx<W*0.80)then
            winParams.width=W*0.80
          end]]

          win_mainview.setLayoutParams(winParams)

         elseif event.getAction()==MotionEvent.ACTION_UP then

        end
        return true
      end


      function win_focus() --焦点开关
        if HasFocus==false then
          HasFocus=true

          焦点.setImageBitmap(loadbitmap(luajava.luadir.."/res/radiobox-marked.png"))
          焦点.setColorFilter(0xFF000000)

          wmParams.flags=WindowManager.LayoutParams().FLAG_NOT_TOUCH_MODAL
          wmManager.updateViewLayout(mainWindow,wmParams) --用于刷新

         else
          HasFocus=false
          焦点.setImageBitmap(loadbitmap(luajava.luadir.."/res/radiobox-blank.png"))
          焦点.setColorFilter(0xFF000000)

          wmParams.flags=WindowManager.LayoutParams().FLAG_NOT_FOCUSABLE
          wmManager.updateViewLayout(mainWindow,wmParams)
        end
      end



      showWindow() --显示
      BF=true

      --设置出现缩放工具
      wv.getSettings().setSupportZoom(true);
      --设置出现缩放工具
      wv.getSettings().setBuiltInZoomControls(true);
      --扩大比例的缩放
      wv.getSettings().setUseWideViewPort(true);
      wv.getSettings().setJavaScriptCanOpenWindowsAutomatically(false)
      wv.requestFocusFromTouch()--设置支持获取手势焦点
      webSettings = wv.getSettings();
      wv.getSettings().setJavaScriptEnabled(true);
      wv.getSettings().setDisplayZoomControls(false);
      wv.getSettings().setUseWideViewPort(true);
      wv.getSettings().setLoadWithOverviewMode(true);
      wv.getSettings().setJavaScriptEnabled(true);
      wv.getSettings().setCacheMode(WebSettings.LOAD_NO_CACHE);
      wv.getSettings().setAllowFileAccess(true);
      wv.getSettings().setAppCacheEnabled(true);
      wv.getSettings().setDomStorageEnabled(true);
      wv.getSettings().setDatabaseEnabled(true);
      wv.getSettings().setSaveFormData(true);
      --      wv.getSettings().setLoadsImagesAutomatically(true);
      --      wv.getSettings().setDefaultTextEncodingName("utf-8");--设置编码格式
      --wv.getSettings().setAppCacheEnabled(true)--h5缓存


      --无广告UA
      APP_NAME_UA="netdisk;5.2.7;PC;PC-Windows;6.2.9200;WindowsBaiduYunGuanJia"

      acua="Mozilla/5.0 (Linux; Android 4.2.1; M040 Build/JOP40D) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.59 Mobile Safari/537.36"

      wv.getSettings().setUserAgentString(APP_NAME_UA);

      --状态监听
      wv.setWebViewClient{
        shouldOverrideUrlLoading=function(view,url)
          --Url即将跳转
          win_move.setText("loading")

        end,
        onPageStarted=function(view,url,favicon)
          --网页加载
          --          win_move.setText("加载中")

        end,
        onPageFinished=function(view,url)
          --网页加载完成
          win_move.setText(wv.getTitle())
        end}


      adp=LuaAdapter(activity,muen)
      function 添加项目(bt)
        adp.add{
          bt=bt}
      end

      自定义胶囊=luajava.luadir.."/custom.txt"

      function 加载胶囊()
        adp.clear()
        if not File(自定义胶囊).exists() then
          local data=[[          
        必应:https://www.bing.com,
        百度:https://www.baidu.com,        
        樱花动漫:http://m.imomoe.ai,
        电影狗:https://www.dianyinggou.com,  
        zzzfun:http://www.zzzfun.com/, 
        ]]
          local data=data:gsub("%s","")
          写入文件(自定义胶囊,data)
        end

        胶囊={}
        胶囊内容=io.open(自定义胶囊):read("*a")

        for i ,c in utf8.gmatch(胶囊内容,"(.-):(.-),") do
          胶囊[i]=c
          添加项目(i)
        end
        添加项目("+")
      end
      加载胶囊()

      function 加载(url)
        wv.loadUrl(url)
        wv.setVisibility(View.VISIBLE);
        f1.setVisibility(View.GONE);
        f1.removeAllViews();
        home_.setVisibility(View.GONE);
        LLQ=true
      end

      lv.Adapter=adp
      lv.onItemClick=function(l,v,p,i)
        local s=(v.Tag.bt.Text)
        if s== "+" then
          打开程序(软件包名)

          local layout= {
            LinearLayout;
            orientation="vertical";
            layout_height="fill";
            layout_width="fill";
            {
              LinearLayout;
              layout_width="fill";
              {
                CardView;
                radius="18dp";
                layout_margin="6dp";
                layout_weight="1";
                Elevation="2dp";
                {
                  EditText;
                  layout_width="fill";
                  background="0";
                  textSize="14sp";
                  id="edit2";
                  Hint="名称",
                  singleLine=true,
                  padding="10dp";
                  layout_marginLeft="6dp";
                };
              };
            };
            {
              LinearLayout;
              layout_width="fill";
              {
                CardView;
                radius="18dp";
                layout_margin="6dp";
                layout_weight="1";
                Elevation="2dp";
                {
                  EditText;
                  layout_width="fill";
                  background="0";
                  textSize="14sp";
                  id="edit3";
                  Hint="网址",
                  singleLine=true,
                  padding="10dp";
                  layout_marginLeft="6dp";
                };
              };
            };
          };

          local func=function()
            if edit2.Text ~="" and edit3.Text~="" then

              xpcall(function()
                local e2=utf8.gsub(edit2.Text,"%s?%p?","")
                local 胶囊内容=胶囊内容..e2 ..":"..edit3.Text..","
                if (utf8.sub(edit3.Text,1,4)=="http")then
                  写入文件(自定义胶囊,胶囊内容)
                 elseif (utf8.sub(edit3.Text,1,3)=="www")then
                  local 胶囊内容=胶囊内容..e2.Text ..":http://"..edit3.Text..","
                  写入文件(自定义胶囊,胶囊内容)
                 else
                  local 胶囊内容=胶囊内容..edit2.Text ..":"..edit3.Text..","
                  写入文件(自定义胶囊,胶囊内容)
                end

              end,function()

                local 胶囊内容=胶囊内容..edit2.Text ..":"..edit3.Text..","
                if (utf8.sub(edit3.Text,1,4)=="http")then
                  写入文件(自定义胶囊,胶囊内容)
                 elseif (utf8.sub(edit3.Text,1,3)=="www")then
                  local 胶囊内容=胶囊内容..edit2.Text ..":http://"..edit3.Text..","
                  写入文件(自定义胶囊,胶囊内容)
                 else
                  local 胶囊内容=胶囊内容..edit2.Text ..":"..edit3.Text..","
                  写入文件(自定义胶囊,胶囊内容)
                end
              end)



              加载胶囊()
            end

          end

          双对话框(layout,"添加快捷胶囊","添加",func)
         else
          加载(胶囊[s])
        end
      end

      lv.onItemLongClick=function(p,v,i,s)--长按删除
        local s=(v.Tag.bt.Text)
        local s=utf8.gsub(s,"%s","")
        local v=胶囊[s]
        local v=utf8.gsub(v,"%s","")
        local c=(s..":"..v..",")

        local 胶囊内容=utf8.gsub(胶囊内容,c,"")

        写入文件(自定义胶囊,胶囊内容)
        加载胶囊()
        return true
      end

      function undo()
        if LLQ then
          if f1.getVisibility()==8 then
            wv.goBack()
           else
            wv.setVisibility(View.VISIBLE);
            f1.setVisibility(View.GONE);
            f1.removeAllViews();
            wv.reload()
          end
          home_.setVisibility(View.GONE);
        end
      end

      function redo()
        if LLQ then
          wv.goForward()
          home_.setVisibility(View.GONE);
          f1.setVisibility(View.GONE);--隐藏
          wv.setVisibility(View.VISIBLE);
        end
      end

      function reload()
        if LLQ then
          wv.reload()
          home_.setVisibility(View.GONE);
          f1.setVisibility(View.GONE);--隐藏
          wv.setVisibility(View.VISIBLE);
        end
      end

      function wb()
        if LLQ then
          --     浏览器打开(wv.getUrl())
          local uri = Uri.parse(wv.getUrl());
          local intent = Intent(Intent.ACTION_VIEW, uri);
          activity. startActivity(intent);
        end
      end

      function uc()
        if LLQ then
          if not UA then

            wv.getSettings().setUserAgentString(acua);

            ucc.setImageBitmap(loadbitmap(luajava.luadir.."/res/ic_ua.png"))
            ucc.setColorFilter(0xFF000000)
            UA="uc"

            if wv.getVisibility()== 0 then
              wv.reload()
              wv.setVisibility(View.VISIBLE);
              f1.setVisibility(View.GONE);
              f1.removeAllViews();
              home_.setVisibility(View.GONE);
            end

           elseif UA=="uc" then
            wv.getSettings().setUserAgentString(APP_NAME_UA);

            ucc.setImageBitmap(loadbitmap(luajava.luadir.."/res/ic_pc.png"))
            ucc.setColorFilter(0xFF000000)
            UA="pc"

            if wv.getVisibility()== 0 then
              wv.reload()
              wv.setVisibility(View.VISIBLE);
              f1.setVisibility(View.GONE);
              f1.removeAllViews();
              home_.setVisibility(View.GONE);
            end

           elseif UA=="pc" then
            wv.getSettings().setUserAgentString(acua);

            ucc.setImageBitmap(loadbitmap(luajava.luadir.."/res/ic_ua.png"))
            ucc.setColorFilter(0xFF000000)
            UA="uc"

            if wv.getVisibility()== 0 then
              wv.reload()
              wv.setVisibility(View.VISIBLE);
              f1.setVisibility(View.GONE);
              f1.removeAllViews();
              home_.setVisibility(View.GONE);
            end
          end
        end
      end

      function add()
        if LLQ then

          打开程序(软件包名)

          local layout= {
            LinearLayout;
            orientation="vertical";
            layout_height="fill";
            layout_width="fill";
            {
              LinearLayout;
              layout_width="fill";
              {
                CardView;
                radius="18dp";
                layout_margin="6dp";
                layout_weight="1";
                Elevation="2dp";
                {
                  EditText;
                  layout_width="fill";
                  background="0";
                  textSize="14sp";
                  id="edit2";
                  Hint="名称",
                  singleLine=true,
                  padding="10dp";
                  layout_marginLeft="6dp";
                };
              };
            };
            {
              LinearLayout;
              layout_width="fill";
              {
                CardView;
                radius="18dp";
                layout_margin="6dp";
                layout_weight="1";
                Elevation="2dp";
                {
                  EditText;
                  layout_width="fill";
                  background="0";
                  textSize="14sp";
                  id="edit3";
                  Hint="网址",
                  singleLine=true,
                  padding="10dp";
                  layout_marginLeft="6dp";
                };
              };
            };
          };

          local func=function()
            if edit2.Text ~="" and edit3.Text~="" then
              xpcall(function()
                local e2=utf8.gsub(edit2.Text,"%s?%p?","")
                local 胶囊内容=胶囊内容..e2 ..":"..edit3.Text..","
                if (utf8.sub(edit3.Text,1,4)=="http")then
                  写入文件(自定义胶囊,胶囊内容)
                 elseif (utf8.sub(edit3.Text,1,3)=="www")then
                  local 胶囊内容=胶囊内容..e2.Text ..":http://"..edit3.Text..","
                  写入文件(自定义胶囊,胶囊内容)
                 else
                  local 胶囊内容=胶囊内容..edit2.Text ..":"..edit3.Text..","
                  写入文件(自定义胶囊,胶囊内容)
                end

              end,function()

                local 胶囊内容=胶囊内容..edit2.Text ..":"..edit3.Text..","
                if (utf8.sub(edit3.Text,1,4)=="http")then
                  写入文件(自定义胶囊,胶囊内容)
                 elseif (utf8.sub(edit3.Text,1,3)=="www")then
                  local 胶囊内容=胶囊内容..edit2.Text ..":http://"..edit3.Text..","
                  写入文件(自定义胶囊,胶囊内容)
                 else
                  local 胶囊内容=胶囊内容..edit2.Text ..":"..edit3.Text..","
                  写入文件(自定义胶囊,胶囊内容)
                end
              end)


              加载胶囊()
            end

          end

          双对话框(layout,"添加快捷胶囊","添加",func)
          edit3.setText(wv.getUrl())
          edit2.setText(wv.getTitle())

        end
      end

      function home()
        wv.loadUrl(nil)
        wv.stopLoading()--停止加载网页
        wv.setVisibility(View.GONE);
        wv.removeAllViews();
        f1.setVisibility(View.GONE);--隐藏
        f1.removeAllViews();
        home_.setVisibility(View.VISIBLE);
        win_move.setText("")
        加载胶囊()
      end

      --右下角回车监听
      edit.setOnEditorActionListener(TextView.OnEditorActionListener{
        onEditorAction=function(v,a,e)

          if (a == 3) then

            local searchContent = tostring(edit.getText())
            -- local searchContent=string.lower(searchContent)

            if (TextUtils.isEmpty(searchContent)) then
              --没有文字事件
              return true;
            end

            if (searchContent~="" )then

              local tou="https://cn.bing.com/search?q="

              if not (string.sub(searchContent,1,4) =="http") then
                wv.loadUrl(tou..searchContent)
                home_.setVisibility(View.GONE);
                f1.setVisibility(View.GONE);--隐藏
                wv.setVisibility(View.VISIBLE);

               else
                wv.loadUrl(searchContent)
                home_.setVisibility(View.GONE);
                f1.setVisibility(View.GONE);--隐藏
                wv.setVisibility(View.VISIBLE);

              end

              if not LLQ then
                LLQ=true
              end

            end

            return true;
          end
        end})

      function go()

        if (edit.Text~="" )then


          if not (string.sub(edit.Text,1,4) =="http") then
            local tou="https://cn.bing.com/search?q="

            wv.loadUrl(tou..edit.Text)
            home_.setVisibility(View.GONE);
            f1.setVisibility(View.GONE);--隐藏
            wv.setVisibility(View.VISIBLE);

           else
            wv.loadUrl(edit.Text)
            home_.setVisibility(View.GONE);
            f1.setVisibility(View.GONE);--隐藏
            wv.setVisibility(View.VISIBLE);

          end

          if not LLQ then
            LLQ=true
          end

        end
      end



      f1.setVisibility(View.GONE);--隐藏
      wv.setVisibility(View.GONE);--隐藏
      home_.setVisibility(View.VISIBLE);--显示
      LLQ=false

      local ztb=activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()
      if ztb then
        local ztb=tostring(ztb)
        if (string.sub(ztb,1,4)=="http")then
          edit.setText(ztb)
        end
      end
      ztb=nil

      import "com.lua.*"

      wv.setWebChromeClient(LuaWebChrome(LuaWebChrome.IWebChrine{
        onShowCustomView=function(view, callback)
          wv.setVisibility(View.GONE);
          f1.setVisibility(View.VISIBLE);
          f1.addView(view);
          home_.setVisibility(View.GONE);
          mCallback = callback

        end,
        onHideCustomView=function()
          wv.setVisibility(View.VISIBLE);
          f1.setVisibility(View.GONE);
          f1.removeAllViews();
          home_.setVisibility(View.GONE);
          wv.reload()
        end,
        onProgressChanged=function(view,i)
          if i==100 then
            win_move.setText(wv.getTitle())
           else
            win_move.setText("loading "..i.."%")
          end
        end}));

      --web下载监听
      wv.setDownloadListener(function(url)
        打开程序(软件包名)
        --[[     SnakeBar:show("确定下载吗",nil,2000,"下载",function()
            文件下载(url,"Download",string.match(url,".*/(.*)$"))
          提示("下载在 Download 文件夹下")
          end)]]

        local layout= {
          LinearLayout;
          orientation="vertical";
          layout_height="fill";
          layout_width="fill";
          {
            LinearLayout;
            layout_width="fill";
            {
              CardView;
              radius="18dp";
              layout_margin="6dp";
              layout_weight="1";
              Elevation="2dp";
              {
                EditText;
                layout_width="fill";
                background="0";
                textSize="14sp";
                id="edit2";
                Hint="名称与后缀",
                singleLine=true,
                padding="10dp";
                layout_marginLeft="6dp";
              };
            };
          };
          {
            LinearLayout;
            layout_width="fill";
            {
              CardView;
              radius="18dp";
              layout_margin="6dp";
              layout_weight="1";
              Elevation="2dp";
              {
                EditText;
                layout_width="fill";
                background="0";
                textSize="14sp";
                id="edit3";
                Hint="绝对网址",
                singleLine=true,
                padding="10dp";
                layout_marginLeft="6dp";
              };
            };
          };
          {
            LinearLayout,
            layout_height="fill",
            layout_width="fill",
            orientation="vertical",
            layout_marginTop="5dp",
            {
              CardView;
              layout_width="-1";
              layout_height="-2";
              layout_margin="5dp";
              radius="18dp";
              --         background=字体背景;
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
                --    textColor=圆图字体颜色;
                id="qtxz";
                Text="用其他的方法下载",
                gravity="center";
                BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
              };
            };
          };

        };

        local func=function()
          if edit2.Text ~="" and edit3.Text~="" then
            文件下载(edit3.Text,"Download",edit2.Text)
           else
            提示("下载失败",3)
          end
        end
        双对话框(layout,"下载文件","下载",func)
        edit2.setText(string.match(url,".*/(.*)"))
        edit3.setText(url)

        qtxz.onClick=function()
          local i = Intent(Intent.ACTION_VIEW)
          i.data = Uri.parse(url)
          activity. startActivity(i)
        end

      end)--下载监听结束


      filter = IntentFilter();
      filter.addAction(Intent.ACTION_SCREEN_ON);--开屏
      filter.addAction(Intent.ACTION_SCREEN_OFF);--锁屏
      filter.addAction(Intent.ACTION_USER_PRESENT);--解锁

      activity.registerReceiver(function(context,intent)
        local bundle = intent.getExtras();

        local 状态=(intent.getAction())

        if (状态==Intent.ACTION_SCREEN_ON) then -- 开屏
          --  print("开屏")
          if LLQ and BF then
            BF=false
            changeWindow()
          end
         elseif (状态==Intent.ACTION_SCREEN_OFF) then--锁屏
          --     print("锁屏")
          if LLQ and BF then
            BF=false
            changeWindow()
          end
         elseif (状态==Intent.ACTION_USER_PRESENT) then --解锁
          --  print("解锁")
        end

      end, filter);



    end


  end
end
