extends Node2D

enum {RED, GREEN, BLUE}

@export var circle_scene : PackedScene


var ballcolour = [RED, GREEN, BLUE]


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


func _physics_process(delta):
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)


func _on_spawntimer_timeout():
	randomize()
	var circle_spawn_location = $points.get_point()
	var circle = circle_scene.instantiate()
	add_child(circle)
	ballcolour.shuffle()
	circle.colour = ballcolour[0]
	circle.position = circle_spawn_location
	circle.look_at($player.position)
	var direction = circle.rotation
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	circle.linear_velocity = velocity.rotated(direction)
