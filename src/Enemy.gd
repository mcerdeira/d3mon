extends CharacterBody2D
var Blood = preload("res://Blood2.tscn")
var speed_chase = 35.0
var speed_normal = 10.0
var speed = speed_normal
var player_where = null
var where = null
var original_where = null
var health = 10
var hitted_ttl = 0
var bleeding = false
var bleeding_time_total = 3.0
var bleeding_time = bleeding_time_total
var bleeding_spawn_total = 1.0
var bleeding_spawn = 0

func _ready():
	add_to_group("enemies")
	where = get_viewport_rect().size / 2
	original_where = where
	$sprite.play("default")
	$face.play("default")

func _process(delta):
	if bleeding:
		bleeding_spawn -= 1 * delta
		bleeding_time -= 1 * delta
		if bleeding_spawn <= 0:
			bleeding_spawn = bleeding_spawn_total
			bleed()
		
		if bleeding_time <= 0:
			bleeding = false
			bleeding_spawn = 0
			bleeding_time = bleeding_time_total

	if player_where != null and is_instance_valid(player_where):
		where = player_where.position
		speed = lerp(speed, speed_chase, 0.1)
	else:
		player_where = null
		where = original_where
		speed = lerp(speed, speed_normal, 0.1)
	
	
		
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
		

func bleed():
	for i in range(Global.pick_random([1, 2])):
		var p = Blood.instantiate()
		p.global_position = global_position
		p.z_index = -9999
		get_parent().add_child(p)

func hited():
	speed = 0.0
	bleeding = true
	health -= 1
	hitted_ttl = 0.1

func _on_area_attract_body_entered(body):
	if player_where == null and body.is_in_group("players"):
		player_where = body
		where = player_where.position
		speed = speed_chase
