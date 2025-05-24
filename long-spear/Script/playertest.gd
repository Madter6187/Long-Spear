extends RigidBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var move_speed = 100
var jump_force = -200
#
#func move():
	#var AD = Input.get_axis("move_left", "move_right")
	#
	#if AD > 0:
		#linear_velocity.x = move_speed
	#elif AD < 0:
		#linear_velocity.x = -move_speed
	#else:
		#linear_velocity.x = 0
	#if Input.is_action_just_pressed("move_up"):
		#pass
		#linear_velocity.y = jump_force
#
#func swing():
	#pass
	#var turning = Input.get_axis("turn_anti_clock", "turn_clock")
#
#func _physics_process(delta):
#
	#move()
	#swing()
