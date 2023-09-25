# creates a  script to change the ssh configuration

file_line {
    ensure => 'present'
    path => 'etc/ssh/ssh_config'
    line => '   PasswordAuthentication no'
}

file_line {
    ensure => 'present'
    path => 'etc/ssh/ssh_config'
    line => '   IdentityFile ~/.ssh/school'
}