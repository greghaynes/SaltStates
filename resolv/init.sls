/etc/resolv.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://resolv/resolv.conf
