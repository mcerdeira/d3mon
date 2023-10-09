extends Control

@onready var _server: WebSocketServer = $WebSocketServer
@onready var _log_dest = $Panel/VBoxContainer/RichTextLabel
@onready var _line_edit = $Panel/VBoxContainer/Send/LineEdit
@onready var _listen_port = $Panel/VBoxContainer/Connect/Port

func _ready():
	_on_listen_toggled(true)

func info(msg):
	print(msg)
	_log_dest.add_text(str(msg) + "\n")


# Server signals
func _on_web_socket_server_client_connected(peer_id):
	var peer: WebSocketPeer = _server.peers[peer_id]
	info("Remote client connected: %d. Protocol: %s" % [peer_id, peer.get_selected_protocol()])

func _on_web_socket_server_client_disconnected(peer_id):
	var peer: WebSocketPeer = _server.peers[peer_id]
	info("Remote client disconnected: %d. Code: %d, Reason: %s" % [peer_id, peer.get_close_code(), peer.get_close_reason()])

func _on_web_socket_server_message_received(peer_id, message):
	info("Server received data from peer %d: %s" % [peer_id, message])
	#_server.send(-peer_id, "[%d] Says: %s" % [peer_id, message])
	$Game.send_command(peer_id, message)

func _on_listen_toggled(pressed):
	if not pressed:
		_server.stop()
		info("Server stopped")
		return
	$Game.visible = true
	$Panel.visible = false
	var port = int(_listen_port.value)
	var err = _server.listen(port)
	if err != OK:
		info("Error listing on port %s" % port)
		return
	info("Listing on port %s, supported protocols: %s" % [port, _server.supported_protocols])
