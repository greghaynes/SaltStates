postgresql-9.1:
  pkg:
    - installed
  service:
    - name: postgresql
    - running
    - enable: True

{% set config_files = [
    ['pg_hba.conf', '/etc/postgresql/9.1/main/pg_hba.conf'],
    ['postgresql.conf', '/etc/postgresql/9.1/main/postgresql.conf'], ]
%}

{% for src, dest in config_files %}
{{ dest }}:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - source: salt://pgmaster/{{ src }}
{% endfor %}

service postgresql restart:
  cmd.wait:
    - watch:
      {% for src, dest in config_files %}
      - file: {{ dest }}
      {% endfor %}
