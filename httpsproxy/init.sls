openssl:
  pkg:
    - installed

lighttpd:
  pkg:
    - installed
  service:
    - running
    - enable: True

service lighttpd restart:
  cmd.wait:
    - watch:
      - file: /etc/lighttpd/lighttpd.conf

/etc/lighttpd/lighttpd.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://httpsproxy/lighttpd.conf
