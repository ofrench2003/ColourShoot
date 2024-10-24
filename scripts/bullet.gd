extends RigidBody2D

enum {RED, GREEN, BLUE}

var speed = 10000
var velocity = Vector2()
@export var colour = RED


func _ready():
	$AnimatedSprite2D.hide()


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


func _on_VisibilityNotifier2D_viewport_exited(viewport):
	queue_free()
