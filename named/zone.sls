{% set zone_ctxt = pillar['named-zones'][zone_name] %}
{% set ip_prefix = zone_ctxt['ip_prefix'] %} 

;
; BIND data file for {{ zone_name }}
;
$TTL	604800
@	IN	SOA	{{ zone_name }}. root.{{ zone_name }}. (
			12291201	; Serial
			 604800		; Refresh
			  86400		; Retry
			2419200		; Expire
			 604800 )	; Negative Cache TTL
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
