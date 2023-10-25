extends CharacterBody2D
var speed = 10
var player_where = null
var where = get_viewport_rect().size / 2

func _ready():
	add_to_group("enemies")
	where = get_viewport_rect().size / 2
	$sprite.play("default")
	$face.play("default")

func _process(delta):
	if player_where != null and is_instance_valid(player_where):
		where = player_where.position
	
	var direction = global_position.direction_to(where)
	velocity = direction * speed
	move_and_slide()
	if global_position.x < where.x:
		$sprite.scale.x = 1
		$face.scale.x = 1
	else:
		$sprite.scale.x = -1
		$face.scale.x = -1


func _on_area_attract_body_entered(body):
	if body.is_in_group("players"):
		player_where = body
		where = player_where.position
		speed = 50
