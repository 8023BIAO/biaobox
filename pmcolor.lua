require "import"
import "My bag"
layout={
  LinearLayout;
  layout_width="-1";
  layout_height="-1";
  {
    PageView;
    layout_height="-1";
    layout_width="-1";
    pages={
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        background="#000000";
      };
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        background="#FFFFFF";
      };
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        id="渐变1"
      };
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        id="渐变2"
      };
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        id="渐变3"
      };
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        id="渐变4"
      };
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        background="#FF0000";
      };
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        background="#0000FF";
      };
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        background="#00FF00",
      };
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        id="黑白"
      };
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        id="颜色渐变"
      };
      {
        LinearLayout;
        layout_width="-1";
        layout_height="-1";
        id="饱和度"
      };
    };
  };
};

activity.setContentView(loadlayout(layout))

drawable = GradientDrawable(GradientDrawable.Orientation.LEFT_RIGHT,{
  0xFFFFFFFF,
  0xFF000000,
});
渐变1.setBackgroundDrawable(drawable)

drawable = GradientDrawable(GradientDrawable.Orientation.LEFT_RIGHT,{
  0xFF000000,
  0xffff0000,
});
渐变2.setBackgroundDrawable(drawable)
drawable = GradientDrawable(GradientDrawable.Orientation.LEFT_RIGHT,{
  0xFF000000,
  0xff0000ff,
});
渐变3.setBackgroundDrawable(drawable)
drawable = GradientDrawable(GradientDrawable.Orientation.LEFT_RIGHT,{
  0xFF000000,
  0xff00ff00,
});
渐变4.setBackgroundDrawable(drawable)
drawable = GradientDrawable(GradientDrawable.Orientation.LEFT_RIGHT,{
  0xFFFF01DE,
  0xFFFF000A,
  0xFFFFC100,
  0xFF40FF01,
  0xFF00FF75,
  0xFF00FFF7,
  0xFF0008FF,
});
饱和度.setBackgroundDrawable(drawable)

渐变(颜色渐变,30000,{0xFFFFFFFF,0xFF000000})

xx=true
循环=function()
  黑白.setBackgroundColor(0xFFFFFFFF)
  task(2000,function()
    黑白.setBackgroundColor(0xFF000000)
    task(2000,function()
      循环()
    end)
  end)
end

循环()

提示("依次右滑查看结果>>>")
全屏()
设置全透明主题()
if (Build.VERSION.SDK_INT >=19) then
  --activity. getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);--设置半透明状态栏
  activity. getWindow().addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION);--设置透明导航栏
  --隐藏导航栏
  activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION);
end


界面退出()





