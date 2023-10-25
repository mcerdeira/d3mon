extends CharacterBody2D
var speed_chase = 35
var speed_normal = 10
var speed = speed_normal
var player_where = null
var where = null
var original_where = null
var health = 10
var hitted_ttl = 0

func _ready():
	add_to_group("enemies")
	where = get_viewport_rect().size / 2
	original_where = where
	$sprite.play("default")
	$face.play("default")

func _process(delta):
	if player_where != null and is_instance_valid(player_where):
		where = player_where.position
	else:
		player_where = null
		where = original_where
		speed = speed_normal
		
	if hitted_ttl > 0:
		hitted_ttl -= 1 * delta
		$sprite.material.set_shader_parameter("hitted", 1)
		if hitted_ttl <= 0:
			$sprite.material.set_shader_parameter("hitted", 0)
		
	if health <= 0:
		queue_free()
		return
	
	var direction = global_position.direction_to(where)
	velocity = direction * speed
	move_and_slide()
	if global_position.x < where.x:
		$sprite.scale.x = 1
		$face.scale.x = 1
	else:
		$sprite.scale.x = -1
		$face.scale.x = -1

func hited():
	health -= 1
	hitted_ttl = 0.1

func _on_area_attract_body_entered(body):
	if player_where == null and body.is_in_group("players"):
		player_where = body
		where = player_where.position
		speed = speed_chase
