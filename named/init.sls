bind9:
  pkg:
    - installed
  service:
    - running
    - enabled: True

service bind9 reload:
  cmd.wait:
    - watch:
{% for zone_name in pillar['named-zones'].keys() %}
      - file: zone_{{ zone_name }}
{% endfor %}

{% for zone_name, zone_ctxt in pillar['named-zones'].items() %}
zone_{{ zone_name }}:
  file.managed:
    - source: salt://named/zone.sls
    - name: /etc/bind/my_zones/db.{{ zone_name }}
    - template: jinja
    - context:
      zone_name: {{ zone_name }}
    - mode: 644
    - user: root
    - group: root
    - makedirs: True

{% set rdns_zone = zone_ctxt['ip_prefix'].split('.')[:-1]|reverse|join('.') %}
rdns_zone_{{ zone_name}}:
  file.managed:
    - source: salt://named/rdns_zone.sls
    - name: /etc/bind/my_zones/db.in-addr.{{ rdns_zone }}
    - template: jinja
    - context:
      zone_name: {{ zone_name }}
    - mode: 644
    - user: root
    - group: root
{% endfor %}

/etc/bind/named.conf.my-zones:
  file.managed:
    - source: salt://named/named.conf.my-zones
    - template: jinja
    - mode: 644
    - user: root
    - group: root

{% for file in ['bind.keys', 'named.conf', 'named.conf.default-zones', 'named.conf.local', 'named.conf.options', 'zones.rfc1918'] %}
conf-{{ file }}:
  file.managed:
    - source: salt://named/{{ file }}
    - mode: 644
    - user: root
    - group: root
    - name: /etc/bind/{{ file }}
    - makedirs: True
{% endfor %}

{% for file in ['db.0', 'db.127', 'db.255', 'db.empty', 'db.local', 'db.root'] %}
default_zone_{{ file }}:
  file.managed:
    - source: salt://named/default_zones/{{ file }}
    - mode: 644
    - user: root
    - group: root
    - name: /etc/bind/default_zones/{{ file }}
    - makedirs: True
{% endfor %}
