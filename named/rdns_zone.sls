{% set zone_ctxt = pillar['named-zones'][zone_name] %}
{% set ip_prefix = zone_ctxt['ip_prefix'] %}

;
; BIND reverse data file for blue.gah reverse
;
$TTL	{{ zone_ctxt['ttl'] }}
@	IN	SOA	{{ zone_name }}. root.{{ zone_name }}. (
			{{ zone_ctxt['serial'] }}	; Serial
			{{ zone_ctxt['refresh'] }}		; Refresh
			{{ zone_ctxt['retry'] }}		; Retry
			{{ zone_ctxt['expire'] }}		; Expire
			{{ zone_ctxt['negative_ttl'] }} )	; Negative Cache TTL
;

{% for src, dest in zone_ctxt['a_records'].items() %}
{{ [dest.split('.')|reverse|join('.'), ip_prefix.split('.')|reverse|join('.')]|join('') }}	IN	PTR	{{ src }}
{% endfor %}

$GENERATE	1-9	$.1	IN	PTR	lxc00$.blue.gah.
$GENERATE	10-99	$.1	IN	PTR	lxc0$.blue.gah.
$GENERATE	100-255	$.1	IN	PTR	lxc$.blue.gah.

