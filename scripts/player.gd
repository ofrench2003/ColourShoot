extends CharacterBody2D

enum {RED,GREEN,BLUE}

@export var bulletscene: PackedScene
var dying = false
var colour = RED
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	
	#~~~~~~~~~~Directions~~~~~~~~~~#
	var up = Input.is_action_pressed("up")
	var down = Input.is_action_pressed("down")
	var left = Input.is_action_pressed("left")
	var right = Input.is_action_pressed("right")
	
	if up and not dying:
		if left and not right:
			look_at(get_parent().get_node("points/point1").position)
		elif right and not left:
			look_at(get_parent().get_node("points/point3").position)
		else:
			look_at(get_parent().get_node("points/point2").position)
	if down and not dying:
		if left and not right:
			look_at(get_parent().get_node("points/point7").position)
		elif right and not left:
			look_at(get_parent().get_node("points/point5").position)
		else:
			look_at(get_parent().get_node("points/point6").position)
	if left and not up and not down and not dying:
		look_at(get_parent().get_node("points/point8").position)
	if right and not up and not down and not dying:
		look_at(get_parent().get_node("points/point4").position)
	
	
	
	#shooting
	if Input.is_action_just_pressed("shoot") and not dying:
		fireweapon()
	
	#changing colour
	if Input.is_action_just_pressed("red") and not dying:
		colour = RED
		fireweapon()
	if Input.is_action_just_pressed("blue") and not dying:
		colour = BLUE
		fireweapon()
	if Input.is_action_just_pressed("green") and not dying:
		colour = GREEN
		fireweapon()

	if Input.is_action_just_pressed("swap") and not dying:
		match colour:
			RED:
				colour = GREEN
			GREEN:
				colour = BLUE
			BLUE:
				colour = RED
	
	match colour:
		RED:
			$AnimatedSprite2D.animation = "red"
		GREEN:
			$AnimatedSprite2D.animation = "green"
		BLUE:
			$AnimatedSprite2D.animation = "blue"
	
	#restarting
	if Input.is_action_just_pressed("restart") and dying:
		get_tree().reload_current_scene()
	
func fireweapon():
	
	#bullet
	var bulletloc = $bulletposition.global_position.x
	var bullety = $bulletposition.global_position.y
	var bullet = bulletscene.instantiate()
	bullet.colour = colour
	var direction = self.rotation
	bullet.rotation = direction
	var velocity2 = Vector2(2000, 0)
	get_parent().add_child(bullet)
	bullet.position = Vector2(bulletloc, bullety)
	bullet.linear_velocity = velocity2.rotated(direction)

func kill():
	dying = true
	$AnimatedSprite2D.hide()
	set_collision_layer_value(1, false)
	set_collision_mask_value(3, false)
	match colour:
		RED:
			$deathParticles.color = Color(1, 0, 0)
		GREEN:
			$deathParticles.color = Color(0, 1, 0)
		BLUE:
			$deathParticles.color = Color(0, 0, 1)
	$deathParticles.emitting = true
	


func _on_death_particles_finished():
	pass # Replace with function body.
