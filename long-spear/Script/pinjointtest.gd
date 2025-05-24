extends Node2D

@onready var spear : RigidBody2D = $Spear
@onready var player : RigidBody2D = $Player
@onready var boxer = preload("res://box.tscn")
@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var move_speed = 100
var jump_force = -200

func _process(delta):
	pass
	boxing()
func boxing():
	var box = boxer.instantiate()
	if Input.is_action_just_pressed("E"):
		box.position = $Marker2D.position
		add_child(box)

func move():
	var AD = Input.get_axis("move_left", "move_right")
	
	if AD > 0: # ---->
		player.linear_velocity.x = move_speed
		#player.apply_impulse(Vector2(20, 0).rotated(rotation))
	elif AD < 0:# <----
		player.linear_velocity.x = -move_speed

	else:
		player.linear_velocity.x = 0
	if Input.is_action_just_pressed("move_up"):
		player.linear_velocity.y = jump_force


func swing():
	pass
	var turning = Input.get_axis("turn_anti_clock", "turn_clock")
	if turning > 0:
		#spear.constant_torque = 5000
		spear.angular_velocity = 5
	elif turning < 0:
		#spear.constant_torque = -5000
		spear.angular_velocity = -5
	else:
		spear.constant_torque = 0
		spear.angular_velocity = 0

func _physics_process(delta):
	
	move()
	swing()
