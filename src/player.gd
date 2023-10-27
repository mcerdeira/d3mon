extends CharacterBody2D
var already_shake = false
var global_delta = 0.1
var player_id = -1
var player_command = "end"
var last_dir = "right"
var bullet_obj = preload("res://bullet.tscn")
var Blood = preload("res://Blood2.tscn")
var speed = 100.0
var ttl = 0
var hit_color = Color(1, 0, 0)
var current_color = null
var my_name = ""
var is_named = false
var bleeding = false
var bleeding_time_total = 3.0
var bleeding_time = bleeding_time_total
var bleeding_spawn_total = 1.0
var bleeding_spawn = 0
var spawning = true
var health = 10
var hitted_ttl = 0
var dead = false

func _ready():
	$sprite.visible = false
	$face.visible = false
	$cloth.visible = false
	$hat.visible = false
	$lbl_name.visible = false
	
	$spawner.play("default")
	add_to_group("players")
	randomize()
	current_color = Global.get_random_color()
	$sprite.material.set_shader_parameter("new", current_color)
	$hat.material.set_shader_parameter("new", current_color)
	set_random_frame($face)
	set_random_frame($hat)
	
func set_random_frame(sprite):
	randomize()
	var f = randi() % sprite.get_sprite_frames().get_frame_count("default")
	sprite.frame = f

func send_command(command):
	player_command = command
	
func send_action():
	if !spawning:
		if ttl <= 0:
			ttl = 0.1
			var bullet = null
			var ttls = [0.4, 0.3, 0.3]
			var framos = [1, 0, 0]
			for i in range(3):
				bullet = bullet_obj.instantiate()
				bullet.global_position =  $shoot_pos.global_position
				bullet.player_command = last_dir
				bullet.ttl = ttls[i]
				bullet.desv = i
				bullet.framo = framos[i]
				get_parent().add_child(bullet)
			
func bleed():
	for i in range(Global.pick_random([1, 2])):
		var p = Blood.instantiate()
		p.global_position = global_position
		p.z_index = -9999
		get_parent().add_child(p)
		
func _physics_process(delta):
	if !is_named:
		is_named = true
		$lbl_name.text = my_name
		
	if spawning:
		return
	
	ttl -= 1 * delta
	
	if hitted_ttl > 0:
		hitted_ttl -= 1 * delta
		$sprite.material.set_shader_parameter("new", hit_color)
		$hat.material.set_shader_parameter("new", hit_color)
		if hitted_ttl <= 0:
			$sprite.material.set_shader_parameter("new", current_color)
			$hat.material.set_shader_parameter("new", current_color)
	
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
	
#
#	target = (get_global_mouse_position() - self.global_position).normalized()
#	velocity = target * speed
#	print(get_global_mouse_position() )
#
#	move_and_slide()
	
	var is_moving = (player_command != "end")
	
	if player_command == "leftup":
		last_dir = player_command 
		position.y -= speed * delta
		position.x -= speed * delta
		scale.x = -1
	if player_command == "rightup":
		last_dir = player_command 
		position.y -= speed * delta
		position.x += speed * delta
		scale.x = 1
	if player_command == "leftdown":
		last_dir = player_command
		position.y += speed * delta
		position.x -= speed * delta
		
		scale.x = -1
	if player_command == "rightdown":
		last_dir = player_command
		position.y += speed * delta
		position.x += speed * delta
		scale.x = 1
	
	if player_command == "up":
		last_dir = player_command
		position.y -= speed * delta
	if player_command == "down":
		last_dir = player_command
		position.y += speed * delta
	if player_command == "left":
		last_dir = player_command
		position.x -= speed * delta
		scale.x = -1
	if player_command == "right":
		last_dir = player_command
		position.x += speed * delta
		scale.x = 1
		
	if health <= 0 and !dead:
		get_parent().zoom_out()
		dead = true
		queue_free()
	
	$lbl_name.scale.x = scale.x
			
	if is_moving:
		$sprite.play("default")
	else:
		$sprite.stop()

func _on_spawner_animation_looped():
	spawning = false
	$sprite.visible = true
	$face.visible = true
	$cloth.visible = true
	$hat.visible = true
	$lbl_name.visible = true
	$spawner.visible = false
	$spawner.queue_free()
	$SpawnKiller.killemall()

func _on_spawner_frame_changed():
	if $spawner.frame >= 7:
		if !already_shake:
			already_shake = true
			Global.shaker_obj.shake(50, 2.1)
	
	if $spawner.frame >= 20:
		$sprite.visible = true
		$face.visible = true
		$cloth.visible = true
		$hat.visible = true
		
func _on_area_body_entered(body):
	if body.is_in_group("enemies") and !spawning:
		body.stop_hit()
		hitted_ttl = 0.1
		bleeding = true
		health -= 1
