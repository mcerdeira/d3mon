extends CharacterBody2D
var player_command = ""
var speed_max = 1500.0
var speed = 800
var motion = Vector2()
var desv = 0
var divisor = 5
var ttl = 0
var framo = 0

func _ready():
	var rand_desv = Global.pick_random([89, 24, 1, 3])
	divisor += rand_desv
	$sprite.stop()

func _physics_process(delta):
	$sprite.frame = framo
	ttl -= 1 * delta
	if ttl <= 0:
		queue_free()
		visible = false
		return
		
	if player_command == "leftup":
		position.y -= speed * delta
		position.x -= speed * delta
		if desv == 1:
			position.y += speed / divisor * delta
		if desv == 2:
			position.y -= speed / divisor * delta
			
	if player_command == "rightup":
		position.y -= speed * delta
		position.x += speed * delta
		if desv == 1:
			position.y += speed / divisor * delta
		if desv == 2:
			position.y -= speed / divisor * delta
	if player_command == "leftdown":
		position.y += speed * delta
		position.x -= speed * delta
		if desv == 1:
			position.y += speed / divisor * delta
		if desv == 2:
			position.y -= speed / divisor * delta		
	if player_command == "rightdown":
		position.y += speed * delta
		position.x += speed * delta
		if desv == 1:
			position.y += speed / divisor * delta
		if desv == 2:
			position.y -= speed / divisor * delta
	
	if player_command == "up":
		position.y -= speed * delta
		if desv == 1:
			position.x += speed / divisor * delta
		if desv == 2:
			position.x -= speed / divisor * delta
	if player_command == "down":
		position.y += speed * delta
		if desv == 1:
			position.x += speed / divisor * delta
		if desv == 2:
			position.x -= speed / divisor * delta
	if player_command == "left":
		position.x -= speed * delta
		if desv == 1:
			position.y += speed / divisor * delta
		if desv == 2:
			position.y -= speed / divisor * delta
	if player_command == "right":
		position.x += speed * delta
		if desv == 1:
			position.y += speed / divisor * delta
		if desv == 2:
			position.y -= speed / divisor * delta
