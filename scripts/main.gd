extends Node2D

enum {RED, GREEN, BLUE}

@export var circle_scene : PackedScene

var spawnTime = 2
var enemySpeed = 150
var spawnAmount = 1
var doubleChance = [1, 0, 0, 0, 0]

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
	doubleChance.shuffle()
	if doubleChance[0] == 1:
		doubleChance = [1, 0, 0, 0, 0]
		spawnAmount = 2
	else:
		doubleChance.pop_at(0)
		spawnAmount = 1
	for i in range(spawnAmount):
		var circle_spawn_location = $points.get_point()
		var circle = circle_scene.instantiate()
		add_child(circle)
		ballcolour.shuffle()
		circle.colour = ballcolour[0]
		circle.position = circle_spawn_location
		circle.look_at($player.position)
		var direction = circle.rotation
		var velocity = Vector2(randf_range(enemySpeed, enemySpeed * 1.667), 0.0)
		circle.linear_velocity = velocity.rotated(direction)
		$spawntimer.wait_time = randf_range(spawnTime, spawnTime * 1.5)
		$spawntimer.start()


func _on_progression_timer_timeout():
	spawnTime -= 0.1
	enemySpeed += 5
