extends CharacterBody2D
var dir = null
var speed_max = 1500.0
var speed = 500
var motion = Vector2()
var target = null

func _ready():
	if dir == null:
		dir = Vector2(0, 0)

	target = (dir - self.global_position).normalized() #(get_global_mouse_position() - self.global_position).normalized()
	velocity = target * speed
	$sprite.play("default")

func _physics_process(delta):
	move_and_slide()
