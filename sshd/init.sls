openssh-server:
  pkg:
    - installed

ssh:
  service:
    - running
    - enabled: True

sshd_config:
  file.managed:
    - source: salt://sshd/sshd_config
    - user: root
    - group: root
    - mode: 640
    - name: /etc/ssh/sshd_config

service ssh restart:
  cmd.wait:
    - watch:
      - file: sshd_config
