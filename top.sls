base:
  '*':
    - resolv
    - sshd
    - cacert
    - locale
    - rsyslog
    - motd
  'os:Ubuntu':
    - match: grain
    - apt
    - ubuntu-user
  lxc003:
    - httpsproxy
  lxc004:
    - avtredmine
  lxc005:
    - pgmaster
  lxc022:
    - named
  lxc018:
    - httpproxy
  lxc017:
    - mumble
  lxc023:
    - mumble
  lxc024:
    - redis
  lxc025:
    - gitolite
