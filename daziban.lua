require "import"
import "My bag"

sft={...}
tx=string.gsub(sft[1],"%s%p","")
locallayout={
  FrameLayout;
  layout_height="-1";
  layout_width="-1";
  background="nil";
  LinearLayout;
  background="#000000";
  layout_height="fill";
  layout_width="fill";
  id="dj",
  {
    ScrollView,
    layout_width="-1";
    VerticalScrollBarEnabled=false;
    layout_height="-1";
    {
      LinearLayout;
      background="#000000";
      layout_height="fill";
      layout_width="fill";
      gravity="center";
      id="d",
      {
        TextView;
        layout_height="-1";
        id="txt";
        layout_width="-1";
        layout_margin="10dp";
        textSize="130sp",
        Text=tx,
        TextColor="#FFFFFF",
        gravity="center";
        layout_margin="5dp";
        layout_gravity="center";
        --跑马灯
        --   ellipsize="marquee",
        --    focusable=true,
        --    focusableInTouchMode=true,
        -- singleLine=true,
      };
    };
  };
  {
    LinearLayout;
    layout_gravity="bottom";
    layout_width="-1";
    layout_height="-2";
    layout_marginBottom="20dp";
    {
      SeekBar;
      max=1000;
      id="seekbar";
      layout_width="-1";
    };
  };
};



防止屏幕休眠()
activity.setTitle(sft[2])
activity.setContentView(loadlayout(locallayout))


function seekbar显示控制()
  if not sbk then
    sdb=true
    --控件显示
    seekbar.setVisibility(View.VISIBLE)
    task(3000,function()
      sdb=nil
      --控件隐藏
      seekbar.setVisibility(View.GONE)
    end)
  end
end

seekbar显示控制()

txt.onClick=function()
  seekbar显示控制()
  if not DJ then
    DJ=true
    dj.setBackgroundColor(0xffffffff)
    d.setBackgroundColor(0xffffffff)
    txt.setTextColor(int("0xff000000"))
    seekbar.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xff000000,PorterDuff.Mode.SRC_ATOP))
    seekbar.Thumb.setColorFilter(PorterDuffColorFilter(0xff000000,PorterDuff.Mode.SRC_ATOP))
   else
    DJ=nil
    dj.setBackgroundColor(0xff000000)
    d.setBackgroundColor(0xff000000)
    txt.setTextColor(int("0xffffffff"))
    seekbar.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xffffffff,PorterDuff.Mode.SRC_ATOP))
    seekbar.Thumb.setColorFilter(PorterDuffColorFilter(0xffffffff,PorterDuff.Mode.SRC_ATOP))
  end
end

seekbar.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xffffffff,PorterDuff.Mode.SRC_ATOP))
seekbar.Thumb.setColorFilter(PorterDuffColorFilter(0xff000000,PorterDuff.Mode.SRC_ATOP))

seekbar.setOnSeekBarChangeListener{
  onProgressChanged=function(v,i)
    pcall(function()
      txt.setTextSize(px2dp(i))
    end)
  end}


全屏()

local yx1=function()
  屏幕方向("自动旋转")
end
local yx2=function()
  --横屏模式
  activity.setRequestedOrientation(0);
end
xpcall(yx1,yx2)
设置全透明主题()
界面退出()

