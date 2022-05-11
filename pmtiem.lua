require "import"
import "My bag"

locallayout={

  LinearLayout;
  background="#000000";
  orientation="vertical";
  gravity="center";
  layout_height="fill";
  layout_width="fill";
  id="dj",
  {
    FrameLayout;
    layout_height="-1";
    layout_width="-1";
    background="nil";
    {
      TextView;
      textColor="#FFFFFF";
      textSize="100sp";
      layout_gravity="center";
      id="sj";
      layout_height="-2";
      layout_width="-2";
      Text=os.date("%H:%M:%S"),
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

}
防止屏幕休眠()
activity.setTitle('屏幕时间')
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

全屏()
--横屏
local yx1=function()
  屏幕方向("自动旋转")
end
local yx2=function()
  --横屏模式
  activity.setRequestedOrientation(0);
end
xpcall(yx1,yx2)
导航栏透明()
设置主题()

--Ticker定时器
ti=Ticker()
ti.Period=1000
ti.onTick=function()
  --事件
  sj.setText(os.date("%H:%M:%S"))
end

--启动Ticker定时器
ti.start()


sj.onClick=function()
  seekbar显示控制()
  if not DJ then
    DJ=true
    dj.setBackgroundColor(0xffffffff)
    sj.setTextColor(int("0xff000000"))
    seekbar.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xff000000,PorterDuff.Mode.SRC_ATOP))
    seekbar.Thumb.setColorFilter(PorterDuffColorFilter(0xff000000,PorterDuff.Mode.SRC_ATOP))

   else
    DJ=nil
    dj.setBackgroundColor(0xff000000)
    sj.setTextColor(int("0xffffffff"))
    seekbar.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xffffffff,PorterDuff.Mode.SRC_ATOP))
    seekbar.Thumb.setColorFilter(PorterDuffColorFilter(0xffffffff,PorterDuff.Mode.SRC_ATOP))
  end
end

seekbar.ProgressDrawable.setColorFilter(PorterDuffColorFilter(0xffffffff,PorterDuff.Mode.SRC_ATOP))
seekbar.Thumb.setColorFilter(PorterDuffColorFilter(0xff000000,PorterDuff.Mode.SRC_ATOP))

seekbar.setOnSeekBarChangeListener{
  onProgressChanged=function(v,i)
    pcall(function()
      sj.setTextSize(px2dp(i))
    end)
  end}


local shijian=0
function onKeyDown(code,event)
  if string.find(tostring(event),"KEYCODE_BACK") ~= nil then
    if shijian+2 > tonumber(os.time()) then
      --停止Ticker定时器
      ti.stop()
      ti=nil
      activity.finish()--关闭当前页面
      activity.overridePendingTransition(android.R.anim.fade_in,android.R.anim.fade_out)
    end
    --提示("再按一次返回键退出",nil,"18dp")
    shijian=tonumber(os.time())
    return true
  end
end
