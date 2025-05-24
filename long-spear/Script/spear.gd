extends RigidBody2D

@onready var shape : ShapeCast2D = $ShapeCast2D
@onready var timer : Timer = $Timer

func _physics_process(delta):
	
	if shape.is_colliding():
		print("Hit")
		shape.enabled = false
		timer.start()

func _on_timer_timeout():
	shape.enabled = true
