extends TileMap

var prev_pos = Vector2()

func floor_material(): #get the floor material of the tile the player is moving on
	for player in get_tree().get_nodes_in_group("Player"):
		var pos = world_to_map(player.position)
		
		if prev_pos == pos:
			return
		
		prev_pos = pos
		
		var name = tile_set.tile_get_name(get_cellv(pos))
		
		if "metal" in name.to_lower():
			player.floor_material = "_metal"
		else:
			player.floor_material = ""

func _physics_process(delta):
	floor_material()
