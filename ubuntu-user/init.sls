/home/ubuntu/.ssh:
  file.directory:
    - user: ubuntu
    - group: ubuntu
    - mode: 700

/home/ubuntu/.ssh/authorized_keys:
  file.managed:
    - user: ubuntu
    - group: ubuntu
    - mode: 600
    - source: salt://ubuntu-user/authorized_keys
    - template: jinja
    - require:
      - file: /home/ubuntu/.ssh
