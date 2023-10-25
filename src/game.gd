extends Node2D
var player_obj = preload("res://player.tscn")
var enemu_obj = preload("res://Enemy.tscn")
var local_player = false
var enemy_spawn_ttl_total = 5
var enemy_spawn_ttl = 0
var spawn_swap = 0
var radius = Vector2(650, 0)
var enemy_count = 30

func _physics_process(delta):
	if Input.is_action_just_pressed("zoom"):
		$Camera2D.zoom -= Vector2(0.05, 0.05) 
		enemy_count += 10
		radius += Vector2(100, 0)
		spawn_enemy()
		radius += Vector2(100, 0)
		spawn_enemy()
	
	enemy_spawn_ttl -= 1 * delta
	if enemy_spawn_ttl <= 0:
		enemy_spawn_ttl = enemy_spawn_ttl_total
		spawn_enemy()
	
	if !local_player:
		if Input.is_action_just_pressed("join"):
			local_player = true
			send_command(0, "1|Local_Player:join")
	else:
		if Input.is_action_pressed("shoot"):
			send_command(0, "1:a") 
		if Input.is_action_pressed("down"):
			send_command(0, "1:down") 
		if Input.is_action_pressed("up"):
			send_command(0, "1:up") 
		if Input.is_action_pressed("left"):
			send_command(0, "1:left") 
		if Input.is_action_pressed("right"):
			send_command(0, "1:right")
			
		if Input.is_action_just_released("down") or Input.is_action_just_released("up") or Input.is_action_just_released("left") or Input.is_action_just_released("right"):
			send_command(0, "1:end")

func spawn_enemy():
	var enemy_instances = get_tree().get_nodes_in_group("enemies").size();
	if enemy_instances <= 1000:
		var count = enemy_count
		var center = get_viewport_rect().size / 2

		var step = 2 * PI / count

		for i in range(count):
			var spawn_pos = center + radius.rotated(step * i)
			
			spawn_pos.x += Global.pick_random(range(1, 100)) * Global.pick_random([1, -1])
			spawn_pos.y += Global.pick_random(range(1, 100)) * Global.pick_random([1, -1])

			var node = enemu_obj.instantiate()
			node.position = spawn_pos 
			add_child(node)
			
		if spawn_swap == 0:
			spawn_swap = 1
		else:
			spawn_swap = 0

func send_command(peer_id, message):
	var msg = message.rsplit(":")
	var id = msg[0]
	var my_name = ""
	var command = msg[1]
	if command == "none":
		command = "end"
		
	if command == "join":
		var msg2 = id.rsplit("|")
		id = msg2[0]
		command = "end"
		my_name = msg2[1]

	var is_dir = is_direction(command)
	var player = add_player(id, my_name)
		
	if player:
		if is_dir:
			player.send_command(command)
		else:
			player.send_action()
			
func is_direction(command):
	return command == "none" or command == "up" or command == "down" or command == "left" or command == "right" or command == "end" or command == "leftup" or command == "leftdown" or command == "rightdown" or command == "rightup"

func remove_player(id):
	var player = find_player_by_id(id)
	if player:
		player.queue_free()
	
func add_player(id, my_name):
	var player = find_player_by_id(id)
	if !player:
		player = player_obj.instantiate()
		player.position.x = 600
		player.position.y = 300
		player.player_id = id
		player.my_name = my_name
		add_child(player)
		
	return player

func find_player_by_id(id):
	var players = get_tree().get_nodes_in_group("players")
	for player in players:
		if player.player_id == id:
			return player
			
	return null
