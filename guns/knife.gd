extends Node2D

var speed = 500.0
var target = Vector2(0,0)

func _process(delta):
	
	if Input.is_action_just_pressed("mouse_clicke"):
		target = get_global_mouse_position()
	var target_position =  (target - position).normalized()
	move_and_slide(target_position * speed)
