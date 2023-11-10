extends Node2D
var ttl = 1.3

func _process(delta):
	position.y -= 10 * delta
	ttl -= 1 * delta
	if ttl <= 0:
		queue_free()
