extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$fader.play("fadeIn")
	await get_tree().create_timer(0.5).timeout
	$Control/fadeColour.hide()


func _physics_process(_delta):
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)


func _on_quit_button_pressed():
	get_tree().quit()


func _on_play_button_pressed():
	$Control/fadeColour.show()
	$fader.play("fadeOut")
	await get_tree().create_timer(0.5).timeout
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_controls_button_pressed():
	get_tree().change_scene_to_file("res://scenes/controls.tscn")
