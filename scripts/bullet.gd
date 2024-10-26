extends RigidBody2D


var speed = 10000
var velocity = Vector2()
var colour


func _ready():
	$AnimatedSprite2D.hide()


func _physics_process(_delta):
	match colour:
		"red":
			$AnimatedSprite2D.animation = "red"
			$AnimatedSprite2D.show()
		"green":
			$AnimatedSprite2D.animation = "green"
			$AnimatedSprite2D.show()
		"blue":
			$AnimatedSprite2D.animation = "blue"
			$AnimatedSprite2D.show()


func _on_VisibilityNotifier2D_viewport_exited(_viewport):
	queue_free()
