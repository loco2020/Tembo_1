extends ColorRect

var play_again = false

func get_state():
	return play_again
	
func set_state(state:bool):
	play_again = state
	
func _on_button_button_down():
	
	play_again = true


