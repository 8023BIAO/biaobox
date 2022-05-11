
gg.clearResults()--清除搜索数据
gg.showUiButton()--显示按钮

while true do--无限循环
  if gg.isClickedUiButton() then--点击按钮

    local data1= {
      "第一个选项",
      "第二个选项",
      "第三个选项",
      "第四个选项",
      "退出脚本",
    }

    local list=gg.choice(data1,nil,"小标题")--单选择对话框

    if list== 1 then--选择结果1

     elseif list== 2 then--选择结果2

     elseif list== 3 then--选择结果3

     elseif list== 4 then--选择结果4

     elseif list== 5 then--选择结果5
      os.exit()--结束(退出)
    end


  end
end