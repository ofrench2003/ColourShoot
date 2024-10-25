extends RigidBody2D

enum {RED, GREEN, BLUE}


@export var firstColour = RED
@export var secondColour = RED
var colours = [RED, GREEN, BLUE]
@export var colour = RED
var lastColour = false


func _ready():
	$AnimatedSprite2D.show()
	$AnimatedSprite2D2.show()
	randomize()
	colours.shuffle()
	firstColour = colours[0]
	colours.shuffle()
	secondColour = colours[0]
	colour = firstColour


func _physics_process(_delta):
	match secondColour:
		RED:
			$AnimatedSprite2D.animation = "red"
		GREEN:
			$AnimatedSprite2D.animation = "green"
		BLUE:
			$AnimatedSprite2D.animation = "blue"
	match firstColour:
		RED:
			$AnimatedSprite2D2.animation = "red"
		GREEN:
			$AnimatedSprite2D2.animation = "green"
		BLUE:
			$AnimatedSprite2D2.animation = "blue"


func _on_area_2d_body_entered(body):
	if body.is_in_group("bullet"):
		if colour == body.colour and lastColour:
			linear_velocity = Vector2(0, 0)
			$Area2D.set_collision_layer_value(3, 0)
			$Area2D.set_collision_mask_value(1, 0)
			$Area2D.set_collision_mask_value(2, 0)
			$AnimatedSprite2D.hide()
			match colour:
				RED:
					$deathParticles.color = Color(1, 0, 0)
				GREEN:
					$deathParticles.color = Color(0, 1, 0)
				BLUE:
					$deathParticles.color = Color(0, 0, 1)
			$deathParticles.emitting = true
		else:
			linear_velocity *= 2
		body.queue_free()
	elif body.is_in_group("player"):
		body.kill()

func _on_death_particles_finished():
	queue_free()

