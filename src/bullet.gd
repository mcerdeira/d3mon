extends CharacterBody2D
var dir = ""
var speed_max = 1500.0
var speed = 500
var motion = Vector2()
var target = null

func _ready():
	print(get_global_mouse_position())
	target = (get_global_mouse_position() - self.global_position).normalized()
	print(target)
	velocity = target * speed
	$sprite.play("default")

func _physics_process(delta):
	move_and_slide()
