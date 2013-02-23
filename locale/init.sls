language-pack-en-base:
  pkg:
    - installed

locale-gen en_US.UTF-8:
  cmd.wait:
    - watch:
      - pkg: language-pack-en-base

dpkg-reconfigure locales:
  cmd.wait:
    - watch:
      - cmd: locale-gen en_US.UTF-8
