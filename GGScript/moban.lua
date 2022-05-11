require "import"
import "mod"

layout={
  LinearLayout;
  layout_height="-1";
  layout_width="-1";
  {
    LinearLayout,
    layout_width="fill",
    layout_height="fill",
    orientation="vertical";
    fitsSystemWindows="true";
    {
      LuaEditor,
      id="txt",
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
  };
};

activity.setTitle("GGScript")
--避免输入法界面弹出后遮挡输入光标的问题
activity.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_ADJUST_RESIZE | WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN);
--网页中的视频，上屏幕的时候，可能出现闪烁的情况，需要如下设置
activity.getWindow().setFormat(PixelFormat.TRANSLUCENT);
activity.getWindow().setSoftInputMode(0x10)
--activity.setTitle('模板')
页面主题自动设置()
activity.setContentView(loadlayout(layout))
activity.getActionBar().setDisplayShowHomeEnabled(false)

pcall(function()
  --activity.getWindow().getDecorView().setSystemUiVisibility(View.SYSTEM_UI_FLAG_HIDE_NAVIGATION);
  activity.getWindow().setNavigationBarColor(int(0xff303030));
end)



function click(v)
  txt.paste(v.Text)
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
local ps = {"function","(", ")", "[", "]", "{", "}", "\"", "=", ":", ".", ",", "_", "+", "-", "*", "!","/", "\\", "%", "#", "^", "$", "?", "&", "|", "<", ">", "~", ";", "'" };
for k, v in ipairs(ps) do
  ps_bar.addView(newButton(v))
end


dm=[==[--第一种
--清除搜索数据
gg.clearResults()
--显示按钮
gg.showUiButton()

KG=true
--无限循环
while KG do

  --判断按钮点击
  if gg.isClickedUiButton() then

::biao::--标签

    local bm=gg.getTargetPackage()
    local sj=os.date("%Y-%m-%d %H:%M:%S")
    local title="\n当前时间:"..sj.."\n当前进程包名："..bm

    --GG单选择列表
    local list=gg.choice({
      "选项1",
      "选项2",
      "测试",
      "多选择",
      "编辑框",
      "结束脚本",
    },nil,title)--参数({列表,Boolean值,字符串})

    if list ==1 then
      --弹出窗口
      local gga= gg.alert("提示内容","取消","返回","积极")--参数(小标题,"消极","中立","积极")

      if gga ==1 then
        --nil
       elseif gga == 2 then
        goto biao;--通过标签返回主页面
       elseif gga == 3 then
        --积极事件

      end

     elseif list == 2 then
      --弹出窗口
      local gga= gg.alert("提示2","取消","返回","积极")--参数(小标题,"消极","中立","积极")

      if gga ==1 then
        --nil
       elseif gga == 2 then
        goto biao;--通过标签返回主页面
       elseif gga == 3 then
        --积极事件
      end

     elseif list == 3 then
      local e ,er= pcall(function()

        gg.alert()

      end)

      if not e then
        gg.alert("发生错误:\n"..tostring(er))
      end

     elseif list== 4 then
      --multi=多种
      --Choice=选择
      --table=表、表格
      --selection=选择
      --message=消息、信息
      local gga= gg.multiChoice({
        "第一个",
        "第二个",
        "第三个",
        "第四个",
      },nil,"小标题")

      if gga then
        gg.alert(tostring(gga))
      end

     elseif list==5 then
      local t= gg.prompt(
      {"第一个","第二个"},--编辑框
      {[1]=185,[2]=10},--默认值
      {[1]='number',[2]='number'})--类型

      if t then
        --搜索参数
        local str,types=t[1].."D;"..t[2].."D::",gg.TYPE_DWORD
        --搜索数值--真
        if (gg.searchNumber(str,types)) then
          --[[
          搜索地址(地址,-1,类型,gg.SIGN_EQUAL, 0, -1)
          gg.searchAddress("B3BFA1BC",-1, gg.TYPE_DWORD, gg.SIGN_EQUAL, 0, -1)

          ]]
          --获取搜索结果数量
          local nc=gg.getResultsCount()

          if tonumber(nc)>0 then
            --获取全部搜索结果
            local tb=gg.getResults(tonumber(nc))
            --转成获取值
            tb=gg.getValues(tb)

            local diz,mz=tb[1].address,tb[1].value

            local tg={}
            tg[1]={}
            tg[1].address = diz--地址(tb[1].addrees)
            tg[1].flags = gg.TYPE_DWORD--类型
            --tg[1].freeze =  true --冻结
            tg[1].value =mz --值(tb[1].value)

            --添加到保存数据
            gg.addListItems(tg)
            --设置列表
            gg.setValues(tg)
            --清除搜索数据
            gg.clearResults()
          end


        end

      end

     elseif list==6 then
      KG=nil--通过赋值nil关闭无限循环
      -- os.exit()--这样也可以
    end --listend


  end
end
------------------------------------------------------






--第二种
function strat()
  --清除内存
  gg.clearResults()
  --提示
  gg.toast("清除内存")
  --弹出窗口
  gg.alert("提示")
  --按钮点击事件
  gg.isClickedUiButton()--返回true或者false

  k= gg.multiChoice({
    "功能一",
    "功能二",
    "功能三",
  }, nil, "公告")
  if k[1]==true then

  end
  if k[2]==true then

  end
  if k[3]==true then

  end


end
--没有循环所以会执行一次就关闭

------------------------------------------------------------









--其他写法
function Main0()
SN = gg.choice({
	 "一级菜单",
}, nil, "测试")
if SN==1 then
	 Main1()
end
FX=0
end

function Main1()
SN = gg.choice({
	 "1",
	 "2",
}, nil, "这是一个公告")
if SN==1 then
	 HS2()
end
if SN==2 then
	 HS3()
end
FX=0
end

function HS2()
	 gg.clearResults()

	 gg.searchAddress("B3BFA1BC",-1, gg.TYPE_DWORD, gg.SIGN_EQUAL, 0, -1)
	 jg=gg.getResults(1)
	 sl=gg.getResultCount()
	 for i = 1, sl do
	 	 dzy=jg[i].address
	 	 gg.addListItems({[1] = {address = dzy,flags = gg.TYPE_DWORD,freeze = true,value = 100}})
	 end
	 gg.toast("完成")
	 gg.clearResults()
end

function HS3()
	 gg.clearResults()

	 gg.searchAddress("B3BFA1B8",-1, gg.TYPE_DWORD, gg.SIGN_EQUAL, 0, -1)
	 jg=gg.getResults(1)
	 sl=gg.getResultCount()
	 for i = 1, sl do
	 	 dzy=jg[i].address
	 	 gg.addListItems({[1] = {address = dzy,flags = gg.TYPE_DWORD,freeze = true,value = 100}})
	 end
	 gg.toast("完成")
	 gg.clearResults()
end



Main0()


-----------------------------------------------------------------


--(云脚本)
--脚本访问网络
local url="http://www.baidu.com/"
local js=gg.makeRequest(url).content
--尝试加载并执行
local e,code=pcall(function() loadstring(js)() end)
if not e then
  gg.alert("load eerror :\n"..code)
end




--GG函数
--[[
1.gg.alert 弹出提示窗口

2. gg.toast 屏幕下方弹出提示条( 会自动消失 )

3. gg.prompt 弹出带有控件的提示窗口

4. gg.choice 弹出单选列表窗口

5. gg.clearResults 清除搜索结果

6. gg.editAll 修改搜索结果

7. gg.getFile 获取当前脚本所在目录

8. gg.getResults 获取搜索结果

9. gg.getResultCount 获取搜索结果数量

10. gg.setRanges 设置搜索内存

11. gg.isVisible 判断GG界面是否可见

12. gg.multiChoice 弹出多选列表窗口

13. gg.processKill 结束当前选定应用

14. gg.searchNumber 搜索数据 (重要)

15. gg.setVisible 设置GG界面是否可见

16.getline()读取行数

17.getlocale0荻取地值

18.getRanges()洪取内存区域内的

19.getRangeslist)荻取内存区域列表

20.getResultCount)荻取結果計数

21.getResultso :荻取結果井加載

22.getSpeedo荻取加速

23.getTargetInfo荻取目棕信息

24.getTargetPackage0荻取迸程包名

GG内存代码：

A内存：gg.REGION_ANONYMOUS

CA内存：gg.REGION_C_ALLOC

B内存：gg.REGION_BAD

Xs内存：gg.REGION_CODE_SYS

Xa内存：gg.REGION_CODE_APP

O内存：gg.REGION_OTHER

Ch内存：gg.REGION_C_HEAP

Jh内存：gg.REGION_JAVA_HEAP

J内存：gg.REGION_JAVA

Cd内存：gg.REGION_C_DATA

S内存：gg.REGION_STACK

GG类型代码：

A类：gg.TYPE_AUTO

F类：gg.TYPE_FLOAT

D类：gg.TYPE_DWORD

E类：gg.TYPE_DOUBLE

B类：gg.TYPE_BYTE

Q类：gg.TYPE_QWORD

W类：gg.TYPE_WORD

]]

最后：
GG+安卓10框架+中文手册：https://biao8023.lanzoui.com/b06s9bjcb
GG官网:http://gameguardian.net
GG中文手册:https://biao8023.lanzoui.com/it9qUin2nbc


那个html版的手册是我通过中文手册转html删改来的

因为那个软件没有联系方式，本来想联系作者的……抱歉
所以就自己仿做了一个，有问题请联系我，QQ:2222048023
关于GG修改器的问题别问我，我不会，哈哈哈哈哈哈哈

如果您有GG代码想提供或者教程欢迎您联系我
并会在下一版本中出现并标注来源（作者）

好像没啥好说的了……对了，写的不好大家凑合用哈
还有日期：2020.11.22


]==]

txt.setText(dm)
导航栏透明()



local m = {
  { MenuItem,
    title = "撤销",
    id = "undo",
    icon = "undo", },
  { MenuItem,
    title = "重做",
    id = "redo",
    icon = "redo", },
  { MenuItem,
    title = "手册",
    id = "doc", },

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
    [optmenu.doc]=func.doc,
    [optmenu.search]=func.search,
    [optmenu.navi]=func.navi,
    [optmenu.gotoline]=func.gotoline,
    [optmenu.txtformat]=func.format,
    [optmenu.undo]=func.undo,
    [optmenu.redo]=func.redo,
  }

end

func={}

func.doc=function()
  渐变跳转页面("doc")
end

func.search = function()
  txt.search()
end

func.navi = function()
  create_navi_dlg()
  local str = txt.getText().toString()
  local fs = {}
  indexs = {}
  for s, i in str:gmatch("([%w%._]* *=? *function *[%w%._]*%b())()") do
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
