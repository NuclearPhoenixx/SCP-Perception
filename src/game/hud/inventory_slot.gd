extends ColorRect

onready var image = get_node("ItemImage")
onready var description = get_parent().get_parent().get_node("Description")
onready var clearance = get_parent().get_parent().get_node("Description/Clearance")

var item_name #item name shown in inventory description
var item_clearance #item security clearance shown in inventory description
var inv_hover_color = Color(1,1,1,0.9)
var inv_normal_color = Color(1,1,1,0.5)

func _ready():
	set_process(false)

func _on_Slot1_gui_input(event):
	if event.is_action_pressed("drop_item") and !item_name.empty():
		var i = 0 ####
		var name
		for key in inventory.inventory: #GET THE ORIGINAL ITEM NAME BACK FROM INVENTORY DICT. IMPROVABLE?
			if get_index() == i:
				name = key
				break
			i += 1 ####
			
		inventory.drop(name)
		accept_event()

func _on_Slot1_mouse_entered(): #Mouse hovering background colors
	color = inv_hover_color
	description.show()
	set_process(true)

func _on_Slot1_mouse_exited():
	color = inv_normal_color
	description.hide()
	set_process(false)

func _process(delta):
	description.text = item_name
	clearance.text = item_clearance
