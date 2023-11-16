# Simulates HTTP requests on Nginx using ApacheBench

exec { 'fix_nginx':
  command => 'sed -i "s/-n 15/-n 4096/" /etc/default/nginx',
  path    => '/usr/local/bin/:/bin/',
}

exec { 'restart_nginx':
  command     => '/etc/init.d/nginx restart',
  refreshonly => true,
  subscribe   => Exec['fix_nginx'],
}
