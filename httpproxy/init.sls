lighttpd:
  pkg:
    - installed
  service:
    - running

lighttpd-conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://httpproxy/lighttpd.conf
    - name: /etc/lighttpd/lighttpd.conf
    - template: jinja

service lighttpd reload:
  cmd.wait:
    - watch:
      - file: lighttpd-conf
