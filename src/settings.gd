extends Node

signal debug_mode #to signal that debugging mode has been toggled

#SETTINGS
var follow_mode = false # If pressed up/forward follow the mouse instead of just going up
var debug_mode = false
var zoom_res = .05 #resolution of a single camera zoom. makes it faster or slower

func _ready():
	connect("debug_mode", self, "toggle_debug")

func toggle_debug():
	if debug_mode:
		debug_mode = false
	else:
		debug_mode = true
