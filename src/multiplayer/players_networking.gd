extends Node2D

var SERVER_PORT = 9090
var SERVER_IP = "127.0.0.1"
var MAX_PLAYERS = 2

var peer = NetworkedMultiplayerENet.new()

onready var player = get_node("Player")
onready var other_player = get_node("Player2")

remote var player2_pos = Vector2(0,0)
remote var player2_rot = 0

func _on_ClientButton_pressed():
	peer.create_client(SERVER_IP, SERVER_PORT)
	get_tree().set_network_peer(peer)

func _on_ServerButton_pressed():
	peer.create_server(SERVER_PORT, MAX_PLAYERS)
	get_tree().set_network_peer(peer)

func _process(delta):
	if !get_tree().has_network_peer():
		return
	
	other_player.position = player2_pos
	other_player.rotation = player2_rot
	rset_unreliable("player2_pos", player.position)
	rset_unreliable("player2_rot", player.rotation)
