mumble-server:
  pkg:
    - installed

mumble-config:
  file.managed:
    - source: salt://mumble/mumble-server.ini
    - name: /etc/mumble-server.ini

service mumble-server restart:
  cmd.wait:
    - watch:
      - file: mumble-config
