extends Node2D
var global_delta = 0.1
var player_id = -1

func _ready():
	add_to_group("players")

func send_command(command):
	if command == "up":
		position.y -= 5 
	if command == "down":
		position.y += 5 
	
	if command == "left":
		position.x -= 5 
	if command == "right":
		position.x += 5 
