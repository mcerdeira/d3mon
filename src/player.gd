extends CharacterBody2D
var global_delta = 0.1
var player_id = -1
var player_command = "end"
var last_dir = "right"
var bullet_obj = preload("res://bullet.tscn")
var speed = 100.0
var ttl = 0
var target = null

func _ready():
	add_to_group("players")

func send_command(command, _x=null, _y=null):
	player_command = command
	if _x and _y:
		target = Vector2(int(_x), int(_y))
	else:
		target = null
	
func send_action():
	if ttl <= 0:
		ttl = 0.2
		var bullet = bullet_obj.instantiate()
		bullet.global_position =  $shoot_pos.global_position
		bullet.dir = target
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
	if player_command == "up":
		last_dir = "up"
		position.y -= speed * delta
	if player_command == "down":
		last_dir = "down"
		position.y += speed * delta
	if player_command == "left":
		last_dir = "left"
		position.x -= speed * delta
		$sprite.scale.x = -1
	if player_command == "right":
		last_dir = "right"
		position.x += speed * delta
		$sprite.scale.x = 1
		
	if is_moving:
		$sprite.play("default")
	else:
		$sprite.stop()
