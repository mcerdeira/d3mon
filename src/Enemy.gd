extends CharacterBody2D
var speed = 10
var where = get_viewport_rect().size / 2

func _ready():
	where = get_viewport_rect().size / 2
	$sprite.play("default")
	$face.play("default")

func _process(delta):
	var direction = global_position.direction_to(where)
	velocity = direction * speed
	move_and_slide()
	if global_position.x < where.x:
		$sprite.scale.x = 1
		$face.scale.x = 1
	else:
		$sprite.scale.x = -1
		$face.scale.x = -1
