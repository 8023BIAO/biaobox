require "import"
import "mod"

local layout={
  LinearLayout,
  layout_width="fill";
  gravity="center";
  orientation="vertical";
  layout_height="fill";
  {
    LuaEditor,
    id="txt",
    text="",
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
}



local cans={...}
local name=tostring(cans[1])
local 路径="/storage/emulated/0/小工具GGScript/"..name..".lua"
local 文件=io.open(路径):read("*a")

页面主题自动设置()
activity.setTitle(name)
activity.getWindow().setSoftInputMode(0x10)
activity.getWindow().setFormat(PixelFormat.TRANSLUCENT);
activity.getActionBar().setDisplayShowHomeEnabled(false)
activity.setContentView(loadlayout(layout))

history = {}

function write(path, str)
  local sw = io.open(path, "wb")
  if sw then
    sw:write(str)
    sw:close()
   else
    Toast.makeText(activity, "保存失败." .. path, Toast.LENGTH_SHORT ).show()
  end
  return str
end

luapath= luapath or 路径

function save()
  history[luapath] = txt.getSelectionEnd()
  local str = ""
  local f = io.open(luapath, "r")
  if f then
    str = f:read("*all")
    f:close()
  end
  local src = txt.getText().toString()
  if src ~= str then
    write(luapath, src)
  end

  return src
end

local m = {
  { MenuItem,
    title = "撤销",
    id = "undo",
    icon = "../res/icon/undo", },
  { MenuItem,
    title = "重做",
    id = "redo",
    icon = "../res/icon/redo", },
  { MenuItem,
    title = "保存",
    id = "seve", },
  { MenuItem,
    title = "模板",
    id = "moban", },
  { MenuItem,
    title = "手册",
    id = "doc", },
  { MenuItem,
    title = "lua手册",
    id = "luadoc", },
  { MenuItem,
    title = "查找",
    id = "search",},
  { MenuItem,
    title = "导航",
    id = "navi",},
  { MenuItem,
    title = "转到",
    id= "gotoline",},
  { MenuItem,
    title = "格式化",
    id = "txtformat",},

}

optmenu = {}
function onCreateOptionsMenu(menu)
  loadmenu(menu, m, optmenu, 2)
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


function onMenuItemSelected(id,item)
  switch2(item) {
    default2 = function()
      提示("功能开发中。。。")
    end,
    [optmenu.seve]=func.seve,
    [optmenu.moban]=func.moban,
    [optmenu.doc]=func.doc,
    [optmenu.search]=func.search,
    [optmenu.navi]=func.navi,
    [optmenu.gotoline]=func.gotoline,
    [optmenu.txtformat]=func.format,
    [optmenu.undo]=func.undo,
    [optmenu.redo]=func.redo,
    [optmenu.luadoc]=func.luadoc,
  }

end

func={}

func.moban=function()
  渐变跳转页面("moban")
end

func.doc=function()
  渐变跳转页面("doc")
end

func.luadoc=function()
  activity.newActivity("../luadoc")
end

func.seve=function()
  save()
end

func.search = function()
  txt.search()
end

func.navi = function()
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

func.gotoline = function()
  txt.gotoLine()
end

func.format = function()
  txt.format()
end

func.undo = function()
  txt.undo()
end

func.redo = function()
  txt.redo()
end

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

--自定义输入建议
local dir=luajava.luadir.."/func.txt"
local names=String(io.open(dir, "r"):read("*all"))
local names=names.split(",")

txt.addNames(names)

if 文件==""then
  local data=io.open(luajava.luadir.."/mb.lua"):read("*a")
  写入文件(路径,data)
  local 文件=io.open(路径):read("*a")
  txt.setText(文件)
 else
  txt.setText(文件)
end

function onStop()
  save()
end

界面退出()


