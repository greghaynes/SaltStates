rsyslog:
  pkg:
    - installed
  service:
    - running
    - enable: True

/etc/rsyslog.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://rsyslog/rsyslog.conf
    - template: jinja

service rsyslog reload:
  cmd.wait:
    - watch:
      - file: /etc/rsyslog.conf
