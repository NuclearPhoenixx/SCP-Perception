extends ColorRect

onready var NameNode = get_parent().get_parent().get_node("ItemName")
onready var DescNode = NameNode.get_node("ItemDescription")
onready var ImgNode = get_node("ItemImage")

var item_node_name = "" #name of the item's node, useful for dropping item, etc
var item_name = "" #item name shown in inventory description
var item_description = "" #item security clearance shown in inventory description
export(Color, RGBA) var inv_hover_color = Color(1,1,1,0.9)
export(Color, RGBA) var inv_normal_color = Color(1,1,1,0.5)

func _ready():
	set_process(false)
	inventory.connect("item_grabbed", self, "update_inv")
	inventory.connect("item_dropped", self, "update_inv")
	inventory.connect("reload_inv", self, "update_inv")
	color = inv_normal_color

func update_inv():
	ImgNode.texture = null
	item_description = ""
	item_name = ""
	item_node_name = ""
	
	var i = 0
	for item in inventory.inventory.keys():
		if i == get_index():
			var dict = inventory.inventory[item]
			ImgNode.texture = load(dict["texture"]) 
			item_description = dict["item_description"]
			item_name = dict["item_name"]
			item_node_name = item
		i += 1

func _on_Slot1_gui_input(event):
	if event.is_action_pressed("drop_item") and !item_node_name.empty():
		accept_event()
		inventory.drop(item_node_name)

func _on_Slot1_mouse_entered(): #Mouse hovering background colors
	color = inv_hover_color
	NameNode.show()
	set_process(true)

func _on_Slot1_mouse_exited():
	color = inv_normal_color
	NameNode.hide()
	set_process(false)

func _process(delta):
	NameNode.text = item_name
	DescNode.text = item_description
