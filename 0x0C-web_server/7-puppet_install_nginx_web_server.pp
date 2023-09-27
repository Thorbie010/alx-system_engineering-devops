# Install and configure nginx

exec {'update package':
  command =>  '/usr/bin/sudo apt-get update && /usr/bin/sudo apt-get upgrade -y',
  path    => ['/bin', '/usr/bin']
}

exec {'install nginx':
  command => '/usr/bin/sudo  apt -y install nginx',
  path    => ['/bin', '/usr/bin'],
  require => EXEC['update package']
}

exec {'manage html page':
  command => '/usr/bin/sudo mkdir /etc/nginx/html; sudo touch /etc/nginx/html/index.html; sudo chmod +w /etc/nginx/html/index.html',
  path    => ['/bin', '/usr/bin'],
  require => EXEC['install nginx']
}

exec {'write to html file':
  command =>  '/usr/bin/sudo echo "Hello World!" | sudo tee /etc/nginx/html/index.html > /dev/null',
  path    => ['/bin', '/usr/bin'],
  require => EXEC['manage html page']
}

exec {'configuration':
  command => '/usr/bin/sudo echo "server {\n\tlisten 80 default_server;\n\tlisten [::]:80 default_server;\n\troot /etc/nginx/html;\n\tindex index.html index.htm;\n\tlocation /redirect_me {\n\t\treturn 301 http://khingz.tech/;\n\t}\n\t} | sudo tee /etc/nginx/sites-available/default > /dev/null"',
  path    => ['/bin', '/usr/bin'],
  require => EXEC['install nginx']
}

exec {'restart nginx':
  command =>  '/usr/bin/sudo nginx -t; /usr/bin/sudo service nginx restart',
  path    => ['/bin', '/usr/bin'],
  require => EXEC['configuration']
}
 
