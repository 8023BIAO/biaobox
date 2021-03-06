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
import "bin"

require "layout"
activity.setTitle('Blua+')

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


activity.getWindow().setSoftInputMode(0x10)

history = {}
luahist = luajava.luadir .. "/lua.hist"
luadir = luajava.luaextdir .. "/" or "/sdcard/Androlua/"
luaconf = luajava.luadir .. "/lua.conf"
luaproj = luajava.luadir .. "/lua.proj"
pcall(dofile, luaconf)
pcall(dofile, luahist)
luapath = luapath or luadir .. "new.lua"
luadir = luapath:match("^(.-)[^/]+$")
pcall(dofile, luaproj)
luaproject = luaproject
if luaproject then
  local p = {}
  local e = pcall(loadfile(luaproject .. "init.lua", "bt", p))
  if e then
    activity.setTitle(tostring(p.appname))
    Toast.makeText(activity, "打开工程." .. p.appname, Toast.LENGTH_SHORT ).show()
  end
end


luabindir = luajava.luaextdir .. "/bin/"
code = [===[
require "import"
import "android.widget.*"
import "android.view.*"
--import "mod"


]===]
pcode = [[
require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
--import "mod"
--import "layout"
--activity.setTitle('title')
--activity.setTheme(android.R.style.Theme_Holo_Light)
--activity.setContentView(loadlayout(layout))


]]

lcode = [[
{
  LinearLayout,
  orientation="vertical",
  layout_width="fill",
  layout_height="fill",
}
]]
upcode = [[
theme="Theme_Material_NoActionBar"--黑色MD
--theme="Theme_DeviceDefault_Light_NoActionBar"--白色
user_permission={
  "INTERNET",
  "WRITE_EXTERNAL_STORAGE",
}
]]

local BitmapDrawable = luajava.bindClass("android.graphics.drawable.BitmapDrawable")
m = {
  { MenuItem,
    title = "布局",
    id = "helper",
    icon = "../res/icon/buj", },
  { MenuItem,
    title = "运行",
    id = "play",
    icon = "../res/icon/play", },

  { MenuItem,
    title = "撤销",
    id = "undo",
    icon = "../res/icon/undo", },
  { MenuItem,
    title = "重做",
    id = "redo",
    icon = "../res/icon/redo", },
  { MenuItem,
    title = "Java浏览器",
    id = "more_java", },
  { MenuItem,
    title = "帮助",
    id = "more_help", },
  { MenuItem,
    title = "手册",
    id = "more_manual", },

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

luaprojectdir = luajava.luaextdir .. "/project/"

function create_project()
  local appname = project_appName.getText().toString()
  local packagename = project_packageName.getText().toString()
  local f = File(luaprojectdir .. appname)
  if f.exists() then
    print("工程已存在")
    return
  end
  if not f.mkdirs() then
    print("工程创建失败")
    return

  end
  --mod
  mymod=io.open(luajava.luadir.."/../My bag.lua"):read("*a")
  SnakeBar_a=io.open(luajava.luadir.."/../SnakeBar.lua"):read("*a")

  luadir = luaprojectdir .. appname .. "/"
  write(luadir .. "init.lua", string.format("appname=\"%s\"\nappver=\"1.0\"\npackagename=\"%s\"\n%s", appname, packagename, upcode))
  write(luadir .. "main.lua", pcode)
  write(luadir .. "layout.aly", lcode)
  write(luadir .. "SnakeBar.lua", SnakeBar_a)
  write(luadir .. "mod.lua", mymod)
  --project_dlg.hide()
  luapath = luadir .. "main.lua"
  read(luapath)

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
    activity.setTitle("Blua+")
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

function create_lua()
  luapath = luadir .. create_e.getText().toString() .. ".lua"
  if not pcall(read, luapath) then
    f = io.open(luapath, "a")
    f:write(code)
    f:close()
    table.insert(history, 1, luapath)
    editor.setText(code)
    write(luaconf, string.format("luapath=%q", luapath))
    Toast.makeText(activity, "新建文件." .. luapath, Toast.LENGTH_SHORT ).show()
   else
    Toast.makeText(activity, "打开文件." .. luapath, Toast.LENGTH_SHORT ).show()
  end
  write(luaconf, string.format("luapath=%q", luapath))
  activity.getActionBar().setSubtitle(".." .. luapath:match("(/[^/]+/[^/]+)$"))
  --create_dlg.hide()

end

function create_dir()
  luadir = luadir .. create_e.getText().toString() .. "/"
  if File(luadir).exists() then
    Toast.makeText(activity, "文件夹已存在." .. luadir, Toast.LENGTH_SHORT ).show()
   elseif File(luadir).mkdirs() then
    Toast.makeText(activity, "创建文件夹." .. luadir, Toast.LENGTH_SHORT ).show()
   else
    Toast.makeText(activity, "创建失败." .. luadir, Toast.LENGTH_SHORT ).show()
  end

end

function create_aly()
  luapath = luadir .. create_e.getText().toString() .. ".aly"
  if not pcall(read, luapath) then
    f = io.open(luapath, "a")
    f:write(lcode)
    f:close()
    table.insert(history, 1, luapath)
    editor.setText(lcode)
    write(luaconf, string.format("luapath=%q", luapath))
    Toast.makeText(activity, "新建文件." .. luapath, Toast.LENGTH_SHORT ).show()
   else
    Toast.makeText(activity, "打开文件." .. luapath, Toast.LENGTH_SHORT ).show()
  end
  write(luaconf, string.format("luapath=%q", luapath))
  activity.getActionBar().setSubtitle(".." .. luapath:match("(/[^/]+/[^/]+)$"))
  --create_dlg.hide()

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

function getalpinfo(path)
  local app = {}
  loadstring(tostring(String(LuaUtil.readZip(path, "init.lua"))), "bt", "bt", app)()
  local str = string.format("名称: %s\
版本: %s\
包名: %s\
作者: %s\
说明: %s\
路径: %s",
  app.appname,
  app.appver,
  app.packagename,
  app.developer,
  app.description,
  path
  )
  return str, app.mode
end

function imports(path)
  create_imports_dlg()
  local mode
  imports_dlg.Message, mode = getalpinfo(path)
  if mode == "plugin" or path:match("^([^%._]+)_plugin") then
    imports_dlg.setTitle("导入插件")
   elseif mode == "build" or path:match("^([^%._]+)_build") then
    imports_dlg.setTitle("打包安装")
  end
  imports_dlg.show()
end

function importx(path, tp)
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
    output.close()
  end

  local f = File(path)
  local app = {}
  loadstring(tostring(String(LuaUtil.readZip(path, "init.lua"))), "bt", "bt", app)()

  local s = app.appname or f.Name:match("^([^%._]+)")
  local out = activity.getLuaExtDir("project") .. "/" .. s

  if tp == "build" then
    out = activity.getLuaExtDir("bin/.temp") .. "/" .. s
   elseif tp == "plugin" then
    out = activity.getLuaExtDir("plugin") .. "/" .. s
  end
  local d = File(out)
  if autorm then
    local n = 1
    while d.exists() do
      n = n + 1
      d = File(out .. "-" .. n)
    end
  end
  if not d.exists() then
    d.mkdirs()
  end
  out = out .. "/"
  local zip = ZipFile(f)
  local entries = zip.entries()
  for entry in enum(entries) do
    local name = entry.Name
    local tmp = File(out .. name)
    local pf = tmp.ParentFile
    if not pf.exists() then
      pf.mkdirs()
    end
    if entry.isDirectory() then
      if not tmp.exists() then
        tmp.mkdirs()
      end
     else
      copy(zip.getInputStream(entry), FileOutputStream(out .. name))
    end
  end
  zip.close()
  function callback2(s)
    LuaUtil.rmDir(File(activity.getLuaExtDir("bin/.temp")))
    bin_dlg.hide()
    bin_dlg.Message = ""
    if s==nil or not s:find("成功") then
      create_error_dlg()
      error_dlg.Message = s
      error_dlg.show()
    end
  end

  if tp == "build" then
    bin(out)
    return out
   elseif tp == "plugin" then
    Toast.makeText(activity, "导入插件." .. s, Toast.LENGTH_SHORT ).show()
    return out
  end
  luadir = out
  luapath = luadir .. "main.lua"
  read(luapath)
  Toast.makeText(activity, "导入工程." .. luadir, Toast.LENGTH_SHORT ).show()
  return out
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

func.export = function()
  save()
  if luaproject then
    local name = export(luaproject)
    Toast.makeText(activity, "工程已导出." .. name, Toast.LENGTH_SHORT ).show()
   else
    Toast.makeText(activity, "仅支持工程导出.", Toast.LENGTH_SHORT ).show()
  end
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

func.navi = function()
  create_navi_dlg()
  local str = editor.getText().toString()
  local fs = {}
  indexs = {}
  for s, i in str:gmatch("([\u4e00-\u9fa5 %w%._]* *=? *function *[\u4e00-\u9fa5%w%._]*%b())()") do
    i = utf8.len(str, 1, i) - 1
    s = s:gsub("^ +", "")
    table.insert(fs, s)
    table.insert(indexs, i)
    fs[s] = i
  end
  local adapter = ArrayAdapter(activity, android.R.layout.simple_list_item_1, String(fs))
  navi_list.setAdapter(adapter)
  navi_dlg.show()
end

func.seach = function()
  editor.search()
end

func.gotoline = function()
  editor.gotoLine()
end

func.luac = function()
  save()
  local path, str = console.build(luapath)
  if path then
    Toast.makeText(activity, "编译完成: " .. path, Toast.LENGTH_SHORT ).show()
   else
    Toast.makeText(activity, "编译出错: " .. str, Toast.LENGTH_SHORT ).show()
  end
end

func.build = function()
  save()
  if not luaproject then
    Toast.makeText(activity, "仅支持工程打包.", Toast.LENGTH_SHORT ).show()
    return
  end
  bin(luaproject .. "/")
end

buildfile = function()
  Toast.makeText(activity, "正在打包..", Toast.LENGTH_SHORT ).show()
  task(bin, luaPath.getText().toString(), appName.getText().toString(), appVer.getText().toString(), packageName.getText().toString(), apkPath.getText().toString(), function(s)
    status.setText(s or "打包出错!")
  end)
end

func.info = function()
  if not luaproject then
    Toast.makeText(activity, "仅支持修改工程属性.", Toast.LENGTH_SHORT ).show()
    return
  end
  activity.newActivity("projectinfo", { luaproject })
end

func.logcat = function()
  activity.newActivity("logcat")
end

func.help = function()
  activity.newActivity("help")
end

func.java = function()
  activity.newActivity("javaapi/main")
end

func.manual = function()
  activity.newActivity("../luadoc")
end
--布局按键
func.helper = function()
  --现在路径查找
  if luapath:find(".*%.aly") then
    save()
    isupdate = true
    activity.newActivity("../layouthelper/main", { luaproject, luapath })
   else
    print("不是.aly文件")
  end

end

--打开本地url(泥人捐赠)
func.donation = function()
  xpcall(function()
    local url = "alipayqr://platformapi/startapp?saId=10000007&clientVersion=3.7.0.0718&qrcode=https://qr.alipay.com/apt7ujjb4jngmu3z9a"
    activity.startActivity=(Intent(Intent.ACTION_VIEW, Uri.parse(url)));
  end,
  function()
    local url = "https://qr.alipay.com/apt7ujjb4jngmu3z9a";
    activity.startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(url)));
  end)
end

--加群1,2
key2 = [[N_9Rrnm8jJcdcXs7TQsXQBVA8Liq8mhU]]

key = [[QRDW1jiyM81x-T8RMIgeX1g_v76QSo6a]]

function joinQQGroup(key)
  import "android.content.Intent"
  import "android.net.Uri"
  local intent = Intent();
  intent.setData(Uri.parse("mqqopensdkapi://bizAgent/qm/qr?url=http%3A%2F%2Fqm.qq.com%2Fcgi-bin%2Fqm%2Fqr%3Ffrom%3Dapp%26p%3Dandroid%26k%3D" .. key));
  activity.startActivity(intent);
end

func.qq = function()
  joinQQGroup(key)
end


func.about = function()
  onVersionChanged("", "")
end

func.fiximport = function()
  save()
  activity.newActivity("javaapi/fiximport", { luaproject, luapath })
end

--[[func.plugin = function()
  activity.newActivity("plugin/main", { luaproject, luapath })
end]]

func.myhome=function()

  local version = Build.VERSION.SDK_INT;
  local h = tonumber(os.date("%H"))

  day()
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
      return (android.R.style.Theme_Material)
     else
      return (android.R.style.Theme_Holo)
    end
  end


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
    [optmenu.more_help] = func.help,
    [optmenu.helper] = func.helper,
    [optmenu.more_manual] = func.manual,
    --[[    [optmenu.file_open] = func.open,
    [optmenu.file_history] = func.history,
    [optmenu.file_save] = func.save,
    [optmenu.file_new] = func.new,
    [optmenu.file_build] = func.luac,
    [optmenu.project_open] = func.openproject,
    [optmenu.project_build] = func.build,
    [optmenu.project_create] = func.create,
    [optmenu.project_export] = func.export,
    [optmenu.project_info] = func.info,
    [optmenu.code_format] = func.format,
    [optmenu.code_check] = func.check,
    [optmenu.code_import] = func.fiximport,
    [optmenu.goto_line] = func.gotoline,
    [optmenu.goto_func] = func.navi,
    [optmenu.goto_seach] = func.seach,
    [optmenu.helper] = func.helper,
    [optmenu.more_logcat] = func.logcat,
    [optmenu.more_java] = func.java,
    [optmenu.more_help] = func.help,
    [optmenu.more_manual] = func.manual,
    --[optmenu.more_donation] = func.donation,
    -- [optmenu.more_qq] = func.qq,
    -- [optmenu.more_about] = func.about,
    --[optmenu.plugin] = func.plugin,
    --  [optmenu.myhome]= func.myhome,]]--主题
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
    luapath = activity.LuaExtDir .. "/new.lua"
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

function create_imports_dlg()
  if imports_dlg then
    return
  end
  imports_dlg = AlertDialogBuilder(activity)
  imports_dlg.setTitle("导入")
  imports_dlg.setPositiveButton("确定", {
    onClick = function()
      local path = imports_dlg.Message:match("路径: (.+)$")
      if imports_dlg.Title == "打包安装" then
        importx(path, "build")
        imports_dlg.setTitle("导入")
       elseif imports_dlg.Title == "导入插件" then
        importx(path, "plugin")
        imports_dlg.setTitle("导入")
       else
        importx(path)
      end
    end })
  imports_dlg.setNegativeButton("取消", nil)
end

function create_delete_dlg()
  if delete_dlg then
    return
  end
  delete_dlg = AlertDialogBuilder(activity)
  delete_dlg.setTitle("删除")
  delete_dlg.setPositiveButton("确定", {
    onClick = function()
      if luapath:find(delete_dlg.Message) then
        Toast.makeText(activity, "不能删除正在打开的文件.", Toast.LENGTH_SHORT ).show()
       elseif LuaUtil.rmDir(File(delete_dlg.Message)) then
        Toast.makeText(activity, "已删除.", Toast.LENGTH_SHORT ).show()
        list(listview, luadir)

        pcall(function()
          adp.clear()
          main_toolbar()
        end)

       else
        Toast.makeText(activity, "删除失败.", Toast.LENGTH_SHORT ).show()
      end
    end })
  delete_dlg.setNegativeButton("取消", nil)
end

function create_open_dlg()
  if open_dlg then
    return
  end
  open_dlg = AlertDialogBuilder(activity)
  open_dlg.setTitle("打开")
  open_title = TextView(activity)
  listview = open_dlg.ListView
  listview.FastScrollEnabled = true

  listview.addHeaderView(open_title)
  listview.setOnItemClickListener(AdapterView.OnItemClickListener {
    onItemClick = function(parent, v, pos, id)
      open(v.Text)
      local yy,ee=string.find(v.Text,"[%w u4e00-u9fa5]+(%.[lua]?[aly]?)")
      if yy or ee then
        main_toolbar()
      end
    end
  })

  listview.onItemLongClick = function(parent, v, pos, id)
    if v.Text ~= "../" then
      create_delete_dlg()
      delete_dlg.setMessage(luadir .. v.Text)
      delete_dlg.show()

    end
    return true
  end

  --open_dlg.setItems{"空"}
  --open_dlg.setContentView(listview)
end

function create_open_dlg2()
  if open_dlg2 then
    return
  end
  open_dlg2 = AlertDialogBuilder(activity)
  --open_dlg2.getWindow().clearFlags(WindowManager.LayoutParams.FLAG_ALT_FOCUSABLE_IM);

  open_dlg2.setTitle("最近打开")
  open_dlg2.setView(loadlayout(layout.open2))

  --listview2=open_dlg2.ListView
  listview2.FastScrollEnabled = true
  --open_edit=EditText(activity)
  --listview2.addHeaderView(open_edit)

  open_edit.addTextChangedListener {
    onTextChanged = function(c)
      local s = tostring(c)
      if #s == 0 then
        listview2.setAdapter(adapter(plist))
      end
      local t = {}
      s = s:lower()
      for k, v in ipairs(plist) do
        if v:lower():find(s, 1, true) then
          table.insert(t, v)
        end
      end
      listview2.setAdapter(adapter(t))
    end
  }

  listview2.setOnItemClickListener(AdapterView.OnItemClickListener {
    onItemClick = function(parent, v, pos, id)
      if File(v.Text).exists() then
        luadir = v.Text:gsub("[^/]+$", "")
        read(v.Text)
        open_dlg2.hide()
       else
        listview2.adapter.remove(pos)
        table.remove(plist, id)
        Toast.makeText(activity, "文件不存在", 1000).show()
      end
    end
  })
end

function create_create_dlg()
  if create_dlg then
    return
  end
  create_dlg = AlertDialogBuilder(activity)
  create_dlg.setMessage(luadir)
  create_dlg.setTitle("新建")
  create_e = EditText(activity)
  create_dlg.setView(create_e)
  create_dlg.setPositiveButton(".lua", { onClick = create_lua })
  create_dlg.setNegativeButton("dir", { onClick = create_dir })
  create_dlg.setNeutralButton(".aly", { onClick = create_aly })
end

function create_project_dlg()
  if project_dlg then
    return
  end
  project_dlg = AlertDialogBuilder(activity)
  project_dlg.setTitle("新建工程")
  project_dlg.setView(loadlayout(layout.project))
  project_dlg.setPositiveButton("确定", { onClick = create_project })
  project_dlg.setNegativeButton("取消", nil)
end

function create_build_dlg()
  if build_dlg then
    return
  end
  build_dlg = AlertDialogBuilder(activity)
  build_dlg.setTitle("打包")
  build_dlg.setView(loadlayout(layout.build))
  build_dlg.setPositiveButton("确定", { onClick = buildfile })
  build_dlg.setNegativeButton("取消", nil)
end

function create_bin_dlg()
  if bin_dlg then
    return
  end
  bin_dlg = ProgressDialog(activity);
  bin_dlg.setTitle("正在打包");
  bin_dlg.setMax(100);
end

import "android.content.*"
cm = activity.getSystemService(activity.CLIPBOARD_SERVICE)

function copyClip(str)
  local cd = ClipData.newPlainText("label", str)
  cm.setPrimaryClip(cd)
  Toast.makeText(activity, "已复制到剪切板", 1000).show()
end

function create_import_dlg()
  if import_dlg then
    return
  end
  import_dlg = AlertDialogBuilder(activity)
  import_dlg.Title = "可能需要导入的类"
  import_dlg.setPositiveButton("确定", nil)

  import_dlg.ListView.onItemClick = function(l, v)
    copyClip(v.Text)
    import_dlg.hide()
    return true
  end
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
      Toast.makeText(activity, "再按一次退出程序.", Toast.LENGTH_SHORT ).show()
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

  if (v.Text == "Fun") then
    editor.paste("function")
   elseif (v.Text == "TAB") then
    editor.paste(" ")
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



--------------自己添加---------------------
打开.onClick=function()
  func.open()
end
最近.onClick=function()
  func.history()
end
工程.onClick=function()
  func.openproject()
end
打包.onClick=function()
  func.build()
end
新建工程.onClick=function()
  func.create()
end
导出.onClick=function()
  func.export()
end
属性.onClick=function()
  func.info()
end
保存.onClick=function()
  func.save()
end
新建.onClick=function()
  func.new()
end
编译.onClick=function()
  func.luac()
end
查错.onClick=function()
  func.check ()
end
搜索.onClick=function()
  func.seach()
end
转到.onClick=function()
  func.gotoline()
end
导航.onClick=function()
  func.navi()
end
格式化.onClick=function()
  func.format ()
end
分析.onClick=function()
  func.fiximport()
end
日志.onClick=function()
  func.logcat()
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
  table.insert(data,{text={Text="刷新"}})

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
    if sxs=="刷新" then
      adp.clear()
      main_toolbar()
      return true
    end

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
    if sxs=="刷新" then
      print("点刷新快捷列表")
      return true
    end
    create_delete_dlg()
    delete_dlg.setMessage(luadir .. sxs)
    delete_dlg.show()
    return true
  end
  --
end

main_toolbar()
