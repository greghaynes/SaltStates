language-pack-en-base:
  pkg:
    - installed

locale-gen:
  cmd.wait:
    - watch:
      - pkg: language-pack-en-base
    - name: locale-gen {{ pillar['locale-name'] }}

dpkg-reconfigure locales:
  cmd.wait:
    - watch:
      - cmd: locale-gen
