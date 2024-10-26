extends RigidBody2D


var colour


func _ready():
	$AnimatedSprite2D.show()


func _physics_process(_delta):
	match colour:
		"red":
			$AnimatedSprite2D.animation = "red"
		"green":
			$AnimatedSprite2D.animation = "green"
		"blue":
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
				"red":
					$deathParticles.color = Color(1, 0, 0)
				"green":
					$deathParticles.color = Color(0, 1, 0)
				"blue":
					$deathParticles.color = Color(0, 0, 1)
			$deathParticles.emitting = true
			Global.score += 5
		else:
			linear_velocity *= 2
		body.queue_free()
	elif body.is_in_group("player"):
		body.kill()

func _on_death_particles_finished():
	queue_free()
