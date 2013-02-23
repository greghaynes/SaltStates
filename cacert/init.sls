/etc/ssl/certs/GAH_RootCA.pem:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://cacert/cacert.pem
