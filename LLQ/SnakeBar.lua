require "import"
import "android.widget.*"
import "android.view.*"
import "android.graphics.drawable.BitmapDrawable"
import "android.view.animation.LayoutAnimationController"
import "android.view.animation.Animation"
import "android.view.animation.AlphaAnimation"
import "android.view.animation.TranslateAnimation"
import "android.view.animation.AnimationSet"
import "android.view.animation.TranslateAnimation"
import "android.view.animation.Animation$AnimationListener"

SnakeBar = {}
local a=true

function SnakeBar:show(str,color,time,funm,fun)
  if color==nil then
    color="#ff212121"
  end
  if a==true then
    a=false

    SnakeBarLayout={
      LinearLayout,
      orientation="horizontal",
      background=color,
      layout_width="fill",
      layout_height="fill",
      id="SnakeBarId",
      {
        TextView,
        layout_height="fill",
        layout_width="0",
        layout_weight="4",
        layout_marginLeft="3%w",
        Gravity="center_vertical",
        Text=str,
        padding="30",
        textColor="#ffffff",
      },
      {
        TextView,
        layout_height="fill",
        layout_width="0",
        layout_weight="1",
        layout_marginRight="3%w",
        Gravity="center",
        Text=funm,
        padding="30",
        textColor="#FF029184",
        id="SnakeBarPositiveId",
      },
    }
    
    pop=PopupWindow(activity)
    pop.setContentView(loadlayout(SnakeBarLayout))
    pop.setWidth(-1)
    pop.setOutsideTouchable(false)
    pop.setBackgroundDrawable(BitmapDrawable(loadbitmap("xxx.png")))
    pop.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE);
    pop.showAtLocation(view,Gravity.BOTTOM,0,0)

    Translate_up=TranslateAnimation(0, 0,130,0)
    Translate_up.setDuration(time)
    SnakeBarId.startAnimation(Translate_up)
    Translate_up.setAnimationListener(AnimationListener{
      onAnimationEnd=function()
        Translate_stop=TranslateAnimation(0,0,0,0)
        Translate_stop.setDuration(1500)
        SnakeBarId.startAnimation(Translate_stop)
        Translate_stop.setAnimationListener(AnimationListener{
          onAnimationEnd=function()
            Translate_down=TranslateAnimation(0, 0,0,130)
            Translate_down.setDuration(time)
            SnakeBarId.startAnimation(Translate_down)
            Translate_down.setAnimationListener(AnimationListener{
              onAnimationEnd=function()
                pop.dismiss()
                a=true
              end
            })
          end
        })
      end
    })

    SnakeBarPositiveId.onClick=function()
      Translate_down=TranslateAnimation(0, 0,0,130)
      Translate_down.setDuration(time)
      SnakeBarId.startAnimation(Translate_down)
      Translate_down.setAnimationListener(AnimationListener{
        onAnimationEnd=function()
          pop.dismiss()
          a=true
          fun()
        end
      })
    end
  end
end