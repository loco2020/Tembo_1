extends Marker2D


var point = 0
var incress = "+"
var decress = "-"
var state = incress

func _ready():
	$label.text = state + str(point)
	
