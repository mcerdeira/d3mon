extends Node2D
var global_delta = 0.1
var player_id = -1
var player_command = "end"
var last_dir = "right"
var bullet_obj = preload("res://bullet.tscn")
var speed = 100.0
var ttl = 0

func _ready():
	add_to_group("players")

func send_command(command):
	player_command = command
	
func send_action():
	if ttl <= 0:
		ttl = 0.2
		var bullet = bullet_obj.instantiate()
		bullet.global_position =  $shoot_pos.global_position
		bullet.dir = last_dir
		get_parent().add_child(bullet)
		
func _physics_process(delta):
	ttl -= 1 * delta
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
