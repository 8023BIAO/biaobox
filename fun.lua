
网址取源=function()
  网络判断(function() 提示("没有网络_(•̀ω•́ 」∠)_",3) end,function()
    QJDJ=true
    local layout={
      LinearLayout;
      layout_height="fill",
      layout_width="fill",
      orientation="vertical";
      Focusable=true;
      FocusableInTouchMode=true;
      {
        LinearLayout;
        background="nil";
        layout_width="fill";
        {
          CardView;
          radius="18dp";
          layout_weight="1";
          layout_margin="5dp";
          Elevation="2dp";
          background=字体背景;
          {
            EditText;
            id="a";
            textSize="14sp";
            textColor=其他字体;
            layout_width="fill";
            Hint="请输入网址(http或https开头)",
            padding="10dp";
            background="#00000000";
            SingleLine=true,
          };
        };
      };
      {
        LinearLayout;
        layout_width="-1";
        layout_height="wrap";
        gravity="center";
        {
          CardView;
          layout_width="-1";
          layout_height="-2";
          radius="18dp";
          background=字体背景;
          layout_margin="5dp";
          layout_marginTop="8dp";
          layout_marginBottom="8dp";
          Elevation="2dp";
          {
            TextView;
            layout_width="-1";
            layout_height="-1";
            textSize="14sp";
            paddingRight="21dp";
            paddingLeft="21dp";
            paddingTop="10dp";
            paddingBottom="10dp";
            Text="查看";
            textColor=圆图字体颜色;
            id="b";
            gravity="center";
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
      };
      {
        LinearLayout;
        gravity="center";
        layout_width="-1";
        layout_height="fill";
        {
          ScrollView,
          layout_width="-1";
          layout_margin="6dp";
          VerticalScrollBarEnabled=false;
          {
            TextView;
            layout_width="-1";
            layout_height="wrap";
            id="c",
            textSize="14sp";
            textColor=其他字体;
            textIsSelectable=true;
            Hint ="这里是解析后的字符串";
            layout_margin="6dp";
            gravity="center";
          };
        };
      };
    };

    local jji=function()
      if c.Text=="" then 提示("请解析成功后再复制",3) else 复制文本(c.Text)提示("已经复制信息",1)end
    end

    双对话框(layout,"网址取源","复制",jji)

    local ztb=activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()
    if ztb then
      ztb=tostring(ztb)
      if string.sub(ztb,0,4)=="http" then
        a.setText(ztb)
      end
    end
    ztb=nil

    b.onClick=function()
      if a.Text==""then
        提示("请输入后再重试",3)
       else
        local 运行=function()
          Http.get(a.Text,function(a,b)
            if b and a== 200 then
              c.setText(b)
              提示("解析成功",1)
             else
              提示("开发者努力中_(•̀ω•́ 」∠)_",3)
            end
          end)
        end
        local 错误=function()
          提示("开发者努力中_(•̀ω•́ 」∠)_",3)
        end
        xpcall(运行,错误)
      end
    end
  end)
end

特殊文字=function()
  local TEdata={
    [1]={
      [1]= "花藤",
      [2]="ั͡ζั͡彪ั͡͡",
    },
    [2]={
      [1]="ℳℓ文字",
      [2]="ℳℓ彪ℳℓ",
    },
    [3]={
      [1]="带刺",
      [2]="ۣۖิ彪ۣۖิ",
    },
    [4]={
      [1]="叶子",
      [2]="❦❧彪",
    },
    [5]={
      [1]="非法字符",
      [2]=" ‮ ‮ ‮ ‮ ‮ ‮ ‮彪",
    },
    [6]={
      [1]="菱形",
      [2]="⃟彪⃟",
    },
    [7]={
      [1]="竖立",
      [2]=" 彪 ",
    },
    [8]={
      [1]="禁止",
      [2]="彪⃠",
    },
    [9]={
      [1]="胶囊",
      [2]="彪⃢",
    },
    [10]={
      [1]="小棒",
      [2]="⃓彪",
    },
    [11]={
      [1]="圈圈",
      [2]="⃘⃘彪",
    },
    [12]={
      [1]="颠倒",
      [2]="ﮥ彪",
    },
    [13]={
      [1]="删除",
      [2]="﻿̶彪﻿̶",
    },
    [14]={
      [1]="列表前文字",
      [2]="a'ゞ彪",
    },
    [15]={
      [1]="射线1",
      [2]="ฏ๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎彪",
    },
    [16]={
      [1]="射线2",
      [2]="ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็彪",
    },
    [17]={
      [1]="射线3",
      [2]="ۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖ 彪 ۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۣۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖۖ",
    },
    [18]={
      [1]="小胡子",
      [2]="ฅᰩ彪᭄ฅ"
    }
  }

  local layout={
    LinearLayout;
    layout_height="fill",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      layout_width="fill";
      background="nil";
      {
        CardView;
        radius="18dp";
        layout_margin="5dp";
        layout_weight="1";
        Elevation="2dp";
        background=字体背景;
        {
          EditText;
          layout_width="fill";
          id="txt";
          Hint="请输入字符",
          textSize="14sp";
          textColor=其他字体;
          padding="10dp";
          background="0";
          singleLine=true,
        };
      };
    };
    {
      LinearLayout;
      layout_width="-1";
      orientation="vertical";
      background="nil";
      {
        CardView;
        id="ch1";
        layout_width="fill";
        layout_height="fill";
        layout_gravity="center";
        background="nil";
        {
          LinearLayout;
          layout_width="-1";
          layout_height="fill";
          layout_gravity="center";
          background="nil";
          {
            CardView;
            radius="18dp";
            layout_width="-1";
            layout_height="-2";
            layout_margin="5dp";
            layout_marginTop="8dp";
            layout_marginBottom="8dp";
            Elevation="2dp";
            background=字体背景;
            {
              TextView;
              id="sc";
              layout_width="-1";
              layout_height="-1";
              paddingRight="21dp";
              paddingLeft="21dp";
              paddingTop="10dp";
              paddingBottom="10dp";
              Text="开始生成";
              textSize="14sp";
              textColor=圆图字体颜色;
              gravity="center";
              BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
            };
          };
        };
      };
    };
    {
      LinearLayout;
      layout_width="-1";
      layout_height="wrap";
      orientation="vertical";
      background="nil";
      {
        ListView;
        layout_width="fill";
        layout_margin="5dp";
        id="listview";
        DividerHeight=1,
      };
    };
  };

  单对话框(layout,"特殊文字生成")
  local layout2={
    LinearLayout;
    layout_width="-1";
    orientation="horizontal";
    gravity="center|left";
    {
      LinearLayout;
      orientation="vertical";
      {
        TextView;
        id="tv";
        layout_marginLeft="10dp";
        textSize="16sp";
        textColor=其他字体;
      };
      {
        TextView;
        id="tv1";
        layout_marginLeft="20dp";
        textSize="14sp";
        textColor=其他字体;
      };
    };
  };
  adp=LuaAdapter(activity,layout2)
  sc.onClick=function()
    if txt.Text=="" then
      提示("请输入后再重试",3)
     else
      adp.clear()
      local t=txt.Text
      local strs=utf8.len(t)
      for i=1,#TEdata do
        local 字符名字=TEdata[i][1]
        local 字符=TEdata[i][2]
        local t3=""
        if 字符名字=="花藤" then
          for n=1,strs do
            local t1=utf8.sub(t,n,n)
            local t2=string.gsub(字符,"彪",t1)
            t3=t3..t2
          end
          t3=t3.."✾"
         elseif 字符名字=="列表前文字" then
          local t2=utf8.gsub(字符,"彪",t)
          t3=t3..t2
         elseif 字符名字=="颠倒" then
          local t2=string.gsub(字符,"彪",t)
          t3=t3..t2
         elseif 字符名字=="叶子" then
          for n=1,strs do
            local t1=utf8.sub(t,n,n)
            local t2=string.gsub(字符,"彪",t1)
            t3=t3..t2
          end
          t3=t3.."❦❧"
         elseif 字符名字=="小棒" then
          for n=1,strs do
            local t1=utf8.sub(t,n,n)
            local t2=string.gsub(字符,"彪",t1)
            t3=t3..t2
          end
          t3=t3.."⃓"
         elseif 字符名字=="圈圈" then
          for n=1,strs do
            local t1=utf8.sub(t,n,n)
            local t2=string.gsub(字符,"彪",t1)
            t3=t3..t2
          end
          t3=t3.."⃘⃘"
         elseif 字符名字=="射线1" then
          for n=1,strs do
            local t1=utf8.sub(t,n,n)
            local t2=string.gsub(字符,"彪",t1)
            t3=t3..t2
          end
          t3=t3.."ฏ๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎๎"
         elseif 字符名字=="射线2" then
          for n=1,strs do
            local t1=utf8.sub(t,n,n)
            local t2=string.gsub(字符,"彪",t1)
            t3=t3..t2
          end
          t3=t3.."ด้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็็็็็้้้้้็็็็็้้้้้้้้็"
         elseif 字符名字=="小胡子"then
          t3="ฅᰩ"..t.."᭄ฅ"
         else
          for n=1,strs do
            local t1=utf8.sub(t,n,n)
            local t2=string.gsub(字符,"彪",t1)
            t3=t3..t2
          end
        end
        adp.add{tv=字符名字..":",tv1=t3}
      end
      t1,t2,t3=nil,nil,nil
      listview.Adapter=adp
      listview.onItemClick=function(l,v,p,i)
        local s=(v.Tag.tv.Text):match("(.*):")
        local ss=(v.Tag.tv1.Text)
        复制文本(ss)
        提示("已经复制:"..s.." 特殊字符串",1)
        s,ss=nil,nil
      end
    end
  end
end

重复文本=function()
  local layout={
    LinearLayout;
    layout_height="fill",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      layout_width="fill";
      background="nil";
      {
        CardView;
        radius="18dp";
        layout_margin="5dp";
        layout_weight="1";
        Elevation="2dp";
        background=字体背景;
        {
          EditText;
          id="txt";
          layout_width="fill";
          textSize="14sp";
          Hint="请输入需要重复的字符",
          textColor=其他字体;
          padding="10dp";
          background="0";
          singleLine=true,
        };
      };
    };
    {
      LinearLayout;
      layout_width="-1";
      orientation="vertical";
      background="nil";
      {
        CardView;
        layout_width="fill";
        layout_gravity="center";
        id="ch1";
        background="nil";
        layout_height="fill";
        {
          LinearLayout;
          layout_width="-1";
          layout_gravity="center";
          layout_height="fill";
          background="nil";
          {
            CardView;
            layout_width="-1";
            layout_margin="5dp";
            layout_height="-2";
            radius="18dp";
            background=字体背景;
            layout_marginTop="8dp";
            layout_marginBottom="8dp";
            Elevation="2dp";
            {
              TextView;
              layout_width="-1";
              layout_height="-1";
              textSize="14sp";
              paddingRight="21dp";
              paddingLeft="21dp";
              paddingTop="10dp";
              paddingBottom="10dp";
              Text="开始生成";
              textColor=圆图字体颜色;
              id="sc";
              gravity="center";
              BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
            };
          };
        };
      };
    };
    {
      LinearLayout;
      layout_width="-1";
      layout_height="wrap";
      orientation="vertical";
      background="nil";
      {
        ListView;
        layout_width="fill";
        layout_margin="5dp";
        id="listview";
      };
    };
  };

  单对话框(layout,"重复昵称")
  ---代码
  local txzf=""
  local fczfc=" "

  local layout2={
    LinearLayout;
    layout_width="-1";
    orientation="horizontal";
    gravity="center|left";
    {
      LinearLayout;
      orientation="vertical";
      {
        TextView;
        layout_marginLeft="10dp";
        textSize="14sp";
        id="tv";
      };
      {
        TextView;
        layout_marginLeft="20dp";
        id="tv1";
        textSize="14sp";
        textColor="#ff777777";
      };
    };
  };
  adp=LuaAdapter(activity,layout2)

  sc.onClick=function()
    if txt.Text=="" then
      提示("请输入后再重试",3)
     else

      local z1=txzf..txt.Text
      local z2=txt.Text..txzf
      local z3=txzf..txt.Text..txzf
      local z4=txzf..txzf..txt.Text
      local z5=txt.Text..txzf..txzf
      local z6=txzf..txzf..txt.Text..txzf..txzf

      local sz1=fczfc..txt.Text
      local sz2=txt.Text..fczfc
      local sz3=fczfc..txt.Text..fczfc
      local sz4=fczfc..fczfc..txt.Text
      local sz5=txt.Text..fczfc..fczfc
      local sz6=fczfc..fczfc..txt.Text..fczfc..fczfc

      adp.clear()
      adp.add{tv="重复昵称1:",tv1=z1}
      adp.add{tv="重复昵称2:",tv1=z2}
      adp.add{tv="重复昵称3:",tv1=z3}
      adp.add{tv="重复昵称4:",tv1=z4}
      adp.add{tv="重复昵称5:",tv1=z5}
      adp.add{tv="重复昵称6:",tv1=z6}

      adp.add{tv="--我是分割线--",tv1=""}

      adp.add{tv="重复昵称7:",tv1=sz1}
      adp.add{tv="重复昵称8:",tv1=sz2}
      adp.add{tv="重复昵称9:",tv1=sz3}
      adp.add{tv="重复昵称10:",tv1=sz4}
      adp.add{tv="重复昵称11:",tv1=sz5}
      adp.add{tv="重复昵称12:",tv1=sz6}

      adp.add{tv="--我是分割线--",tv1=""}

      adp.add{tv="特殊字符1",tv1=txzf}
      adp.add{tv="特殊字符2",tv1=fczfc}
      adp.add{tv="帮助:",tv1="可以用于王者重复名字与其他，复制特殊字符可以自己组合重复昵称。点击即可复制\n(一个字符添加了特殊符号(づ◡ど)"}
      listview.Adapter=adp
      --项目被单击
      listview.onItemClick=function(l,v,p,i)
        local s=(v.Tag.tv.Text)
        复制文本(v.Tag.tv1.Text)
        提示("已复制:"..v.Tag.tv1.Text,1)
      end
    end
  end
end

临时聊天=function()
  local layout={
    LinearLayout;
    layout_height="fill",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      layout_width="fill";
      background="nil";
      {
        CardView;
        background=字体背景;
        radius="18dp";
        layout_margin="5dp";
        layout_weight="1";
        Elevation="2dp";
        {
          EditText;
          layout_width="fill";
          background="0";
          textSize="14sp";
          id="edit";
          Hint="请输入需要临时会话的QQ号(五位数QQ以上)",
          InputType="number";
          textColor=其他字体;
          singleLine=true,
          padding="10dp";
        };
      };
    };
  };

  local jji=function()
    if edit.Text=="" or string.len(edit.Text)<5 then
      提示("开发者努力中ヾ(❀╹◡╹)ﾉ~",3)
     else
      pcall(function()
        local url="mqqwpa://im/chat?chat_type=wpa&uin="..edit.Text
        activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)))
      end)
    end
  end
  双对话框(layout,"QQ临时会话",nil,jji)
end


转MD5=function()
  local layout={
    LinearLayout;
    layout_height="fill",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      layout_width="fill";
      background="nil";
      {
        CardView;
        background=字体背景;
        radius="18dp";
        layout_margin="5dp";
        layout_weight="1";
        Elevation="2dp";
        {
          EditText;
          layout_width="fill";
          background="0";
          textSize="14sp";
          id="edit";
          Hint="请输入字符串",
          textColor=其他字体;
          -- singleLine=true,
          padding="10dp";
        };
      };
    };
  };
  local jji=function()
    if edit.Text=="" then
      提示("请输入后再重试",3)
     else
      local 值=MD5(edit.Text)
      复制文本(值)
      提示("转值完成！已复制:\n"..值,1)
      值=nil
    end
  end
  双对话框(layout,"MD5摘要",nil,jji)
end

文字加解密=function()
  local layout={
    LinearLayout;
    layout_height="fill",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      layout_width="fill";
      background="nil";
      {
        CardView;
        background=字体背景;
        radius="18dp";
        layout_margin="5dp";
        layout_weight="1";
        Elevation="2dp";
        {
          EditText;
          layout_width="fill";
          background="0";
          textSize="14sp";
          id="edit";
          Hint="请输入要加解密的值",
          textColor=其他字体;
          singleLine=true,
          padding="10dp";
        };
      };
    };
    {
      LinearLayout;
      layout_width="fill";
      background="nil";
      {
        CardView;
        background=字体背景;
        radius="18dp";
        layout_margin="5dp";
        layout_weight="1";
        Elevation="2dp";
        {
          EditText;
          layout_width="fill";
          background="0";
          textSize="14sp";
          id="edit2";
          Hint="请输入要加解密值的密钥",
          textColor=其他字体;
          singleLine=true,
          padding="10dp";
        };
      };
    };
    {
      LinearLayout;
      layout_width="-1";
      background="nil";
      {
        CardView;
        layout_width="-1";
        layout_margin="5dp";
        layout_height="-2";
        radius="18dp";
        background=字体背景;
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
          Text="加密";
          textColor=圆图字体颜色;
          id="jiami";
          gravity="center";
          BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
        };
      };
      {
        CardView;
        layout_width="-1";
        layout_margin="5dp";
        layout_height="-2";
        radius="18dp";
        background=字体背景;
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
          Text="解密";
          textColor=圆图字体颜色;
          id="jiema";
          gravity="center";
          BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
        };
      };
    };

    {
      LinearLayout;
      layout_width="-1";
      background="nil";
      {
        CardView;
        layout_width="-1";
        layout_margin="5dp";
        layout_height="-2";
        radius="18dp";
        background=字体背景;
        layout_marginTop="8dp";
        layout_marginBottom="8dp";
        Elevation="2dp";
        {
          TextView;
          layout_width="-1";
          layout_height="-1";
          textSize="14sp";
          paddingRight="21dp";
          paddingLeft="21dp";
          paddingTop="10dp";
          paddingBottom="10dp";
          Text="复制结果";
          textColor=圆图字体颜色;
          id="fz";
          gravity="center";
          BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
        };
      };
    };
    {
      LinearLayout;
      layout_width="fill";
      background="nil";
      {
        TextView;
        layout_width="fill";
        background="0";
        textSize="14sp";
        layout_margin="5dp";
        id="ends";
        Hint="结果",
        Text="",
        textColor=其他字体;
        gravity="center";
        singleLine=true,
        padding="10dp";
      };
    };
  };

  单对话框(layout,"文字加解密")
  jiami.onClick=function()
    local e,_e=pcall(function()
      if edit.Text=="" or edit2.Text=="" then
        提示("请输入完整后再重试！",3)
       else
        local _edit,_edit2=edit.Text,edit2.Text
        local 值=文字加密(_edit,_edit2)
        ends.setText(值)
        值=nil
      end
    end)
    if not e then
      提示("开发者努力中_(•̀ω•́ 」∠)_",3)
    end
  end

  jiema.onClick=function()
    local e=pcall(function()
      if edit.Text==""or edit2.Text=="" then
        提示("请输入完整后再重试！",3)
       else
        local _edit,_edit2=edit.Text,edit2.Text
        local 值=文字解码(_edit,_edit2)
        ends.setText(值)
        值=nil
      end
    end)
    if not e then
      提示("开发者努力中_(•̀ω•́ 」∠)_",3)
    end
  end

  fz.onClick=function()
    if ends.Text~=""then
      复制文本(ends.Text)
      提示("已经复制结果",1)
    end
  end
end


base64加解密=function()
  local layout={
    LinearLayout;
    layout_height="fill",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      layout_width="fill";
      background="nil";
      {
        CardView;
        background=字体背景;
        radius="18dp";
        layout_margin="5dp";
        layout_weight="1";
        Elevation="2dp";
        {
          EditText;
          layout_width="fill";
          background="0";
          textSize="14sp";
          id="edit";
          Hint="请输入要加解密的值",
          textColor=其他字体;
          singleLine=true,
          padding="10dp";
        };
      };
    };
    {
      LinearLayout;
      layout_width="-1";
      background="nil";
      {
        CardView;
        layout_width="-1";
        layout_margin="5dp";
        layout_height="-2";
        radius="18dp";
        background=字体背景;
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
          Text="加密";
          textColor=圆图字体颜色;
          id="jiami";
          gravity="center";
          BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
        };
      };
      {
        CardView;
        layout_width="-1";
        layout_margin="5dp";
        layout_height="-2";
        radius="18dp";
        background=字体背景;
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
          Text="解密";
          textColor=圆图字体颜色;
          id="jiema";
          gravity="center";
          BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
        };
      };
    };

    {
      LinearLayout;
      layout_width="-1";
      background="nil";
      {
        CardView;
        layout_width="-1";
        layout_margin="5dp";
        layout_height="-2";
        radius="18dp";
        background=字体背景;
        layout_marginTop="8dp";
        layout_marginBottom="8dp";
        Elevation="2dp";
        {
          TextView;
          layout_width="-1";
          layout_height="-1";
          textSize="14sp";
          paddingRight="21dp";
          paddingLeft="21dp";
          paddingTop="10dp";
          paddingBottom="10dp";
          Text="复制结果";
          textColor=圆图字体颜色;
          id="fz";
          gravity="center";
          BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
        };
      };
    };
    {
      LinearLayout;
      layout_width="fill";
      background="nil";
      {
        TextView;
        layout_width="fill";
        background="0";
        textSize="14sp";
        layout_margin="5dp";
        id="ends";
        Hint="结果",
        Text="",
        textColor=其他字体;
        gravity="center";
        singleLine=true,
        padding="10dp";
      };
    };
  };
  单对话框(layout,"Base64加解密")

  jiami.onClick=function()
    local e=pcall(function()
      if edit.Text==""then
        提示("请输入后再重试！",3)
       else
        local 值=base64.encode(edit.Text)
        ends.setText(值)
        值=nil
      end
    end)
    if not e then
      提示("开发者努力中_(•̀ω•́ 」∠)_",3)
    end
  end

  jiema.onClick=function()
    local e=pcall(function()
      if edit.Text=="" then
        提示("请输入后再重试",3)
       else
        local 值=base64.decode(edit.Text)
        ends.setText(值)
        值=nil
      end
    end)
    if not e then
      提示("开发者努力中_(•̀ω•́ 」∠)_",3)
    end
  end

  fz.onClick=function()
    if ends.Text~="" then
      复制文本(ends.Text)
      提示("已经复制结果",1)
    end
  end
end


在线翻译=function()
  网络判断(function() 提示("没有网络_(•̀ω•́ 」∠)_",3) end,function()
    QJDJ=true
    local layout={
      LinearLayout;
      layout_width="-1";
      layout_height="-1";
      orientation="vertical";
      Focusable=true,
      FocusableInTouchMode=true,
      {
        LinearLayout;
        layout_width="fill";
        background="nil";
        {
          CardView;
          background=字体背景;
          radius="18dp";
          layout_margin="5dp";
          layout_weight="1";
          Elevation="2dp";
          {
            EditText;
            layout_width="fill";
            background="0";
            textSize="14sp";
            Hint="请输入需要翻译的文字",
            id="a";
            textColor=其他字体;
            singleLine=true,
            padding="10dp";
          };
        };
      };
      {
        LinearLayout;
        layout_width="-1";
        layout_height="wrap";
        gravity="center";
        background="nil";
        {
          CardView;
          layout_width="-1";
          layout_weight="1";
          layout_margin="5dp";
          layout_height="-2";
          radius="18dp";
          background=字体背景;
          layout_marginTop="8dp";
          layout_marginBottom="8dp";
          Elevation="2dp";
          {
            TextView;
            layout_width="-1";
            layout_height="-1";
            textSize="14sp";
            paddingRight="21dp";
            paddingLeft="21dp";
            paddingTop="10dp";
            paddingBottom="10dp";
            Text="翻译";
            textColor=圆图字体颜色;
            id="b";
            gravity="center";
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
        {
          CardView;
          layout_width="-1";
          layout_weight="1";
          layout_margin="5dp";
          layout_height="-2";
          radius="18dp";
          background=字体背景;
          layout_marginTop="8dp";
          layout_marginBottom="8dp";
          Elevation="2dp";
          {
            TextView;
            layout_width="-1";
            layout_height="-1";
            textSize="14sp";
            paddingRight="21dp";
            paddingLeft="21dp";
            paddingTop="10dp";
            paddingBottom="10dp";
            Text="复制";
            textColor=圆图字体颜色;
            id="fz1";
            gravity="center";
            BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
          };
        };
      };
      {
        LinearLayout;
        layout_width="-1";
        background="nil";
        layout_height="fill";
        {
          ScrollView,
          layout_width="-1";
          VerticalScrollBarEnabled=false;
          layout_margin="6dp";
          {
            TextView;
            layout_width="-1";
            textColor=其他字体;
            layout_marginLeft="4dp";
            id="c";
            layout_height="-2";
            Hint="这里是翻译后的文字";
            textIsSelectable=true,
            textSize="14sp";
            padding="10dp";
          };
        };
      };
    };
    单对话框(layout,"在线翻译")

    fz1.onClick=function()
      if c.Text=="" then
        提示("请输入翻译后再复制",3)
       else
        复制文本(c.Text)
        提示("已经复制翻译信息",1)
      end
    end

    b.onClick=function()
      local s=a.Text
      if s==""then
        提示("请输入后再重试",3)
       else
        local systenTime=System.currentTimeMillis();
        local data="from=auto&to=zh-CHS&text="..a.Text.."&fr=fanyiapp_android_text&index="..systenTime.."&uuid=&requestId="..systenTime.."&isReturnPhonetic=on"
        Http.post("http://fanyi.sogou.com/reventondc/multiLangTranslate",tostring(data),function(code,con)
          if code==200 then
            local jieg=con:match([[dit":"(.-)","]])
            c.Text=jieg
            jieg=nil
           else
            提示("开发者努力中_(•̀ω•́ 」∠)_",3)
          end
        end)
        data,systenTime=nil,nil
      end
      s=nil
    end
  end)
end


转AV号=function()
  网络判断(function() 提示("没有网络_(•̀ω•́ 」∠)_",3) end,function()
    QJDJ=true
    local layout={
      LinearLayout;
      layout_height="fill",
      layout_width="fill",
      orientation="vertical";
      Focusable=true,
      FocusableInTouchMode=true,
      {
        LinearLayout;
        layout_width="fill";
        background="nil";
        {
          CardView;
          background=字体背景;
          radius="18dp";
          layout_margin="5dp";
          layout_weight="1";
          Elevation="2dp";
          {
            EditText;
            layout_width="fill";
            background="0";
            textSize="14sp";
            id="edit";
            Hint="请输入要转AV号的BV号",
            textColor=其他字体;
            singleLine=true,
            padding="10dp";
          };
        };
      };
    };

    local jji=function()
      if edit.Text=="" then
        提示("请输入后再重试",3)
       else

        local 运行=function()
          Http.get("https://api.bilibili.com/x/web-interface/view?bvid="..edit.Text,function(a,b)
            if a==200 and b then
              local e=pcall(function()
                local b=b:match("\"aid\":(.-),")
                local 值=b
                提示("转AV号完成！已复制:\n av"..值,1)
                复制文本("av"..值)
                值=nil
              end)
              if not e then
                提示("开发者努力中_(•̀ω•́ 」∠)_",3)
              end
             else
              提示("开发者努力中_(•̀ω•́ 」∠)_",3)
            end
          end)
        end
        local 错误=function() 提示("开发者努力中_(•̀ω•́ 」∠)_",3) end
        xpcall(运行,错误)
      end
    end
    双对话框(layout,"BV号转AV号",nil,jji)
    local ztb=activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()
    --获取剪贴板
    if ztb then
      ztb=tostring(ztb)
      if string.sub(ztb,0,2)=="BV" then
        edit.setText(ztb)
      end
    end
    ztb=nil
  end)
end

系统下载=function(a)
  网络判断(function()提示("没有网络_(•̀ω•́ 」∠)_",3)end,function()
    QJDJ=true
    local layout={
      LinearLayout;
      layout_height="fill",
      layout_width="fill",
      orientation="vertical";
      Focusable=true,
      FocusableInTouchMode=true,
      {
        LinearLayout;
        layout_width="fill";
        background="nil";
        {
          CardView;
          background=字体背景;
          radius="18dp";
          layout_margin="5dp";
          layout_weight="1";
          Elevation="2dp";
          {
            EditText;
            layout_width="fill";
            background="0";
            textSize="14sp";
            id="edit";
            Hint="请输入绝对下载链接(下载在Download文件夹)",
            textColor=其他字体;
            singleLine=true,
            padding="10dp";
          };
        };
      };
    }

    local jji=function()
      运行=function()
        local ht=tostring(edit.Text)
        if edit.Text ~="" and string.sub(ht,0,4)=="http" then
          网络判断(function()提示("没有网络_(•̀ω•́ 」∠)_",3)end,function()
            local name=edit.Text.."biao"
            local name=name:match(".*/(.-)biao")
            local downloadManager=activity.getSystemService(Context.DOWNLOAD_SERVICE);
            local url=Uri.parse(edit.Text);
            local request=DownloadManager.Request(url);
            request.setAllowedNetworkTypes(DownloadManager.Request.NETWORK_MOBILE|DownloadManager.Request.NETWORK_WIFI);
            request.setDestinationInExternalPublicDir("Download",name);
            request.setNotificationVisibility(DownloadManager.Request.VISIBILITY_VISIBLE_NOTIFY_COMPLETED);
            downloadManager.enqueue(request);
          end)
         else
          提示("请输入绝对链接",3)
        end
      end
      错误=function()
        提示("开发者努力中_(•̀ω•́ 」∠)_",3)
      end
      xpcall(运行,错误)
    end
    双对话框(layout,"系统下载器","下载",jji)
    local ztb=activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()
    --获取剪贴板
    if ztb then
      ztb=tostring(ztb)
      if string.sub(ztb,0,4)=="http" then
        edit.setText(ztb)
      end
    end
    ztb=nil
  end)
end



辅助准星=function()
  local 运行=function()

    --画笔属性
    local mPaint=Paint()
    mPaint.setARGB(60,0,191,255)--颜色--RGB
    mPaint.setStrokeWidth(3)--画笔宽度
    mPaint.setTextSize(1)--画笔大小
    mPaint.setAlpha(122)--设置画笔的透明度
    mPaint.setAntiAlias(true)--抗齿轮
    mPaint.setDither(true)--设定是否使用图像抖动处理，设置后图像更加清晰
    mPaint.setStyle(Paint.Style.STROKE)--设置画笔的风格,空心
    mPaint.setPathEffect(CornerPathEffect(50))--使路径的转角变得圆滑
    mPaint.setFilterBitmap(true); --//设置双线性过滤

    --画笔属性
    local mPaint2=Paint()
    mPaint2.setARGB(60,0,191,255)--颜色--RGB
    mPaint2.setStrokeWidth(3)--画笔宽度
    mPaint2.setStrokeCap(Paint.Cap.ROUND); --圆角效果
    mPaint2.setTextSize(1)--画笔大小
    mPaint2.setAlpha(110)--设置画笔的透明度
    mPaint2.setAntiAlias(true)--抗齿轮
    mPaint2.setDither(true)--设定是否使用图像抖动处理，设置后图像更加清晰
    mPaint2.setStyle(Paint.Style.STROKE)--设置画笔的风格,空心
    mPaint2.setPathEffect(CornerPathEffect(25))--使路径的转角变得圆滑
    -- --绘制长度为4的实线后再绘制长度为4的区域，0位间隔
    --mPaint2.setPathEffect(DashPathEffect(float{6, 1}, 0.5));

    --画笔属性
    local mPaint3=Paint()
    mPaint3.setARGB(60,0,191,255)--颜色--RGB
    mPaint3.setStrokeWidth(3)--画笔宽度
    mPaint3.setStrokeCap(Paint.Cap.ROUND); --圆角效果
    mPaint3.setTextSize(1)--画笔大小
    mPaint3.setAlpha(100)--设置画笔的透明度
    mPaint3.setAntiAlias(true)--抗齿轮
    mPaint3.setDither(true)--设定是否使用图像抖动处理，设置后图像更加清晰
    mPaint3.setStyle(Paint.Style.STROKE)--设置画笔的风格,空心
    mPaint3.setPathEffect(CornerPathEffect(25))--使路径的转角变得圆滑
    -- --绘制长度为4的实线后再绘制长度为4的空白区域，0位间隔
    mPaint3.setPathEffect(DashPathEffect(float{4, 4}, 0));

    local layout={
      ImageView;
      layout_width="-2";
      layout_height="-2";
      id="awm"
    }

    --开就关，关就开
    if zxfz then
      --清空图片
      awm.setImageDrawable(nil);
      wm.removeView(awm)
      zxfz=false
      QJDJ=false
      wm=nil
      lp=nil
     else

      if zxfz~=true or zxfz==false or zxfz== nil then
        -- 检查是否已经授予权限，大于6.0的系统适用，小于6.0系统默认打开，无需理会
        if Build.VERSION.SDK_INT >= 23 and Settings.canDrawOverlays(this)~=true then
          -- 没有权限，需要申请权限，因为是打开一个授权页面，所以拿不到返回状态的，所以建议是在onResume方法中从新执行一次校验
          intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
          intent.setData(Uri.parse("package:" ..软件包名));
          activity.startActivity(Intent(intent))
         else
          --bit大小
          local bitmap = Bitmap.createBitmap(52, 52, Bitmap.Config.ARGB_8888);
          --获取选择后的bitmap宽高
          local bitw=bitmap.getWidth()
          local bith=bitmap.getHeight()
          --这个不要设置局部变量
          wm=activity.getApplicationContext().getSystemService(Context.WINDOW_SERVICE);
          lp=WindowManager.LayoutParams()
          lp.format = PixelFormat.RGBA_8888
          lp.flags=WindowManager.LayoutParams.FLAG_FULLSCREEN|WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN
          lp.flags = WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE | WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE
          --全屏覆盖
          lp.flags = WindowManager.LayoutParams.FLAG_FULLSCREEN
          lp.flags = WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN
          --最高悬浮权限
          lp.type = WindowManager.LayoutParams.TYPE_SYSTEM_OVERLAY
          lp.x=bitw/2-27.4614
          lp.y=bith/2-27.8614

          lp.width=WindowManager.LayoutParams.WRAP_CONTENT
          lp.height=WindowManager.LayoutParams.WRAP_CONTENT

          wm.addView(loadlayout(layout),lp)

          --创建画布
          canvas = Canvas(bitmap);

          canvas.drawARGB(00,00,00,00)

          --圆
          canvas.drawCircle(26, 26, 25, mPaint);
          --y线
          canvas.drawLine(26, 2, 26, 50,mPaint);
          --x线
          canvas.drawLine(26, 26, 50, 26,mPaint);

          --小线条
          canvas.drawLine(16, 6, 24, 6,mPaint2);

          canvas.drawLine(14, 12, 24, 12,mPaint2);
          canvas.drawLine(14, 17, 24, 17,mPaint2);
          canvas.drawLine(14, 23, 24, 23,mPaint2);
          canvas.drawLine(14, 29, 24, 29,mPaint2);
          canvas.drawLine(14, 35, 24, 35,mPaint2);
          canvas.drawLine(14, 41, 24, 41,mPaint2);
          canvas.drawLine(17, 47, 24, 47,mPaint2);
          --半圆
          rectF = RectF(15, 12,40, 40);
          canvas.drawArc(rectF, 270, 180, false, mPaint3)

          --斜线下
          canvas.drawLine(26, 26, 44, 40,mPaint3);
          --斜线上
          canvas.drawLine(26, 26,45 ,13,mPaint3);

          --显示
          awm.setImageBitmap(bitmap)
          bitmap=nil
          zxfz=true
        end
      end

    end

  end
  local 错误=function()
    提示("开发者努力中_(•̀ω•́ 」∠)_",3)
  end
  xpcall(运行,错误)
end

打字板=function()
  local layout={
    LinearLayout;
    layout_height="-2",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      layout_width="fill";
      background="nil";
      layout_height="-2",
      {
        CardView;
        background=字体背景;
        radius="18dp";
        layout_margin="5dp";
        layout_weight="1";
        Elevation="2dp";
        {
          EditText;
          layout_width="fill";
          background="0";
          textSize="14sp";
          id="edit";
          Hint="请输入需要显示文字",
          textColor=其他字体;
          -- singleLine=true,
          padding="10dp";
          gravity="center";
        };
      };
    };
  };
  local jji=function() if edit.Text=="" then
      提示("请输入后再重试！",3)
     else
      activity.newActivity("daziban",android.R.anim.fade_in,android.R.anim.fade_out,{tostring(edit.Text),"打字板"})
    end

  end
  双对话框(layout,"屏幕文字",nil,jji)

  local ztb=activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()
  --获取剪贴板
  if ztb then
    ztb=tostring(ztb)
    edit.setText(ztb)
  end
  ztb=nil

end

全局设置背景=function()
  local layout={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    id="dj",
    {
      SeekBar;
      id="tmd";
      layout_width="fill";
      layout_height="16dp";
      layout_margin="5dp";
      layout_marginBottom="8dp";
    };
    {
      LinearLayout;
      layout_width="-1";
      layout_height="wrap";
      gravity="center";
      background="nil";
      {
        CardView;
        layout_width="-1";
        layout_margin="5dp";
        layout_height="-2";
        radius="18dp";
        background=字体背景;
        layout_marginTop="8dp";
        layout_marginBottom="8dp";
        Elevation="2dp";
        {
          TextView;
          layout_width="-1";
          layout_height="-1";
          textSize="14sp";
          paddingRight="21dp";
          paddingLeft="21dp";
          paddingTop="10dp";
          paddingBottom="10dp";
          Text="设置/关闭";
          textColor=圆图字体颜色;
          id="sz";
          gravity="center";
          BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
        };
      };
    };
  };
  单对话框(layout,"全局背景")

  sz.onClick=function()
    全局背景()
  end

  tmd.max=255;
  if not TMD then
    tmd.progress=56;
   else
    tmd.progress=TMD
  end
  tmd.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFF9E9E9E,PorterDuff.Mode.SRC_ATOP))
  tmd.Thumb.setColorFilter(PorterDuffColorFilter(0xFF9E9E9E,PorterDuff.Mode.SRC_ATOP))

  tmd.setOnSeekBarChangeListener{
    onProgressChanged=function(v,i)
      if wm2 then
        pAlpha.setAlpha(i)
        TMD=i
       else
        TMD=i
      end
    end}
end

全局背景=function()
  local yx=function()
    -- 检查是否已经授予权限，大于6.0的系统适用，小于6.0系统默认打开，无需理会
    if Build.VERSION.SDK_INT >= 23 and Settings.canDrawOverlays(this)~=true then
      -- 没有权限，需要申请权限，因为是打开一个授权页面，所以拿不到返回状态的，所以建议是在onResume方法中从新执行一次校验
      --  intent=Intent()
      intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION);
      intent.setData(Uri.parse("package:" ..软件包名));
      activity.startActivity(Intent(intent))
     else
      --移除
      if wm2 then
        wm2.removeView(tp)
        lp2=nil
        wm2=nil
        pAlpha=nil
        img_path=nil
        bgcolor=nil
       else
        --调用图库
        local intent= Intent(Intent.ACTION_PICK)
        intent.setType("image/*")
        this.startActivityForResult(intent, 1)

      end

      lay={
        ImageView;
        scaleType="fitXY";
        id="tp";
        layout_height="-1";
        layout_width="-1";
        background=nil,
      };

      --回调
      function onActivityResult(requestCode,resultCode,intent)
        if intent then
          local cursor =this.getContentResolver ().query(intent.getData(), nil, nil, nil, nil)
          cursor.moveToFirst()
          local idx = cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA)
          local fileSrc = cursor.getString(idx)
          --路径
          local img_path=fileSrc
          --设置图片
          pAlpha = Drawable.createFromPath(img_path)
          --图片透明(渐变)
          if TMD then
            pAlpha.setAlpha(TMD)
           else
            pAlpha.setAlpha(56)--设置透明度
          end
          if wm2 == nil then
            wm2 = activity.getApplicationContext().getSystemService(Context.WINDOW_SERVICE);

            lp2 = WindowManager.LayoutParams()

            lp2.width = WindowManager.LayoutParams.MATCH_PARENT;
            lp2.height= WindowManager.LayoutParams.MATCH_PARENT;

            lp2.format = PixelFormat.RGBA_8888
            --全屏覆盖
            lp2.flags = WindowManager.LayoutParams.FLAG_FULLSCREEN
            lp2.flags = WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN
            pcall(function()
              --其他
              lp2.flags = WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL
              lp2.flags = WindowManager.LayoutParams.LAYOUT_IN_DISPLAY_CUTOUT_MODE_SHORT_EDGES
              --导航栏覆盖隐藏(一下
              lp2.flags = WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS;
            end)
            --让点击事件可以传递过去(窗口不获取焦点)
            lp2.flags = WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
            --最高悬浮权限
            lp2.type = WindowManager.LayoutParams.TYPE_SYSTEM_OVERLAY
            --开始设置
            wm2.addView(loadlayout(lay),lp2)

            tp.setBackground(pAlpha)

          end
        end
      end
    end
  end
  local cw=function()
    提示("开发者努力中_(•̀ω•́ 」∠)_",3)
  end
  xpcall(yx,cw)

end

颜色选择=function()
  local yx=function()
    local layout={
      FrameLayout;
      {
        GridView;
        id="tm";
        layout_width="-1";
        VerticalScrollBarEnabled=false;
        layout_height="-2";
        NumColumns="15";
      };
      {
        FrameLayout;
        layout_width="-1";
        layout_height="-2";
        --background="#FFFFFF";
        id="bj";
        {
          LinearLayout;
          layout_width="-1";
          layout_height="-2";
          background="0";
          orientation="vertical";
          layout_marginBottom="7.1dp";
          layout_marginTop="150dp";
          padding="10dp";

          {
            CardView;
            layout_width="-1";
            layout_height="-2";
            radius="18dp";
            background=字体背景;
            Elevation="2dp";
            layout_weight="1";
            layout_marginTop="8dp";
            layout_margin="5dp";
            layout_marginBottom="8dp";
            {
              TextView;
              layout_width="-1";
              layout_height="-1";
              textSize="14sp";
              paddingRight="21dp";
              paddingLeft="21dp";
              paddingTop="10dp";
              paddingBottom="10dp";
              textColor=圆图字体颜色;
              id="a";
              gravity="center";
              BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
            };
          };
          {
            CardView;
            layout_width="-1";
            layout_height="-2";
            layout_margin="5dp";
            radius="18dp";
            background=字体背景;
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
              textColor=圆图字体颜色;
              id="b";
              gravity="center";
              BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
            };
          };
          {
            CardView;
            layout_width="-1";
            layout_height="-2";
            layout_margin="5dp";
            radius="18dp";
            background=字体背景;
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
              textColor=圆图字体颜色;
              id="c";
              gravity="center";
              BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
            };
          };
        };
        {
          LinearLayout;
          layout_width="fill";
          layout_marginTop="10dp";
          orientation="vertical";
          {
            GridLayout;
            layout_width="fill";
            padding="10dp";
            columnCount="2";
            {
              TextView;
              text="A";
              layout_height="35dp";
              TextColor="#808080";
            };
            {
              SeekBar;
              id="alpha";
              progress=255;
              layout_width="fill";
              max=255;
              layout_height="30dp";
            };
            {
              TextView;
              text="R";
              layout_height="35dp";
              TextColor="#FF0000";
            };
            {
              SeekBar;
              layout_width="fill";
              max=255;
              id="red";
              layout_height="30dp";
            };
            {
              TextView;
              text="G";
              layout_height="35dp";
              TextColor="#008000";
            };
            {
              SeekBar;
              layout_width="fill";
              max=255;
              id="green";
              layout_height="30dp";
            };
            {
              TextView;
              text="B";
              layout_height="35dp";
              TextColor="#0000FF";
            };
            {
              SeekBar;
              layout_width="fill";
              max=255;
              id="blue";
              layout_height="30dp";
            };
          };
        };
      };
    };

    单对话框(layout,"颜色选择")

    if 读取缓存("主题") =="夜间" then

      --初始化
      A="FF"
      R="00"
      G="00"
      B="00"
      AI=255
      RI=0
      GI=0
      BI=0
      ARGB=(A..R..G..B)
      red.Progress=0
      green.Progress=0
      blue.Progress=0
      alpha.Progress=255

      bj.backgroundColor=int(tostring("0xff000000"))
     else
      --初始化
      A="FF"
      R="FF"
      G="FF"
      B="FF"
      AI=255
      RI=255
      GI=255
      BI=255
      ARGB=(A..R..G..B)
      red.Progress=255
      green.Progress=255
      blue.Progress=255
      alpha.Progress=255

      bj.backgroundColor=int(tostring("0xffffffff"))
    end

    a.setText("#"..R..G..B)
    b.setText("0x"..ARGB)
    c.setText(AI..","..RI..","..GI..","..BI)


    alpha.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFF9E9E9E,PorterDuff.Mode.SRC_ATOP))
    alpha.Thumb.setColorFilter(PorterDuffColorFilter(0xFF9E9E9E,PorterDuff.Mode.SRC_ATOP))

    red.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFFF44336,PorterDuff.Mode.SRC_ATOP))
    red.Thumb.setColorFilter(PorterDuffColorFilter(0xFFF44336,PorterDuff.Mode.SRC_ATOP))

    green.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFF4CAF50,PorterDuff.Mode.SRC_ATOP))
    green.Thumb.setColorFilter(PorterDuffColorFilter(0xFF4CAF50,PorterDuff.Mode.SRC_ATOP))

    blue.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFF2196F3,PorterDuff.Mode.SRC_ATOP))
    blue.Thumb.setColorFilter(PorterDuffColorFilter(0xFF2196F3,PorterDuff.Mode.SRC_ATOP))


    --滑动监听
    alpha.setOnSeekBarChangeListener{
      onProgressChanged=function(v,i)
        AI=i
        local i=i+1
        local e=Integer.toHexString(i-1)
        local e=string.upper(e)
        if #e== 1 then
          e="0"..e
         else
          e=e
        end
        --string
        A=e
        ARGB=(A..R..G..B)
        a.setText("#"..R..G..B)
        b.setText("0x"..ARGB)
        v,i,e=nil,nil,nil
      end}

    red.setOnSeekBarChangeListener{
      onProgressChanged=function(v,i)
        RI=i
        local i=i+1
        local e=Integer.toHexString(i-1)
        local e=string.upper(e)
        if #e== 1 then
          e="0"..e
         else
          e=e
        end
        --string
        R=e
        ARGB=(A..R..G..B)
        a.setText("#"..R..G..B)
        b.setText("0x"..ARGB)
        v,i,e=nil,nil,nil
      end}

    green.setOnSeekBarChangeListener{
      onProgressChanged=function(v,i)
        GI=i
        local i=i+1
        local e=Integer.toHexString(i-1)
        local e=string.upper(e)
        if #e== 1 then
          e="0"..e
         else
          e=e
        end
        --string
        G=e
        ARGB=(A..R..G..B)
        a.setText("#"..R..G..B)
        b.setText("0x"..ARGB)
        v,i,e=nil,nil,nil
      end}

    blue.setOnSeekBarChangeListener{
      onProgressChanged=function(v,i)
        BI=i
        local i=i+1
        local e=Integer.toHexString(i-1)
        local e=string.upper(e)
        if #e== 1 then
          e="0" ..e
         else
          e=e
        end
        --string
        B=e
        ARGB=(A..R..G..B)
        a.setText("#"..R..G..B)
        b.setText("0x"..ARGB)
        v,i,e=nil,nil,nil
      end}

    --字体更改监听
    b.addTextChangedListener(TextWatcher{
      onTextChanged=function(s, start, before, count)
        bj.backgroundColor=int(tostring(s))
        c.setText(AI..","..RI..","..GI..","..BI)
        s, start, before, count=nil,nil,nil,nil
      end
    })

    a.onClick=function()
      local 颜色=tostring(a.getText())
      复制文本(颜色)
      提示("已复制:"..颜色,1)
      颜色=nil
    end

    b.onClick=function()
      local 颜色1=tostring(b.getText())
      复制文本(颜色1)
      提示("已复制:"..颜色1,1)
      颜色1=nil
    end

    c.onClick=function()
      local 颜色2=tostring(c.getText())
      复制文本(颜色2)
      提示("已复制:"..颜色2,1)
      颜色2=nil
    end

    local mml={
      TextView;
      layout_width="39.614dp";
      layout_height="25.614dp";
      id="ym";
    }

    adp=LuaAdapter(activity,mml)
    function 添加项目(lx)
      if lx==1 then
        nr=0xffEEEEEE
      end
      if lx==2 then
        nr=0xff757575
      end
      adp.add{
        ym={Background=ColorDrawable(tonumber(nr))}
      }
    end
    for i=0,96 do
      添加项目(1)
      添加项目(2)
    end
    添加项目(1)
    tm.Adapter=adp

  end

  local cw=function()
    提示("开发者努力中_(•̀ω•́ 」∠)_",3)
  end
  xpcall(yx,cw)
end

清除空文件夹=function()
  local wjjql= pcall(function()

    执行清理=function()
      提示("开始执行\n请稍等_(•̀ω•́ 」∠)_")
      function find(catalog)
        pcall(function()
          --必须存在
          nilfile ="sdcard/空文件夹.txt"
          function FindFile(catalog)

            local ls=catalog.listFiles()
            for 次数=0,#ls-1 do
              local f=ls[次数]
              if f.isDirectory() then--如果是文件夹则
                local ml= luajava.astable(f.listFiles())
                if ml[1] ==nil then
                  local truefile= io.open(nilfile):read("*a")
                  io.open(nilfile,"w+"):write(truefile.."\n"..tostring(f).."\n"):close()
                end
                FindFile(f)
               else--如果是文件则
                --删除
                luajava.clear(f)
              end
              --删除
              luajava.clear(f)
            end
          end

          function endx ()
            local truefile= io.open(nilfile):read("*a")
            if truefile=="" or truefile=="%s" or truefile=="\n" then
              call("提示","清除空文件夹完成",1)
              os.remove ("sdcard/空文件夹.txt")

             else
              for k in truefile:gmatch("\n(.-)\n") do
                local k=tostring(k)
                if k~="%s" then
                  --删除空文件夹
                  os.remove (tostring(k))
                end
              end
              io.open(nilfile,"w+"):write(""):close()
              FindFile(catalog)
              endx()
            end
          end
          FindFile(catalog)
          endx()
        end)
      end
      catalog=File(tostring(手机内置路径()))
      thread(find,catalog)
    end

    --必须存在
    nilfile ="sdcard/空文件夹.txt"

    if File(nilfile).exists() then
      -- io.open(nilfile,"w+"):write(""):close()
      if not QLKWJJ then
        QLKWJJ=true
        io.open(nilfile,"w+")
        执行清理()
       else
        提示("正在执行中...")
      end
     else
      QLKWJJ=true
      io.open(nilfile,"w+")
      执行清理()
    end

  end)
  if not wjjql then
    提示("开发者努力中(づ◡ど)")
  end
end

滚动字幕=function()
  local layout={
    LinearLayout;
    layout_height="fill",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      layout_width="fill";
      background="nil";
      {
        CardView;
        background=字体背景;
        radius="18dp";
        layout_margin="5dp";
        layout_weight="1";
        Elevation="2dp";
        {
          EditText;
          layout_width="fill";
          background="0";
          textSize="14sp";
          id="edit";
          Hint="请输入文字",
          textColor=其他字体;
          --singleLine=true,
          padding="10dp";
          gravity="center";
        };
      };
    };
  };
  local jji=function() if edit.Text=="" then
      提示("请输入后再重试！",3)
     else
      activity.newActivity("Entertaining_diversions",android.R.anim.fade_in,android.R.anim.fade_out,{tostring(edit.Text),"滚动字幕"})
    end
  end
  双对话框(layout,"滚动字幕",nil,jji)
  local ztb=activity.getSystemService(Context.CLIPBOARD_SERVICE).getText()
  --获取剪贴板
  if ztb then
    ztb=tostring(ztb)
    edit.setText(ztb)
  end
  ztb=nil
end


纯色图片生成=function()
  local yx=function()
    local 纯色图片路径="sdcard/Pictures/PureColor/"
    if File(纯色图片路径).exists()~=true then
      os.execute('mkdir '..纯色图片路径)
    end

    --填充颜色
    --bitmap.eraseColor(Color.parseColor("#ff0000"));
    local bitmap = Bitmap.createBitmap(1080, 1920, Bitmap.Config.ARGB_8888);
    local canvas = Canvas(bitmap);

    local layout={
      FrameLayout;
      {
        GridView;
        id="tm";
        layout_width="-1";
        VerticalScrollBarEnabled=false;
        layout_height="-2";
        NumColumns="15";
      };
      {
        FrameLayout;
        layout_width="-1";
        layout_height="-2";
        --  background="#FFFFFF";
        id="bj";
        {
          LinearLayout;
          layout_width="-1";
          layout_height="-2";
          background="0";
          orientation="vertical";
          layout_marginBottom="7.1dp";
          layout_marginTop="150dp";
          padding="10dp";
          {
            CardView;
            layout_width="-1";
            layout_margin="5dp";
            layout_height="-2";
            radius="18dp";
            background=字体背景;
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
              textColor=圆图字体颜色;
              id="a";
              gravity="center";
              BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
            };
          };
          {
            CardView;
            layout_width="-1";
            layout_margin="5dp";
            layout_height="-2";
            radius="18dp";
            background=字体背景;
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
              textColor=圆图字体颜色;
              id="b";
              gravity="center";
              BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
            };
          };
          {
            CardView;
            layout_width="-1";
            layout_margin="5dp";
            layout_height="-2";
            radius="18dp";
            background=字体背景;
            layout_marginTop="8dp";
            layout_marginBottom="8dp";
            Elevation="2dp";
            --      layout_weight="1";
            {
              TextView;
              layout_width="-1";
              layout_height="-1";
              textSize="14sp";
              paddingRight="21dp";
              paddingLeft="21dp";
              paddingTop="10dp";
              paddingBottom="10dp";
              textColor=圆图字体颜色;
              id="c";
              gravity="center";
              BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
            };
          };
        };
        {
          LinearLayout;
          layout_width="fill";
          layout_marginTop="10dp";
          orientation="vertical";
          {
            GridLayout;
            layout_width="fill";
            padding="10dp";
            columnCount="2";
            {
              TextView;
              text="A";
              layout_height="35dp";
              TextColor="#808080";
            };
            {
              SeekBar;
              id="alpha";
              progress=255;
              layout_width="fill";
              max=255;
              layout_height="30dp";
            };
            {
              TextView;
              text="R";
              layout_height="35dp";
              TextColor="#FF0000";
            };
            {
              SeekBar;
              layout_width="fill";
              max=255;
              id="red";
              layout_height="30dp";
            };
            {
              TextView;
              text="G";
              layout_height="35dp";
              TextColor="#008000";
            };
            {
              SeekBar;
              layout_width="fill";
              max=255;
              id="green";
              layout_height="30dp";
            };
            {
              TextView;
              text="B";
              layout_height="35dp";
              TextColor="#0000FF";
            };
            {
              SeekBar;
              layout_width="fill";
              max=255;
              id="blue";
              layout_height="30dp";
            };
          };
        };
      };
    };


    单对话框(layout,"纯色图片生成")

    if 读取缓存("主题") =="夜间" then

      --初始化
      A="FF"
      R="00"
      G="00"
      B="00"
      AI=255
      RI=0
      GI=0
      BI=0
      ARGB=(A..R..G..B)
      red.Progress=0
      green.Progress=0
      blue.Progress=0
      alpha.Progress=255

      bj.backgroundColor=int(tostring("0xff000000"))
     else
      --初始化
      A="FF"
      R="FF"
      G="FF"
      B="FF"
      AI=255
      RI=255
      GI=255
      BI=255
      ARGB=(A..R..G..B)
      red.Progress=255
      green.Progress=255
      blue.Progress=255
      alpha.Progress=255

      bj.backgroundColor=int(tostring("0xffffffff"))
    end

    a.setText("#"..R..G..B)
    b.setText("0x"..ARGB)
    c.setText(AI..","..RI..","..GI..","..BI)

    alpha.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFF9E9E9E,PorterDuff.Mode.SRC_ATOP))
    alpha.Thumb.setColorFilter(PorterDuffColorFilter(0xFF9E9E9E,PorterDuff.Mode.SRC_ATOP))

    red.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFFF44336,PorterDuff.Mode.SRC_ATOP))
    red.Thumb.setColorFilter(PorterDuffColorFilter(0xFFF44336,PorterDuff.Mode.SRC_ATOP))

    green.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFF4CAF50,PorterDuff.Mode.SRC_ATOP))
    green.Thumb.setColorFilter(PorterDuffColorFilter(0xFF4CAF50,PorterDuff.Mode.SRC_ATOP))

    blue.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFF2196F3,PorterDuff.Mode.SRC_ATOP))
    blue.Thumb.setColorFilter(PorterDuffColorFilter(0xFF2196F3,PorterDuff.Mode.SRC_ATOP))


    --滑动监听
    alpha.setOnSeekBarChangeListener{
      onProgressChanged=function(v,i)
        AI=i
        local i=i+1
        local e=Integer.toHexString(i-1)
        local e=string.upper(e)
        if #e== 1 then
          e="0"..e
         else
          e=e
        end
        --string
        A=e
        ARGB=(A..R..G..B)
        a.setText("#"..R..G..B)
        b.setText("0x"..ARGB)
        v,i,e=nil,nil,nil
      end}

    red.setOnSeekBarChangeListener{
      onProgressChanged=function(v,i)
        RI=i
        local i=i+1
        local e=Integer.toHexString(i-1)
        local e=string.upper(e)
        if #e== 1 then
          e="0"..e
         else
          e=e
        end
        --string
        R=e
        ARGB=(A..R..G..B)
        a.setText("#"..R..G..B)
        b.setText("0x"..ARGB)
        v,i,e=nil,nil,nil
      end}
    green.setOnSeekBarChangeListener{
      onProgressChanged=function(v,i)
        GI=i
        local i=i+1
        local e=Integer.toHexString(i-1)
        local e=string.upper(e)
        if #e== 1 then
          e="0"..e
         else
          e=e
        end
        --string
        G=e
        ARGB=(A..R..G..B)
        a.setText("#"..R..G..B)
        b.setText("0x"..ARGB)
        v,i,e=nil,nil,nil
      end}
    blue.setOnSeekBarChangeListener{
      onProgressChanged=function(v,i)
        BI=i
        local i=i+1
        local e=Integer.toHexString(i-1)
        local e=string.upper(e)
        if #e== 1 then
          e="0" ..e
         else
          e=e
        end
        --string
        B=e
        ARGB=(A..R..G..B)
        a.setText("#"..R..G..B)
        b.setText("0x"..ARGB)
        v,i,e=nil,nil,nil
      end}

    --字体更改监听
    b.addTextChangedListener(TextWatcher{
      onTextChanged=function(s, start, before, count)
        bj.backgroundColor=int(tostring(s))
        c.setText(AI..","..RI..","..GI..","..BI)
        ARGB=(A..R..G..B)
        s,start, before, count=nil,nil,nil,nil
      end
    })

    a.onLongClick=function()
      --控件被长按
      --  canvas.drawARGB(AI,RI,GI,BI)
      bitmap.eraseColor(Color.parseColor(a.getText()));

      --生成
      SavePicture("sdcard/".."0x"..ARGB..".png",bitmap)
      提示("已保存在sdcard/目录下",1)
    end

    b.onLongClick=function()
      --控件被长按
      -- canvas.drawARGB(AI,RI,GI,BI)
      bitmap.eraseColor(Color.parseColor(a.getText()));

      --生成
      SavePicture("sdcard/".."0x"..ARGB..".png",bitmap)
      提示("已保存在sdcard/目录下",1)
    end

    c.onLongClick=function()
      --控件被长按
      --  canvas.drawARGB(AI,RI,GI,BI)
      bitmap.eraseColor(Color.parseColor(a.getText()));

      --生成
      SavePicture("sdcard/".."0x"..ARGB..".png",bitmap)
      提示("已保存在sdcard/目录下",1)
    end

    提示("长按任意按钮生成所选择颜色_(•̀ω•́ 」∠)_")

    local mml={
      TextView;
      layout_width="39.614dp";
      layout_height="25.614dp";
      id="ym";
    }

    adp=LuaAdapter(activity,mml)
    function 添加项目(lx)
      if lx==1 then
        nr=0xffEEEEEE
      end
      if lx==2 then
        nr=0xff757575
      end
      adp.add{
        ym={Background=ColorDrawable(tonumber(nr))}
      }
    end
    for i=0,96 do
      添加项目(1)
      添加项目(2)
    end
    添加项目(1)
    tm.Adapter=adp
  end

  local cw=function()
    提示("开发者努力中_(•̀ω•́ 」∠)_",3)
  end
  xpcall(yx,cw)
end

bitmap转Base64=function()
  local layout={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    id="dj",
    {
      SeekBar;
      id="tmd2";
      -- progress=100;
      layout_width="fill";
      -- max=100;
      layout_height="16dp";
      layout_margin="5dp";
      layout_marginBottom="8dp";
    };

    {
      LinearLayout;
      layout_width="-1";
      layout_height="wrap";
      gravity="center";
      background="nil";
      {
        CardView;
        layout_width="-1";
        layout_margin="5dp";
        layout_height="-2";
        radius="18dp";
        background=字体背景;
        layout_marginTop="8dp";
        layout_marginBottom="8dp";
        Elevation="2dp";
        {
          TextView;
          layout_width="-1";
          layout_height="-1";
          textSize="14sp";
          paddingRight="21dp";
          paddingLeft="21dp";
          paddingTop="10dp";
          paddingBottom="10dp";
          Text="开始";
          textColor=圆图字体颜色;
          id="sz";
          gravity="center";
          BackgroundDrawable=activity.Resources.getDrawable(ripples).setColor(ColorStateList(int[0].class{int{}},int{bwz}));
        };
      };
    };
  };
  单对话框(layout,"图片转Base64")

  sz.onClick=function()
    --调用图库选择图片
    local intent= Intent(Intent.ACTION_PICK)
    intent.setType("image/*")
    this.startActivityForResult(intent, 1)

    --回调
    function onActivityResult(requestCode,resultCode,intent)
      if intent then

        local cursor =this.getContentResolver ().query(intent.getData(), nil, nil, nil, nil)
        cursor.moveToFirst()
        local idx = cursor.getColumnIndex(MediaStore.Images.ImageColumns.DATA)
        local fileSrc = cursor.getString(idx)
        bit=nil
        --fileSrc回调路径路径
        local bit =BitmapFactory.decodeFile(fileSrc)
        local yx=function()
          bitmapToBase64(bit,function(a)
            if a then
              复制文本(a)
              提示("已复制bitmap的Base64码",1)
              a=nil
            end
          end,YESUO)
        end
        local xx=function()
          提示("实验性功能开发者努力中_(•̀ω•́ 」∠)_\n建议取较小的图片或者调整压缩图片值")
        end
        xpcall(yx,xx)
      end
    end
    pcall(function()
      if an then
        an.hide()
        QJDJ=false
      end
    end)
  end

  tmd2.max=100;
  if not YESUO then
    tmd2.progress=100;
   else
    YESUO=nil
    tmd2.progress=100;
  end
  tmd2.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xFF9E9E9E,PorterDuff.Mode.SRC_ATOP))
  tmd2.Thumb.setColorFilter(PorterDuffColorFilter(0xFF9E9E9E,PorterDuff.Mode.SRC_ATOP))

  tmd2.setOnSeekBarChangeListener{
    onProgressChanged=function(v,i)
      YESUO=i
    end}

end

base64转bitmap=function()
  local layout={
    LinearLayout;
    layout_height="fill",
    layout_width="fill",
    orientation="vertical";
    Focusable=true,
    FocusableInTouchMode=true,
    {
      LinearLayout;
      layout_width="fill";
      background="nil";
      {
        CardView;
        background=字体背景;
        radius="18dp";
        layout_margin="5dp";
        layout_weight="1";
        Elevation="2dp";
        {
          EditText;
          layout_width="fill";
          background="0";
          textSize="14sp";
          id="edit";
          Hint="请输入bitmap(图片)的Base64值",
          textColor=其他字体;
          --singleLine=true,
          --layout_height="-2",
          padding="10dp";
        };
      };
    };
  };
  local jji=function() if edit.Text=="" then
      提示("请输入后再重试！",3)
     else
      local e=pcall(function()
        local str=tostring(edit.Text)
        local bit=Base64ToBitmap(str)
        if bit then
          bittup(bit)
          --特殊需求
          an.hide()
          QJDJ=false
        end
        bit=nil
      end)
      if not e then
        提示("实验性功能开发者努力中(づ◡ど)",3)
      end
    end
  end
  双对话框(layout,"Base64转图片",nil,jji)
end

bittup=function(bit)
  if bit then
    local e=pcall(function()
      local layout={
        LinearLayout;
        layout_height="fill",
        layout_width="fill",
        orientation="vertical";
        Focusable=true,
        FocusableInTouchMode=true,
        {
          ImageView;
          layout_width="-1";
          id="wb";
          layout_gravity="center";
          layout_height="-1";
          background="0";
          layout_margin="6dp";
        };
      };

      local jji=function()
        SavePicture("/sdcard/"..tostring(bit)..".png",bit)
        提示("已经保存图片在:sdcard/目录下",1)
        bit=nil
      end
      双对话框2(layout,"Base64转图片","保存",jji)
      wb.setImageDrawable(nil);
      --加载
      wb.setImageBitmap(bit)
    end)
    if not e then
      提示("实验性功能开发者努力中(づ◡ど)",3)
    end
  end
end

function 获取文件MD5()

  getMd5str=function(fileluj)
    local _e,_= pcall(function()
      local fileluj=LuaUtil.getFileMD5(fileluj);
      local fileluj=tostring(fileluj)
      复制文本(fileluj)
      fileluj=nil
      提示("已复制文件MD5",1)
    end)
    if _ and not e then
      提示("开发者努力中( •̥́ ˍ •̀ू )",3)
    end
  end

  ChoiceFile(手机内置路径(),function(fileluj)

    _e_=pcall(function()
      local dl=ProgressDialog.show(activity,nil,'获取中...')
      dl.show()
      task(function(fileluj,复制文本,dl)
        require "import"
        if pcall(function()
            local fileluj=LuaUtil.getFileMD5(fileluj);
            local fileluj=tostring(fileluj)
            复制文本(fileluj)
            dl.dismiss()
            fileluj=nil
          end)then
          if fileluj then
            return "已复制文件MD5",1
          end
         else
          local ee= pcall(function()
            local fileluj=LuaUtil.getFileMD5(fileluj);
            local fileluj=tostring(fileluj)
            复制文本(fileluj)
          end)
          if not ee then
            local e =pcall(function()
              call("getMd5str",fileluj)
            end)
            if not e then
              提示("开发者努力中( •̥́ ˍ •̀ू )",3)
            end
            dl.dismiss()
           else
            fileluj=nil
            dl.dismiss()
            return "已复制文件MD5",1
          end

        end
      end,fileluj,复制文本,dl,提示)
    end)

    if not _e_ then
      local fileluj=LuaUtil.getFileMD5(fileluj);
      local fileluj=tostring(fileluj)
      复制文本(fileluj)
      提示("已复制文件MD5",1)
    end

  end)
end

渐变颜色参考=function()
  local layout={
    RelativeLayout;
    layout_width="-1";
    layout_height="-1";
    background=背景颜色;
    {
      LinearLayout;
      layout_width="-1";
      layout_height="-1";
      orientation="vertical";
      {
        GridView;
        id="lv";
        layout_width="-1";
        layout_height="-1";
        VerticalScrollBarEnabled=false;
      };
    };
  };

  单对话框(layout,"渐变颜色参考")

  local mml={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor="0";
      Radius="8dp";
      layout_width="-1";
      layout_height="-2";
      layout_margin="16dp";
      layout_marginTop="8dp";
      layout_marginBottom="8dp";
      {
        CardView;
        CardElevation="0dp";
        -- CardBackgroundColor=背景颜色;
        Radius=dp2px(8)-4;
        layout_margin="4px";
        layout_width="-1";
        layout_height="-1";
        {
          LinearLayout;
          layout_width="-1";
          layout_height="72dp";
          gravity="left|center";
          id="ym";
          {
            TextView;
            layout_width="-1";
            layout_height="-1";
            textColor="#ff212121";
            textSize="14sp";
            padding="16dp";
            layout_weight="1";
            gravity="left|center";
            id="dml";
          };
          {
            TextView;
            layout_width="-1";
            layout_height="-1";
            textColor="#ff212121";
            textSize="14sp";
            padding="16dp";
            layout_weight="1";
            gravity="right|center";
            id="dmr";
          };
        };
      };
    };
  };
  adp=LuaAdapter(activity,mml)
  function 添加项目(l,r)
    local ln=l:match("0xFF(.+)")
    local lj='#'..ln
    local rn=r:match("0xFF(.+)")
    local rj='#'..rn
    adp.add{
      dml={text=lj},
      ym={BackgroundDrawable=GradientDrawable(GradientDrawable.Orientation.LEFT_RIGHT,{l,r})},
      dmr={text=rj}
    }
  end

  添加项目("0xFF81FBB8","0xFF28C76F")
  添加项目("0xFFF97794","0xFF623AA2")
  添加项目("0xFFE2B0FF","0xFF9F44D3")
  添加项目("0xFF90F7EC","0xFF32CCBC")
  添加项目("0xFFFFF6B7","0xFFF6416C")
  添加项目("0xFFCE9FFC","0xFF7367F0")
  添加项目("0xFFFEB692","0xFFEA5455")
  添加项目("0xFFABDCFF","0xFF0396FF")
  添加项目("0xFF83A4D4","0xFFB6FBFF")
  添加项目("0xFFFF8BB1","0xFFE82C32")
  添加项目("0xFFFF5E75","0xFFFF42EB")
  添加项目("0xFFFF96F9","0xFFC32BAC")
  添加项目("0xFFA050F1","0xFF8F3196")
  添加项目("0xFFEFB884","0xFFBE944D")
  添加项目("0xFF7CE084","0xFF50BF1C")
  添加项目("0xFF43CBFF","0xFF3C8CE7")
  添加项目("0xFF5F87FF","0xFF122EF1")
  添加项目("0xFF42A5F5","0xFF00C853")
  添加项目("0xFFFF6B66","0xFFF0703E")
  添加项目("0xFFCB7575","0xFFA3C9C7")
  添加项目("0xFF5CAB7D","0xFFF68657")
  添加项目("0xFFC65146","0xFF84B1ED")
  添加项目("0xFF6A60A9","0xFFFC913A")
  添加项目("0xFF1E8AE8","0xFF0075D5")
  添加项目("0xFFFB7299","0xFFF670DA")
  添加项目("0xFF3F51B3","0xFFE81C61")
  添加项目("0xFF7986CB","0xFF5EFFAE")
  添加项目("0xFF363C4A","0xFF1F8792")
  添加项目("0xFF087EA2","0xFF08BBE4")
  添加项目("0xFF544E74","0xFFE68967")
  添加项目("0xFF155F82","0xFFA5700A")

  lv.Adapter=adp
  lv.onItemClick=function(l,v,p,i)
    lm=v.Tag.dml.Text
    rm=v.Tag.dmr.Text
    提示("已复制颜色 "..lm..","..rm,1)
    复制文本(lm..","..rm)
  end

end

颜色参考=function()
  local layout={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    orientation="vertical";
    background=背景颜色;
    {
      GridView;
      id="lv";
      layout_width="-1";
      layout_height="-1";
      VerticalScrollBarEnabled=false;
    };
  };

  单对话框2(layout,"颜色参考")

  local mml={
    LinearLayout;
    layout_width="-1";
    layout_height="-2";
    orientation="vertical";
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor="#86cdcdcd";
      Radius="8dp";
      layout_width="-1";
      layout_height="-2";
      layout_margin="16dp";
      layout_marginTop="8dp";
      layout_marginBottom="8dp";
      {
        CardView;
        CardElevation="0dp";
        CardBackgroundColor=背景颜色;
        Radius=dp2px(8)-4;
        layout_margin="4px";
        layout_width="-1";
        layout_height="-1";
        {
          LinearLayout;
          layout_width="-1";
          gravity="left|center";
          layout_height="-1";
          {
            CardView;
            radius="24dp";
            layout_width="48dp";
            layout_height="48dp";
            layout_margin="16dp";
            elevation="1dp";
            {
              TextView;
              layout_width="-1";
              layout_height="-1";
              id="yb";
            };
          };
          {
            LinearLayout;
            layout_width="-1";
            layout_height="-1";
            orientation="vertical";
            gravity="left|center";
            {
              TextView;
              textSize="14sp";
              layout_height="-2";
              layout_width="-1";
              layout_marginTop="16dp";
              layout_marginLeft="16dp";
              layout_marginRight="16dp";
              id="bt";
            };
            {
              TextView;
              textColor="#ff424242";
              textSize="14sp";
              layout_height="-2";
              layout_width="-1";
              layout_marginTop="4dp";
              layout_marginBottom="16dp";
              layout_marginLeft="16dp";
              layout_marginRight="16dp";
              id="nr";

            };
            {
              TextView;
              layout_height="0";
              layout_width="0";
              id="ys";
            };
          };
        };
      };
    };
  };

  adp=LuaAdapter(activity,mml)
  function 添加项目(bt,yw,ysn)
    adp.add{
      bt={text=bt,textColor=tonumber(ysn)},
      yb={Background=ColorDrawable(tonumber(ysn))},
      nr={text=yw,textColor=tonumber(ysn)},
      ys=ysn
    }
  end

  添加项目("红色","Red","0xFFF44336")
  添加项目("粉色","Pink","0xFFE91E63")
  添加项目("紫色","Purple","0xFF9C27B0")
  添加项目("深紫","Deep Purple","0xFF673AB7")
  添加项目("靛蓝","Indigo","0xFF3F51B5")
  添加项目("蓝色","Blue","0xFF2196F3")
  添加项目("亮蓝","Light Blue","0xFF03A9F4")
  添加项目("青色","Cyan","0xFF00BCD4")
  添加项目("鸭绿","Teal","0xFF009688")
  添加项目("绿色","Green","0xFF4CAF50")
  添加项目("亮绿","Light Green","0xFF8BC34A")
  添加项目("青柠","Lime","0xFFCDDC39")
  添加项目("黄色","Yello","0xFFFFEB3B")
  添加项目("琥珀","Amber","0xFFFFC107")
  添加项目("橙色","Orange","0xFFFF9800")
  添加项目("深橙","Deep Orange","0xFFFF5722")
  添加项目("棕色","Brown","0xFF795548")
  添加项目("灰色","Grey","0xFF9E9E9E")
  添加项目("蓝灰","Blue Grey","0xFF607D8B")

  lv.Adapter=adp
  lv.onItemClick=function(l,v,p,i)
    颜色参考2(v.Tag.bt.Text,v.Tag.ys.Text,v.Tag.nr.Text)
  end

end

颜色参考2=function(bt,ys,nr)
  local layout={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    background=背景颜色;
    orientation="vertical";
    {
      ListView;
      id="lv";
      layout_width="-1";
      layout_height="-1";
      DividerHeight=0;
      VerticalScrollBarEnabled=false;
    };
  }
  local ys,ll,yw=bt,ys,nr
  local ll=tostring(ll)
  local ys=tostring(ys)
  local yw=tostring(yw)

  local mln=ll:match("0xFF(.+)")
  local zybs='#'..mln
  local zybw=tonumber("0x3F"..ll:match("0xFF(.+)"))

  单对话框(layout,bt)

  local ztskp={
    LinearLayout;
    layout_width="-1";
    layout_height="-2";
    orientation="vertical";
    onClick=function()return true end;
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor="#86cdcdcd";
      Radius="8dp";
      layout_width="-1";
      layout_height="128dp";
      layout_margin="16dp";
      layout_marginTop="8dp";
      layout_marginBottom="8dp";

      {
        CardView;
        CardElevation="0dp";
        CardBackgroundColor=背景颜色;
        Radius=dp2px(8)-4;
        layout_margin="4px";
        layout_width="-1";
        layout_height="-1";
        {
          LinearLayout;
          layout_width="-1";
          layout_height="-1";
          gravity="bottom";
          onClick=function()
            提示("已复制颜色 "..bz.Text)
            复制文本(bz.Text)
          end;
          background=zybs;
          {
            RelativeLayout;
            layout_width="-1";
            layout_height="-2";
            {
              TextView;
              layout_height="-1";
              layout_width="-1";
              textColor="#ffffffff";
              textSize="14sp";
              gravity="right|bottom";
              text="基本色";
              layout_margin="16dp";
              id="jbs";
            };
            {
              TextView;
              textColor="#ffffffff";
              textSize="14sp";
              layout_height="-1";
              gravity="left|bottom";
              layout_width="-1";
              layout_margin="16dp";
              id="bz";
            };
            {
              LinearLayout;
              layout_height="-1";
              layout_width="-1";
              id="ripped";
            };
          };
        };
      };
    };
  };

  footerview =loadlayout(ztskp)
  footerview.setLayoutParams(AbsListView.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT,ViewGroup.LayoutParams.WRAP_CONTENT--[[dp2px(120)--[[+dp(56)]]))
  lv.addHeaderView(footerview)

  bz.setText(zybs)

  local mml={
    LinearLayout;
    layout_width="-1";
    layout_height="-1";
    {
      CardView;
      CardElevation="0dp";
      CardBackgroundColor="#86cdcdcd";
      Radius="8dp";
      layout_width="-1";
      layout_height="-2";
      layout_margin="16dp";
      layout_marginTop="8dp";
      layout_marginBottom="8dp";
      {
        CardView;
        CardElevation="0dp";
        CardBackgroundColor=背景颜色;
        Radius=dp2px(8)-4;
        layout_margin="4px";
        layout_width="-1";
        layout_height="-1";
        {
          LinearLayout;
          layout_width="-1";
          layout_height="72dp";
          gravity="left|center";
          id="ym";
          {
            TextView;
            layout_width="-1";
            layout_height="-1";
            textColor="#ff212121";
            textSize="14sp";
            padding="16dp";
            layout_weight="1";
            gravity="left|center";
            id="dm";
          };
          {
            TextView;
            layout_width="-1";
            layout_height="-1";
            textColor="#ff212121";
            textSize="12sp";
            padding="8dp";
            layout_weight="1";
            gravity="right|top";
            id="md";
          };
        };
      };
    };
  };

  adp=LuaAdapter(activity,mml)
  function 添加项目(nr,sz)
    local zsml=nr:match("0xFF(.+)")
    local zsll='#'..zsml
    if sz=="50" or sz=="100" or sz=="200" or sz=="300" or sz=="400" or sz=="500" or sz=="600" or sz=="700" or sz=="800" or sz=="900" then
      if tonumber(sz)>=500 then
        zs=0xffffffff
       else
        zs=0xff212121
      end
     else
      if sz=="A100" or sz=="A200" then
        zs=0xff212121
       else
        zs=0xffffffff
      end
    end
    if sz=="500" then
      sz="基本色 500"
     elseif sz=="700" then
      sz="基本色深色 700"
     elseif sz=="A200" then
      sz="强调色 A200"
    end
    adp.add{
      dm={text=zsll,textColor=zs},
      ym={Background=ColorDrawable(tonumber(nr))},
      md={text=sz,textColor=zs}
    }
  end

  if ys=="红色" then
    添加项目("0xFFFFEBEE","50")
    添加项目("0xFFFFCDD2","100")
    添加项目("0xFFEF9A9A","200")
    添加项目("0xFFE57373","300")
    添加项目("0xFFEF5350","400")
    添加项目("0xFFF44336","500")
    添加项目("0xFFE53935","600")
    添加项目("0xFFD32F2F","700")
    添加项目("0xFFC62828","800")
    添加项目("0xFFB71C1C","900")
    添加项目("0xFFFF8A80","A100")
    添加项目("0xFFFF5252","A200")
    添加项目("0xFFFF1744","A400")
    添加项目("0xFFD50000","A700")
  end
  if ys=="粉色" then
    添加项目("0xFFFCE4EC","50")
    添加项目("0xFFF8BBD0","100")
    添加项目("0xFFF48FB1","200")
    添加项目("0xFFF06292","300")
    添加项目("0xFFEC407A","400")
    添加项目("0xFFE91E63","500")
    添加项目("0xFFD81B60","600")
    添加项目("0xFFC2185B","700")
    添加项目("0xFFAD1457","800")
    添加项目("0xFF880E4F","900")
    添加项目("0xFFFF80AB","A100")
    添加项目("0xFFFF4081","A200")
    添加项目("0xFFF50057","A400")
    添加项目("0xFFC51162","A700")
  end
  if ys=="紫色" then
    添加项目("0xFFF3E5F5","50")
    添加项目("0xFFE1BEE7","100")
    添加项目("0xFFCE93D8","200")
    添加项目("0xFFBA68C8","300")
    添加项目("0xFFAB47BC","400")
    添加项目("0xFF9C27B0","500")
    添加项目("0xFF8E24AA","600")
    添加项目("0xFF7B1FA2","700")
    添加项目("0xFF6A1B9A","800")
    添加项目("0xFF4A148C","900")
    添加项目("0xFFEA80FC","A100")
    添加项目("0xFFE040FB","A200")
    添加项目("0xFFD500F9","A400")
    添加项目("0xFFAA00FF","A700")
  end
  if ys=="深紫" then
    添加项目("0xFFEDE7F6","50")
    添加项目("0xFFD1C4E9","100")
    添加项目("0xFFB39DDB","200")
    添加项目("0xFF9575CD","300")
    添加项目("0xFF7E57C2","400")
    添加项目("0xFF673AB7","500")
    添加项目("0xFF5E35B1","600")
    添加项目("0xFF512DA8","700")
    添加项目("0xFF4527A0","800")
    添加项目("0xFF311B92","900")
    添加项目("0xFFB388FF","A100")
    添加项目("0xFF7C4DFF","A200")
    添加项目("0xFF651FFF","A400")
    添加项目("0xFF6200EA","A700")
  end
  if ys=="靛蓝" then
    添加项目("0xFFE8EAF6","50")
    添加项目("0xFFC5CAE9","100")
    添加项目("0xFF9FA8DA","200")
    添加项目("0xFF7986CB","300")
    添加项目("0xFF5C6BC0","400")
    添加项目("0xFF3F51B5","500")
    添加项目("0xFF3949AB","600")
    添加项目("0xFF303F9F","700")
    添加项目("0xFF283593","800")
    添加项目("0xFF1A237E","900")
    添加项目("0xFF8C9EFF","A100")
    添加项目("0xFF536DFE","A200")
    添加项目("0xFF3D5AFE","A400")
    添加项目("0xFF304FFE","A700")
  end
  if ys=="蓝色" then
    添加项目("0xFFE3F2FD","50")
    添加项目("0xFFBBDEFB","100")
    添加项目("0xFF90CAF9","200")
    添加项目("0xFF64B5F6","300")
    添加项目("0xFF42A5F5","400")
    添加项目("0xFF2196F3","500")
    添加项目("0xFF1E88E5","600")
    添加项目("0xFF1976D2","700")
    添加项目("0xFF1565C0","800")
    添加项目("0xFF0D47A1","900")
    添加项目("0xFF82B1FF","A100")
    添加项目("0xFF448AFF","A200")
    添加项目("0xFF2979FF","A400")
    添加项目("0xFF2962FF","A700")
  end
  if ys=="亮蓝" then
    添加项目("0xFFE1F5FE","50")
    添加项目("0xFFB3E5FC","100")
    添加项目("0xFF81D4FA","200")
    添加项目("0xFF4FC3F7","300")
    添加项目("0xFF29B6F6","400")
    添加项目("0xFF03A9F4","500")
    添加项目("0xFF039BE5","600")
    添加项目("0xFF0288D1","700")
    添加项目("0xFF0277BD","800")
    添加项目("0xFF01579B","900")
    添加项目("0xFF80D8FF","A100")
    添加项目("0xFF40C4FF","A200")
    添加项目("0xFF00B0FF","A400")
    添加项目("0xFF0091EA","A700")
  end
  if ys=="青色" then
    添加项目("0xFFE0F7FA","50")
    添加项目("0xFFB2EBF2","100")
    添加项目("0xFF80DEEA","200")
    添加项目("0xFF4DD0E1","300")
    添加项目("0xFF26C6DA","400")
    添加项目("0xFF00BCD4","500")
    添加项目("0xFF00ACC1","600")
    添加项目("0xFF0097A7","700")
    添加项目("0xFF00838F","800")
    添加项目("0xFF006064","900")
    添加项目("0xFF84FFFF","A100")
    添加项目("0xFF18FFFF","A200")
    添加项目("0xFF00E5FF","A400")
    添加项目("0xFF00B8D4","A700")
  end
  if ys=="鸭绿" then
    添加项目("0xFFE0F2F1","50")
    添加项目("0xFFB2DFDB","100")
    添加项目("0xFF80CBC4","200")
    添加项目("0xFF4DB6AC","300")
    添加项目("0xFF26A69A","400")
    添加项目("0xFF009688","500")
    添加项目("0xFF00897B","600")
    添加项目("0xFF00796B","700")
    添加项目("0xFF00695C","800")
    添加项目("0xFF004D40","900")
    添加项目("0xFFA7FFEB","A100")
    添加项目("0xFF64FFDA","A200")
    添加项目("0xFF1DE9B6","A400")
    添加项目("0xFF00BFA5","A700")
  end
  if ys=="绿色" then
    添加项目("0xFFE8F5E9","50")
    添加项目("0xFFC8E6C9","100")
    添加项目("0xFFA5D6A7","200")
    添加项目("0xFF81C784","300")
    添加项目("0xFF66BB6A","400")
    添加项目("0xFF4CAF50","500")
    添加项目("0xFF43A047","600")
    添加项目("0xFF388E3C","700")
    添加项目("0xFF2E7D32","800")
    添加项目("0xFF1B5E20","900")
    添加项目("0xFFB9F6CA","A100")
    添加项目("0xFF69F0AE","A200")
    添加项目("0xFF00E676","A400")
    添加项目("0xFF00C853","A700")
  end
  if ys=="亮绿" then
    添加项目("0xFFF1F8E9","50")
    添加项目("0xFFDCEDC8","100")
    添加项目("0xFFC5E1A5","200")
    添加项目("0xFFAED581","300")
    添加项目("0xFF9CCC65","400")
    添加项目("0xFF8BC34A","500")
    添加项目("0xFF7CB342","600")
    添加项目("0xFF689F38","700")
    添加项目("0xFF558B2F","800")
    添加项目("0xFF33691E","900")
    添加项目("0xFFCCFF90","A100")
    添加项目("0xFFB2FF59","A200")
    添加项目("0xFF76FF03","A400")
    添加项目("0xFF64DD17","A700")
  end
  if ys=="青柠" then
    添加项目("0xFFF9FBE7","50")
    添加项目("0xFFF0F4C3","100")
    添加项目("0xFFE6EE9C","200")
    添加项目("0xFFDCE775","300")
    添加项目("0xFFD4E157","400")
    添加项目("0xFFCDDC39","500")
    添加项目("0xFFC0CA33","600")
    添加项目("0xFFAFB42B","700")
    添加项目("0xFF9E9D24","800")
    添加项目("0xFF827717","900")
    添加项目("0xFFF4FF81","A100")
    添加项目("0xFFEEFF41","A200")
    添加项目("0xFFC6FF00","A400")
    添加项目("0xFFAEEA00","A700")
  end
  if ys=="黄色" then
    添加项目("0xFFFFFDE7","50")
    添加项目("0xFFFFF9C4","100")
    添加项目("0xFFFFF59D","200")
    添加项目("0xFFFFF176","300")
    添加项目("0xFFFFEE58","400")
    添加项目("0xFFFFEB3B","500")
    添加项目("0xFFFDD835","600")
    添加项目("0xFFFBC02D","700")
    添加项目("0xFFF9A825","800")
    添加项目("0xFFF57F17","900")
    添加项目("0xFFFFFF8D","A100")
    添加项目("0xFFFFFF00","A200")
    添加项目("0xFFFFEA00","A400")
    添加项目("0xFFFFD600","A700")
  end
  if ys=="琥珀" then
    添加项目("0xFFFFF8E1","50")
    添加项目("0xFFFFECB3","100")
    添加项目("0xFFFFE082","200")
    添加项目("0xFFFFD54F","300")
    添加项目("0xFFFFCA28","400")
    添加项目("0xFFFFC107","500")
    添加项目("0xFFFFB300","600")
    添加项目("0xFFFFA000","700")
    添加项目("0xFFFF8F00","800")
    添加项目("0xFFFF6F00","900")
    添加项目("0xFFFFE57F","A100")
    添加项目("0xFFFFD740","A200")
    添加项目("0xFFFFC400","A400")
    添加项目("0xFFFFAB00","A700")
  end
  if ys=="橙色" then
    添加项目("0xFFFFF3E0","50")
    添加项目("0xFFFFE0B2","100")
    添加项目("0xFFFFCC80","200")
    添加项目("0xFFFFB74D","300")
    添加项目("0xFFFFA726","400")
    添加项目("0xFFFF9800","500")
    添加项目("0xFFFB8C00","600")
    添加项目("0xFFF57C00","700")
    添加项目("0xFFEF6C00","800")
    添加项目("0xFFE65100","900")
    添加项目("0xFFFFD180","A100")
    添加项目("0xFFFFAB40","A200")
    添加项目("0xFFFF9100","A400")
    添加项目("0xFFFF6D00","A700")
  end
  if ys=="深橙" then
    添加项目("0xFFFBE9E7","50")
    添加项目("0xFFFFCCBC","100")
    添加项目("0xFFFFAB91","200")
    添加项目("0xFFFF8A65","300")
    添加项目("0xFFFF7043","400")
    添加项目("0xFFFF5722","500")
    添加项目("0xFFF4511E","600")
    添加项目("0xFFE64A19","700")
    添加项目("0xFFD84315","800")
    添加项目("0xFFBF360C","900")
    添加项目("0xFFFF9E80","A100")
    添加项目("0xFFFF6E40","A200")
    添加项目("0xFFFF3D00","A400")
    添加项目("0xFFDD2C00","A700")
  end
  if ys=="棕色" then
    添加项目("0xFFEFEBE9","50")
    添加项目("0xFFD7CCC8","100")
    添加项目("0xFFBCAAA4","200")
    添加项目("0xFFA1887F","300")
    添加项目("0xFF8D6E63","400")
    添加项目("0xFF795548","500")
    添加项目("0xFF6D4C41","600")
    添加项目("0xFF5D4037","700")
    添加项目("0xFF4E342E","800")
    添加项目("0xFF3E2723","900")
  end
  if ys=="灰色" then
    添加项目("0xFFFAFAFA","50")
    添加项目("0xFFF5F5F5","100")
    添加项目("0xFFEEEEEE","200")
    添加项目("0xFFE0E0E0","300")
    添加项目("0xFFBDBDBD","400")
    添加项目("0xFF9E9E9E","500")
    添加项目("0xFF757575","600")
    添加项目("0xFF616161","700")
    添加项目("0xFF424242","800")
    添加项目("0xFF212121","900")
  end
  if ys=="蓝灰" then
    添加项目("0xFFECEFF1","50")
    添加项目("0xFFCFD8DC","100")
    添加项目("0xFFB0BEC5","200")
    添加项目("0xFF90A4AE","300")
    添加项目("0xFF78909C","400")
    添加项目("0xFF607D8B","500")
    添加项目("0xFF546E7A","600")
    添加项目("0xFF455A64","700")
    添加项目("0xFF37474F","800")
    添加项目("0xFF263238","900")
  end

  lv.Adapter=adp
  lv.onItemClick=function(l,v,p,i)
    local xm=tostring(v.Tag.dm.Text)
    复制文本(xm)
    提示("已复制颜色:"..xm,1)
    xm=nil
  end

end

