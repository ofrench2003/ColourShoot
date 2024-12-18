extends Node2D


@export var circle_scene : PackedScene
@export var squareScene : PackedScene

var spawnTime = 2
var enemySpeed = 150
var spawnAmount = 1
var doubleChance = [1, 0, 0, 0, 0]

var squareList = randi_range(0, 100)
var squareChance = 10

var ballcolour = ["red", "green", "blue"]

#@onready var musicPlayer = $musicBackground
#@onready var lowpassFilter : AudioEffectLowPassFilter = AudioServer.get_bus_effect(1 , 0) as AudioEffectLowPassFilter
#var fadingIn = false
#var fadeTimer : float = 0.0
#var fadeDuration : float = 0.5
#var maxCutoff : float = 10000.0
#var minCutoff : float = 1000.0

var filter := AudioEffectLowPassFilter.new()


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	Global.score = 0
	$UIControl/restartLabel.hide()
	$UIControl/controlLabel.hide()
	$UIControl/highscoreLabel.hide()
	await  get_tree().create_timer(0.5).timeout
	$musicBackground.play()
	#lowpassFilter.cutoff_frequency_hz = maxCutoff
	AudioServer.add_bus_effect(0,filter,0)
	filter.cutoff_hz = 10000.0


func _physics_process(delta):
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	
	$UIControl/scoreLabel.text = "Score: " + str(Global.score)
	
	#if fadingIn:
		#fadeTimer += delta
		#var t = clamp(fadeTimer / fadeDuration, 0.0, 1.0)
		#lowpassFilter.cutoff_frequency_hz = lerp(maxCutoff, minCutoff, t)
		#if t >= 1.0:
			#fadingIn = false  # Stop fading once the duration is complete


func _on_spawntimer_timeout():
	doubleChance.shuffle()
	if doubleChance[0] == 1:
		doubleChance = [1, 0, 0, 0, 0]
		spawnAmount = 2
	else:
		doubleChance.pop_at(0)
		spawnAmount = 1
	for i in range(spawnAmount):
		if squareList <= squareChance:
			var squareSL = $points.get_point()
			var square = squareScene.instantiate()
			add_child(square)
			square.position = squareSL
			square.look_at($player.position)
			var direction = square.rotation
			var velocity = Vector2(randf_range(enemySpeed, enemySpeed * 1.667), 0.0)
			square.linear_velocity = velocity.rotated(direction)
			$spawntimer.wait_time = randf_range(spawnTime, spawnTime * 1.5)
			$spawntimer.start()
		else:
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
		squareList = randi_range(0, 100)


func _on_progression_timer_timeout():
	spawnTime -= 0.1
	enemySpeed += 5
	squareChance += 5


func _on_player_end_game():
	#fadingIn = true
	#fadeTimer = 0.0
	
	var tween := create_tween()
	tween.tween_property(filter,"cutoff_hz",1000.0,0.5)
	
	await get_tree().create_timer(0.5).timeout
	$UIControl/restartLabel.show()
	$UIControl/controlLabel.show()
	var highscore = Global.getHighscore()
	if highscore < Global.score:
		Global.updateHighscore(Global.score)
		$UIControl/highscoreLabel.text = "New Highscore: " + str(Global.score)
	else:
		$UIControl/highscoreLabel.text = "Highscore: " + str(highscore)
	$UIControl/highscoreLabel.show()
