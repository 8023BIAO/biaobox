
namedata={
  [1]	= "AndroLua" ;
  [2]	= "BV号转AV号" ;
  [3]	= "Base64加解密" ;
  [4]	= "Base64转图片" ;
  [5]	= "GGScript" ;
  [6]	= "HTML代码运行" ;
  [7]	= "Lua代码运行" ;
  [8]	= "MD5摘要" ;
  [9]	= "Ping" ;
  [10]	= "QQ临时会话" ;
  [11]	= "QQ自动点赞" ;
  [12]	= "TTS语音播报" ;
  [13]	= "UUID生成" ;
  [14]	= "get/post 调试" ;
  [15]	= "全局背景" ;
  [16]	= "全屏准星" ;
  [17]	= "图片取色" ;
  [18]	= "图片圆角" ;
  [19]	= "图片转Base64" ;
  [20]	= "在线翻译" ;
  [21]	= "安装包提取" ;
  [22]	= "屏幕尺子" ;
  [23]	= "屏幕文字" ;
  [24]	= "屏幕时间" ;
  [25]	= "屏幕测试" ;
  [26]	= "悬浮浏览器" ;
  [27]	= "文字加解密" ;
  [28]	= "文本去重" ;
  [29]	= "机器陪聊" ;
  [30]	= "油画" ;
  [31]	= "清理空文件夹" ;
  [32]	= "渐变颜色参考" ;
  [33]	= "滚动字幕" ;
  [34]	= "特殊文字生成" ;
  [35]	= "短链接生成" ;
  [36]	= "空白昵称" ;
  [37]	= "系统下载器" ;
  [38]	= "纯色图片生成" ;
  [39]	= "网址取源" ;
  [40]	= "网页转应用" ;
  [41]	= "获取QQ头像" ;
  [42]	= "获取文件MD5" ;
  [43]	= "视频解析" ;
  [44]	= "进制转换" ;
  [45]	= "重复昵称" ;
  [46]	= "颜色参考" ;
  [47]	= "颜色选择" ;
  [48]	= "魔方" ;
  } ;

function 点击事件功能(s)
  switch (s)
   case "BV号转AV号"
    转AV号()
   case "MD5摘要"
    转MD5()
    QJDJ=true
   case "HTML代码运行"
    activity.newActivity("html",android.R.anim.fade_in,android.R.anim.fade_out)
   case "QQ临时会话"
    临时聊天()
    QJDJ=true
   case "Lua代码运行"
    activity.newActivity("lua",android.R.anim.fade_in,android.R.anim.fade_out,{"https://easypage.com/e/page"})
   case "全局背景"
    全局设置背景()
    QJDJ=true
   case "全屏准星"
    辅助准星()
   case "图片取色"
    图片取色()
    QJDJ=true
   case "在线翻译"
    在线翻译()
   case "屏幕文字"
    打字板()
    QJDJ=true
   case "屏幕时间"
    activity.newActivity("pmtiem",android.R.anim.fade_in,android.R.anim.fade_out)
   case "屏幕尺子"
    activity.newActivity("Measuring_scale",android.R.anim.fade_in,android.R.anim.fade_out)
   case "文字加解密"
    文字加解密()
    QJDJ=true
   case "机器陪聊"
    机器陪聊()
   case "清理空文件夹"
    清除空文件夹()
   case "滚动字幕"
    滚动字幕()
    QJDJ=true
   case "特殊文字生成"
    特殊文字()
    QJDJ=true
   case "空白昵称"
    空白昵称()
    QJDJ=true
   case "系统下载器"
    系统下载()
   case "纯色图片生成"
    纯色图片生成()
    QJDJ=true
   case "网址取源"
    网址取源()
   case "获取文件MD5"
    获取文件MD5()
    QJDJ=true
   case "视频解析"
    网络判断(function()提示("没有网络ヾ(❀╹◡╹)ﾉ~",3)end,function()
      activity.newActivity("video_parsing",android.R.anim.fade_in,android.R.anim.fade_out)
    end)
   case "Base64加解密"
    base64加解密()
    QJDJ=true
   case "重复昵称"
    重复文本()
    QJDJ=true
   case "颜色选择"
    颜色选择()
    QJDJ=true
   case "渐变颜色参考"
    渐变颜色参考()
    QJDJ=true
   case "颜色参考"
    颜色参考()
    QJDJ=true
   case "安装包提取"
    安装包提取()
    QJDJ=true
   case "网页转应用"
    网页转应用()
    QJDJ=true
   case "图片转Base64"
    bitmap转Base64()
    QJDJ=true
   case "屏幕测试"
    activity.newActivity("pmcolor",android.R.anim.fade_in,android.R.anim.fade_out)
   case "Base64转图片"
    base64转bitmap()
    QJDJ=true
   case "文本去重"
    文本去重()
    QJDJ=true
   case "图片圆角"
    图片圆角()
    QJDJ=true
   case "获取QQ头像"
    获取QQ头像()
   case "短链接生成"
    短链接生成()
   case "魔方"
    魔方()
    QJDJ=true
   case "UUID生成"
    UUID生成()
    QJDJ=true
   case "油画"
    油画()
    QJDJ=true
   case "AndroLua"
    渐变跳转页面("BLua/main")
   case "进制转换"
    进制转换()
    QJDJ=true
   case "GGScript"
    渐变跳转页面("GGScript/main")
   case "QQ自动点赞"
    QQ自动点赞()
   case "悬浮浏览器"
    渐变跳转页面("LLQ/main")
   case "Ping"
    ping1()
    QJDJ=true
   case "TTS语音播报"
    TTS语音播报()
    QJDJ=true
   case "get/post 调试"
    get_post()
    QJDJ=true
  end
end

grid.onItemClick=function(l,v,p,i)
  local s=(v.Tag.title.Text)
  if not QJDJ then
    点击事件功能(s)
    return true
  end
end

grid.onItemLongClick=function(p,v,i,s)
  local s=(v.Tag.title.Text)
  if File(收藏文件路径).exists() then
    local read_2=io.open(收藏文件路径):read("*a")
    if not string.find(read_2,s) then
      写入文件2(收藏文件路径, read_2.. s.."\n")
    end
    read_2=nil
   else
    写入文件(收藏文件路径,s.."\n")
  end
  提示("已经收藏:"..s,1)
  return true
end

grid3.onItemClick=function(l,v,p,i)
  local s=(v.Tag.title.Text)
  if not QJDJ then
    点击事件功能(s)
    return true
  end
end

grid3.onItemLongClick=function(p,v,i,s)
  local s=(v.Tag.title.Text)
  if File(收藏文件路径).exists() then
    local read_str=io.open(收藏文件路径):read("*a")
    local read_str=string.gsub(read_str,s.."\n","")
    写入文件(收藏文件路径,read_str)
    read_str=nil
    xpcall(function()
      列表加载()
    end,function()
      列表加载()
    end)
  end
  return true
end
