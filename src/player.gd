extends CharacterBody2D
var global_delta = 0.1
var player_id = -1
var player_command = "end"
var last_dir = "right"
var bullet_obj = preload("res://bullet.tscn")
var speed = 100.0
var ttl = 0
var current_color = null

func _ready():
	add_to_group("players")
	randomize()
	current_color = Color(randf(), randf(), randf())
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
		
func _physics_process(delta):
	ttl -= 1 * delta
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
		
	if is_moving:
		$sprite.play("default")
	else:
		$sprite.stop()
