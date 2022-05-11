-- 时间监听

time_intentFilter = IntentFilter();

time_intentFilter.addAction(Intent.ACTION_TIME_TICK);--每分钟变化

time_intentFilter.addAction(Intent.ACTION_TIMEZONE_CHANGED);--设置了系统时区

time_intentFilter.addAction(Intent.ACTION_TIME_CHANGED);--设置了系统时间

timeChangeReceiver = function(context,intent)
  local bundle = intent.getExtras();
  local 状态=(intent.getAction())

  if 状态==Intent.ACTION_TIME_TICK then



  end


end

activity.registerReceiver(timeChangeReceiver, time_intentFilter);
