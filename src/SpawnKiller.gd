extends Area2D
var enemies = []
var active = true

func _process(delta):
	if active:
		enemies = get_overlapping_bodies()

func killemall():
	for e in enemies:
		if e.is_in_group("enemies"):
			e.hitkill()
	
	active = false
	queue_free()
