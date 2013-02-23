mumble-server:
  pkg:
    - installed

mumble-config:
  file.managed:
    - source: salt://mumble/mumble-server.ini
    - name: /etc/mumble-server.ini
    - user: root
    - group: root
    - mode: 644
    - template: jinja

service mumble-server restart:
  cmd.wait:
    - watch:
      - file: mumble-config
