/home/ubuntu/.ssh/authorized_keys:
  file.managed:
    - user: ubuntu
    - group: ubuntu
    - makedirs: True
    - mode: 600
    - source: salt://ubuntuuser/authorized_keys
