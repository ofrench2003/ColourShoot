extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var point

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func get_point():
	randomize()
	var count = get_child_count()
	point = get_child(randf_range(0, count - 1))
	return point.position
