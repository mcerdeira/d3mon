extends Node2D
var global_delta = 0.1
var player_id = -1
var player_command = "end"
var bullet_obj = preload("res://bullet.tscn")

func _ready():
	add_to_group("players")

func send_command(command):
	player_command = command
	
func send_action():
	var bullet = bullet_obj.instantiate()
	bullet.global_position = self.global_position
	get_parent().add_child(bullet)
		
func _physics_process(delta):
	var is_moving = (player_command != "end")
	if player_command == "up":
		position.y -= 100 * delta
	if player_command == "down":
		position.y += 100 * delta
	if player_command == "left":
		position.x -= 100 * delta
		$sprite.scale.x = -1
	if player_command == "right":
		position.x += 100 * delta
		$sprite.scale.x = 1
		
	if is_moving:
		$sprite.play("default")
	else:
		$sprite.stop()
