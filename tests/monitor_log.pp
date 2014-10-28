monitor_log { 'watch_login':
  path    => '/tmp/log/login',
  match   => '^done$',
  timeout => 15,
}
