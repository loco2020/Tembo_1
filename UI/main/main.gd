extends Node2D

var started = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_state():
	
	return started
	
func on_start_pressed():
	
	started = true
