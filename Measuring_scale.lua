
require "import"
import "My bag"

--各种单位之间转换函数
function dpTopx(sdp)
  import "android.util.TypedValue"
  dm=this.getResources().getDisplayMetrics()
  types={px=0,dp=1,sp=2,pt=3,["in"]=4,mm=5}
  n,ty=sdp:match("^(%-?[%.%d]+)(%a%a)$")
  return TypedValue.applyDimension(types[ty],tonumber(n),dm)
end


mm=dpTopx("1mm")

layout1={
  FrameLayout,
  layout_height="fill";
  layout_width="fill";

  {
    LinearLayout;
    orientation="vertical";
    layout_height="fill";
    layout_width="fill";
    Gravity="center|top",
    {
      TextView;
      layout_height="300",
      layout_width="fill",
      layout_marginLeft="40",
      id="tv",
    };
  },

  {
    LinearLayout,
    layout_height="fill",
    layout_width="fill",
    Gravity="center",
    {
      TextView,
      layout_height="300",
      layout_width="300",
      text=tostring(0),
      Gravity="center",
      textColor="#ffffff",
      textSize="60",
      id="tv4",
    },
  },

  {
    LinearLayout,
    layout_height="fill",
    layout_width="fill",
    Gravity="center",
    {
      TextView,
      layout_height="300",
      layout_width="300",
      text=tostring(0),
      Gravity="center",
      paddingTop="150",
      paddingLeft="150",
      textColor="#ffffff",
      textSize="30",
      id="tv5",
    },
  },

  {
    LinearLayout,
    orientation="vertical",
    layout_height="fill",
    layout_width="fill",
    id="tv2",
    {
      LinearLayout,
      layout_height="fill",
      layout_width=mm*2,
      Gravity="center",
      layout_marginLeft="30"+mm,
      id="tv3",
      {
        TextView,
        layout_height="fill",
        layout_width="4",
        background="#808080",
      },
    },
  },

}

activity.setContentView(loadlayout(layout1))

myLuaDrawable=LuaDrawable(function(mCanvas,mPaint,mDrawable)

  --画笔属性
  mPaint.setColor(0xFF000000)
  mPaint.setAntiAlias(true)
  mPaint.setStrokeWidth(2)
  mPaint.setStyle(Paint.Style.FILL)
  mPaint.setStrokeCap(Paint.Cap.ROUND)
  mPaint.setTextSize(28)


  MaxPx=mDrawable.getBounds().right-30

  MaxMm=math.ceil(MaxPx/100)

  mCanvas.drawColor(0xffcdcdcd)


  for i=0,MaxMm*10 do

    if i%10==0 then

      mCanvas.drawLine(mm*i+mm,0,mm*i+mm,80,mPaint)


      mCanvas.drawText(tostring(math.modf(i/10)),(mm*i+mm)-mm/2 ,120, mPaint)

     elseif i%5==0 then

      mCanvas.drawLine(mm*i+mm,0,mm*i+mm,60,mPaint)

     else

      mCanvas.drawLine(mm*i+mm,0,mm*i+mm,40,mPaint)

    end

  end


end)


--绘制的Drawble设置成控件背景
tv.background=myLuaDrawable

tv2.onTouch=function(v,e)

  a=e.getAction()&255

  switch a

   case MotionEvent.ACTION_DOWN


   case MotionEvent.ACTION_MOVE

    moveX=e.getX()
    tv3.setTranslationX(moveX)

    --print("≈"..math.floor(moveX/mw).."mm")

    a=math.floor((moveX/mm)/10)

    --向上取整
    tv4.Text=tostring(math.floor((moveX/mm)/10))

    --向上取整
    tv5.Text=tostring(math.floor(moveX/mm)-a*10)


   case MotionEvent.ACTION_UP

  end

  return true
end



myLuaDrawable2=LuaDrawable(function(mCanvas,mPaint,mDrawable)

  --画笔属性
  mPaint.setColor(0xFF636562)
  mPaint.setAntiAlias(true)
  mPaint.setStrokeWidth(20)
  mPaint.setStyle(Paint.Style.STROKE)

  --mCanvas.drawColor(0xffffeeaa)

  mCanvas.drawCircle(150, 150, 100, mPaint);

  mPaint.setColor(0xFF9C9A9D)
  mPaint.setStyle(Paint.Style.FILL)

  mCanvas.drawCircle(150, 150, 90, mPaint);

end)


--绘制的Drawble设置成控件背景
tv4.background=myLuaDrawable2


myLuaDrawable3=LuaDrawable(function(mCanvas,mPaint,mDrawable)

  --画笔属性
  mPaint.setColor(0xFF434542)
  mPaint.setAntiAlias(true)
  mPaint.setStrokeWidth(20)
  mPaint.setStyle(Paint.Style.FILL)

  mCanvas.drawCircle(225, 225, 50, mPaint);


end)

tv5.background=myLuaDrawable3

--横屏模式
activity.setRequestedOrientation(0);

全屏()

界面退出()