extends Node
var shaker_obj = null
var SfxMuted = false
var GAME_OVER = true
var ENEMY_SPEED_BASE = 0.0
var ENEMY_SPAWN_VEL = 5.0
var MainTheme = "res://music/Electric Callboy - WE GOT THE MOVES (OFFICIAL VIDEO).mp3"
var COLORS = [
	Color8(66, 135, 245),
	Color8(245, 185, 66),
	Color8(242, 245, 66),
	Color8(66, 245, 87),
	Color8(66, 245, 239),
	Color8(66, 117, 245),
	Color8(69, 66, 245),
	Color8(179, 66, 245),
	Color8(245, 66, 164),
	Color8(255, 255, 255),
	Color8(34, 54, 225),
]

func get_random_color():
	return pick_random(COLORS)

func pick_random(container):
	if typeof(container) == TYPE_DICTIONARY:
		return container.values()[randi() % container.size() ]
	assert( typeof(container) in [
			TYPE_ARRAY, TYPE_PACKED_COLOR_ARRAY, TYPE_PACKED_INT32_ARRAY,
			TYPE_PACKED_BYTE_ARRAY, TYPE_PACKED_FLOAT32_ARRAY, TYPE_PACKED_STRING_ARRAY,
			TYPE_PACKED_VECTOR2_ARRAY, TYPE_PACKED_VECTOR3_ARRAY
			], "ERROR: pick_random" )
	return container[randi() % container.size()]

func play_sound(stream: AudioStream, options:= {}) -> AudioStreamPlayer:
	if SfxMuted:
		return null
	else:
		var audio_stream_player = AudioStreamPlayer.new()

		add_child(audio_stream_player)
		audio_stream_player.stream = stream
		audio_stream_player.bus = "SFX"
		
		for prop in options.keys():
			audio_stream_player.set(prop, options[prop])
		
		audio_stream_player.play()
		audio_stream_player.connect("finished", queue_free)
		
		return audio_stream_player
