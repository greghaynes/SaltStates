{% set zone_ctxt = pillar['named-zones'][zone_name] %}
{% set ip_prefix = zone_ctxt['ip_prefix'] %} 

;
; BIND data file for {{ zone_name }}
;
$TTL	{{ zone_ctxt['ttl'] }}
@	IN	SOA	{{ zone_name }}. root.{{ zone_name }}. (
			{{ zone_ctxt['serial'] }}	; Serial
			{{ zone_ctxt['refresh'] }}		; Refresh
			{{ zone_ctxt['retry'] }}		; Retry
			{{ zone_ctxt['expire'] }}		; Expire
			{{ zone_ctxt['negative_ttl'] }} )	; Negative Cache TTL
;


{% for src, dest in zone_ctxt['ns_records'].items() %}
{{ src }}	IN	NS	{{ dest }}
{% endfor %}


{% for src, dest in zone_ctxt['a_records'].items() %}
{{ src }}	IN	A	{{ [ip_prefix, dest]|join('') }}
{% endfor %}


$GENERATE	1-9	lxc00$	IN	A	{{ ip_prefix }}1.$
$GENERATE	10-99	lxc0$	IN	A	{{ ip_prefix }}1.$
$GENERATE	100-255	lxc$	IN	A	{{ ip_prefix }}1.$
