--[=[[
local Popup_layout={
  LinearLayout;
  {
    CardView;
    CardElevation="6dp";
    CardBackgroundColor=背景颜色;
    Radius="8dp";
    layout_width="-2";
    layout_height="-2";
    layout_margin="8dp";
    {
      GridView;
      layout_height="-1";
      layout_width="-1";
      NumColumns=1;
      id="Popup_list";
    };
  };
};


pop=PopupWindow(activity)
pop.setContentView(loadlayout(Popup_layout))
pop.setWidth(dp2px(192))
pop.setHeight(-2)

pop.setOutsideTouchable(true)
pop.setBackgroundDrawable(ColorDrawable(0x00000000))

pop.onDismiss=function()
  --消失事件
end

--PopupWindow列表项布局
Popup_list_item={
  LinearLayout;
  layout_width="-1";
  layout_height="48dp";
  {
    TextView;
    id="popadp_text";
    textColor=圆图字体颜色;
    layout_width="-1";
    layout_height="-1";
    textSize="14sp";
    gravity="left|center";
    paddingLeft="16dp";
  };
};

--PopupWindow列表适配器
local popadp=LuaAdapter(activity,Popup_list_item)

Popup_list.setAdapter(popadp)
--popadp.add{popadp_text="切换主题"}
--popadp.add{popadp_text="搜索工具"}
--popadp.add{popadp_text="清除缓存"}

--菜单点击事件
Popup_list.setOnItemClickListener(AdapterView.OnItemClickListener{
  onItemClick=function(parent, v, pos,id)
    pop.dismiss()
    local s=v.Tag.popadp_text.Text
    switch s
      --     case "搜索工具"
      --      搜索工具()
      --      QJDJ=true
      --     case "切换主题"
      --   case "清除缓存"
    end
  end
})

--长按
Popup_list.onItemLongClick=function(parent, v, pos,id)
  --  local s=v.Tag.popadp_text.Text

  return true
end

--[[menu_id.onClick=function()
--  local 获取屏幕宽=activity.getWidth()
  --showAtLocation(View parent, int gravity, int x, int y)
--  pop.showAtLocation(v,0,获取屏幕宽,0)
  return true
end]]
]]=]


-------------------------
BIAO.onClick=function()
  activity.newActivity("EditCode")
  return true
end

BIAO.onLongClick=function()
  local layout={
    TextView;
    layout_height="-2";
    layout_width="-1";
    textSize="14sp";
    id="txt",
    Text="您确定删除APP缓存和数据吗？",
    textIsSelectable=true,
    layout_margin="20dp";
    textColor=对话框字体,
  };

  local jji=function()
    if File("/sdcard/空文件夹.txt").exists() then
      os.remove ("/sdcard/空文件夹.txt")
    end
    --强制结束自身并清除自身数据
    os.execute("pm clear "..软件包名)
  end
  双对话框(layout,"清除缓存","确定",jji)
  return true
end

theme_1.onClick=function()

  if 读取缓存("主题")=="白天" then

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

    写入缓存("主题","夜间")
    _G=nil
    collectgarbage("collect")
    activity.finish()
    activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
    activity.newActivity("main")
   else

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

    if XFC and wmManager then
      pcall(function()
        wmManager.removeView(mainWindow)
      end)
    end

    写入缓存("主题","白天")
    _G=nil
    collectgarbage("collect")
    activity.finish()
    activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
    activity.newActivity("main")
  end

end



搜索工具=function()
  local layout={
    LinearLayout;
    layout_width="fill";
    layout_height=获取屏幕高;
    orientation="vertical";
    {
      LinearLayout;
      layout_width="fill";
      {
        CardView;
        background=字体背景;
        radius="18dp";
        layout_margin="6dp";
        layout_weight="1";
        Elevation="2dp";
        {
          EditText;
          layout_width="fill";
          background="0";
          textSize="14sp";
          id="edit";
          Hint="输入点什么",
          textColor=其他字体;
          singleLine=true,
          padding="10dp";
          layout_marginLeft="6dp";
        };
      };
    };
    {
      GridView;
      layout_width="-1";
      gravity="center";
      VerticalScrollBarEnabled=false;
      id="grid2";
      --两行之间的边距
      verticalSpacing="10dp";
      --两列之间的边距
      horizontalSpacing="10dp";
      --去除拖动条
      --设置拖动条颜色
      --cacheColorHint="#ff000000";
      --点击某条记录不放，颜色会在记录的后面成为背景色,内容的文字可见(缺省为false)
      --  drawSelectorOnTop=true;
      --定义的衰落(褪去)边缘的长度
      --fadingEdgeLength="10dp" ;
      OverScrollMode=2;
      gravity="center";
      --设置每行个数
      numColumns="2";
      background=背景颜色;
    };
  };

  单对话框3(layout,"搜索工具")
  QJDJ=true
  local data = {}
  import"layout2"
  local adp2=LuaMultiAdapter(this,data,layout2)

  function 注册功能2(n)
    adp2.add{
      __type=1,
      title={Text=n,
        BackgroundDrawable=activity.Resources.getDrawable(ripple).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
      },
    }
  end

  --编辑框监听事件
  edit.addTextChangedListener{
    onTextChanged=function()
      if #edit.Text==0 then
        adp2.clear()
       else
        local datas={}
        for i=1,#namedata do
          local gn= namedata[i]
          --lua正则匹配，简单粗暴
          pcall(function()
            if gn:match(edit.Text) then
              table.insert(datas,namedata[i])
             else
              adp2.clear()
            end
          end)

        end
        table.sort(datas)
        for i=1,#datas do
          注册功能2(datas[i])
        end
      end
    end}

  grid2.setAdapter(adp2)
  grid2.setOverScrollMode(ScrollView.OVER_SCROLL_NEVER);--去除阴影

  grid2.onItemClick=function(l,v,p,i)
    local s=(v.Tag.title.Text)
    点击事件功能(s)
    return true
  end

end

theme_1.onLongClick=function()
  提示("切换主题")
  return true
end

search.onClick=function()
  if not QJDJ then
    搜索工具()
  end
  return true
end

search.onLongClick=function()
  提示("搜索工具")
  return true
end

