extends Node2D
var player_obj = preload("res://player.tscn")

func send_command(peer_id, message):
	var msg = message.rsplit(":")
	var id = msg[0]
	var command = msg[1]
	var player = add_player(id)
	if player:
		player.send_command(command)

func remove_player(id):
	var player = find_player_by_id(id)
	if player:
		player.queue_free()
	
func add_player(id):
	var player = find_player_by_id(id)
	if !player:
		player = player_obj.instantiate()
		player.position.x = 600
		player.position.y = 300
		player.player_id = id
		add_child(player)
		
	return player

func find_player_by_id(id):
	var players = get_tree().get_nodes_in_group("players")
	for player in players:
		if player.player_id == id:
			return player
			
	return null
