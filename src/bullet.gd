extends CharacterBody2D
var player_command = ""
var speed_max = 1500.0
var speed = 500
var motion = Vector2()

func _ready():
	$sprite.play("default")

func _physics_process(delta):
	if player_command == "leftup":
		position.y -= speed * delta
		position.x -= speed * delta
	if player_command == "rightup":
		position.y -= speed * delta
		position.x += speed * delta
	if player_command == "leftdown":
		position.y += speed * delta
		position.x -= speed * delta
	if player_command == "rightdown":
		position.y += speed * delta
		position.x += speed * delta
	
	if player_command == "up":
		position.y -= speed * delta
	if player_command == "down":
		position.y += speed * delta
	if player_command == "left":
		position.x -= speed * delta
	if player_command == "right":
		position.x += speed * delta
