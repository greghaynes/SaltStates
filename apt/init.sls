apt-get -y update:
  cmd.wait:
    - watch:
      - file: /etc/apt/sources.list

/etc/apt/sources.list:
  file.managed:
    - mode: 644
    - user: root
    - group: root
    - source: salt://apt/sources.list
    - template: jinja
