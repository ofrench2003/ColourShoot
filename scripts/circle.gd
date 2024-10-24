extends RigidBody2D

enum {RED, GREEN, BLUE}

@export var colour = RED
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	match colour:
		RED:
			$AnimatedSprite2D.animation = "red"
			$AnimatedSprite2D.show()
		GREEN:
			$AnimatedSprite2D.animation = "green"
			$AnimatedSprite2D.show()
		BLUE:
			$AnimatedSprite2D.animation = "blue"
			$AnimatedSprite2D.show()
	
	


func _on_area_2d_body_entered(body):
	if body.is_in_group("bullet"):
		if colour == body.colour:
			queue_free()
		body.queue_free()
