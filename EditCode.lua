require "import"
import "console"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "com.androlua.*"
import "java.io.*"
import "android.text.method.*"
import "android.net.*"
import "android.content.*"
import "android.graphics.drawable.*"
--import "autotheme"
require "EditCodeLayout"
activity.setTitle('小工具')

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
activity.getActionBar().setDisplayShowHomeEnabled(false)

--activity.setTheme(android.R.style.Theme_Material_NoActionBar)
--import "android.graphics.drawable.ColorDrawable"
--activity.ActionBar.setBackgroundDrawable(ColorDrawable(0xFF212121))


local version = Build.VERSION.SDK_INT;
local h = tonumber(os.date("%H"))

function ext(f)
  local f=io.open(f)
  if f then
    f:close()
    return true
  end
  return false
end

local theme
if h <= 6 or h >= 22 then
  theme = activity.getLuaExtDir("fonts") .. "/night.lua"
 else
  theme = activity.getLuaExtDir("fonts") .. "/day.lua"
end
if not ext(theme) then
  theme = activity.getLuaExtDir("fonts") .. "/theme.lua"
end


local function day()
  if version >= 21 then
    return (android.R.style.Theme_Material_Light)
   else
    return (android.R.style.Theme_Holo_Light)
  end
end

local function night()
  if version >= 21 then
    return (android.R.style.Theme_Material_NoActionBar)
   else
    return (android.R.style.Theme_Holo)
  end
end

local p = {}
local e = pcall(loadfile(theme, "bt", p))
if e then
  for k, v in pairs(p) do
    if k == "theme" then
      if v == "day" then
        activity.setTheme(day())
       elseif v == "night" then
        activity.setTheme(night())
      end
     else
      layout.main[2][k] = v
    end
  end
end

------------------------------------------------

activity.getWindow().setSoftInputMode(0x10)

--activity.getActionBar().show()
history = {}
luahist = luajava.luadir .. "/lua.hist"
luadir = luajava.luadir.."/"
luaconf = luajava.luadir .. "/lua.conf"
luaproj = luajava.luadir .. "/lua.proj"

pcall(dofile, luaconf)
pcall(dofile, luahist)

luapath = luapath or luajava.luadir .. "/main.lua"
luadir = luapath:match("^(.-)[^/]+$")
pcall(dofile, luaproj)

luaproject = luaproject
if luaproject then
  local p = {}
  local e = pcall(loadfile(luaproject .. "init.lua", "bt", p))
  if e then
    -- activity.setTitle(tostring(p.appname))
    Toast.makeText(activity, "代码编辑模式:" .. p.appname, Toast.LENGTH_SHORT ).show()
  end
end

local BitmapDrawable = luajava.bindClass("android.graphics.drawable.BitmapDrawable")
m = {
  { MenuItem,
    title = "布局",
    id = "helper",
    icon = "res/icon/buj", },
  { MenuItem,
    title = "运行",
    id = "play",
    icon = "res/icon/play", },
  { MenuItem,
    title = "撤销",
    id = "undo",
    icon = "res/icon/undo", },
  { MenuItem,
    title = "重做",
    id = "redo",
    icon = "res/icon/redo", },
  { MenuItem,
    title = "Java浏览器",
    id = "more_java", },
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
    id= "gotoline",},
  { MenuItem,
    title = "手册",
    id = "manual",},
  { MenuItem,
    title = "日志",
    id = "logcat",},

}

optmenu = {}
function onCreateOptionsMenu(menu)
  loadmenu(menu, m, optmenu, 4)
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
  print("功能开发中")
end

function update(s)
  bin_dlg.setMessage(s)
end

function callback(s)
  bin_dlg.hide()
  bin_dlg.Message = ""
  if not s:find("成功") then
    create_error_dlg()
    error_dlg.Message = s
    error_dlg.show()
  end
end

function reopen(path)
  local f = io.open(path, "r")
  if f then
    local str = f:read("*all")
    if tostring(editor.getText()) ~= str then
      editor.setText(str, true)
    end
    f:close()
  end
end

function read(path)

  local f = io.open(path, "r")
  if f == nil then
    --Toast.makeText(activity, "打开文件出错."..path, Toast.LENGTH_LONG ).show()
    error()
    return
  end
  local str = f:read("*all")
  f:close()
  if string.byte(str) == 0x1b then
    Toast.makeText(activity, "不能打开已编译文件." .. path, Toast.LENGTH_LONG ).show()
    return
  end
  editor.setText(str)

  activity.getActionBar().setSubtitle(".." .. path:match("(/[^/]+/[^/]+)$"))
  luapath = path
  if history[luapath] then
    editor.setSelection(history[luapath])
  end
  table.insert(history, 1, luapath)
  for n = 2, #history do
    if n > 50 then
      history[n] = nil
     elseif history[n] == luapath then
      table.remove(history, n)
    end
  end
  write(luaconf, string.format("luapath=%q", path))
  if luaproject and path:find(luaproject, 1, true) then
    --Toast.makeText(activity, "打开文件."..path, Toast.LENGTH_SHORT ).show()
    activity.getActionBar().setSubtitle(path:sub(#luaproject))
    return
  end

  local dir = luadir
  local p = {}
  local e = pcall(loadfile(dir .. "init.lua", "bt", p))
  while not e do
    dir, n = dir:gsub("[^/]+/$", "")
    if n == 0 then
      break
    end
    e = pcall(loadfile(dir .. "init.lua", "bt", p))
  end

  if e then
    activity.setTitle(tostring(p.appname))
    luaproject = dir
    activity.getActionBar().setSubtitle(path:sub(#luaproject))
    write(luaproj, string.format("luaproject=%q", luaproject))
    --Toast.makeText(activity, "打开工程."..p.appname, Toast.LENGTH_SHORT ).show()
   else
    activity.setTitle("代码编辑")
    luaproject = nil
    write(luaproj, "luaproject=nil")
    --Toast.makeText(activity, "打开文件."..path, Toast.LENGTH_SHORT ).show()
  end
  if path ==nil or false then
    return false or nil
  end
end

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

function save()
  history[luapath] = editor.getSelectionEnd()
  local str = ""
  local f = io.open(luapath, "r")
  if f then
    str = f:read("*all")
    f:close()
  end
  local src = editor.getText().toString()
  if src ~= str then
    write(luapath, src)
  end

  return src
end

function click(s)
  func[s.getText()]()
end

function open(p)
  if p == luadir then
    return nil
  end
  if p:find("%.%./") then
    luadir = luadir:match("(.-)[^/]+/$")
    list(listview, luadir)
   elseif p:find("/") then
    luadir = luadir .. p
    list(listview, luadir)
   elseif p:find("%.alp$") then
    imports(luadir .. p)
    open_dlg.hide()
   else
    read(luadir .. p)
    open_dlg.hide()
  end

end

function sort(a, b)
  if string.lower(a) < string.lower(b) then
    return true
   else
    return false
  end
end

function adapter(t)
  return ArrayListAdapter(activity, android.R.layout.simple_list_item_1, String(t))
end

function list(v, p)
  local f = File(p)
  if not f then
    open_title.setText(p)
    local adapter = ArrayAdapter(activity, android.R.layout.simple_list_item_1, String {})
    v.setAdapter(adapter)
    return
  end

  local fs = f.listFiles()
  fs = fs or String[0]
  Arrays.sort(fs)
  local t = {}
  local td = {}
  local tf = {}
  if p ~= "/" then
    table.insert(td, "../")
  end
  for n = 0, #fs - 1 do
    local name = fs[n].getName()
    if fs[n].isDirectory() then
      table.insert(td, name .. "/")
     elseif name:find("%.lua$") or name:find("%.aly$") or name:find("%.alp$") then
      table.insert(tf, name)
    end
  end
  table.sort(td, sort)
  table.sort(tf, sort)
  for k, v in ipairs(tf) do
    table.insert(td, v)
  end
  pcall(function()
    open_title.setText(p)

    --local adapter=ArrayAdapter(activity,android.R.layout.simple_list_item_1, String(td))
    --v.setAdapter(adapter)
    open_dlg.setItems(td)
  end)
end

function list2(v, p)
  local adapter = ArrayListAdapter(activity, android.R.layout.simple_list_item_1, String(history))
  v.setAdapter(adapter)
  plist = history
end

function export(pdir)
  require "import"
  import "java.util.zip.*"
  import "java.io.*"
  local function copy(input, output)
    local b = byte[2 ^ 16]
    local l = input.read(b)
    while l > 1 do
      output.write(b, 0, l)
      l = input.read(b)
    end
    input.close()
  end

  local f = File(pdir)
  local date = os.date("%y%m%d%H%M%S")
  local tmp = activity.getLuaExtDir("backup") .. "/" .. f.Name .. "_" .. date .. ".alp"
  local p = {}
  local e, s = pcall(loadfile(f.Path .. "/init.lua", "bt", p))
  if e then
    if p.mode then
      tmp = string.format("%s/%s_%s_%s-%s.%s", activity.getLuaExtDir("backup"), p.appname,p.mode, p.appver:gsub("%.", "_"), date,p.ext or "alp")
     else
      tmp = string.format("%s/%s_%s-%s.%s", activity.getLuaExtDir("backup"), p.appname, p.appver:gsub("%.", "_"), date,p.ext or "alp")
    end
  end
  local out = ZipOutputStream(FileOutputStream(tmp))
  local using={}
  local using_tmp={}
  function addDir(out, dir, f)
    local ls = f.listFiles()
    --entry=ZipEntry(dir)
    --out.putNextEntry(entry)
    for n = 0, #ls - 1 do
      local name = ls[n].getName()
      if name:find("%.apk$") or name:find("%.luac$") or name:find("^%.") then
       elseif p.mode and name:find("%.lua$") and name ~= "init.lua" then
        local ff=io.open(ls[n].Path)
        local ss=ff:read("a")
        ff:close()
        for u in ss:gmatch([[require *%b""]]) do
          if using_tmp[u]==nil then
            table.insert(using,u)
            using_tmp[u]=true
          end
        end
        local path, err = console.build(ls[n].Path)
        if path then
          entry = ZipEntry(dir .. name)
          out.putNextEntry(entry)
          copy(FileInputStream(File(path)), out)
          os.remove(path)
         else
          error(err)
        end
       elseif p.mode and name:find("%.aly$") then
        name = name:gsub("aly$", "lua")
        local path, err = console.build_aly(ls[n].Path)
        if path then
          entry = ZipEntry(dir .. name)
          out.putNextEntry(entry)
          copy(FileInputStream(File(path)), out)
          os.remove(path)
         else
          error(err)
        end
       elseif ls[n].isDirectory() then
        addDir(out, dir .. name .. "/", ls[n])
       else
        entry = ZipEntry(dir .. name)
        out.putNextEntry(entry)
        copy(FileInputStream(ls[n]), out)
      end
    end
  end

  addDir(out, "", f)
  local ff=io.open(f.Path.."/.using","w")
  ff:write(table.concat(using,"\n"))
  ff:close()
  entry = ZipEntry(".using")
  out.putNextEntry(entry)
  copy(FileInputStream(f.Path.."/.using"), out)

  out.closeEntry()
  out.close()
  return tmp
end

func = {}
func.open = function()
  save()
  create_open_dlg()
  list(listview, luadir)
  open_dlg.show()
end
func.new = function()
  save()
  create_create_dlg()
  create_dlg.setMessage(luadir)
  create_dlg.show()
end

func.history = function()
  save()
  create_open_dlg2()
  list2(listview2)
  open_edit.Text = ""
  open_dlg2.show()
end

func.create = function()
  save()
  create_project_dlg()
  project_dlg.show()
end
func.openproject = function()
  save()
  activity.newActivity("project")
  --[[
      create_open_dlg2()
      list2(listview2, luaprojectdir)
      open_edit.Text=""
      open_dlg2.show()]]

end

func.save = function()
  save()
  Toast.makeText(activity, "文件已保存." .. luapath, Toast.LENGTH_SHORT ).show()
end

func.play = function()

  if func.check(true) then
    return
  end
  save()

  if luaproject then
    --设置新的活动
    --activity.newActivity(luaproject .. "main.lua",android.R.anim.fade_in,android.R.anim.fade_out,nil,true)--跳转,进入动画,退出动画,参数,开关
    --设置窗口名跟图标
    --  this.setTaskDescription(ActivityManager.TaskDescription(nil,loadbitmap(luaproject.."icon.png")))

    activity.newActivity(luaproject .. "main.lua")--跳转,进入动画,退出动画,参数,开关

   else
    activity.newActivity(luapath)

  end
end

func.undo = function()
  editor.undo()
end

func.redo = function()
  editor.redo()
end

func.format = function()
  editor.format()
end

func.check = function(b)
  local src = editor.getText()
  src = src.toString()
  if luapath:find("%.aly$") then
    src = "return " .. src
  end
  local _, data = loadstring(src)

  if data then
    local _, _, line, data = data:find(".(%d+).(.+)")
    editor.gotoLine(tonumber(line))
    Toast.makeText(activity, line .. ":" .. data, Toast.LENGTH_SHORT ).show()
    return true
   elseif b then
   else
    Toast.makeText(activity, "没有语法错误", Toast.LENGTH_SHORT ).show()
  end
end


func.seach = function()
  editor.search()
end

func.gotoline = function()
  editor.gotoLine()
end


func.java = function()
  activity.newActivity("javaapi/main")
end

func.manual = function()
  activity.newActivity("luadoc")
end


func.navi = function()
  create_navi_dlg()
  local str = editor.getText().toString()
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
    editor.setSelection(indexs[pos + 1])
    navi_dlg.hide()
  end
  navi_dlg.setContentView(navi_list)
end


--布局按键
func.helper = function()
  --现在路径查找
  if luapath:find(".*%.aly") then
    save()
    isupdate = true
    activity.newActivity("layouthelper/main", { luaproject, luapath })
   else
    print("不是.aly文件")
  end

end

func.about = function()
  onVersionChanged("", "")
end

func.fiximport = function()
  save()
  activity.newActivity("javaapi/fiximport", { luaproject, luapath })
end


func.logcat=function()
  activity.newActivity("logcat",android.R.anim.fade_in,android.R.anim.fade_out)
end

func.gotoline = function()
  editor.gotoLine()
end


function onMenuItemSelected(id, item)
  switch2(item) {
    default2 = function()
      print("功能开发中。。。")
    end,
    [optmenu.play] = func.play,
    [optmenu.undo] = func.undo,
    [optmenu.redo] = func.redo,
    [optmenu.more_java] = func.java,
    [optmenu.helper] = func.helper,
    [optmenu.txtformat] =func.format,
    [optmenu.check] = func.check,
    [optmenu.search] = func.seach,
    [optmenu.navi] = func.navi,
    [optmenu.manual] = func.manual,
    [optmenu.logcat] = func.logcat,
    [optmenu.gotoline] = func.gotoline,
  }
end

activity.setContentView(layout.main)

function onCreate(s)
  --[[ local intent=activity.getIntent()
    local uri=intent.getData()
    if not s and uri and uri.getPath():find("%.alp$") then
      imports(uri.getPath())
    else]]
  if pcall(read, luapath) then
    last = last or 0
    if last < editor.getText().length() then
      editor.setSelection(last)
    end
   else

    luapath = luajava.luadir .. "/main.lua"

    if not pcall(read, luapath) then
      write(luapath, code)
      pcall(read, luapath)
    end
  end
  --end
end

function onNewIntent(intent)
  local uri = intent.getData()
  if uri and uri.getPath():find("%.alp$") then
    imports(uri.getPath():match("/storage.+") or uri.getPath())
  end
end
--子页面回调
function onResult(name, path)
  --print(name,path)
  if name == "project" then
    luadir = path .. "/"
    read(path .. "/main.lua")
    main_toolbar()
   elseif name == "projectinfo" then
    activity.setTitle(path)
  end
end

function onActivityResult(req, res, intent)
  if res == 10000 then
    read(luapath)
    editor.format()
    return
  end
  if res ~= 0 then
    local data = intent.getStringExtra("data")
    local _, _, path, line = data:find("\n[	 ]*([^\n]-):(%d+):")
    if path == luapath then
      editor.gotoLine(tonumber(line))
    end
    local classes = require "javaapi.android"
    local c = data:match("a nil value %(global '(%w+)'%)")
    if c then
      local cls = {}
      c = "%." .. c .. "$"
      for k, v in ipairs(classes) do
        if v:find(c) then
          table.insert(cls, string.format("import %q", v))
        end
      end
      if #cls > 0 then
        create_import_dlg()
        import_dlg.setItems(cls)
        import_dlg.show()
      end
    end
  end

end

function onStart()
  reopen(luapath)
  if isupdate then
    editor.format()
  end
  isupdate = false
end

function onStop()
  save()
  --Toast.makeText(activity, "文件已保存."..luapath, Toast.LENGTH_SHORT ).show()
  local f = io.open(luaconf, "wb")
  f:write( string.format("luapath=%q\nlast=%d", luapath, editor. getSelectionEnd() ))
  f:close()
  local f = io.open(luahist, "wb")
  f:write(string.format("history=%s", dump(history)))
  f:close()
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
    editor.setSelection(indexs[pos + 1])
    navi_dlg.hide()
  end
  navi_dlg.setContentView(navi_list)
end

import "android.content.*"
cm = activity.getSystemService(activity.CLIPBOARD_SERVICE)

function copyClip(str)
  local cd = ClipData.newPlainText("label", str)
  cm.setPrimaryClip(cd)
  Toast.makeText(activity, "已复制到剪切板", 1000).show()
end


function create_error_dlg()
  if error_dlg then
    return
  end
  error_dlg = AlertDialogBuilder(activity)
  error_dlg.Title = "出错"
  error_dlg.setPositiveButton("确定", nil)
end

lastclick = os.time() - 2
function onKeyDown(e)
  local now = os.time()
  if e == 4 then
    if now - lastclick > 2 then
      --print("再按一次退出程序")
      --     Toast.makeText(activity, "再按一次退出程序.", Toast.LENGTH_SHORT ).show()
      lastclick = now
      return true
    end
  end
end

local cd1 = ColorDrawable(0x00ffffff)
local cd2 = ColorDrawable(0x88000088)

local pressed = android.R.attr.state_pressed;
local window_focused = android.R.attr.state_window_focused;
local focused = android.R.attr.state_focused;
local selected = android.R.attr.state_selected;

function click(v)
    if (v.Text == "TAB") then
    editor.paste(" ")
    elseif (v.Text == "Fun") then
    editor.paste("function")
    else
      editor.paste(v.Text)
  end
end

function newButton(text)
  local sd = StateListDrawable()
  sd.addState({ pressed }, cd2)
  sd.addState({ 0 }, cd1)
  local btn = TextView()
  btn.TextSize = 20;
  local pd = btn.TextSize / 2
  btn.setPadding(pd, pd / 2, pd, pd / 4)
  btn.Text = text
  btn.setBackgroundDrawable(sd)
  btn.onClick = click
  return btn
end

--低栏添加
local ps = { "Fun","TAB","()","(", ")", "[", "]", "{", "}", "\"", "=", ":", ".", ",", "_", "+", "-", "*", "/", "\\", "%", "#", "^", "$", "?", "&", "|", "<", ">", "~", ";", "'" };
for k, v in ipairs(ps) do
  ps_bar.addView(newButton(v))
end


local function adds()
  require "import"
  local classes = require "javaapi.android"
  local ms = { "onCreate",
    "onStart",
    "onResume",
    "onPause",
    "onStop",
    "onDestroy",
    "onActivityResult",
    "onResult",
    "onCreateOptionsMenu",
    "onOptionsItemSelected",
    "onClick",
    "onTouch",
    "onLongClick",
    "onItemClick",
    "onItemLongClick",
  }
  local buf = String[#ms + #classes]
  for k, v in ipairs(ms) do
    buf[k - 1] = v
  end
  local l = #ms
  for k, v in ipairs(classes) do
    buf[l + k - 1] = string.match(v, "%w+$")
  end
  return buf
end

task(adds, function(buf)
  editor.addNames(buf)
end)


local buf={}
local tmp={}
local curr_ms=luajava.astable(LuaActivity.getMethods())
for k,v in ipairs(curr_ms) do
  v=v.getName()
  if not tmp[v] then
    tmp[v]=true
    table.insert(buf,v)
  end
end
editor.addPackage("activity",buf)


function fix(c)
  local classes = require "javaapi.android"
  if c then
    local cls = {}
    c = "%." .. c .. "$"
    for k, v in ipairs(classes) do
      if v:find(c) then
        table.insert(cls, string.format("import %q", v))
      end
    end
    if #cls > 0 then
      create_import_dlg()
      import_dlg.setItems(cls)
      import_dlg.show()
    end
  end
end

function onKeyShortcut(keyCode, event)
  local filteredMetaState = event.getMetaState() & ~KeyEvent.META_CTRL_MASK;
  if (KeyEvent.metaStateHasNoModifiers(filteredMetaState)) then
    switch(keyCode)
     case
      KeyEvent.KEYCODE_O
      func.open();
      return true;
     case
      KeyEvent.KEYCODE_P
      func.openproject();
      return true;
     case
      KeyEvent.KEYCODE_S
      func.save();
      return true;
     case
      KeyEvent.KEYCODE_E
      func.check();
      return true;
     case
      KeyEvent.KEYCODE_R
      func.play();
      return true;
     case
      KeyEvent.KEYCODE_N
      func.navi();
      return true;
     case
      KeyEvent.KEYCODE_U
      func.undo();
      return true;
     case
      KeyEvent.KEYCODE_I
      fix(editor.getSelectedText());
      return true;
    end
  end
  return false;
end



function newButton2(text)
  local sd = StateListDrawable()
  sd.addState({ pressed }, cd2)
  sd.addState({ 0 }, cd1)
  local btn = TextView()
  btn.TextSize = 20;
  local pd = btn.TextSize / 2
  btn.setPadding(pd, pd / 2, pd, pd / 4)
  btn.Text = text
  btn.setBackgroundDrawable(sd)
  btn.setTextColor(0xff000000);

  btn.onClick = function()
    if pcall(function()
        read(luadir..btn.Text )
      end)then

     else
      activity.finish()
      activity.newActivity("main",android.R.anim.fade_in,android.R.anim.fade_out,nil)
    end
  end

  return btn
end
--快捷路径文件添加
function luj_xs()
  --现在路径
  local f=File(luadir)
  local fs = f.listFiles()
  fs = fs or String[0]
  Arrays.sort(fs)
  local t = {}
  local td = {}
  local tf={}
  if p ~= "/" then
    table.insert(td, "../")
  end

  for n = 0, #fs - 1 do
    local name = fs[n].getName()
    if fs[n].isDirectory() then
      table.insert(td, name .. "/")
     elseif name:find("%.lua$") or name:find("%.aly$") or name:find("%.alp$") then
      table.insert(tf, name)
    end
  end

  table.sort(td, sort)
  table.sort(tf, sort)

  --[[ for k, v in ipairs(tf) do
    table.insert(td, v)
  end]]

  for k, v in ipairs(tf) do
    spq2.addView(newButton2(v))
  end

end

--luj_xs()--调用快捷文件路径

function main_toolbar()

  local f=File(luadir)
  local fs = f.listFiles()
  fs = fs or String[0]
  Arrays.sort(fs)
  local t = {}
  local td = {}
  local tf={}
  if p ~= "/" then
    table.insert(td, "../")
  end

  for n = 0, #fs - 1 do
    local name = fs[n].getName()
    if fs[n].isDirectory() then
      table.insert(td, name .. "/")
     elseif name:find("%.lua$") or name:find("%.aly$") or name:find("%.alp$") then
      table.insert(tf, name)
    end
  end

  table.sort(td, sort)
  table.sort(tf, sort)


  item={
    LinearLayout,
    orientation="vertical",
    layout_width="fill",
    {
      TextView,
      id="text",
      -- layout_margin="15dp",
      layout_width="wrap",
      layout_marginLeft="20dp";
      TextColor="0xff000000";
      textSize="20sp",
    },
  }
  --创建项目数组
  data={}
  --创建适配器
  adp=LuaAdapter(activity,data,item)
  --添加数据
  -- table.insert(data,{text={Text="刷新"}})

  for k,v in ipairs(tf) do
    table.insert(data,{
      text={
        Text=tostring(v),
      },
    })
  end

  --设置适配器
  spq2.Adapter=adp
  spq2.onItemClick=function(l,v,p,i)

    local sxs=(v.Tag.text.Text)

    if pcall(function()
        save()--保存
        read(luadir..sxs)
      end) then
     else

      adp.clear()
      main_toolbar()
    end
    return true
  end

  spq2.onItemLongClick=function(l,v,p,i)
    local sxs=(v.Tag.text.Text)
    activity.getSystemService(Context.CLIPBOARD_SERVICE).setText(sxs)
    print("复制:"..sxs)
    return true
  end
  --
end

main_toolbar()
