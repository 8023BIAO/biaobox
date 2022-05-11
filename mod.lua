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
  -- an3.getWindow().setSoftInputMode(0x10)
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
        layout_height=获取屏幕高-(导航栏高度+状态栏高度+dp2px(56));
        id="wb";
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

    wb.getSettings().setSupportZoom(true);
    wb.getSettings().setBuiltInZoomControls(true);
    wb.getSettings().setDefaultFontSize(14);
    wb.getSettings().setDisplayZoomControls(false);
    wb.getSettings().setUseWideViewPort(true);
    wb.getSettings().setLoadWithOverviewMode(true);
    wb.getSettings().setJavaScriptEnabled(true);
    wb.getSettings().setCacheMode(WebSettings.LOAD_NO_CACHE);
    wb.getSettings().setAllowFileAccess(true);
    wb.getSettings().setAppCacheEnabled(true);
    wb.getSettings().setDomStorageEnabled(true);
    wb.getSettings().setDatabaseEnabled(true);


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


