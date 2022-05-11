require "import"
import "mod"
import "layout"
activity.setTitle('GGScript')

页面主题自动设置()

activity.setContentView(loadlayout(layout))

local m = {

  { MenuItem,
    title = "新建",
    id = "xinjian", },
  { MenuItem,
    title = "模板",
    id = "moban", },
  { MenuItem,
    title = "手册",
    id = "doc", },
  { MenuItem,
    title = "lua手册",
    id = "luadoc", }
}

optmenu = {}
function onCreateOptionsMenu(menu)
  loadmenu(menu, m, optmenu, 0)
end

function switch2(s)
  return function(t)
    local f = t[s]
    if not f then
      for k, v in pairs(t) do
        if s.equals(k) then
          f = v
          break
        end
      end
    end
    f = f or t.default2
    return f and f()
  end
end

function donothing()
  提示("功能开发中")
end

function onMenuItemSelected(id, item)
  switch2(item) {
    default2 = function()
      提示("功能开发中。。。")
    end,
    [optmenu.xinjian]=func.xinjian,
    [optmenu.moban]=func.moban,
    [optmenu.doc]=func.doc,
    [optmenu.luadoc]=func.luadoc,
  }
end

func={}

func.xinjian=function()
  local layout={
    LinearLayout;
    layout_width="fill";
    background="nil";
    padding="10dp";
    {
      CardView;
      radius="2dp";
      layout_margin="5dp";
      layout_weight="1";
      Elevation="0";

      {
        EditText;
        layout_width="fill";
        background="#00000000";
        textSize="14sp";
        id="edit";
        Hint="请输入文件名称",
        singleLine=true,
        textColor=其他字体;
        padding="10dp";
      };
    };
  };

  AlertDialog.Builder(this)
  .setTitle("创建文件")
  .setView(loadlayout(layout))
  .setPositiveButton("创建",{onClick=function()
      if edit.Text~="" then
        local _name=edit.Text

        if not File(脚本列表).exists() then
          os.execute('mkdir '..脚本列表)
        end
        写入文件2(脚本列表.._name..".lua","")
        加载列表()
       else
        提示("您未输入如何字符",3)
      end
    end})
  .setNegativeButton("取消",nil)
  .show()
end

func.moban=function()
  渐变跳转页面("moban")
end

func.doc=function()
  渐变跳转页面("doc")
end

func.luadoc=function()
  activity.newActivity("../luadoc")
end


local AppListItem={
  LinearLayout,
  layout_width="-1",
  layout_height="-2",
  {
    CardView;
    CardElevation="0";
    CardBackgroundColor="#86cdcdcd";
    Radius="8dp";
    layout_width="-1";
    layout_height="-2";
    layout_marginTop="5dp",
    layout_marginBottom="5dp",
    layout_marginLeft="20dp",
    layout_marginRight="20dp",
    {
      CardView,
      layout_width="-1",
      layout_height="-1",
      Radius=dp2px(8)-4;
      layout_margin="4px";
      {
        LinearLayout,
        layout_width="-1",
        layout_height="-2",
        orientation="center",
        layout_margin="6dp";
        {
          LinearLayout,
          layout_weight="1",
          layout_height="-2",
          orientation="vertical",
          {
            TextView,
            id="title",
            textSize="16sp",
            layout_width="-2",
            gravity="left",
            layout_marginBottom="2dp",
          },
          {
            TextView,
            id="nr",
            textSize="12sp",
            layout_width="-2",
            gravity="left",
            layout_marginBottom="2dp",
          },
        },
      },
    },
  },
}
AppListAdp=LuaAdapter(activity,AppListItem)
List.setAdapter(AppListAdp)

脚本路径="/sdcard/小工具GGScript"
脚本列表=脚本路径.."/"

加载列表=function()
  AppListAdp.clear()--清空
  if not File(脚本列表).exists() then
    AppListAdp.add{
      title="哎呀，您好像没有创建任何文件",
      nr="请点击右上角创建一个吧",
    }
   else
    文件列表=luajava.astable(File(脚本列表).listFiles())
    if not 文件列表[1] then
      AppListAdp.add{
        title="哎呀，您好像没有创建任何文件",
        nr="请点击右上角创建一个吧",
      }
      os.remove (脚本路径)
      加载列表()
    end
    for i=1,#文件列表 do
      local 标题=tostring(文件列表[i])
      local 标题=标题:match(".*/(.-).lua")
      AppListAdp.add{
        title=标题,
        nr=获取文件最后修改时间(tostring(文件列表[i]))
      }
    end
  end
end

加载列表()


--列表项目被长按
List.onItemLongClick=function(p,v,i,s)
  local title=tostring(v.Tag.title.Text)
  if title~="哎呀，您好像没有创建任何文件"then
    local 路径=脚本列表..title..".lua"
    local pop=PopupMenu(activity,v)
    local menu=pop.Menu
    menu.add("重命名").onMenuItemClick=function(a)
      local layout={
        LinearLayout;
        layout_width="fill";
        background="nil";
        padding="10dp";
        {
          CardView;
          radius="2dp";
          layout_margin="5dp";
          layout_weight="1";
          Elevation="0";

          {
            EditText;
            layout_width="fill";
            background="#00000000";
            textSize="14sp";
            id="edit";
            Hint="请输入文件的新名称",
            singleLine=true,
            textColor=其他字体;
            padding="10dp";
            Text=title;
          };
        };
      };

      AlertDialog.Builder(this)
      .setTitle("重命名文件")
      .setView(loadlayout(layout))
      .setPositiveButton("重命名",{onClick=function()
          if edit.Text~="" then
            local _name=edit.Text
            local 新脚本路径=脚本列表.._name..".lua"
            os.rename (路径, 新脚本路径)
            加载列表()
           else
            提示("您未输入如何字符",3)
          end
        end})
      .setNegativeButton("取消",nil)
      .show()
    end
    menu.add("详细").onMenuItemClick=function(a)
      local 字符数=io.open(路径):read("*a")
      local 字符数=tostring(统计字符(字符数))

      local filemd5=LuaUtil.getFileMD5(路径);
      local filemd5=tostring(filemd5)

      local nrr="脚本名称："..title.."\n\n路径:\n"..路径.."\n\n".."文件大小:"..tostring(获取文件大小(路径)).."\n\n字符数:"..字符数.."\n\n文件MD5:\n"..filemd5.."\n\n文件最后修改时间:\n"..获取文件最后修改时间(路径)
      AlertDialog.Builder(this)
      .setTitle("脚本信息")
      .setMessage(nrr)
      .setPositiveButton("复制路径",{onClick=function()
          复制文本(路径)
          提示("已经复制路径",1)
        end})
      .setNegativeButton("取消",nil)
      .show()
    end
    menu.add("分享").onMenuItemClick=function(a)
      分享文件(路径)
    end
    menu.add("删除").onMenuItemClick=function(a)

      --普通对话框
      AlertDialog.Builder(this)
      .setTitle("删除脚本")
      .setMessage("您确定要删除“"..title.."”".."吗？")
      .setPositiveButton("删除",{onClick=function(v)
          os.remove (路径)
          提示("已经删除:"..title,1)
          加载列表()
        end})
      .setNegativeButton("取消",nil)
      .show()
    end
    pop.show()
  end
  return true
end

--列表点击
List.onItemClick=function(p,v,i,s)
  local title=tostring(v.Tag.title.Text)
  if title~="哎呀，您好像没有创建任何文件"then
    渐变跳转页面("sjjm",{title})
  end
  return true
end

界面退出()

function onResume()
  加载列表()
end
