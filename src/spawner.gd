extends AnimatedSprite2D

var playernum = 1

func _ready():
	play("default")

func _on_animation_looped():
	#TODO: Spawn Player here!
	queue_free()
