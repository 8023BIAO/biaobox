require "import"
import "My bag"

layout={
  LinearLayout,
  layout_width="fill",
  layout_height="fill",
  orientation="vertical";
  fitsSystemWindows="true";
  {
    LuaEditor,
    id="txt",
    text="",
    --padding="10dp";
    layout_width="fill",
    layout_weight=1 ,
  },
  {
    HorizontalScrollView;
    horizontalScrollBarEnabled=false,
    {
      LinearLayout;
      id="ps_bar";
      layout_width="fill";
    };
    layout_width="fill";
  };
},

activity.setTitle('Lua代码运行')
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

activity.setTheme(autotheme())
activity.getWindow().setSoftInputMode(0x10)
activity.getWindow().setFormat(PixelFormat.TRANSLUCENT);
activity.getActionBar().setDisplayShowHomeEnabled(false)
activity.setContentView(loadlayout(layout))

pcall(function()
  --activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION);
  activity.getWindow().setNavigationBarColor(int(0xff303030));
end)


luapath=luajava.luapath

function click(v)
  if (v.Text == "TAB") then
    txt.paste(" ")
   elseif (v.Text == "Fun") then
    txt.paste("function")
   else
    txt.paste(v.Text)
  end
end

function newButton(text)
  local btn = TextView()
  btn.TextSize = 20;
  local pd = btn.TextSize / 2
  btn.setPadding(pd, pd / 2, pd, pd / 4)
  btn.Text = text
  btn.setBackgroundDrawable(sd)
  btn.onClick = click
  return btn
end
local ps = {"Fun","TAB","()","(", ")", "[", "]", "{", "}", "\"", "=", ":", ".", ",", "_", "+", "-", "*", "!","/", "\\", "%", "#", "^", "$", "?", "&", "|", "<", ">", "~", ";", "'" };
for k, v in ipairs(ps) do
  ps_bar.addView(newButton(v))
end


mt =
{
  { MenuItem,
    title = "运行",
    id = "play",
    icon = "res/icon/play.png", },
  { MenuItem,
    title = "撤销",
    id = "undo",
    icon = "res/icon/undo.png", },
  { MenuItem,
    title = "重做",
    id = "redo",
    icon = "res/icon/redo.png", },
  { MenuItem,
    title = "格式化",
    id = "txtformat",},
  { MenuItem,
    title = "查错",
    id = "check",},
  { MenuItem,
    title = "查找",
    id = "search",},
  { MenuItem,
    title = "导航",
    id = "navi",},
  { MenuItem,
    title = "转到",
    id = "gotoLine",},
  { MenuItem,
    title = "手册",
    id = "manual",},

}


optmenu = {}
function onCreateOptionsMenu(menu)
  loadmenu(menu, mt, optmenu, 3)
end

play = function()
  if txt.Text=="" then
   else
    local src = txt.getText()
    src = src.toString()
    if luapath:find("%.aly$") then
      src = "return " .. src
    end

    local _, data = loadstring(src)

    if data then
      local _, _, line, data = data:find(".(%d+).(.+)")
      txt.gotoLine(tonumber(line))
      --  Toast.makeText(activity, line.."行" .. ":" .. data, Toast.LENGTH_SHORT ).show()
      提示(line.. ":" .. data)
      return true
     elseif a then
     else
      -- Toast.makeText(activity, "没有语法错误", Toast.LENGTH_SHORT ).show()
      --txt.format()
      -- loadstring(txt.Text)()
      str=tostring(txt.Text)
      activity.newActivity("runlua",android.R.anim.fade_in,android.R.anim.fade_out,{str})
    end
  end
end


manual= function()
  activity.newActivity("luadoc")
end


check = function(b)
  local src = txt.getText()
  src = src.toString()
  if luapath:find("%.aly$") then
    src = "return " .. src
  end
  local _, data = loadstring(src)

  if data then
    local _, _, line, data = data:find(".(%d+).(.+)")
    txt.gotoLine(tonumber(line))
    Toast.makeText(activity, line .. ":" .. data, Toast.LENGTH_SHORT ).show()
    return true
   elseif b then
   else
    --Toast.makeText(activity, "没有语法错误", Toast.LENGTH_SHORT ).show()
    提示("没有语法错误")
  end
end

navi = function()
  create_navi_dlg()
  local str = txt.getText().toString()
  local fs = {}
  indexs = {}
  for s, i in str:gmatch("([\u4e00-\u9fa5 %w%._]* *=? *function *[\u4e00-\u9fa5 %w%._]*%b())()") do
    i = utf8.len(str, 1, i) - 1
    s = s:gsub("^ +", "")
    table.insert(fs, s)
    table.insert(indexs, i)
    fs[s] = i
  end
  if not fs[1] then
    fs={[1]="暂时没有可导航的"}
  end
  local adapter = ArrayAdapter(activity, android.R.layout.simple_list_item_1, String(fs))
  navi_list.setAdapter(adapter)
  navi_dlg.show()
end

--创建对话框
function create_navi_dlg()
  if navi_dlg then
    return
  end
  navi_dlg = Dialog(activity)
  navi_dlg.setTitle("导航")
  navi_list = ListView(activity)
  navi_list.onItemClick = function(parent, v, pos, id)
    txt.setSelection(indexs[pos + 1])
    navi_dlg.hide()
  end
  navi_dlg.setContentView(navi_list)
end


function onMenuItemSelected(id, item)
  switch tostring(item)
   case "运行"
    play()
    return true
   case "撤销"
    txt.undo()
    return true
   case "重做"
    txt.redo()
    return true
   case "格式化"
    txt.format()
    return true
   case "查错"
    check()
    return true
   case "查找"
    txt.search()
    return true
   case "导航"
    navi()
    return true
   case "转到"
    txt.gotoLine()
    return true
   case "手册"
    manual()
    return true
  end
end

local tou=[[--程序自带xpcall





]]

txt.setText(tou)
导航栏透明()
界面退出()
