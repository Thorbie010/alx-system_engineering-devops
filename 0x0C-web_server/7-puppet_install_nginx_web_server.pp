# Install and configure nginx

exec {'update package':
  command =>  '/usr/bin/apt-get update && /usr/bin/apt-get upgrade -y',
  path    => ['/bin', '/usr/bin']
}

package {'nginx':
  ensure   => present,
  provider =>  'apt'
}

file { '/etc/nginx/html':
  ensure  => directory,
  require => Package['nginx']
}

file {'/etc/nginx/html/index.html':
  ensure  => file,
  content =>  "Hello world!\n",
  mode    =>  '0666',
  require => Package['nginx']
}

file {'/etc/nginx/sites-available/default':
  ensure  => file,
  content => @(EOT),
  server {
        listen 80 default_server;
        listen [::]:80 default_server;
        root /etc/nginx/html;
        index index.html index.htm;

        location /redirect_me {
:x
        }
  }
  |-EOT
  mode    => '0666',
  require => Package['nginx']
}

exec {'nginx test':
  command =>  '/usr/sbin/nginx -t',
  path    => ['/bin', '/usr/bin', '/usr/sbin'],
  require =>  Package['nginx']
}

exec {'nginx reload':
  command =>  '/usr/sbin/service nginx restart',
  path    => ['/bin', '/usr/bin', '/usr/sbin'],
  require => Exec['nginx test']
}
 
