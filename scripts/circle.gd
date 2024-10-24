extends RigidBody2D

enum {RED, GREEN, BLUE}

@export var colour = RED


func _ready():
	$AnimatedSprite2D.show()


func _physics_process(delta):
	match colour:
		RED:
			$AnimatedSprite2D.animation = "red"
		GREEN:
			$AnimatedSprite2D.animation = "green"
		BLUE:
			$AnimatedSprite2D.animation = "blue"


func _on_area_2d_body_entered(body):
	if body.is_in_group("bullet"):
		if colour == body.colour:
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
