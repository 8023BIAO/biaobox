

--动画设置___从下往上平移动画
Translate_up_down=TranslateAnimation(0, 0,获取屏幕高,0 )
Translate_up_down.setDuration(300)
Translate_up_down.setFillAfter(true)

--动画设置___从上往下平移动画
Translate_up_down2=TranslateAnimation(0, 0, 0,获取屏幕高+状态栏高度 )

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

          id.startAnimation(Translate_up_down2.setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
            onAnimationEnd=function()
              dialog.hide()
              dialog=nil

              if Show_dl then
                Show_dl=nil
               elseif Show_ddl then
                Show_ddl=nil
              end

              pcall(function()
                velocityTracker.recycle()
              end)
            end}))

         else
          --  ObjectAnimator.ofFloat(icon_down_box,"translationY",{upY/2,0}).setDuration(300).start()
          ObjectAnimator().ofFloat(v,"Y",{upY/2,0}).setDuration(500).start()

        end

      end

    end

    return true
  end

end


function 双对话框(layout,title,buttom_name,buttom_fun,strfun,gb)

  local 关闭对话框=function (id,dl,strfun)
    pcall(function()
      local imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE);
      imm.hideSoftInputFromWindow(an.getWindow().getDecorView().getWindowToken(), 0);
    end)
    id.startAnimation(TranslateAnimation(0, 0, 0,获取屏幕高+状态栏高度 ).setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
      onAnimationEnd=function()
        dl.hide()
        dl=nil
        Show_dl=nil
        if strfun then
          xpcall(function()
            strfun()
          end,function(e)
            提示(e)
          end)
        end
      end}))
  end

  if not Show_dl then
    Show_dl=true

    if not title then
      title="Title"
    end
    if not buttom_str then
      buttom_str="开始"
    end

    local gd = GradientDrawable()
    gd.setColor(主题背景色)--填充
    local radius=dp2px(18)
    gd.setCornerRadii({radius,radius,radius,radius,0,0,0,0})--圆角
    gd.setShape(0)--形状，0矩形，1圆形，2线，3环形

    local sann={
      LinearLayout;
      layout_width="-1";
      layout_height="-1";
      background="#00000000";
      id="bj";
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
            关闭对话框(bj,adb)
          end,
        },
        {
          LinearLayout;
          layout_width="-1";
          layout_height="wrap_content";
          layout_gravity="bottom";
          background="#00000000";
          {
            LinearLayout;
            orientation="vertical";
            layout_width="-1";
            layout_height="-2";
            Elevation="4dp";
            BackgroundDrawable=gd;
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
                Text=title;
                Typeface=Typeface.DEFAULT_BOLD;
                -- textColor=圆图字体颜色;
              };
              {
                LinearLayout;
                layout_width="-1";
                layout_height="-2";
                layout_marginTop="56dp";
                -- padding="4dp";
                {
                  LinearLayout;
                  layout_height="fill",
                  layout_width="fill",
                  orientation="vertical",
                  Focusable=true,
                  FocusableInTouchMode=true,
                  layout;
                };
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
                      关闭对话框(bj,adb)
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
                      --   textColor=圆图字体颜色;
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
                    background="#007FFF",
                    Elevation="1dp";
                    onClick=function()
                      关闭对话框(bj,adb,buttom_fun)
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
                      Text=buttom_name;
                      textColor="#FFFFFF";
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

    adb=AlertDialog.Builder(activity,android.R.style.Theme_Translucent_NoTitleBar).create()
    adb.setInverseBackgroundForced(true);
    adb.getWindow().setSoftInputMode(0x10)

    if gb then
      adb.setCancelable(false)
    end

    --AlertDialog监听返回
    adb.setOnKeyListener(function(view,keyCode,event)
      local et=event.getAction()
      if keyCode == 4 and et == 0 then
        关闭对话框(bj,adb)
        return true
       else
        return false
      end
      return false;
    end)

    --点击空白
    adb.setOnCancelListener(function(...)
      关闭对话框(bj,adb)
    end)

    local window = adb.show().getWindow();
    window.setContentView(loadlayout(sann));
    window.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT));

    local wlp = window.getAttributes();
    wlp.gravity = Gravity.BOTTOM;
    wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
    wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
    wlp.flags=WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL

    window.setAttributes(wlp);

    bj.startAnimation(Translate_up_down)

    手势滑动(adb,ztbj,500)

    if strfun then
      strfun()
    end

  end

end


function 单对话框(layout,title,strfun,gb)

  local 关闭对话框=function (id,dl)
    pcall(function()
      local imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE);
      imm.hideSoftInputFromWindow(an.getWindow().getDecorView().getWindowToken(), 0);
    end)
    id.startAnimation(TranslateAnimation(0, 0, 0,获取屏幕高+状态栏高度 ).setDuration(300).setFillAfter(true).setAnimationListener(AnimationListener{
      onAnimationEnd=function()
        dl.hide()
        dl=nil
        Show_ddl=nil
      end}))
  end

  if not Show_ddl then
    Show_ddl=true

    if not title then
      title="Title"
    end

    local gd2 = GradientDrawable()
    gd2.setColor(主题背景色)--填充
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
        {
          LinearLayout;
          layout_height=activity.getHeight();
          layout_width="fill";
          layout_weight="1";
          background="#00000000";
          onClick=function()
            关闭对话框(dc,dl)
          end,
        },
        {
          LinearLayout;
          layout_width="-1";
          layout_height="wrap_content";
          layout_gravity="bottom";
          orientation="vertical";
          background="#00000000";
          {
            LinearLayout;
            orientation="vertical";
            layout_width="-1";
            layout_height="-2";
            Elevation="4dp";
            BackgroundDrawable=gd2;
            id="dztbj";
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
                Text=title;
                Typeface=Typeface.DEFAULT_BOLD;
                --    textColor=圆图字体颜色;
              };
              {
                LinearLayout;
                layout_width="-1";
                layout_height="-2";
                layout_marginTop="56dp";
                -- padding="4dp";
                {
                  LinearLayout;
                  layout_height="fill",
                  layout_width="fill",
                  orientation="vertical",
                  Focusable=true,
                  FocusableInTouchMode=true,
                  layout;
                },
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
                      关闭对话框(dc,dl)
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
                      --textColor=圆图字体颜色;
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

    dl=AlertDialog.Builder(activity,android.R.style.Theme_Translucent_NoTitleBar).create()
    dl.setInverseBackgroundForced(true);
    dl.getWindow().setSoftInputMode(0x20)

    if gb then
      dl.setCancelable(false)
    end

    dl.setOnKeyListener(function(view,keyCode,event)
      local et=event.getAction()
      if keyCode == 4 and et == 0 then
        关闭对话框(dc,dl)
        return true
       else
        return false
      end
      return false;
    end)

    --点击空白事件
    dl.setOnCancelListener(function(...)
      关闭对话框(dc,dl)
    end)

    local window = dl.show().getWindow();
    window.setContentView(loadlayout(dann));
    window.setBackgroundDrawable(ColorDrawable(Color.TRANSPARENT));

    local wlp = window.getAttributes();
    wlp.gravity = Gravity.BOTTOM;
    wlp.width = WindowManager.LayoutParams.MATCH_PARENT;
    wlp.height = WindowManager.LayoutParams.WRAP_CONTENT;
    wlp.flags=WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL

    window.setAttributes(wlp);

    dc.startAnimation(Translate_up_down)

    手势滑动(dl,dztbj,500)

    if strfun then
      strfun()
    end

  end
end

