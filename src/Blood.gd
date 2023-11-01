extends CPUParticles2D
var fade_duration = 5.0
var finished = false

func _process(delta):
	if finished:
		fade_duration -= 1 * delta
		if fade_duration <= 0:
			modulate.a = lerp(modulate.a, 0.0, 0.01)
			if modulate.a <= 0:
				queue_free()

func _on_timer_timeout():
	#set_process(false)
	set_physics_process(false)
	set_process_input(false)
	set_process_internal(false)
	set_process_unhandled_input(false)
	set_process_unhandled_key_input(false)
	finished = true
