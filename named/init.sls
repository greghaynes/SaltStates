bind9:
  pkg:
    - installed
  service:
    - running
    - enabled: True

service bind9 reload:
  cmd.wait:
    - watch:
      - file: config_data

config_dir:
  file.directory:
    - user: root
    - group: bind
    - mode: 750
    - recurse:
      - user
      - group
    - name: /etc/bind

config_data:
  file.recurse:
    - name: /etc/bind
    - source: salt://named/bind
