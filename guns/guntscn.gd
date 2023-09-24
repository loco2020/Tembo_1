extends Marker2D
var instance = 0
signal shoot
var mp = 0
@export var sensitevty = 15
var boomed = false

var knife_shooting_pos = 0
var knife_scene = preload("res://guns/knife.tscn")
var moive_size = 400

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	
	if mp != snappedf(get_viewport().get_mouse_position()[0],0.1):
		
		if snappedf(get_viewport().get_mouse_position()[0],0.1) < mp:
			# aim left 
			if moive_size > 0 :
				$Polygon2D.position.x -= sensitevty 
				moive_size -= sensitevty
				
		elif snappedf(get_viewport().get_mouse_position()[0],0.01)  > mp :
			if moive_size < 800 :
				$Polygon2D.position.x += sensitevty
				moive_size += sensitevty 
				
		mp = snappedf(get_viewport().get_mouse_position()[0],0.01)

func shot():
	instance = knife_scene.instantiate()
	instance.target_pos = $Polygon2D.position 
	instance.position = position
	add_child(instance)
